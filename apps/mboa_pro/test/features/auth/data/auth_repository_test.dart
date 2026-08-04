import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/auth/data/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class _FakeLogoutRequest extends Fake implements LogoutRequest {}

Response<T> _response<T>(String path, {T? data}) =>
    Response<T>(requestOptions: RequestOptions(path: path), data: data);

void main() {
  setUpAll(() => registerFallbackValue(_FakeLogoutRequest()));

  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockAuthApi authApi;
  late MockSecureTokenStorage storage;
  late AuthRepository repository;

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    authApi = MockAuthApi();
    storage = MockSecureTokenStorage();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getAuthenticationApi).thenReturn(authApi);
    when(() => storage.clear()).thenAnswer((_) async {});

    repository = AuthRepository(dioClient: dioClient, tokenStorage: storage);
  });

  test('revokes the refresh token server-side then clears local tokens', () async {
    when(() => storage.readRefreshToken()).thenAnswer((_) async => 'refresh_1');
    when(() => authApi.logout(logoutRequest: any(named: 'logoutRequest')))
        .thenAnswer((_) async => _response<void>('/auth/logout'));

    await repository.logout();

    verify(() => authApi.logout(logoutRequest: any(named: 'logoutRequest'))).called(1);
    verify(() => storage.clear()).called(1);
  });

  test('still clears local tokens when the revoke call fails (best-effort)', () async {
    when(() => storage.readRefreshToken()).thenAnswer((_) async => 'refresh_1');
    when(() => authApi.logout(logoutRequest: any(named: 'logoutRequest')))
        .thenThrow(Exception('network'));

    await repository.logout();

    verify(() => storage.clear()).called(1);
  });

  test('skips the revoke call when there is no refresh token', () async {
    when(() => storage.readRefreshToken()).thenAnswer((_) async => null);

    await repository.logout();

    verifyNever(() => authApi.logout(logoutRequest: any(named: 'logoutRequest')));
    verify(() => storage.clear()).called(1);
  });
}
