import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for NotificationDevicesApi
void main() {
  final instance = ApiClient().getNotificationDevicesApi();

  group(NotificationDevicesApi, () {
    // Register or refresh a device push token
    //
    //Future registerDevice(RegisterDeviceRequest registerDeviceRequest) async
    test('test registerDevice', () async {
      // TODO
    });

    // Unregister a device push token
    //
    //Future unregisterDevice(String token) async
    test('test unregisterDevice', () async {
      // TODO
    });

  });
}
