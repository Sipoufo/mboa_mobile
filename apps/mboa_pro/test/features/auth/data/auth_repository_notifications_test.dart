import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/auth/data/auth_repository.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockNotificationsRepository extends Mock
    implements NotificationsRepository {}

/// Logout has to revoke the push registration *before* the tokens are cleared —
/// both are authenticated calls. Get the order wrong and the unregister 401s,
/// leaving the device receiving pushes for a signed-out account.
void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockAuthApi authApi;
  late MockSecureTokenStorage storage;
  late MockNotificationsRepository notifications;
  late AuthRepository repository;
  late List<String> calls;

  setUpAll(() => registerFallbackValue(LogoutRequest((b) => b..refreshToken = '')));

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    authApi = MockAuthApi();
    storage = MockSecureTokenStorage();
    notifications = MockNotificationsRepository();
    calls = [];

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getAuthenticationApi).thenReturn(authApi);
    when(() => storage.readRefreshToken()).thenAnswer((_) async => 'refresh');

    when(notifications.stop).thenAnswer((_) async => calls.add('unregister'));
    when(() => authApi.logout(logoutRequest: any(named: 'logoutRequest')))
        .thenAnswer((_) async {
      calls.add('revoke');
      return Response(
        requestOptions: RequestOptions(path: '/auth/logout'),
        statusCode: 200,
      );
    });
    when(storage.clear).thenAnswer((_) async => calls.add('clear'));

    repository = AuthRepository(
      dioClient: dioClient,
      tokenStorage: storage,
      notifications: notifications,
    );
  });

  test('revokes the device, then the refresh token, then clears', () async {
    await repository.logout();

    expect(calls, ['unregister', 'revoke', 'clear']);
  });

  test('still clears when the device unregister fails', () async {
    when(notifications.stop).thenThrow(Exception('offline'));

    // A failed deregistration must not strand the user signed-in.
    await expectLater(repository.logout(), completes);
    expect(calls, ['revoke', 'clear']);
  });

  test('works without a notifications repository (mboa_user today)', () async {
    final bare = AuthRepository(dioClient: dioClient, tokenStorage: storage);

    await bare.logout();

    expect(calls, ['revoke', 'clear']);
  });
}
