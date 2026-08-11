import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for UserProfileApi
void main() {
  final instance = ApiClient().getUserProfileApi();

  group(UserProfileApi, () {
    // Get the authenticated user's profile
    //
    //Future<UserProfileResponse> getMyUserProfile() async
    test('test getMyUserProfile', () async {
      // TODO
    });

    // Partially update the authenticated user's profile
    //
    //Future<UserProfileResponse> updateMyUserProfile(UpdateUserProfileRequest updateUserProfileRequest) async
    test('test updateMyUserProfile', () async {
      // TODO
    });

  });
}
