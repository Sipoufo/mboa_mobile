import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_user/features/listing/data/listing_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockSearchApi extends Mock implements SearchApi {}

/// §37 C — a fiche read offline still says the landlord's conditions.
void main() {
  test('the advance and the deposit survive the 24h cache', () async {
    final stored = <String, Map<String, dynamic>>{};
    final dioClient = MockDioClient();
    final apiClient = MockApiClient();
    final cache = MockHiveCache();
    final api = MockSearchApi();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getSearchApi).thenReturn(api);
    when(() => cache.put(any(), any(), any())).thenAnswer((call) async {
      stored['${call.positionalArguments[0]}/${call.positionalArguments[1]}'] =
          jsonDecode(jsonEncode(call.positionalArguments[2])) as Map<String, dynamic>;
    });
    when(() => cache.get(any(), any(), ttl: any(named: 'ttl')))
        .thenAnswer((call) => stored['${call.positionalArguments[0]}/${call.positionalArguments[1]}']);
    when(() => api.getAnnonceDetail(id: 'a-1', xDeviceId: any(named: 'xDeviceId'))).thenAnswer(
      (_) async => Response(
        data: AnnonceDetailResponse((b) => b
          ..id = 'a-1'
          ..title = 'Studio Akwa'
          ..advanceMonths = 3
          ..depositMonths = 0),
        requestOptions: RequestOptions(path: '/search/annonces/a-1'),
        statusCode: 200,
      ),
    );
    final repository = ListingRepository(dioClient: dioClient, cache: cache);

    await repository.one('a-1');
    final cached = repository.cached('a-1')!;

    expect((cached.advanceMonths, cached.depositMonths), (3, 0));
  });
}
