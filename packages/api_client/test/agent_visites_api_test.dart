import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AgentVisitesApi
void main() {
  final instance = ApiClient().getAgentVisitesApi();

  group(AgentVisitesApi, () {
    // Cancel a visit, up to one hour before the slot (RM-M16-04)
    //
    //Future cancelAgentVisite(String id) async
    test('test cancelAgentVisite', () async {
      // TODO
    });

    // One visit in full: exact address, both contacts, whether it can start (RM-M16-01)
    //
    //Future<AgentVisiteDetail> getMyAgentVisite(String id) async
    test('test getMyAgentVisite', () async {
      // TODO
    });

    // Visits assigned to the authenticated agent
    //
    //Future<PageResponseVisiteResponse> listMyAgentVisites(Pageable pageable, { BuiltList<String> status, DateTime from, DateTime to }) async
    test('test listMyAgentVisites', () async {
      // TODO
    });

    // The agent's round for today, soonest first
    //
    //Future<BuiltList<VisiteResponse>> listMyAgentVisitesToday() async
    test('test listMyAgentVisitesToday', () async {
      // TODO
    });

  });
}
