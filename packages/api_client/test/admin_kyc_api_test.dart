import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminKYCApi
void main() {
  final instance = ApiClient().getAdminKYCApi();

  group(AdminKYCApi, () {
    // Approve a KYC submission and activate the account
    //
    //Future<KycStatusResponse> approve(String id) async
    test('test approve', () async {
      // TODO
    });

    // List pending KYC submissions (with pre-signed document URLs)
    //
    //Future<PageResponseKycReviewItem> listPending(Pageable pageable) async
    test('test listPending', () async {
      // TODO
    });

    // Reject a KYC submission with a reason
    //
    //Future<KycStatusResponse> reject(String id, RejectKycRequest rejectKycRequest) async
    test('test reject', () async {
      // TODO
    });

  });
}
