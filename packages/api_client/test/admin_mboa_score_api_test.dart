import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminMboaScoreApi
void main() {
  final instance = ApiClient().getAdminMboaScoreApi();

  group(AdminMboaScoreApi, () {
    // Adjust a user's Mboa Score by hand, with a mandatory reason (RM-M18-05)
    //
    //Future<AdminMboaScoreResponse> adjustMboaScore(String userId, ScoreAdjustmentRequest scoreAdjustmentRequest) async
    test('test adjustMboaScore', () async {
      // TODO
    });

    // A user's Mboa Score with its adjustment trail
    //
    //Future<AdminMboaScoreResponse> getAdminMboaScore(String userId) async
    test('test getAdminMboaScore', () async {
      // TODO
    });

  });
}
