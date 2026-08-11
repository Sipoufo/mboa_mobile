import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AgentCandidaturesApi
void main() {
  final instance = ApiClient().getAgentCandidaturesApi();

  group(AgentCandidaturesApi, () {
    // Applications the agent has sent, newest first
    //
    //Future<PageResponseAssignmentItem> listMyAgentApplications(Pageable pageable, { BuiltList<String> status }) async
    test('test listMyAgentApplications', () async {
      // TODO
    });

    // Withdraw an application nobody has answered
    //
    //Future withdrawMyAgentApplication(String id) async
    test('test withdrawMyAgentApplication', () async {
      // TODO
    });

    // Withdraw a whole residence application at once (RM-M10bis-10)
    //
    //Future<BatchResult> withdrawResidenceApplication(String residenceId) async
    test('test withdrawResidenceApplication', () async {
      // TODO
    });

  });
}
