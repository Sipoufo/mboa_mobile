import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/listing/data/listing_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockSearchApi extends Mock implements SearchApi {}

/// A residence read once is still there in a tunnel (Doc 12 — offline-first).
void main() {
  late MockSearchApi api;
  late MockHiveCache cache;
  late ListingRepository repository;
  final stored = <String, Map<String, dynamic>>{};

  ResidenceDetailResponse response() => ResidenceDetailResponse(
        (b) => b
          ..id = 'r-1'
          ..name = 'Cité blanche'
          ..city = 'Douala'
          ..district = 'Bonamoussadi'
          ..description = 'Au calme, gardiennage jour et nuit.'
          ..photoKeys = ListBuilder<String>(['listings/a.jpg', 'listings/b.jpg'])
          ..latitude = 4.09
          ..longitude = 9.74
          ..exactLocation = true
          ..units = ListBuilder<SearchResultItem>([
            SearchResultItem(
              (u) => u
                ..id = 'u-1'
                ..title = 'Chambre 1'
                ..propertyType = SearchResultItemPropertyTypeEnum.ROOM
                ..price = 35000
                ..rentalPeriod = SearchResultItemRentalPeriodEnum.MONTH
                ..surfaceArea = 14
                ..primaryPhotoKey = 'listings/u1.jpg',
            ),
          ])
          ..provider.accountId = 'p-1'
          ..provider.displayName = 'Angel Proprio'
          ..provider.logoObjectKey = 'logos/angel.png'
          ..provider.type = ProviderCardTypeEnum.PROMOTEUR
          ..provider.tierRank = 4
          ..provider.badges = ListBuilder<ProviderCardBadgesEnum>([
            ProviderCardBadgesEnum.PHOTOS_VERIFIED,
            ProviderCardBadgesEnum.TRUSTED,
          ])
          ..rating.average = 5.0
          ..rating.reviewCount = 2
          ..rating.visitCount = 1
          ..rating.residentCount = 1,
      );

  setUp(() {
    stored.clear();
    final dioClient = MockDioClient();
    final apiClient = MockApiClient();
    api = MockSearchApi();
    cache = MockHiveCache();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getSearchApi).thenReturn(api);
    // Through JSON, as Hive gives it back: untyped maps and lists.
    when(() => cache.put(any(), any(), any())).thenAnswer((call) async {
      stored['${call.positionalArguments[0]}/${call.positionalArguments[1]}'] =
          jsonDecode(jsonEncode(call.positionalArguments[2])) as Map<String, dynamic>;
    });
    when(() => cache.get(any(), any(), ttl: any(named: 'ttl')))
        .thenAnswer((call) => stored['${call.positionalArguments[0]}/${call.positionalArguments[1]}']);
    when(() => api.getResidenceDetail(id: 'r-1')).thenAnswer(
      (_) async => Response(
        data: response(),
        requestOptions: RequestOptions(path: '/search/residences/r-1'),
        statusCode: 200,
      ),
    );
    repository = ListingRepository(dioClient: dioClient, cache: cache);
  });

  test('the fiche comes back whole from the cache — units, provider, badges, rating', () async {
    final read = await repository.residence('r-1');

    final cached = repository.cachedResidence('r-1');

    expect(cached, isNotNull);
    expect(cached!.name, 'Cité blanche');
    expect(cached.photoKeys, read.photoKeys);
    expect(cached.units, read.units);
    expect(cached.provider, read.provider);
    expect(cached.provider!.badges, [TrustBadge.trustedProvider, TrustBadge.verifiedPhotos]);
    expect(cached.rating, read.rating);
    expect(cached.latitude, read.latitude);
  });

  test('RM-M04-06 — the exact position is the session\'s verdict, never cached', () async {
    final read = await repository.residence('r-1');
    expect(read.exactLocation, isTrue);

    expect(repository.cachedResidence('r-1')!.exactLocation, isFalse);
  });

  test('a residence and a listing never share a cache entry', () async {
    await repository.residence('r-1');

    expect(stored.keys, ['${StorageKeys.viewedBox}/residence:r-1']);
    expect(repository.cached('r-1'), isNull);
  });

  test('nothing read, nothing cached', () {
    expect(repository.cachedResidence('r-1'), isNull);
  });
}
