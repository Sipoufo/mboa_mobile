import 'dart:developer' as developer;

import 'package:api_client/api_client.dart' hide AuthTokens;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/environment.dart';
import '../models/auth_tokens.dart';
import '../storage/secure_token_storage.dart';
import 'interceptors/auth_interceptor.dart';

/// Builds the app-wide [Dio] (with [AuthInterceptor]) and exposes the generated
/// [ApiClient] on top of it. This is the ONLY object features touch to reach the
/// network — repositories call `dioClient.api.getAuthApi()`, never a raw Dio.
class DioClient {
  DioClient({
    required SecureTokenStorage storage,
    required Future<void> Function() onSessionExpired,
    Dio? dio,
    Dio? retryClient,
  }) : _storage = storage {
    final baseOptions = BaseOptions(
      baseUrl: Environment.apiBaseUrl,
      headers: {'Accept': 'application/json'},
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );

    // A bare client (no AuthInterceptor) used to refresh tokens and to replay
    // requests after a refresh — this avoids recursing through the interceptor.
    _bareDio = retryClient ?? Dio(baseOptions);

    dio = dio ?? Dio(baseOptions);
    dio.interceptors.add(
      AuthInterceptor(
        storage: storage,
        rotate: rotateSession,
        onSessionExpired: onSessionExpired,
        retryClient: _bareDio,
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          logPrint: (o) => developer.log(o.toString(), name: 'dio'),
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    _dio = dio;
    // interceptors: [] disables ApiClient's default auth interceptors — we do
    // bearer injection ourselves in AuthInterceptor.
    api = ApiClient(dio: _dio, interceptors: const []);
  }

  final SecureTokenStorage _storage;
  late final Dio _dio;
  late final Dio _bareDio;

  /// The refresh under way, shared by everyone who asks meanwhile.
  Future<AuthTokens?>? _rotation;

  /// The generated, typed API surface.
  late final ApiClient api;

  Dio get dio => _dio;

  /// Rotates the session — the one way the app refreshes, for the
  /// [AuthInterceptor] (on a 401) and the [SessionExpiryWatcher] (ahead of
  /// expiry) alike.
  ///
  /// A refresh token is single-use: presenting a spent one signs the account
  /// out on every device (`REFRESH_TOKEN_REUSED`). So there is one refresh
  /// at a time — every caller meanwhile shares it —, it reads the refresh
  /// token stored *when it starts* (never one held since), and the new pair
  /// is saved before anyone replays.
  ///
  /// Returns `null` when the server refuses the refresh token: the session is
  /// over. Throws when the server could not be reached: the session is kept.
  Future<AuthTokens?> rotateSession() => _rotation ??= _rotate().whenComplete(() => _rotation = null);

  Future<AuthTokens?> _rotate() async {
    final refreshToken = await _storage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return null;
    final tokens = await _refreshTokens(refreshToken);
    if (tokens != null && tokens.isValid) await _storage.save(tokens);
    return tokens;
  }

  /// Calls `/auth/refresh` on the bare client and maps the wire type to the
  /// domain [AuthTokens]. Returns `null` if the refresh token is rejected;
  /// rethrows when there was no answer at all.
  Future<AuthTokens?> _refreshTokens(String refreshToken) async {
    try {
      final response = await AuthenticationApi(_bareDio, standardSerializers).refreshToken(
        refreshTokenRequest: RefreshTokenRequest((b) => b..refreshToken = refreshToken),
      );
      final pair = response.data;
      if (pair == null) return null;
      return AuthTokens(
        accessToken: pair.accessToken ?? '',
        refreshToken: pair.refreshToken ?? '',
        accessTokenExpiresAt: pair.accessTokenExpiresAt,
        refreshTokenExpiresAt: pair.refreshTokenExpiresAt,
      );
    } on DioException catch (error) {
      // An answer is a verdict on the token; no answer is not.
      if (error.response != null) return null;
      rethrow;
    }
  }
}
