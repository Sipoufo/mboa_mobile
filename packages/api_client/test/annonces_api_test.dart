import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AnnoncesApi
void main() {
  final instance = ApiClient().getAnnoncesApi();

  group(AnnoncesApi, () {
    // Archive a listing
    //
    //Future<AnnonceResponse> archive(String id) async
    test('test archive', () async {
      // TODO
    });

    // Create a listing (draft)
    //
    //Future<AnnonceResponse> create1(CreateAnnonceRequest createAnnonceRequest) async
    test('test create1', () async {
      // TODO
    });

    // Delete one of the authenticated prestataire's listings
    //
    //Future delete1(String id) async
    test('test delete1', () async {
      // TODO
    });

    // Get one of the authenticated prestataire's listings
    //
    //Future<AnnonceResponse> getOne1(String id) async
    test('test getOne1', () async {
      // TODO
    });

    // List the authenticated prestataire's listings
    //
    //Future<PageResponseAnnonceResponse> listMine1(Pageable pageable) async
    test('test listMine1', () async {
      // TODO
    });

    // Mark a published or reserved listing as rented
    //
    //Future<AnnonceResponse> markRented(String id) async
    test('test markRented', () async {
      // TODO
    });

    // Publish a draft listing (profile complete + ≥3 photos + tier limit)
    //
    //Future<AnnonceResponse> publish(String id) async
    test('test publish', () async {
      // TODO
    });

    // Reserve a published listing (temporary hold)
    //
    //Future<AnnonceResponse> reserve(String id) async
    test('test reserve', () async {
      // TODO
    });

    // Partially update one of the authenticated prestataire's listings
    //
    //Future<AnnonceResponse> update1(String id, UpdateAnnonceRequest updateAnnonceRequest) async
    test('test update1', () async {
      // TODO
    });

  });
}
