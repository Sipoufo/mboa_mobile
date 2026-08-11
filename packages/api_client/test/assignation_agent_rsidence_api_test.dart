import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AssignationAgentRsidenceApi
void main() {
  final instance = ApiClient().getAssignationAgentRsidenceApi();

  group(AssignationAgentRsidenceApi, () {
    // Choose this agent for the residence; rival applications on those units are declined
    //
    //Future<ResidenceAssignmentResult> acceptResidenceApplication(String residenceId, String agentAccountId) async
    test('test acceptResidenceApplication', () async {
      // TODO
    });

    // Offer every published unit to one agent; units that already have one are skipped
    //
    //Future<ResidenceAssignmentResult> assignAgentToResidence(String residenceId, AssignAgentRequest assignAgentRequest) async
    test('test assignAgentToResidence', () async {
      // TODO
    });

    // Turn one agent's residence application down
    //
    //Future<BatchResult> declineResidenceApplication(String residenceId, String agentAccountId) async
    test('test declineResidenceApplication', () async {
      // TODO
    });

    // Agents who cover this residence's area; query matches a name or phone
    //
    //Future<BuiltList<AgentCandidate>> listResidenceAgentCandidates(String residenceId, { String query }) async
    test('test listResidenceAgentCandidates', () async {
      // TODO
    });

    // Agents who applied, one entry each with their unit count (RM-M10bis-09)
    //
    //Future<BuiltList<ResidenceApplicationSummary>> listResidenceApplications(String residenceId) async
    test('test listResidenceApplications', () async {
      // TODO
    });

    // The residence's assignments unit by unit — which room has whom
    //
    //Future<BuiltList<AssignmentResponse>> listResidenceAssignments(String residenceId, { BuiltList<String> status }) async
    test('test listResidenceAssignments', () async {
      // TODO
    });

    // Take the whole residence back; each unit's planned visits are cancelled
    //
    //Future<BatchResult> withdrawResidenceAgentAssignment(String residenceId) async
    test('test withdrawResidenceAgentAssignment', () async {
      // TODO
    });

  });
}
