import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for UserSettingsApi
void main() {
  final instance = ApiClient().getUserSettingsApi();

  group(UserSettingsApi, () {
    // Get the authenticated account's settings
    //
    //Future<UserSettingsResponse> getMyUserSettings() async
    test('test getMyUserSettings', () async {
      // TODO
    });

    // Partially update the authenticated account's settings
    //
    //Future<UserSettingsResponse> updateMyUserSettings(UpdateUserSettingsRequest updateUserSettingsRequest) async
    test('test updateMyUserSettings', () async {
      // TODO
    });

  });
}
