import 'package:flutter_test/flutter_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

/// Reverse geocoding returns a free-form locality that will not equal the
/// catalogue name, so matching is deliberately loose — and always allowed to
/// fail, because the UI falls back to picking the city by hand.
void main() {
  late LocationRepository repository;

  const cities = [
    CityOption(id: '1', name: 'Douala'),
    CityOption(id: '2', name: 'Yaoundé'),
    CityOption(id: '3', name: 'Bafoussam'),
  ];

  setUp(() {
    repository = LocationRepository(dioClient: MockDioClient());
  });

  test('matches an exact name', () {
    expect(repository.matchCity(cities, 'Douala')?.id, '1');
  });

  test('ignores casing and surrounding whitespace', () {
    expect(repository.matchCity(cities, '  douala ')?.id, '1');
  });

  test('ignores accents in either direction', () {
    // Geocoders vary on whether they return "Yaoundé" or "Yaounde".
    expect(repository.matchCity(cities, 'Yaounde')?.id, '2');
    expect(repository.matchCity(cities, 'YAOUNDÉ')?.id, '2');
  });

  test('matches an arrondissement back to its city', () {
    // "Douala 5e" is a very common geocoder result.
    expect(repository.matchCity(cities, 'Douala 5e')?.id, '1');
    expect(repository.matchCity(cities, 'Douala V')?.id, '1');
  });

  test('returns null rather than guessing when nothing fits', () {
    expect(repository.matchCity(cities, 'Lagos'), isNull);
    expect(repository.matchCity(cities, ''), isNull);
    expect(repository.matchCity(cities, null), isNull);
  });

  test('returns null against an empty catalogue', () {
    expect(repository.matchCity(const [], 'Douala'), isNull);
  });

  group('districts', () {
    test('maps id/name pairs and drops incomplete entries', () async {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      final locationsApi = MockLocationsApi();

      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getLocationsApi).thenReturn(locationsApi);
      when(() => locationsApi.districts(cityId: any(named: 'cityId')))
          .thenAnswer(
        (_) async => Response(
          data: BuiltList<LocationOption>([
            LocationOption((b) => b
              ..id = 'd1'
              ..name = 'Deido'),
            // Incomplete rows must not become unusable options.
            LocationOption((b) => b..id = 'd2'),
          ]),
          requestOptions: RequestOptions(path: '/districts'),
          statusCode: 200,
        ),
      );

      final districts =
          await LocationRepository(dioClient: dioClient).districts('1');

      expect(districts, hasLength(1));
      expect(districts.single.name, 'Deido');
    });
  });
}
