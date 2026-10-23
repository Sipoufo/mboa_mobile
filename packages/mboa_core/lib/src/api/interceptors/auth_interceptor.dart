import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/auth_tokens.dart';
import '../../storage/secure_token_storage.dart';

/// Rotates the session: one refresh for the whole app at a time, from the
/// refresh token stored when it starts, the new pair saved before it returns.
/// Returns `null` when the server refuses the refresh token (the session is
/// over); throws when the server could not be reached (the session is kept).
typedef SessionRotator = Future<AuthTokens?> Function();

/// The one and only place 401s are handled (CLAUDE.md rule: repositories never
/// handle 401 themselves).
///
/// Behaviour:
///  1. Injects `Authorization: Bearer <access>` into every request.
///  2. On 401:
///     ├─ the session was rotated since the request left (another 401, the
///     │  [SessionExpiryWatcher]) → replays it with the new token, no refresh;
///     ├─ otherwise → [rotate]s, then replays the original request;
///     ├─ refused → clears tokens and invokes [onSessionExpired] (clean logout);
///     └─ unreachable → the request fails, the session stays.
///
/// A refresh token is single-use: the server signs the account out
/// everywhere when a spent one comes back (`REFRESH_TOKEN_REUSED`). So no
/// 401 refreshes twice, and nothing refreshes beside [rotate].
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required SecureTokenStorage storage,
    required SessionRotator rotate,
    required Future<void> Function() onSessionExpired,
    required Dio retryClient,
  })  : _storage = storage,
        _rotate = rotate,
        _onSessionExpired = onSessionExpired,
        _retryClient = retryClient;

  final SecureTokenStorage _storage;
  final SessionRotator _rotate;
  final Future<void> Function() _onSessionExpired;

  /// A bare Dio (no [AuthInterceptor]) used to replay the original request after
  /// a successful refresh, so we never recurse through this interceptor.
  final Dio _retryClient;

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

    final current = await _storage.readAccessToken();
    final String accessToken;
    if (current != null && current.isNotEmpty && current != _bearerOf(err.requestOptions)) {
      // Rotated since this request left: its token is simply old.
      accessToken = current;
    } else {
      final AuthTokens? tokens;
      try {
        tokens = await _rotate();
      } catch (error) {
        // Offline, or the server down: the session is not over for that.
        if (kDebugMode) debugPrint('[session] refresh unreachable for ${err.requestOptions.path}: $error');
        return handler.next(err);
      }
      if (tokens == null || !tokens.isValid) {
        await _forceLogout(why: 'refresh refused for ${err.requestOptions.path}');
        return handler.next(err);
      }
      accessToken = tokens.accessToken;
    }

    try {
      return handler.resolve(await _replay(err.requestOptions, accessToken));
    } on DioException catch (replayError) {
      // The request's own failure, now that it is authorised — not the session's.
      return handler.next(replayError);
    }
  }

  /// The session is over and the tokens go. **Says so**: this is the quietest
  /// way an app can log someone out — a request fails somewhere, the tokens
  /// vanish, and the next screen simply offers to sign in.
  Future<void> _forceLogout({String? why}) async {
    if (kDebugMode) {
      debugPrint('[session] forced logout by the interceptor${why == null ? '' : ' — $why'}');
    }
    await _storage.clear();
    await _onSessionExpired();
  }

  bool _alreadyRetried(RequestOptions options) =>
      options.extra['mboa_retried'] == true;

  static String? _bearerOf(RequestOptions options) {
    final header = options.headers['Authorization'];
    return header is String && header.startsWith('Bearer ') ? header.substring(7) : null;
  }

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
