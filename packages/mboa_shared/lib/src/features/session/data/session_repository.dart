import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

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
      return const SessionUnauthenticated();
    }

    // Fast-path: a refresh token past its own expiry is definitively dead — the
    // refresh (and thus /me) would 401, so reject locally without a call. A null
    // expiry (older tokens / backend omitted it) falls through to /me.
    final refreshExpiry = tokens.refreshTokenExpiresAt;
    if (refreshExpiry != null && !refreshExpiry.isAfter(DateTime.now())) {
      return const SessionUnauthenticated();
    }

    if (!await _networkMonitor.isOnline) {
      return const SessionAuthenticated(fromCache: true);
    }

    try {
      await _dioClient.api.getCurrentUserApi().getMe();
      return const SessionAuthenticated();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const SessionUnauthenticated();
      }
      if (_isConnectivityError(e)) {
        return const SessionAuthenticated(fromCache: true);
      }
      return const SessionCheckError();
    }
  }

  bool _isConnectivityError(DioException e) =>
      e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout;
}
