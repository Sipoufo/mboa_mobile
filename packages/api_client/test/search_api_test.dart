import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for SearchApi
void main() {
  final instance = ApiClient().getSearchApi();

  group(SearchApi, () {
    // Public detail of a residence with its live units
    //
    //Future<ResidenceDetailResponse> residenceDetail(String id) async
    test('test residenceDetail', () async {
      // TODO
    });

    // Search listings and residences (city/district required; other filters cumulative)
    //
    //Future<PageResponseSearchResult> search({ String cityId, BuiltList<String> districtIds, BuiltList<String> propertyTypes, int rentMin, int rentMax, int roomsMin, int surfaceMin, int surfaceMax, bool furnished, bool availableNow, int page, int size }) async
    test('test search', () async {
      // TODO
    });

  });
}
