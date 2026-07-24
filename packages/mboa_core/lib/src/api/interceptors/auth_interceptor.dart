import 'dart:async';

import 'package:dio/dio.dart';

import '../../models/auth_tokens.dart';
import '../../storage/secure_token_storage.dart';

/// Refreshes an [AuthTokens] pair given the current refresh token.
/// Returns `null` when the refresh token is itself rejected.
typedef TokenRefresher = Future<AuthTokens?> Function(String refreshToken);

/// The one and only place 401s are handled (CLAUDE.md rule: repositories never
/// handle 401 themselves).
///
/// Behaviour:
///  1. Injects `Authorization: Bearer <access>` into every request.
///  2. On 401 → calls [refresher] with the stored refresh token.
///     ├─ success → persists new tokens and retries the original request.
///     └─ failure → clears tokens and invokes [onSessionExpired] (clean logout).
///
/// Concurrent 401s are collapsed into a single refresh via [_refreshLock].
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required SecureTokenStorage storage,
    required TokenRefresher refresher,
    required Future<void> Function() onSessionExpired,
    required Dio retryClient,
  })  : _storage = storage,
        _refresher = refresher,
        _onSessionExpired = onSessionExpired,
        _retryClient = retryClient;

  final SecureTokenStorage _storage;
  final TokenRefresher _refresher;
  final Future<void> Function() _onSessionExpired;

  /// A bare Dio (no [AuthInterceptor]) used to replay the original request after
  /// a successful refresh, so we never recurse through this interceptor.
  final Dio _retryClient;

  Future<AuthTokens?>? _refreshLock;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final isAuthEndpoint = err.requestOptions.path.contains('/auth/');

    if (response?.statusCode != 401 ||
        isAuthEndpoint ||
        _alreadyRetried(err.requestOptions)) {
      return handler.next(err);
    }

    final refreshToken = await _storage.readRefreshToken();
    if (refreshToken == null) {
      await _forceLogout();
      return handler.next(err);
    }

    try {
      // Single-flight: all queued 401s await the same refresh.
      final tokens = await (_refreshLock ??= _refresher(refreshToken));
      _refreshLock = null;

      if (tokens == null || !tokens.isValid) {
        await _forceLogout();
        return handler.next(err);
      }

      await _storage.save(tokens);
      final retried = await _replay(err.requestOptions, tokens.accessToken);
      return handler.resolve(retried);
    } catch (_) {
      _refreshLock = null;
      await _forceLogout();
      return handler.next(err);
    }
  }

  Future<void> _forceLogout() async {
    await _storage.clear();
    await _onSessionExpired();
  }

  bool _alreadyRetried(RequestOptions options) =>
      options.extra['mboa_retried'] == true;

  Future<Response<dynamic>> _replay(RequestOptions options, String accessToken) {
    final headers = Map<String, dynamic>.from(options.headers)
      ..['Authorization'] = 'Bearer $accessToken';
    return _retryClient.request<dynamic>(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      cancelToken: options.cancelToken,
      options: Options(
        method: options.method,
        headers: headers,
        responseType: options.responseType,
        contentType: options.contentType,
        extra: {...options.extra, 'mboa_retried': true},
      ),
    );
  }
}
