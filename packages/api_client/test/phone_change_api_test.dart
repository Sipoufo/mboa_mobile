import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for PhoneChangeApi
void main() {
  final instance = ApiClient().getPhoneChangeApi();

  group(PhoneChangeApi, () {
    // Step 2: verify both codes and switch the number
    //
    //Future<PhoneChangeResponse> confirmChange(ConfirmPhoneChangeRequest confirmPhoneChangeRequest) async
    test('test confirmChange', () async {
      // TODO
    });

    // Step 1: request OTPs on the current and the new number
    //
    //Future requestChange(RequestPhoneChangeRequest requestPhoneChangeRequest) async
    test('test requestChange', () async {
      // TODO
    });

  });
}
