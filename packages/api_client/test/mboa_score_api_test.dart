import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for MboaScoreApi
void main() {
  final instance = ApiClient().getMboaScoreApi();

  group(MboaScoreApi, () {
    // The authenticated user's Mboa Score and its breakdown
    //
    //Future<MboaScoreResponse> getMyMboaScore() async
    test('test getMyMboaScore', () async {
      // TODO
    });

    // A tenant's Mboa Score, once they have messaged you or asked to visit (RM-M09-04)
    //
    //Future<MboaScoreResponse> getTenantMboaScore(String userId) async
    test('test getTenantMboaScore', () async {
      // TODO
    });

  });
}
