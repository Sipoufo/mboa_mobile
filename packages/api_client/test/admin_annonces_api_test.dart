import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminAnnoncesApi
void main() {
  final instance = ApiClient().getAdminAnnoncesApi();

  group(AdminAnnoncesApi, () {
    // Search listings by title or owner phone/email, filtered by status
    //
    //Future<PageResponseAnnonceResponse> listAdminAnnonces(Pageable pageable, { String query, String status }) async
    test('test listAdminAnnonces', () async {
      // TODO
    });

    // Suspend a listing with a reason; its owner is told (RM-M19-02, CA-M19-02)
    //
    //Future suspendAnnonce(String id, SuspendAnnonceRequest suspendAnnonceRequest) async
    test('test suspendAnnonce', () async {
      // TODO
    });

    // Edit a listing's content directly; its owner is told what changed (RM-M19-05)
    //
    //Future<AnnonceResponse> updateAnnonceAsAdmin(String id, UpdateAnnonceRequest updateAnnonceRequest) async
    test('test updateAnnonceAsAdmin', () async {
      // TODO
    });

  });
}
