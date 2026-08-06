import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/prestataire_type.dart';
import '../models/profile_data.dart';

/// App Mboa Pro's profile repository: reuses the shared [BaseProfileRepository]
/// for the account + base profile, and adds the prestataire business profile
/// (`/prestataires/me`) — only for prestataires.
class ProProfileRepository implements ProfileRepository<ProfileData, ProfileEdit> {
  ProProfileRepository({
    required DioClient dioClient,
    required BaseProfileRepository base,
  })  : _dioClient = dioClient,
        _base = base;

  final DioClient _dioClient;
  final BaseProfileRepository _base;

  ApiClient get _api => _dioClient.api;

  @override
  Future<ProfileData> load() async {
    final base = await _base.load();
    PrestataireProfileResponse? prestataire;
    if (base.role.isPrestataire) {
      prestataire = (await _api.getPrestataireProfileApi().myProfile1()).data;
    }
    return ProfileData.fromBase(
      base,
      displayName: prestataire?.displayName,
      mainCity: prestataire?.mainCity,
      mainCityId: prestataire?.mainCityId,
      type: PrestataireType.fromResponse(prestataire?.type),
      logoObjectKey: prestataire?.logoObjectKey,
      profileComplete: prestataire?.profileComplete,
    );
  }

  @override
  Future<ProfileData> save(ProfileEdit edit) async {
    await _base.save(
      BaseProfileEdit(
        firstName: edit.firstName,
        lastName: edit.lastName,
        searchCityId: edit.searchCityId,
      ),
    );
    if (edit.isPrestataire) {
      await _api.getPrestataireProfileApi().updateMyProfile1(
            updatePrestataireProfileRequest: UpdatePrestataireProfileRequest((b) => b
              ..displayName = edit.displayName
              ..mainCityId = edit.mainCityId
              ..type = edit.type?.updateValue),
          );
    }
    return load();
  }

  /// A prestataire's avatar is their business logo, so the key goes to
  /// `/prestataires/me`; an agent has no business profile and keeps the
  /// personal photo on `/users/me`.
  @override
  Future<ProfileData> updatePhoto(String objectKey) async {
    final role = AccountRole.fromResponse((await _api.getCurrentUserApi().me()).data?.role);
    if (!role.isPrestataire) {
      await _base.updatePhoto(objectKey);
      return load();
    }

    // The other fields are re-sent with their current values rather than
    // omitted: partial-update semantics are an assumption here, and guessing
    // wrong would wipe the business profile to set an avatar.
    final current = (await _api.getPrestataireProfileApi().myProfile1()).data;
    await _api.getPrestataireProfileApi().updateMyProfile1(
          updatePrestataireProfileRequest: UpdatePrestataireProfileRequest((b) => b
            ..logoObjectKey = objectKey
            ..displayName = current?.displayName
            ..mainCityId = current?.mainCityId
            ..type = PrestataireType.fromResponse(current?.type)?.updateValue),
        );
    return load();
  }
}
