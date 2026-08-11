import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminKYCApi
void main() {
  final instance = ApiClient().getAdminKYCApi();

  group(AdminKYCApi, () {
    // Approve a KYC submission and activate the account
    //
    //Future<KycStatusResponse> approveKycSubmission(String id) async
    test('test approveKycSubmission', () async {
      // TODO
    });

    // List pending KYC submissions (with pre-signed document URLs)
    //
    //Future<PageResponseKycReviewItem> listPendingKycSubmissions(Pageable pageable) async
    test('test listPendingKycSubmissions', () async {
      // TODO
    });

    // Reject a KYC submission with a reason
    //
    //Future<KycStatusResponse> rejectKycSubmission(String id, RejectKycRequest rejectKycRequest) async
    test('test rejectKycSubmission', () async {
      // TODO
    });

  });
}
