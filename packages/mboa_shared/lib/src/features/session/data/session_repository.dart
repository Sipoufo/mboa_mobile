import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

import '../models/session_result.dart';

/// Resolves the startup session status, shared by both apps' splash features.
///
/// Strategy (offline-aware, per the /me validation decision):
///  - no token           → [SessionUnauthenticated]
///  - token + offline    → [SessionAuthenticated] (fromCache: true)
///  - token + online     → validate with `GET /me`
///      · 200            → [SessionAuthenticated]
///      · 401            → refresh already failed in the interceptor and tokens
///                         were cleared → [SessionUnauthenticated]
///      · network/timeout→ [SessionAuthenticated] (fromCache: true) — offline-first
///      · other          → [SessionCheckError] (retryable)
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
    if (!await _tokenStorage.hasTokens()) {
      return const SessionUnauthenticated();
    }

    if (!await _networkMonitor.isOnline) {
      return const SessionAuthenticated(fromCache: true);
    }

    try {
      await _dioClient.api.getCurrentUserApi().me();
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
