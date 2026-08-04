import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for PasswordApi
void main() {
  final instance = ApiClient().getPasswordApi();

  group(PasswordApi, () {
    // Change the password (revokes other sessions)
    //
    //Future changePassword(ChangePasswordRequest changePasswordRequest) async
    test('test changePassword', () async {
      // TODO
    });

  });
}
