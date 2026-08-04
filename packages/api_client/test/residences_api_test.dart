import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for ResidencesApi
void main() {
  final instance = ApiClient().getResidencesApi();

  group(ResidencesApi, () {
    // Archive all units at once
    //
    //Future<ResidenceResponse> archiveAll(String id) async
    test('test archiveAll', () async {
      // TODO
    });

    // Bulk-create a residence and its units (drafts)
    //
    //Future<ResidenceResponse> create(CreateResidenceRequest createResidenceRequest) async
    test('test create', () async {
      // TODO
    });

    // Delete a residence and all its units
    //
    //Future delete(String id) async
    test('test delete', () async {
      // TODO
    });

    // Get a residence with its units
    //
    //Future<ResidenceResponse> getOne(String id) async
    test('test getOne', () async {
      // TODO
    });

    // List the authenticated prestataire's residences
    //
    //Future<PageResponseResidenceResponse> listMine(Pageable pageable) async
    test('test listMine', () async {
      // TODO
    });

    // Publish all draft units at once
    //
    //Future<ResidenceResponse> publishAll(String id) async
    test('test publishAll', () async {
      // TODO
    });

    // Mark all live units (published or reserved) as rented at once
    //
    //Future<ResidenceResponse> rentAll(String id) async
    test('test rentAll', () async {
      // TODO
    });

    // Reserve all published units at once
    //
    //Future<ResidenceResponse> reserveAll(String id) async
    test('test reserveAll', () async {
      // TODO
    });

    // Update the residence's shared attributes (cascades to units)
    //
    //Future<ResidenceResponse> update(String id, UpdateResidenceRequest updateResidenceRequest) async
    test('test update', () async {
      // TODO
    });

  });
}
