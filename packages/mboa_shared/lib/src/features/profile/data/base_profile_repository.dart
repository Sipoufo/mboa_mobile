import 'package:mboa_core/mboa_core.dart';

import '../models/account_role.dart';
import '../models/base_profile.dart';
import 'profile_repository.dart';

/// Loads the account (`/me`) + base profile (`/users/me`) into a [BaseProfile],
/// and persists the base fields via `PUT /users/me`. App Mboa uses it directly;
/// App Mboa Pro composes it and adds the business profile on top.
class BaseProfileRepository implements ProfileRepository<BaseProfile, BaseProfileEdit> {
  BaseProfileRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  ApiClient get _api => _dioClient.api;

  @override
  Future<BaseProfile> load() async {
    final me = (await _api.getCurrentUserApi().me()).data;
    final user = (await _api.getUserProfileApi().myProfile()).data;
    return BaseProfile(
      email: me?.email,
      phoneNumber: me?.phoneNumber,
      role: AccountRole.fromResponse(me?.role),
      firstName: user?.firstName,
      lastName: user?.lastName,
      searchCity: user?.searchCity,
      searchCityId: user?.searchCityId,
      photoObjectKey: user?.photoObjectKey,
    );
  }

  @override
  Future<BaseProfile> save(BaseProfileEdit edit) async {
    await _api.getUserProfileApi().updateMyProfile(
          updateUserProfileRequest: UpdateUserProfileRequest((b) => b
            ..firstName = edit.firstName
            ..lastName = edit.lastName
            ..searchCityId = edit.searchCityId),
        );
    return load();
  }

  @override
  Future<BaseProfile> updatePhoto(String objectKey) async {
    // The update DTO fields are all optional (partial update), so sending only
    // the photo key leaves the other fields untouched.
    await _api.getUserProfileApi().updateMyProfile(
          updateUserProfileRequest: UpdateUserProfileRequest((b) => b..photoObjectKey = objectKey),
        );
    return load();
  }
}
