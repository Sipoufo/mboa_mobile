import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for ContratsApi
void main() {
  final instance = ApiClient().getContratsApi();

  group(ContratsApi, () {
    // Accept the terms; signing opens for both parties
    //
    //Future<ContractResponse> acceptContract(String id) async
    test('test acceptContract', () async {
      // TODO
    });

    // Call the contract off — either party, up to the second signature
    //
    //Future cancelContract(String id) async
    test('test cancelContract', () async {
      // TODO
    });

    // Draw up a contract on one of your listings (RM-M08-01)
    //
    //Future<ContractResponse> createContract(CreateContractRequest createContractRequest) async
    test('test createContract', () async {
      // TODO
    });

    // One contract; its exact address appears only once signed (CA-M08-02)
    //
    //Future<ContractResponse> getContract(String id) async
    test('test getContract', () async {
      // TODO
    });

    // A short-lived URL to download the signed contract's PDF (CA-M08-01)
    //
    //Future<ContractPdfResponse> getContractPdf(String id) async
    test('test getContractPdf', () async {
      // TODO
    });

    // Your contracts, as landlord or as tenant
    //
    //Future<PageResponseContractResponse> listMyContracts(Pageable pageable, { BuiltList<String> status }) async
    test('test listMyContracts', () async {
      // TODO
    });

    // Ask the landlord to change the terms, with a comment (CE-M08-03)
    //
    //Future<ContractResponse> requestContractChanges(String id, RequestChangesRequest requestChangesRequest) async
    test('test requestContractChanges', () async {
      // TODO
    });

    // Answer one objection — whether or not you amend the terms (CE-M08-03)
    //
    //Future<ContractResponse> respondToContractChange(String id, String changeId, RespondToChangeRequest respondToChangeRequest) async
    test('test respondToContractChange', () async {
      // TODO
    });

    // Send the draft to the tenant for signature (N-07)
    //
    //Future<ContractResponse> sendContract(String id) async
    test('test sendContract', () async {
      // TODO
    });

    // Sign; the second signature locks the contract for good (RM-M08-03)
    //
    //Future<ContractResponse> signContract(String id, { SignContractRequest signContractRequest }) async
    test('test signContract', () async {
      // TODO
    });

    // Amend terms nobody has accepted or signed yet (RM-M08-03)
    //
    //Future<ContractResponse> updateContract(String id, UpdateContractRequest updateContractRequest) async
    test('test updateContract', () async {
      // TODO
    });

    // Correct your own objection while it is still unanswered
    //
    //Future<ContractResponse> updateContractChange(String id, String changeId, RequestChangesRequest requestChangesRequest) async
    test('test updateContractChange', () async {
      // TODO
    });

    // Check a printed contract is genuine — public, needs the code on the document (RM-M08-04)
    //
    //Future<ContractVerification> verifyContract(String id, String code) async
    test('test verifyContract', () async {
      // TODO
    });

    // Take your objection back; the last one returns the contract to you
    //
    //Future<ContractResponse> withdrawContractChange(String id, String changeId) async
    test('test withdrawContractChange', () async {
      // TODO
    });

  });
}
