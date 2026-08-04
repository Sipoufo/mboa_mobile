import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for LocationsApi
void main() {
  final instance = ApiClient().getLocationsApi();

  group(LocationsApi, () {
    // List cities (optionally filtered by region)
    //
    //Future<BuiltList<LocationOption>> cities({ String regionId }) async
    test('test cities', () async {
      // TODO
    });

    // List countries
    //
    //Future<BuiltList<CountryResponse>> countries() async
    test('test countries', () async {
      // TODO
    });

    // List a city's districts (quartiers)
    //
    //Future<BuiltList<LocationOption>> districts(String cityId) async
    test('test districts', () async {
      // TODO
    });

    // List regions (optionally filtered by country)
    //
    //Future<BuiltList<LocationOption>> regions({ String countryId }) async
    test('test regions', () async {
      // TODO
    });

  });
}
