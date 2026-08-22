import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/prestataire_type.dart';
import '../models/profile_data.dart';

/// App Mboa Pro's profile repository: reuses the shared [BaseProfileRepository]
/// for the account, and layers the role's own record on top.
///
/// **Each role's identity lives somewhere different**, and only one of the three
/// is authoritative for a given account:
///
/// - a **prestataire**'s business identity is `/prestataires/me` — display name,
///   type, city, and `logoObjectKey` as the avatar;
/// - an **agent**'s identity is `/agents/me`, which has its **own** name and
///   photo. The record is created empty on first read and nothing is copied
///   from `/users/me`, so the base profile is not merely secondary for an agent
///   — it is unrelated. `profileComplete` and the prestataire-facing
///   `AgentCandidate` card both read the agent record;
/// - everyone else is just `/users/me`.
///
/// Writing the wrong one is silent: the app shows the new photo, the server
/// still reports the profile incomplete, and the agent is never offered work
/// with nothing on screen explaining why.
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

    if (base.role.isPrestataire) {
      final prestataire =
          (await _api.getPrestataireProfileApi().getMyPrestataireProfile()).data;
      return ProfileData.fromBase(
        base,
        displayName: prestataire?.displayName,
        mainCity: prestataire?.mainCity,
        mainCityId: prestataire?.mainCityId,
        type: PrestataireType.fromResponse(prestataire?.type),
        logoObjectKey: prestataire?.logoObjectKey,
        registrationNumber: prestataire?.registrationNumber,
        profileComplete: prestataire?.profileComplete,
      );
    }

    if (base.role.isAgent) {
      // Overlay the agent record's own name and photo, so the shared chrome
      // shows what the agent actually set rather than an empty base profile.
      final agent = (await _api.getAgentApi().getMyAgentProfile()).data;
      return ProfileData.fromBase(
        base.copyWith(
          firstName: agent?.firstName,
          lastName: agent?.lastName,
          photoObjectKey: agent?.photoObjectKey,
        ),
        profileComplete: agent?.profileComplete,
      );
    }

    return ProfileData.fromBase(base);
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
      await _api.getPrestataireProfileApi().updateMyPrestataireProfile(
            updatePrestataireProfileRequest: UpdatePrestataireProfileRequest((b) => b
              ..displayName = edit.displayName
              ..mainCityId = edit.mainCityId
              ..registrationNumber = edit.registrationNumber
              ..type = edit.type?.updateValue),
          );
    } else if (edit.isAgent) {
      // The agent record carries the name the prestataire sees when choosing a
      // candidate, so it has to be written too — the base profile alone would
      // leave the agent nameless everywhere that matters.
      await _api.getAgentApi().updateMyAgentProfile(
            updateAgentProfileRequest: UpdateAgentProfileRequest((b) => b
              ..firstName = edit.firstName
              ..lastName = edit.lastName),
          );
    }

    return load();
  }

  @override
  Future<ProfileData> updatePhoto(String objectKey) async {
    final role =
        AccountRole.fromResponse((await _api.getCurrentUserApi().getMe()).data?.role);

    if (role.isPrestataire) {
      // The other fields are re-sent with their current values rather than
      // omitted: partial-update semantics are an assumption here, and guessing
      // wrong would wipe the business profile to set an avatar.
      final current =
          (await _api.getPrestataireProfileApi().getMyPrestataireProfile()).data;
      await _api.getPrestataireProfileApi().updateMyPrestataireProfile(
            updatePrestataireProfileRequest: UpdatePrestataireProfileRequest((b) => b
              ..logoObjectKey = objectKey
              ..displayName = current?.displayName
              ..mainCityId = current?.mainCityId
              // Re-sent like the rest: partial-update semantics are an
              // assumption here, and omitting a field would wipe it to set an
              // avatar. The contract's identity line is not worth that risk.
              ..registrationNumber = current?.registrationNumber
              ..type = PrestataireType.fromResponse(current?.type)?.updateValue),
          );
      return load();
    }

    if (role.isAgent) {
      await _api.getAgentApi().updateMyAgentProfile(
            updateAgentProfileRequest:
                UpdateAgentProfileRequest((b) => b..photoObjectKey = objectKey),
          );
      return load();
    }

    await _base.updatePhoto(objectKey);
    return load();
  }
}
