import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/saved_searches/data/saved_searches_repository.dart';
import 'package:mboa_user/features/saved_searches/models/saved_search.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockSavedSearchesApi extends Mock implements SavedSearchesApi {}

class MockHiveCache extends Mock implements HiveCache {}

Response<T> _ok<T>(T data) => Response<T>(
  data: data,
  requestOptions: RequestOptions(path: '/saved-searches'),
);

DioException _refused(String code) => DioException(
  requestOptions: RequestOptions(path: '/saved-searches'),
  response: Response(
    requestOptions: RequestOptions(path: '/saved-searches'),
    statusCode: 409,
    data: {'error': code},
  ),
);

SavedSearchResponse _search(String id, {String name = 'Douala', int fresh = 0}) => SavedSearchResponse(
  (b) => b
    ..id = id
    ..name = name
    ..alertsEnabled = true
    ..newMatchCount = fresh,
);

/// RM-M04-07 — what a saved search puts on the wire, and what it keeps.
void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockSavedSearchesApi api;
  late MockHiveCache cache;
  late SavedSearchesRepository repository;

  setUpAll(() {
    registerFallbackValue(SaveSearchRequest((b) => b.criteria.cityId = 'c'));
    registerFallbackValue(UpdateSavedSearchRequest());
  });

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    api = MockSavedSearchesApi();
    cache = MockHiveCache();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getSavedSearchesApi).thenReturn(api);
    when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});
    when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn(null);
    repository = SavedSearchesRepository(dioClient: dioClient, cache: cache);
  });

  group('criteriaOf — the same fields as GET /search', () {
    test('every filter goes across, in the wire vocabulary', () {
      const query = SearchQuery(
        cityId: 'douala',
        cityName: 'Douala',
        districtIds: ['akwa', 'bonapriso'],
        propertyTypes: [PropertyType.apartment, PropertyType.commercialSpace],
        rentalPeriods: [RentalPeriod.month],
        rentMin: 50000,
        rentMax: 500000,
        roomsMin: 2,
        surfaceMin: 30,
        surfaceMax: 120,
        furnished: true,
        availableNow: false,
        amenities: [Amenity.generator, Amenity.wifi],
        badges: [TrustBadge.verifiedPhotos],
      );

      final criteria = SavedSearchesRepository.criteriaOf(query);

      expect(criteria.cityId, 'douala');
      expect(criteria.districtIds, BuiltList<String>(['akwa', 'bonapriso']));
      expect(
        criteria.propertyTypes,
        BuiltList([SearchCriteriaPropertyTypesEnum.APARTMENT, SearchCriteriaPropertyTypesEnum.COMMERCIAL_SPACE]),
      );
      expect(criteria.rentalPeriods, BuiltList([SearchCriteriaRentalPeriodsEnum.MONTH]));
      expect(criteria.rentMin, 50000);
      expect(criteria.rentMax, 500000);
      expect(criteria.roomsMin, 2);
      expect(criteria.surfaceMin, 30);
      expect(criteria.surfaceMax, 120);
      expect(criteria.furnished, isTrue);
      // "Not available now" is a filter, not the absence of one.
      expect(criteria.availableNow, isFalse);
      expect(
        criteria.amenities,
        BuiltList([SearchCriteriaAmenitiesEnum.GENERATOR, SearchCriteriaAmenitiesEnum.WIFI]),
      );
      expect(criteria.badges, BuiltList([SearchCriteriaBadgesEnum.PHOTOS_VERIFIED]));
    });

    test('a filter left off is absent, not an empty list that would match nothing', () {
      final criteria = SavedSearchesRepository.criteriaOf(const SearchQuery(cityId: 'douala'));

      expect(criteria.districtIds, isNull);
      expect(criteria.propertyTypes, isNull);
      expect(criteria.badges, isNull);
      expect(criteria.furnished, isNull);
    });
  });

  group('save', () {
    test('a blank name is left for the server to build', () async {
      when(
        () => api.saveSearch(saveSearchRequest: any(named: 'saveSearchRequest')),
      ).thenAnswer((_) async => _ok(_search('s-1', name: 'Appartement · Akwa')));

      final saved = await repository.save(const SearchQuery(cityId: 'douala'), name: '   ', alertsEnabled: false);

      final request =
          verify(() => api.saveSearch(saveSearchRequest: captureAny(named: 'saveSearchRequest'))).captured.single
              as SaveSearchRequest;
      expect(request.name, isNull);
      expect(request.alertsEnabled, isFalse);
      expect(saved, const SavedSearch(id: 's-1', name: 'Appartement · Akwa'));
    });

    test('RM-M04-07 — the fourth is refused as the limit', () async {
      when(
        () => api.saveSearch(saveSearchRequest: any(named: 'saveSearchRequest')),
      ).thenThrow(_refused('SAVED_SEARCH_LIMIT'));

      expect(
        () => repository.save(const SearchQuery(cityId: 'douala')),
        throwsA(isA<SaveSearchRefused>().having((e) => e.reason, 'reason', SaveRefusal.limit)),
      );
    });

    test('the same filters twice are refused as a duplicate', () async {
      when(
        () => api.saveSearch(saveSearchRequest: any(named: 'saveSearchRequest')),
      ).thenThrow(_refused('SAVED_SEARCH_DUPLICATE'));

      expect(
        () => repository.save(const SearchQuery(cityId: 'douala')),
        throwsA(isA<SaveSearchRefused>().having((e) => e.reason, 'reason', SaveRefusal.duplicate)),
      );
    });
  });

  group('list — read-only offline', () {
    test('a fresh list is kept for when the network goes', () async {
      when(() => api.listSavedSearches()).thenAnswer((_) async => _ok(BuiltList([_search('s-1', fresh: 2)])));

      final list = await repository.list();

      expect(list.fromCache, isFalse);
      expect(list.searches.single.newMatchCount, 2);
      verify(() => cache.put(StorageKeys.savedSearchesBox, any(), any())).called(1);
    });

    test('offline, the kept list comes back, marked as such', () async {
      when(() => api.listSavedSearches()).thenThrow(Exception('offline'));
      when(() => cache.get(StorageKeys.savedSearchesBox, any(), ttl: any(named: 'ttl'))).thenReturn({
        'items': [const SavedSearch(id: 's-1', name: 'Douala', newMatchCount: 1).toCache()],
      });

      final list = await repository.list();

      expect(list.fromCache, isTrue);
      expect(list.searches, const [SavedSearch(id: 's-1', name: 'Douala', newMatchCount: 1)]);
    });

    test('offline with nothing kept, the failure is the answer', () async {
      when(() => api.listSavedSearches()).thenThrow(Exception('offline'));

      expect(repository.list, throwsException);
    });
  });
}
