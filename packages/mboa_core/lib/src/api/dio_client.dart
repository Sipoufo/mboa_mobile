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
  }) {
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
        refresher: _refreshTokens,
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

  late final Dio _dio;
  late final Dio _bareDio;

  /// The generated, typed API surface.
  late final ApiClient api;

  Dio get dio => _dio;

  /// Refreshes the token pair on demand, ahead of expiry.
  ///
  /// The [AuthInterceptor] refreshes *reactively*, on a 401. [SessionExpiryWatcher]
  /// uses this to refresh *proactively*, before the access token lapses.
  /// Returns `null` when the refresh token is itself rejected — the caller is
  /// responsible for the resulting logout.
  Future<AuthTokens?> refreshSession(String refreshToken) =>
      _refreshTokens(refreshToken);

  /// Calls `/auth/refresh` on the bare client and maps the wire type to the
  /// domain [AuthTokens]. Returns `null` if the refresh token is rejected.
  Future<AuthTokens?> _refreshTokens(String refreshToken) async {
    try {
      final response = await AuthenticationApi(_bareDio, standardSerializers).refresh(
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
    } on DioException {
      return null;
    }
  }
}
