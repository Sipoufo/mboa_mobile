import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for LocationsApi
void main() {
  final instance = ApiClient().getLocationsApi();

  group(LocationsApi, () {
    // List cities (optionally filtered by region)
    //
    //Future<BuiltList<LocationOption>> listCities({ String regionId }) async
    test('test listCities', () async {
      // TODO
    });

    // List countries
    //
    //Future<BuiltList<CountryResponse>> listCountries() async
    test('test listCountries', () async {
      // TODO
    });

    // List a city's districts (quartiers)
    //
    //Future<BuiltList<LocationOption>> listDistricts(String cityId) async
    test('test listDistricts', () async {
      // TODO
    });

    // List regions (optionally filtered by country)
    //
    //Future<BuiltList<LocationOption>> listRegions({ String countryId }) async
    test('test listRegions', () async {
      // TODO
    });

  });
}
