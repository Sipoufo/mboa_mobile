import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for ResidencesApi
void main() {
  final instance = ApiClient().getResidencesApi();

  group(ResidencesApi, () {
    // Archive all units at once
    //
    //Future<ResidenceResponse> archiveResidenceUnits(String id) async
    test('test archiveResidenceUnits', () async {
      // TODO
    });

    // Bulk-create a residence and its units (drafts)
    //
    //Future<ResidenceResponse> createResidence(CreateResidenceRequest createResidenceRequest) async
    test('test createResidence', () async {
      // TODO
    });

    // Delete a residence and all its units
    //
    //Future deleteResidence(String id) async
    test('test deleteResidence', () async {
      // TODO
    });

    // Get a residence with its units
    //
    //Future<ResidenceResponse> getMyResidence(String id) async
    test('test getMyResidence', () async {
      // TODO
    });

    // List the authenticated prestataire's residences
    //
    //Future<PageResponseResidenceResponse> listMyResidences(Pageable pageable) async
    test('test listMyResidences', () async {
      // TODO
    });

    // Publish all draft units at once
    //
    //Future<ResidenceResponse> publishResidenceUnits(String id) async
    test('test publishResidenceUnits', () async {
      // TODO
    });

    // Mark all live units (published or reserved) as rented at once
    //
    //Future<ResidenceResponse> rentResidenceUnits(String id) async
    test('test rentResidenceUnits', () async {
      // TODO
    });

    // Reserve all published units at once
    //
    //Future<ResidenceResponse> reserveResidenceUnits(String id) async
    test('test reserveResidenceUnits', () async {
      // TODO
    });

    // Return all archived units to draft so the residence can be published again (RM-M10-08)
    //
    //Future<ResidenceResponse> unarchiveResidenceUnits(String id) async
    test('test unarchiveResidenceUnits', () async {
      // TODO
    });

    // Update the residence's shared attributes (cascades to units)
    //
    //Future<ResidenceResponse> updateResidence(String id, UpdateResidenceRequest updateResidenceRequest) async
    test('test updateResidence', () async {
      // TODO
    });

  });
}
