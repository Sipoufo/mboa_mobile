import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_user/features/search/data/search_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockLocationsApi extends Mock implements LocationsApi {}

class MockNetworkMonitor extends Mock implements NetworkMonitor {}

/// The district filter offline: the last list read stands in.
void main() {
  late MockLocationsApi api;
  late SearchRepository repository;
  final stored = <String, Map<String, dynamic>>{};

  setUp(() {
    stored.clear();
    final dioClient = MockDioClient();
    final apiClient = MockApiClient();
    final cache = MockHiveCache();
    api = MockLocationsApi();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getLocationsApi).thenReturn(api);
    // Through JSON, as Hive gives it back: untyped maps and lists.
    when(() => cache.put(any(), any(), any())).thenAnswer((call) async {
      stored['${call.positionalArguments[0]}/${call.positionalArguments[1]}'] =
          jsonDecode(jsonEncode(call.positionalArguments[2])) as Map<String, dynamic>;
    });
    when(() => cache.get(any(), any(), ttl: any(named: 'ttl')))
        .thenAnswer((call) => stored['${call.positionalArguments[0]}/${call.positionalArguments[1]}']);
    repository = SearchRepository(dioClient: dioClient, cache: cache, network: MockNetworkMonitor());
  });

  void online() => when(() => api.listDistricts(cityId: 'dla')).thenAnswer(
        (_) async => Response(
          data: BuiltList<LocationOption>([
            LocationOption((b) => b
              ..id = 'd-akwa'
              ..name = 'Akwa'),
            LocationOption((b) => b
              ..id = 'd-bonapriso'
              ..name = 'Bonapriso'),
          ]),
          requestOptions: RequestOptions(path: '/locations'),
          statusCode: 200,
        ),
      );

  void offline() => when(() => api.listDistricts(cityId: 'dla'))
      .thenThrow(DioException(requestOptions: RequestOptions(path: '/locations')));

  test('read once, then offline: the same districts', () async {
    online();
    final read = await repository.districts('dla');
    offline();

    expect(await repository.districts('dla'), read);
    expect(read.map((d) => d.name), ['Akwa', 'Bonapriso']);
  });

  test('offline and never read: the failure is the caller\'s to handle', () async {
    offline();

    await expectLater(repository.districts('dla'), throwsA(isA<DioException>()));
  });
}
