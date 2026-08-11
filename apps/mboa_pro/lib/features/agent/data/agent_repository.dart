import 'package:built_collection/built_collection.dart';
import 'package:mboa_core/mboa_core.dart';

import '../models/agent_profile.dart';
import '../models/availability.dart';

/// The agent's own profile and zones (CDC M15).
///
/// `/agents/me` is a **separate record** from `/users/me`, with its own name and
/// photo. It is the one `profileComplete` and the prestataire's candidate list
/// read, so it is the one the agent screens must write.
class AgentRepository {
  AgentRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  AgentApi get _api => _dioClient.api.getAgentApi();

  Future<AgentProfile> load() async {
    final response = await _api.getMyAgentProfile();
    final data = response.data;
    if (data == null) throw StateError('No agent profile for this account');
    return AgentProfile.fromResponse(data);
  }

  /// Partial update — only the fields given are sent.
  Future<AgentProfile> save({
    String? firstName,
    String? lastName,
    String? photoObjectKey,
    bool? acceptingAssignments,
  }) async {
    final response = await _api.updateMyAgentProfile(
      updateAgentProfileRequest: UpdateAgentProfileRequest((b) => b
        ..firstName = firstName
        ..lastName = lastName
        ..photoObjectKey = photoObjectKey
        ..acceptingAssignments = acceptingAssignments),
    );
    final data = response.data;
    if (data == null) throw StateError('update returned no agent profile');
    return AgentProfile.fromResponse(data);
  }

  /// RM-M15-04. Both lists are sent every time — this replaces the set rather
  /// than adding to it. The backend rejects a request where both are empty, so
  /// the picker must keep at least one selection.
  Future<AgentProfile> saveZones({
    required List<String> cityIds,
    required List<String> districtIds,
  }) async {
    final response = await _api.updateMyAgentZones(
      updateZonesRequest: UpdateZonesRequest((b) => b
        ..cityIds = ListBuilder<String>(cityIds)
        ..districtIds = ListBuilder<String>(districtIds)),
    );
    final data = response.data;
    if (data == null) throw StateError('zones update returned no profile');
    return AgentProfile.fromResponse(data);
  }
}

/// Weekly availability, visit duration and days off (RM-M15-01 / RM-M15-03).
class AgentAvailabilityRepository {
  AgentAvailabilityRepository({required DioClient dioClient})
      : _dioClient = dioClient;

  final DioClient _dioClient;

  AgentApi get _api => _dioClient.api.getAgentApi();

  Future<Availability> load() async {
    final response = await _api.getMyAgentAvailability();
    final data = response.data;
    if (data == null) return const Availability();
    return Availability.fromResponse(data);
  }

  /// Replaces the whole weekly pattern — the endpoint is a PUT, so a rule left
  /// out is a rule deleted.
  Future<Availability> save(Availability availability) async {
    final response = await _api.updateMyAgentAvailability(
      updateAvailabilityRequest: UpdateAvailabilityRequest((b) => b
        ..rules = ListBuilder<AvailabilityRuleRequest>(
          availability.rules.map((r) => r.toRequest()),
        )
        ..visitDurationMinutes = availability.visitDurationMinutes),
    );
    final data = response.data;
    if (data == null) return availability;
    return Availability.fromResponse(data);
  }

  /// RM-M15-03 — blocking a day auto-cancels the visits already booked on it,
  /// which is why this is immediate rather than batched behind a save button.
  Future<void> blockDay(DateTime day) => _api.blockMyAgentDay(
        blockDayRequest: BlockDayRequest((b) => b..day = day.toDate()),
      );

  Future<void> unblockDay(DateTime day) => _api.unblockMyAgentDay(
        day: day.toDate(),
      );
}
