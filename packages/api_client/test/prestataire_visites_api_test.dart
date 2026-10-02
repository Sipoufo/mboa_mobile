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

    // One visit the prestataire carries out: the client's name and phone (RM-M16-01)
    //
    //Future<AgentVisiteDetail> getMyOwnerVisite(String id) async
    test('test getMyOwnerVisite', () async {
      // TODO
    });

    // Visits the prestataire carries out themselves, newest first
    //
    //Future<PageResponseVisiteResponse> listMyOwnerVisites(Pageable pageable, { BuiltList<String> status, DateTime from, DateTime to }) async
    test('test listMyOwnerVisites', () async {
      // TODO
    });

  });
}
