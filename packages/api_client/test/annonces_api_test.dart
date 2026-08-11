import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AnnoncesApi
void main() {
  final instance = ApiClient().getAnnoncesApi();

  group(AnnoncesApi, () {
    // Archive a listing
    //
    //Future<AnnonceResponse> archiveAnnonce(String id) async
    test('test archiveAnnonce', () async {
      // TODO
    });

    // Create a listing (draft)
    //
    //Future<AnnonceResponse> createAnnonce(CreateAnnonceRequest createAnnonceRequest) async
    test('test createAnnonce', () async {
      // TODO
    });

    // Delete one of the authenticated prestataire's listings
    //
    //Future deleteAnnonce(String id) async
    test('test deleteAnnonce', () async {
      // TODO
    });

    // Get one of the authenticated prestataire's listings
    //
    //Future<AnnonceResponse> getMyAnnonce(String id) async
    test('test getMyAnnonce', () async {
      // TODO
    });

    // The prestataire's standalone listings; residence units are managed under /residences
    //
    //Future<PageResponseAnnonceResponse> listMyAnnonces(Pageable pageable, { bool includeResidenceUnits, String residenceId }) async
    test('test listMyAnnonces', () async {
      // TODO
    });

    // Mark a published or reserved listing as rented
    //
    //Future<AnnonceResponse> markAnnonceRented(String id) async
    test('test markAnnonceRented', () async {
      // TODO
    });

    // Publish a draft listing (profile complete + ≥3 photos + tier limit)
    //
    //Future<AnnonceResponse> publishAnnonce(String id) async
    test('test publishAnnonce', () async {
      // TODO
    });

    // Reserve a published listing (temporary hold)
    //
    //Future<AnnonceResponse> reserveAnnonce(String id) async
    test('test reserveAnnonce', () async {
      // TODO
    });

    // Return an archived listing to draft so it can be published again (RM-M10-08)
    //
    //Future<AnnonceResponse> unarchiveAnnonce(String id) async
    test('test unarchiveAnnonce', () async {
      // TODO
    });

    // Partially update one of the authenticated prestataire's listings
    //
    //Future<AnnonceResponse> updateAnnonce(String id, UpdateAnnonceRequest updateAnnonceRequest) async
    test('test updateAnnonce', () async {
      // TODO
    });

  });
}
