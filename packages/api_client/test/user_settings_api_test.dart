import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for UserSettingsApi
void main() {
  final instance = ApiClient().getUserSettingsApi();

  group(UserSettingsApi, () {
    // Get the authenticated account's settings
    //
    //Future<UserSettingsResponse> mySettings() async
    test('test mySettings', () async {
      // TODO
    });

    // Partially update the authenticated account's settings
    //
    //Future<UserSettingsResponse> updateMySettings(UpdateUserSettingsRequest updateUserSettingsRequest) async
    test('test updateMySettings', () async {
      // TODO
    });

  });
}
