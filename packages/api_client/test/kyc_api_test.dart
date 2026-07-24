import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for KYCApi
void main() {
  final instance = ApiClient().getKYCApi();

  group(KYCApi, () {
    // Get the authenticated account's KYC status
    //
    //Future<KycStatusResponse> myStatus() async
    test('test myStatus', () async {
      // TODO
    });

    // Submit KYC documents (R2 object keys) for verification
    //
    //Future<KycStatusResponse> submit(SubmitKycRequest submitKycRequest) async
    test('test submit', () async {
      // TODO
    });

  });
}
