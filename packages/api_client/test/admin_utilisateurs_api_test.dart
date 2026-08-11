import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminUtilisateursApi
void main() {
  final instance = ApiClient().getAdminUtilisateursApi();

  group(AdminUtilisateursApi, () {
    // Search accounts by phone or email, with their subscription (RM-M18-01)
    //
    //Future<PageResponseAdminUserSummary> listAdminUsers(Pageable pageable, { String query, String role, String status }) async
    test('test listAdminUsers', () async {
      // TODO
    });

    // Lift a suspension
    //
    //Future reactivateAccount(String id) async
    test('test reactivateAccount', () async {
      // TODO
    });

    // Suspend an account; sessions are revoked at once (RM-M18-02)
    //
    //Future suspendAccount(String id, SuspendAccountRequest suspendAccountRequest) async
    test('test suspendAccount', () async {
      // TODO
    });

  });
}
