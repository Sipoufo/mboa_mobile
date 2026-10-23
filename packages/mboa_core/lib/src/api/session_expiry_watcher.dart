import 'package:flutter/foundation.dart';
import 'dart:async';

import '../models/auth_tokens.dart';
import '../storage/secure_token_storage.dart';
import 'dio_client.dart';

/// Refreshes the access token *before* it expires, and forces a clean logout
/// once the refresh token itself is dead.
///
/// The [AuthInterceptor] already handles the reactive case (a request 401s, we
/// refresh and replay). That leaves two gaps this closes:
///
///  * an idle app whose access token lapses — the next request pays a wasted
///    round-trip and a visible stall;
///  * an app resumed after the *refresh* token expired — nothing 401s until the
///    user acts, so a dead session lingers on screen.
///
/// Timer-driven rather than tick-driven: one timer armed for the next expiry,
/// re-armed after each refresh. [start] is idempotent, so it is safe to call on
/// login and again on every app resume.
class SessionExpiryWatcher {
  SessionExpiryWatcher({
    required DioClient dioClient,
    required SecureTokenStorage tokenStorage,
    required Future<void> Function() onSessionExpired,
    Duration refreshLeeway = const Duration(minutes: 2),
  })  : _dioClient = dioClient,
        _tokenStorage = tokenStorage,
        _onSessionExpired = onSessionExpired,
        _refreshLeeway = refreshLeeway;

  final DioClient _dioClient;
  final SecureTokenStorage _tokenStorage;
  final Future<void> Function() _onSessionExpired;

  /// How far ahead of expiry to refresh, so a request never races the lapse.
  final Duration _refreshLeeway;

  Timer? _timer;

  /// Arms the watcher against the currently stored tokens. Safe to call
  /// repeatedly — each call replaces the pending timer.
  Future<void> start() async {
    _timer?.cancel();

    final tokens = await _tokenStorage.readTokens();
    if (tokens == null || !tokens.isValid) return;

    // A refresh token past its own expiry can never be redeemed.
    if (_hasLapsed(tokens.refreshTokenExpiresAt)) {
      await _expire();
      return;
    }

    final expiresAt = tokens.accessTokenExpiresAt;
    if (expiresAt == null) {
      // The backend omitted the expiry — nothing to schedule against; the
      // interceptor's 401 path remains the safety net.
      return;
    }

    final delay = expiresAt.difference(DateTime.now()) - _refreshLeeway;
    if (delay <= Duration.zero) {
      await _refresh();
      return;
    }

    _timer = Timer(delay, _refresh);
  }

  /// Cancels any pending refresh. Call on logout.
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  /// Through [DioClient.rotateSession], never on its own: the tokens read
  /// when the timer was armed may have been rotated since by a 401, and a
  /// spent refresh token signs the account out everywhere.
  Future<void> _refresh() async {
    final AuthTokens? refreshed;
    try {
      refreshed = await _dioClient.rotateSession();
    } catch (_) {
      // Unreachable: the session stays; the next resume, or a 401, tries again.
      return;
    }
    if (refreshed == null || !refreshed.isValid) {
      await _expire();
      return;
    }
    // Re-arm against the new expiry.
    await start();
  }

  /// Ends the session and says so — a watcher that logs someone out while the
  /// app is idle is the hardest kind of logout to explain afterwards.
  Future<void> _expire() async {
    if (kDebugMode) debugPrint('[session] expired by the watcher');
    stop();
    await _tokenStorage.clear();
    await _onSessionExpired();
  }

  bool _hasLapsed(DateTime? instant) =>
      instant != null && !instant.isAfter(DateTime.now());
}
