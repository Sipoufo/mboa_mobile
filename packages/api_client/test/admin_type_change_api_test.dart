import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminTypeChangeApi
void main() {
  final instance = ApiClient().getAdminTypeChangeApi();

  group(AdminTypeChangeApi, () {
    // Approve a type-change request and apply the new type
    //
    //Future<TypeChangeReviewResult> approve(String id) async
    test('test approve', () async {
      // TODO
    });

    // List pending type-change requests
    //
    //Future<PageResponseTypeChangeReviewItem> listPending(Pageable pageable) async
    test('test listPending', () async {
      // TODO
    });

    // Reject a type-change request with a reason
    //
    //Future<TypeChangeReviewResult> reject(String id, RejectTypeChangeRequest rejectTypeChangeRequest) async
    test('test reject', () async {
      // TODO
    });

  });
}
