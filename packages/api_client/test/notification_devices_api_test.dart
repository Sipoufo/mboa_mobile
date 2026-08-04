import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for NotificationDevicesApi
void main() {
  final instance = ApiClient().getNotificationDevicesApi();

  group(NotificationDevicesApi, () {
    // Register or refresh a device push token
    //
    //Future register(RegisterDeviceRequest registerDeviceRequest) async
    test('test register', () async {
      // TODO
    });

    // Unregister a device push token
    //
    //Future unregister(String token) async
    test('test unregister', () async {
      // TODO
    });

  });
}
