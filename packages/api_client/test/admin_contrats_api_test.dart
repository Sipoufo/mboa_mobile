import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminContratsApi
void main() {
  final instance = ApiClient().getAdminContratsApi();

  group(AdminContratsApi, () {
    // One archived contract, in full
    //
    //Future<ContractResponse> adminGetContract(String id) async
    test('test adminGetContract', () async {
      // TODO
    });

    // A short-lived URL to download its PDF
    //
    //Future<ContractPdfResponse> adminGetContractPdf(String id) async
    test('test adminGetContractPdf', () async {
      // TODO
    });

    // The contract archive, filterable by status
    //
    //Future<PageResponseContractResponse> adminListContracts(Pageable pageable, { BuiltList<String> status }) async
    test('test adminListContracts', () async {
      // TODO
    });

    // Try again to produce a document that never arrived (CE-M08-02)
    //
    //Future adminRegenerateContractPdf(String id) async
    test('test adminRegenerateContractPdf', () async {
      // TODO
    });

  });
}
