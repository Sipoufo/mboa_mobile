import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AgentApi
void main() {
  final instance = ApiClient().getAgentApi();

  group(AgentApi, () {
    // Block a whole day off (congés — RM-M15-03)
    //
    //Future blockMyAgentDay(BlockDayRequest blockDayRequest) async
    test('test blockMyAgentDay', () async {
      // TODO
    });

    // The agent's weekly working pattern, visit length and days off
    //
    //Future<AvailabilityResponse> getMyAgentAvailability() async
    test('test getMyAgentAvailability', () async {
      // TODO
    });

    // Get the authenticated agent's profile
    //
    //Future<AgentProfileResponse> getMyAgentProfile() async
    test('test getMyAgentProfile', () async {
      // TODO
    });

    // Days the agent has blocked off
    //
    //Future<BuiltList<Date>> listMyAgentDaysOff() async
    test('test listMyAgentDaysOff', () async {
      // TODO
    });

    // Reopen a blocked day
    //
    //Future unblockMyAgentDay(Date day) async
    test('test unblockMyAgentDay', () async {
      // TODO
    });

    // Replace the weekly pattern, e.g. Mon-Sat 08:00-18:00 (RM-M15-01)
    //
    //Future<AvailabilityResponse> updateMyAgentAvailability(UpdateAvailabilityRequest updateAvailabilityRequest) async
    test('test updateMyAgentAvailability', () async {
      // TODO
    });

    // Update the agent's profile; acceptingAssignments=false is \"Inactif\" (RM-M15-05)
    //
    //Future<AgentProfileResponse> updateMyAgentProfile(UpdateAgentProfileRequest updateAgentProfileRequest) async
    test('test updateMyAgentProfile', () async {
      // TODO
    });

    // Replace the agent's intervention zones — cities and/or districts (RM-M15-04)
    //
    //Future<AgentProfileResponse> updateMyAgentZones(UpdateZonesRequest updateZonesRequest) async
    test('test updateMyAgentZones', () async {
      // TODO
    });

  });
}
