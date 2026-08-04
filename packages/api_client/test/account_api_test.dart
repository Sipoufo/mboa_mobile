import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AccountApi
void main() {
  final instance = ApiClient().getAccountApi();

  group(AccountApi, () {
    // Delete the authenticated account (RGPD): anonymises personal data
    //
    //Future deleteMyAccount() async
    test('test deleteMyAccount', () async {
      // TODO
    });

  });
}
