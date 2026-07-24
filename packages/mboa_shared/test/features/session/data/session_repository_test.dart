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

void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockCurrentUserApi currentUserApi;
  late MockSecureTokenStorage storage;
  late MockNetworkMonitor network;
  late SessionRepository repository;

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    currentUserApi = MockCurrentUserApi();
    storage = MockSecureTokenStorage();
    network = MockNetworkMonitor();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getCurrentUserApi).thenReturn(currentUserApi);

    repository = SessionRepository(
      dioClient: dioClient,
      tokenStorage: storage,
      networkMonitor: network,
    );
  });

  test('no token → unauthenticated (no network call)', () async {
    when(storage.hasTokens).thenAnswer((_) async => false);

    expect(await repository.resolve(), isA<SessionUnauthenticated>());
    verifyNever(() => dioClient.api);
  });

  test('token + offline → authenticated from cache (offline-first)', () async {
    when(storage.hasTokens).thenAnswer((_) async => true);
    when(() => network.isOnline).thenAnswer((_) async => false);

    final result = await repository.resolve();

    expect(result, isA<SessionAuthenticated>());
    expect((result as SessionAuthenticated).fromCache, isTrue);
    verifyNever(currentUserApi.me);
  });

  test('token + online + /me 200 → authenticated', () async {
    when(storage.hasTokens).thenAnswer((_) async => true);
    when(() => network.isOnline).thenAnswer((_) async => true);
    when(currentUserApi.me).thenAnswer(
      (_) async => Response<MeResponse>(requestOptions: RequestOptions(path: '/me')),
    );

    final result = await repository.resolve();

    expect(result, isA<SessionAuthenticated>());
    expect((result as SessionAuthenticated).fromCache, isFalse);
  });

  test('token + online + /me 401 → unauthenticated (refresh already failed)', () async {
    when(storage.hasTokens).thenAnswer((_) async => true);
    when(() => network.isOnline).thenAnswer((_) async => true);
    when(currentUserApi.me).thenThrow(_dio('/me', status: 401));

    expect(await repository.resolve(), isA<SessionUnauthenticated>());
  });

  test('token + online + connectivity error → authenticated from cache', () async {
    when(storage.hasTokens).thenAnswer((_) async => true);
    when(() => network.isOnline).thenAnswer((_) async => true);
    when(currentUserApi.me)
        .thenThrow(_dio('/me', type: DioExceptionType.connectionError));

    final result = await repository.resolve();

    expect(result, isA<SessionAuthenticated>());
    expect((result as SessionAuthenticated).fromCache, isTrue);
  });

  test('token + online + server error → retryable check error', () async {
    when(storage.hasTokens).thenAnswer((_) async => true);
    when(() => network.isOnline).thenAnswer((_) async => true);
    when(currentUserApi.me).thenThrow(_dio('/me', status: 500));

    expect(await repository.resolve(), isA<SessionCheckError>());
  });
}
