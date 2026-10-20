import 'package:api_client/api_client.dart' as api;
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockNotificationDevicesApi extends Mock implements api.NotificationDevicesApi {}

class MockSettings extends Mock implements NotificationSettings {}

class _FakeRegister extends Fake implements api.RegisterDeviceRequest {}

/// M03 (RM-M03-02) — the server is told whether the phone shows
/// notifications; when none of an account's devices does, contract pushes go
/// out by SMS too.
void main() {
  late MockFirebaseMessaging messaging;
  late MockNotificationDevicesApi devices;
  late NotificationsRepository repository;

  NotificationSettings settings(AuthorizationStatus status) {
    final s = MockSettings();
    when(() => s.authorizationStatus).thenReturn(status);
    return s;
  }

  setUpAll(() => registerFallbackValue(_FakeRegister()));

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    final dioClient = MockDioClient();
    final apiClient = MockApiClient();
    messaging = MockFirebaseMessaging();
    devices = MockNotificationDevicesApi();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getNotificationDevicesApi).thenReturn(devices);
    when(() => devices.registerDevice(registerDeviceRequest: any(named: 'registerDeviceRequest'))).thenAnswer(
      (_) async => Response<void>(requestOptions: RequestOptions(path: '/notifications/devices')),
    );
    when(() => messaging.getToken()).thenAnswer((_) async => 'tok');
    when(() => messaging.onTokenRefresh).thenAnswer((_) => const Stream.empty());
    repository = NotificationsRepository(dioClient: dioClient, messaging: messaging);
  });

  List<api.RegisterDeviceRequest> registered() =>
      verify(() => devices.registerDevice(registerDeviceRequest: captureAny(named: 'registerDeviceRequest')))
          .captured
          .cast<api.RegisterDeviceRequest>();

  test('a refused permission is said at registration', () async {
    when(() => messaging.requestPermission()).thenAnswer((_) async => settings(AuthorizationStatus.denied));

    await repository.start();

    expect(registered().single.pushEnabled, isFalse);
  });

  test('turned on later in the phone\'s settings: the same token, registered again', () async {
    when(() => messaging.requestPermission()).thenAnswer((_) async => settings(AuthorizationStatus.denied));
    await repository.start();
    registered();

    when(() => messaging.getNotificationSettings()).thenAnswer((_) async => settings(AuthorizationStatus.authorized));
    await repository.syncPermission();

    final again = registered().single;
    expect(again.token, 'tok');
    expect(again.pushEnabled, isTrue);
  });

  test('unchanged: nothing is sent again', () async {
    when(() => messaging.requestPermission()).thenAnswer((_) async => settings(AuthorizationStatus.authorized));
    await repository.start();
    registered();

    when(() => messaging.getNotificationSettings()).thenAnswer((_) async => settings(AuthorizationStatus.authorized));
    await repository.syncPermission();

    verifyNever(() => devices.registerDevice(registerDeviceRequest: any(named: 'registerDeviceRequest')));
  });
}
