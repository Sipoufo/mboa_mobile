import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../profile/models/account_role.dart';
import '../models/session_result.dart';

/// Resolves the startup session status, shared by both apps' splash features.
///
/// Strategy (layered — a cheap local pre-filter, then offline-aware /me):
///  - no token                       → [SessionUnauthenticated]
///  - refresh token already expired  → [SessionUnauthenticated] (local, no call)
///  - token + offline                → [SessionAuthenticated] (fromCache: true)
///  - token + online                 → validate with `GET /me`
///      · 200            → [SessionAuthenticated]
///      · 401            → refresh already failed in the interceptor and tokens
///                         were cleared → [SessionUnauthenticated]
///      · network/timeout→ [SessionAuthenticated] (fromCache: true) — offline-first
///      · other          → [SessionCheckError] (retryable)
///
/// The local expiry check only rejects a definitively-dead token to avoid a
/// doomed network round-trip; it can't detect server-side revocation, so a live
/// token is still validated with `/me`.
class SessionRepository {
  SessionRepository({
    required DioClient dioClient,
    required SecureTokenStorage tokenStorage,
    required NetworkMonitor networkMonitor,
  })  : _dioClient = dioClient,
        _tokenStorage = tokenStorage,
        _networkMonitor = networkMonitor;

  final DioClient _dioClient;
  final SecureTokenStorage _tokenStorage;
  final NetworkMonitor _networkMonitor;

  Future<SessionResult> resolve() async {
    final tokens = await _tokenStorage.readTokens();
    if (tokens == null) {
      return _rejected(NoSessionReason.noTokens);
    }

    // Fast-path: reject locally only when the pair is **definitively** dead —
    // the refresh token past its own expiry *and* no access token left to work
    // with. A dead refresh token alone proves nothing about right now: the
    // access token may have hours on it, every request will be accepted, and
    // declaring the session over would sign the reader out of their own screens
    // while their bookings still go through under their name.
    //
    // That is not hypothetical — it is the bug this replaces. The refresh
    // matters at the next 401, and the interceptor owns that moment.
    if (_lapsed(tokens.refreshTokenExpiresAt) &&
        _lapsed(tokens.accessTokenExpiresAt)) {
      return _rejectAndClear(
        NoSessionReason.refreshExpired,
        detail: 'both tokens expired (refresh at ${tokens.refreshTokenExpiresAt})',
      );
    }

    if (!await _networkMonitor.isOnline) {
      _log('offline — trusting the stored token');
      return const SessionAuthenticated(fromCache: true);
    }

    try {
      // The role rides along with the check that already had to happen —
      // knowing it here is what stops the wrong shell being drawn first.
      final me = await _dioClient.api.getCurrentUserApi().getMe();
      _log('restored — /me answered');
      return SessionAuthenticated(
        role: AccountRole.fromResponse(me.data?.role),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // The interceptor already tried to refresh and could not — it clears
        // on its way out, but say so here too: this path must not depend on
        // another object's housekeeping.
        return _rejectAndClear(NoSessionReason.rejectedByServer);
      }
      if (_isConnectivityError(e)) {
        _log('unreachable — trusting the stored token');
        return const SessionAuthenticated(fromCache: true);
      }
      _log('check failed: ${e.response?.statusCode ?? e.type.name}');
      return const SessionCheckError();
    }
  }

  /// Known to be past. An **absent** expiry is not lapsed: older tokens and
  /// backends that omit the field must fall through to `/me` rather than be
  /// thrown away on something this app never knew.
  static bool _lapsed(DateTime? expiry) =>
      expiry != null && !expiry.isAfter(DateTime.now());

  /// Says why, out loud, in debug.
  ///
  /// A startup that silently drops a session is the hardest kind of bug to
  /// hear about: the tester says "it logged me out again" and there is nothing
  /// to go on. One line names which of the four doors it went through.
  SessionUnauthenticated _rejected(NoSessionReason reason, {String? detail}) {
    _log('no session: ${reason.name}${detail == null ? '' : ' — $detail'}');
    return SessionUnauthenticated(reason);
  }

  /// Makes the conclusion true.
  ///
  /// Deciding "no session" while leaving usable tokens in storage gives an app
  /// that is signed out on screen and signed in on the wire: the Favoris tab
  /// offers to create an account while a visit is booked under the reader's
  /// name. Whatever the reason, the two layers have to agree.
  Future<SessionResult> _rejectAndClear(
    NoSessionReason reason, {
    String? detail,
  }) async {
    await _tokenStorage.clear();
    return _rejected(reason, detail: detail);
  }

  /// Every outcome speaks, not only the refusals: an absent line has to mean
  /// "this code did not run", never "it ran and said nothing".
  static void _log(String what) {
    if (kDebugMode) debugPrint('[session] $what');
  }

  bool _isConnectivityError(DioException e) =>
      e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout;
}
