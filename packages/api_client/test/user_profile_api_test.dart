import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for UserProfileApi
void main() {
  final instance = ApiClient().getUserProfileApi();

  group(UserProfileApi, () {
    // Get the authenticated user's profile
    //
    //Future<UserProfileResponse> myProfile() async
    test('test myProfile', () async {
      // TODO
    });

    // Partially update the authenticated user's profile
    //
    //Future<UserProfileResponse> updateMyProfile(UpdateUserProfileRequest updateUserProfileRequest) async
    test('test updateMyProfile', () async {
      // TODO
    });

  });
}
