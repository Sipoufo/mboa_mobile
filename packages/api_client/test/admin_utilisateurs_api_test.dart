import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminUtilisateursApi
void main() {
  final instance = ApiClient().getAdminUtilisateursApi();

  group(AdminUtilisateursApi, () {
    // Step two: anonymise the account, irreversibly, with the token and a reason (RM-M18-03)
    //
    //Future deleteAccount(String id, DeleteAccountRequest deleteAccountRequest) async
    test('test deleteAccount', () async {
      // TODO
    });

    // One account's full history: moderation, visits, contracts, reports, Mboa Score (RM-M18-04)
    //
    //Future<AdminUserDetail> getAdminUser(String id) async
    test('test getAdminUser', () async {
      // TODO
    });

    // Search accounts by phone, email, name or internal id, with their subscription (RM-M18-01)
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

    // Step one of deleting an account: a confirmation token valid 10 minutes (RM-M18-03)
    //
    //Future<DeletionChallengeResponse> requestAccountDeletion(String id) async
    test('test requestAccountDeletion', () async {
      // TODO
    });

    // Suspend an account for `days` (1–365) or until lifted; sessions are revoked at once (RM-M18-02)
    //
    //Future suspendAccount(String id, SuspendAccountRequest suspendAccountRequest) async
    test('test suspendAccount', () async {
      // TODO
    });

  });
}
