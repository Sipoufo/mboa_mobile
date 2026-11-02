import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for EmailChangeApi
void main() {
  final instance = ApiClient().getEmailChangeApi();

  group(EmailChangeApi, () {
    // Step 2: verify the codes and switch the email
    //
    //Future<EmailChangeResponse> confirmEmailChange(ConfirmEmailChangeRequest confirmEmailChangeRequest) async
    test('test confirmEmailChange', () async {
      // TODO
    });

    // Step 1: codes to the new address and to the phone
    //
    //Future requestEmailChange(RequestEmailChangeRequest requestEmailChangeRequest) async
    test('test requestEmailChange', () async {
      // TODO
    });

  });
}
