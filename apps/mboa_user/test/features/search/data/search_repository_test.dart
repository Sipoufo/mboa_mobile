import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/search/data/search_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockSearchApi extends Mock implements SearchApi {}

class MockHiveCache extends Mock implements HiveCache {}

Response<PageResponseSearchResult> page(List<SearchResult> items) =>
    Response<PageResponseSearchResult>(
      data: PageResponseSearchResult(
        (b) => b
          ..content = ListBuilder<SearchResult>(items)
          ..page = 0
          ..size = 20
          ..totalElements = items.length
          ..totalPages = 1
          ..last = true,
      ),
      requestOptions: RequestOptions(path: '/api/v1/search'),
      statusCode: 200,
    );

SearchResult listing(String id) => SearchResult(
      (b) => b
        ..type = SearchResultTypeEnum.LISTING
        ..listing = SearchResultItemBuilder()
          ..listing.id = id
          ..listing.title = 'Studio $id'
          ..listing.city = 'Douala'
          ..listing.price = 110000
          ..listing.rentalPeriod = SearchResultItemRentalPeriodEnum.MONTH
          ..listing.propertyType = SearchResultItemPropertyTypeEnum.STUDIO,
    );

/// What the search puts on the wire, and what it keeps for the next launch.
void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockSearchApi api;
  late MockHiveCache cache;
  late SearchRepository repository;

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    api = MockSearchApi();
    cache = MockHiveCache();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getSearchApi).thenReturn(api);
    when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});
    when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn(null);

    repository = SearchRepository(dioClient: dioClient, cache: cache);
  });

  test('RM-M04-03 — asks for 20 per page, and maps the filters', () async {
    when(
      () => api.searchListings(
        cityId: any(named: 'cityId'),
        districtIds: any(named: 'districtIds'),
        propertyTypes: any(named: 'propertyTypes'),
        rentalPeriods: any(named: 'rentalPeriods'),
        rentMin: any(named: 'rentMin'),
        rentMax: any(named: 'rentMax'),
        roomsMin: any(named: 'roomsMin'),
        surfaceMin: any(named: 'surfaceMin'),
        surfaceMax: any(named: 'surfaceMax'),
        furnished: any(named: 'furnished'),
        availableNow: any(named: 'availableNow'),
        page: any(named: 'page'),
        size: any(named: 'size'),
      ),
    ).thenAnswer((_) async => page([listing('a')]));

    await repository.search(
      const SearchQuery(
        cityId: 'c-1',
        districtIds: ['d-1', 'd-2'],
        propertyTypes: [PropertyType.studio, PropertyType.commercialSpace],
        rentMax: 150000,
        furnished: true,
      ),
    );

    final call = verify(
      () => api.searchListings(
        cityId: captureAny(named: 'cityId'),
        districtIds: captureAny(named: 'districtIds'),
        propertyTypes: captureAny(named: 'propertyTypes'),
        rentalPeriods: any(named: 'rentalPeriods'),
        rentMin: any(named: 'rentMin'),
        rentMax: captureAny(named: 'rentMax'),
        roomsMin: any(named: 'roomsMin'),
        surfaceMin: any(named: 'surfaceMin'),
        surfaceMax: any(named: 'surfaceMax'),
        furnished: captureAny(named: 'furnished'),
        availableNow: any(named: 'availableNow'),
        page: captureAny(named: 'page'),
        size: captureAny(named: 'size'),
      ),
    ).captured;

    expect(call[0], 'c-1');
    expect((call[1] as BuiltList<String>).toList(), ['d-1', 'd-2']);
    // The wire names, not the Dart ones: COMMERCIAL_SPACE, not commercialSpace.
    expect(
      (call[2] as BuiltList<String>).toList(),
      ['STUDIO', 'COMMERCIAL_SPACE'],
    );
    expect(call[3], 150000);
    expect(call[4], isTrue);
    expect(call[5], 0);
    expect(call[6], 20);
  });

  test('an empty multi-select is left out entirely, not sent empty', () async {
    when(
      () => api.searchListings(
        cityId: any(named: 'cityId'),
        districtIds: any(named: 'districtIds'),
        propertyTypes: any(named: 'propertyTypes'),
        rentalPeriods: any(named: 'rentalPeriods'),
        rentMin: any(named: 'rentMin'),
        rentMax: any(named: 'rentMax'),
        roomsMin: any(named: 'roomsMin'),
        surfaceMin: any(named: 'surfaceMin'),
        surfaceMax: any(named: 'surfaceMax'),
        furnished: any(named: 'furnished'),
        availableNow: any(named: 'availableNow'),
        page: any(named: 'page'),
        size: any(named: 'size'),
      ),
    ).thenAnswer((_) async => page([]));

    await repository.search(const SearchQuery(cityId: 'c-1'));

    final captured = verify(
      () => api.searchListings(
        cityId: any(named: 'cityId'),
        districtIds: captureAny(named: 'districtIds'),
        propertyTypes: captureAny(named: 'propertyTypes'),
        rentalPeriods: captureAny(named: 'rentalPeriods'),
        rentMin: any(named: 'rentMin'),
        rentMax: any(named: 'rentMax'),
        roomsMin: any(named: 'roomsMin'),
        surfaceMin: any(named: 'surfaceMin'),
        surfaceMax: any(named: 'surfaceMax'),
        furnished: any(named: 'furnished'),
        availableNow: any(named: 'availableNow'),
        page: any(named: 'page'),
        size: any(named: 'size'),
      ),
    ).captured;

    // An empty list would be `?districtIds=` on the wire, which is not the
    // same question as "no district filter".
    expect(captured, everyElement(isNull));
  });

  test('RM-M04-02 / CE-M04-02 — the first page and its query are kept',
      () async {
    when(
      () => api.searchListings(
        cityId: any(named: 'cityId'),
        districtIds: any(named: 'districtIds'),
        propertyTypes: any(named: 'propertyTypes'),
        rentalPeriods: any(named: 'rentalPeriods'),
        rentMin: any(named: 'rentMin'),
        rentMax: any(named: 'rentMax'),
        roomsMin: any(named: 'roomsMin'),
        surfaceMin: any(named: 'surfaceMin'),
        surfaceMax: any(named: 'surfaceMax'),
        furnished: any(named: 'furnished'),
        availableNow: any(named: 'availableNow'),
        page: any(named: 'page'),
        size: any(named: 'size'),
      ),
    ).thenAnswer((_) async => page([listing('a')]));

    await repository.search(const SearchQuery(cityId: 'c-1', cityName: 'Douala'));

    verify(() => cache.put(StorageKeys.searchBox, 'lastQuery', any())).called(1);
    verify(() => cache.put(StorageKeys.searchBox, 'lastResults', any()))
        .called(1);
  });

  test('a query written by an older build does not break the launch', () {
    when(() => cache.get(StorageKeys.searchBox, 'lastQuery'))
        .thenReturn({'cityId': 'c-1', 'propertyTypes': 'not-a-list'});

    // Tolerant on purpose: RM-M04-02 restores it at startup, and a stale shape
    // must not be the reason the app fails to open.
    expect(repository.lastQuery()?.cityId, 'c-1');
  });

  test('the cached page is read with the 1h TTL and flagged as cached', () {
    when(
      () => cache.get(StorageKeys.searchBox, 'lastResults', ttl: CacheTtl.search),
    ).thenReturn({
      'hits': [
        {'kind': 'listing', 'id': 'a', 'title': 'Studio', 'price': 110000},
      ],
    });

    final cached = repository.cachedFirstPage();

    expect(cached!.fromCache, isTrue);
    expect(cached.hits.single.id, 'a');
  });
}
