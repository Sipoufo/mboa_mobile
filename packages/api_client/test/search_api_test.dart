import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for SearchApi
void main() {
  final instance = ApiClient().getSearchApi();

  group(SearchApi, () {
    // Public fiche of a listing (M05)
    //
    // Readable without an account. The exact address is never returned and the coordinates are fuzzed by ~200m. Send X-Device-Id so anonymous views are counted once per device per 24h; signed-in views are counted by account.
    //
    //Future<AnnonceDetailResponse> getAnnonceDetail(String id, { String xDeviceId }) async
    test('test getAnnonceDetail', () async {
      // TODO
    });

    // Public detail of a residence with its live units
    //
    //Future<ResidenceDetailResponse> getResidenceDetail(String id) async
    test('test getResidenceDetail', () async {
      // TODO
    });

    // Search listings and residences (city/district required; other filters cumulative)
    //
    //Future<PageResponseSearchResult> searchListings({ String cityId, BuiltList<String> districtIds, BuiltList<String> propertyTypes, BuiltList<String> rentalPeriods, int rentMin, int rentMax, int roomsMin, int surfaceMin, int surfaceMax, bool furnished, bool availableNow, int page, int size }) async
    test('test searchListings', () async {
      // TODO
    });

  });
}
