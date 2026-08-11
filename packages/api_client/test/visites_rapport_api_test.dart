import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for VisitesRapportApi
void main() {
  final instance = ApiClient().getVisitesRapportApi();

  group(VisitesRapportApi, () {
    // The agent's report on a visit — user, agent and prestataire only
    //
    //Future<VisiteReportResponse> getVisiteReport(String id) async
    test('test getVisiteReport', () async {
      // TODO
    });

  });
}
