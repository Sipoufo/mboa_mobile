import 'package:api_client/api_client.dart' show LocationOption;
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

Response<T> _response<T>(T data) =>
    Response<T>(requestOptions: RequestOptions(path: '/locations/cities'), data: data);

LocationOption _opt(String? id, String? name) =>
    LocationOption((b) => b
      ..id = id
      ..name = name);

void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockLocationsApi locationsApi;
  late LocationRepository repository;

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    locationsApi = MockLocationsApi();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getLocationsApi).thenReturn(locationsApi);
    repository = LocationRepository(dioClient: dioClient);
  });

  test('maps cities and drops entries missing an id or name', () async {
    when(() => locationsApi.cities(regionId: any(named: 'regionId'))).thenAnswer(
      (_) async => _response(
        BuiltList<LocationOption>([
          _opt('1', 'Douala'),
          _opt('2', 'Yaoundé'),
          _opt(null, 'Broken'),
          _opt('3', null),
        ]),
      ),
    );

    final cities = await repository.cities();

    expect(cities, const [
      CityOption(id: '1', name: 'Douala'),
      CityOption(id: '2', name: 'Yaoundé'),
    ]);
  });

  test('returns an empty list when the response has no data', () async {
    when(() => locationsApi.cities(regionId: any(named: 'regionId'))).thenAnswer(
      (_) async => Response<BuiltList<LocationOption>>(
        requestOptions: RequestOptions(path: '/locations/cities'),
        data: null,
      ),
    );

    expect(await repository.cities(), isEmpty);
  });
}
