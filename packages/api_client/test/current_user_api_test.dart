import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for CurrentUserApi
void main() {
  final instance = ApiClient().getCurrentUserApi();

  group(CurrentUserApi, () {
    // Get the currently authenticated account
    //
    //Future<MeResponse> getMe() async
    test('test getMe', () async {
      // TODO
    });

  });
}
