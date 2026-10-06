import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

DioException _dio(String path, {int? status, DioExceptionType type = DioExceptionType.badResponse}) {
  final options = RequestOptions(path: path);
  return DioException(
    requestOptions: options,
    type: type,
    response: status == null
        ? null
        : Response<dynamic>(requestOptions: options, statusCode: status),
  );
}

AuthTokens _tokens({DateTime? refreshExpiry, DateTime? accessExpiry}) =>
    AuthTokens(
      accessToken: 'a',
      refreshToken: 'r',
      accessTokenExpiresAt: accessExpiry,
      refreshTokenExpiresAt: refreshExpiry,
    );

void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockCurrentUserApi currentUserApi;
  late MockSecureTokenStorage storage;
  late MockNetworkMonitor network;
  late SessionRepository repository;

  final future = DateTime.now().add(const Duration(days: 7));
  final past = DateTime.now().subtract(const Duration(days: 1));

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    currentUserApi = MockCurrentUserApi();
    storage = MockSecureTokenStorage();
    network = MockNetworkMonitor();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getCurrentUserApi).thenReturn(currentUserApi);

    when(storage.clear).thenAnswer((_) async {});

    repository = SessionRepository(
      dioClient: dioClient,
      tokenStorage: storage,
      networkMonitor: network,
    );
  });

  test('no token → unauthenticated (no network call)', () async {
    when(storage.readTokens).thenAnswer((_) async => null);

    expect(await repository.resolve(), isA<SessionUnauthenticated>());
    verifyNever(() => dioClient.api);
  });

  test('both tokens expired → unauthenticated locally (no call)', () async {
    when(storage.readTokens).thenAnswer(
      (_) async => _tokens(refreshExpiry: past, accessExpiry: past),
    );

    expect(await repository.resolve(), isA<SessionUnauthenticated>());
    verifyNever(() => network.isOnline);
    verifyNever(currentUserApi.getMe);
  });

  test('a dead refresh token does not end a session the access token can still run',
      () async {
    // The bug this replaces: the app declared the session over at startup on
    // the refresh expiry alone. Every request kept working — the access token
    // was fine — so a reader was offered "create an account" on the Favoris
    // tab while booking a visit under their own name.
    when(storage.readTokens).thenAnswer(
      (_) async => _tokens(refreshExpiry: past, accessExpiry: future),
    );
    when(() => network.isOnline).thenAnswer((_) async => true);
    when(currentUserApi.getMe).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(),
        statusCode: 200,
      ),
    );

    expect(await repository.resolve(), isA<SessionAuthenticated>());
    // The refresh matters at the next 401, and the interceptor owns that.
    verify(currentUserApi.getMe).called(1);
  });

  test('a rejected session leaves nothing usable behind', () async {
    when(storage.readTokens).thenAnswer(
      (_) async => _tokens(refreshExpiry: past, accessExpiry: past),
    );

    await repository.resolve();

    // Deciding "no session" while leaving usable tokens in storage is what
    // gives an app signed out on screen and signed in on the wire.
    verify(storage.clear).called(1);
  });

  test('token + offline → authenticated from cache (offline-first)', () async {
    when(storage.readTokens).thenAnswer((_) async => _tokens(refreshExpiry: future));
    when(() => network.isOnline).thenAnswer((_) async => false);

    final result = await repository.resolve();

    expect(result, isA<SessionAuthenticated>());
    expect((result as SessionAuthenticated).fromCache, isTrue);
    verifyNever(currentUserApi.getMe);
  });

  test('token (unexpired) + online + /me 200 → authenticated', () async {
    when(storage.readTokens).thenAnswer((_) async => _tokens(refreshExpiry: future));
    when(() => network.isOnline).thenAnswer((_) async => true);
    when(currentUserApi.getMe).thenAnswer(
      (_) async => Response<MeResponse>(requestOptions: RequestOptions(path: '/me')),
    );

    final result = await repository.resolve();

    expect(result, isA<SessionAuthenticated>());
    expect((result as SessionAuthenticated).fromCache, isFalse);
  });

  test('token with null expiry falls through to /me (backward compatible)', () async {
    when(storage.readTokens).thenAnswer((_) async => _tokens());
    when(() => network.isOnline).thenAnswer((_) async => true);
    when(currentUserApi.getMe).thenAnswer(
      (_) async => Response<MeResponse>(requestOptions: RequestOptions(path: '/me')),
    );

    expect(await repository.resolve(), isA<SessionAuthenticated>());
    verify(currentUserApi.getMe).called(1);
  });

  test('token + online + /me 401 → unauthenticated (refresh already failed)', () async {
    when(storage.readTokens).thenAnswer((_) async => _tokens(refreshExpiry: future));
    when(() => network.isOnline).thenAnswer((_) async => true);
    when(currentUserApi.getMe).thenThrow(_dio('/me', status: 401));

    expect(await repository.resolve(), isA<SessionUnauthenticated>());
  });

  test('token + online + connectivity error → authenticated from cache', () async {
    when(storage.readTokens).thenAnswer((_) async => _tokens(refreshExpiry: future));
    when(() => network.isOnline).thenAnswer((_) async => true);
    when(currentUserApi.getMe)
        .thenThrow(_dio('/me', type: DioExceptionType.connectionError));

    final result = await repository.resolve();

    expect(result, isA<SessionAuthenticated>());
    expect((result as SessionAuthenticated).fromCache, isTrue);
  });

  test('token + online + server error → retryable check error', () async {
    when(storage.readTokens).thenAnswer((_) async => _tokens(refreshExpiry: future));
    when(() => network.isOnline).thenAnswer((_) async => true);
    when(currentUserApi.getMe).thenThrow(_dio('/me', status: 500));

    expect(await repository.resolve(), isA<SessionCheckError>());
  });
}
