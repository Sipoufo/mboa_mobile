import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminTypeChangeApi
void main() {
  final instance = ApiClient().getAdminTypeChangeApi();

  group(AdminTypeChangeApi, () {
    // Approve a type-change request and apply the new type
    //
    //Future<TypeChangeReviewResult> approveTypeChangeRequest(String id) async
    test('test approveTypeChangeRequest', () async {
      // TODO
    });

    // List pending type-change requests
    //
    //Future<PageResponseTypeChangeReviewItem> listPendingTypeChangeRequests(Pageable pageable) async
    test('test listPendingTypeChangeRequests', () async {
      // TODO
    });

    // Reject a type-change request with a reason
    //
    //Future<TypeChangeReviewResult> rejectTypeChangeRequest(String id, RejectTypeChangeRequest rejectTypeChangeRequest) async
    test('test rejectTypeChangeRequest', () async {
      // TODO
    });

  });
}
