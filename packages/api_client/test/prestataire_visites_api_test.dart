import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for PrestataireVisitesApi
void main() {
  final instance = ApiClient().getPrestataireVisitesApi();

  group(PrestataireVisitesApi, () {
    // Cancel a visit up to one hour before the slot; the client is told (N-05)
    //
    //Future cancelMyOwnerVisite(String id) async
    test('test cancelMyOwnerVisite', () async {
      // TODO
    });

    // Confirm a proposed time; the visit becomes scheduled (RM-M15-06)
    //
    //Future<VisiteResponse> confirmVisiteRequest(String id) async
    test('test confirmVisiteRequest', () async {
      // TODO
    });

    // Turn a proposed time down; the client may propose another
    //
    //Future<VisiteResponse> declineVisiteRequest(String id) async
    test('test declineVisiteRequest', () async {
      // TODO
    });

    // One visit on the prestataire's listing: theirs, or an agent's read only (mobile §40 D)
    //
    //Future<AgentVisiteDetail> getMyOwnerVisite(String id) async
    test('test getMyOwnerVisite', () async {
      // TODO
    });

    // Visits on the prestataire's listings — theirs (default), their agents', or both — newest first
    //
    //Future<PageResponseVisiteResponse> listMyOwnerVisites(Pageable pageable, { String conductedBy, String annonceId, BuiltList<String> status, DateTime from, DateTime to }) async
    test('test listMyOwnerVisites', () async {
      // TODO
    });

  });
}
