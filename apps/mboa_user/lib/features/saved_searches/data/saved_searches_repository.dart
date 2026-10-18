import 'package:built_collection/built_collection.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../search/data/search_repository.dart';
import '../models/saved_search.dart';

/// The list, and where it came from.
class SavedSearchList {
  const SavedSearchList(this.searches, {this.fromCache = false});

  final List<SavedSearch> searches;

  /// Read-only: the network is gone, and so is the right to change anything.
  final bool fromCache;
}

/// Why a search was not saved, when the server said why.
enum SaveRefusal {
  /// RM-M04-07 — three is the MVP's limit.
  limit,

  /// The same filters are already saved — order, repeats, and a city given
  /// with its districts do not make a search different.
  duplicate,
}

class SaveSearchRefused implements Exception {
  const SaveSearchRefused(this.reason);

  final SaveRefusal reason;
}

/// Saved searches (CDC M04, RM-M04-07) — `/saved-searches`.
class SavedSearchesRepository {
  SavedSearchesRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  static const String _listKey = 'list';
  static const int _pageSize = 20; // RM-M04-03, same pages as the search

  SavedSearchesApi get _api => _dioClient.api.getSavedSearchesApi();

  /// The account's searches, oldest first. When the network fails, the last
  /// list read — or the failure, when there is none.
  Future<SavedSearchList> list() async {
    try {
      final response = await _api.listSavedSearches();
      final searches = [
        for (final r in response.data ?? BuiltList<SavedSearchResponse>()) ?SavedSearch.fromResponse(r),
      ];
      await _cache.put(StorageKeys.savedSearchesBox, _listKey, {
        'items': searches.map((s) => s.toCache()).toList(),
      });
      return SavedSearchList(searches);
    } catch (_) {
      final cached = _cached();
      if (cached == null) rethrow;
      return SavedSearchList(cached, fromCache: true);
    }
  }

  /// Saves [query]. Without a [name] the server builds one from the criteria.
  ///
  /// Throws [SaveSearchRefused] for the limit and for a duplicate.
  Future<SavedSearch> save(SearchQuery query, {String? name, bool alertsEnabled = true}) async {
    try {
      final response = await _api.saveSearch(
        saveSearchRequest: SaveSearchRequest(
          (b) => b
            ..criteria.replace(criteriaOf(query))
            ..name = (name == null || name.trim().isEmpty) ? null : name.trim()
            ..alertsEnabled = alertsEnabled,
        ),
      );
      final saved = response.data == null ? null : SavedSearch.fromResponse(response.data!);
      if (saved == null) throw Exception('empty save response');
      return saved;
    } catch (error) {
      final api = ApiError.from(error);
      if (api.hasCode('SAVED_SEARCH_LIMIT')) throw const SaveSearchRefused(SaveRefusal.limit);
      if (api.hasCode('SAVED_SEARCH_DUPLICATE')) throw const SaveSearchRefused(SaveRefusal.duplicate);
      rethrow;
    }
  }

  Future<SavedSearch> rename(String id, String name) =>
      _update(id, UpdateSavedSearchRequest((b) => b..name = name.trim()));

  Future<SavedSearch> setAlerts(String id, {required bool enabled}) =>
      _update(id, UpdateSavedSearchRequest((b) => b..alertsEnabled = enabled));

  Future<void> delete(String id) => _api.deleteSavedSearch(id: id);

  /// One page of what the search finds — the same cards as `/search`.
  /// Opening it resets the search's `newMatchCount` on the server.
  Future<SearchPage> results(String id, {int page = 0}) async {
    final response = await _api.getSavedSearchResults(id: id, page: page, size: _pageSize);
    final data = response.data;
    final hits = (data?.content ?? const <SearchResult>[]).map(SearchHit.fromResponse).nonNulls.toList();
    return SearchPage(
      hits: hits,
      page: data?.page ?? page,
      isLast: data?.last ?? hits.length < _pageSize,
    );
  }

  Future<SavedSearch> _update(String id, UpdateSavedSearchRequest request) async {
    final response = await _api.updateSavedSearch(id: id, updateSavedSearchRequest: request);
    final updated = response.data == null ? null : SavedSearch.fromResponse(response.data!);
    if (updated == null) throw Exception('empty update response');
    return updated;
  }

  List<SavedSearch>? _cached() {
    final raw = _cache.get(StorageKeys.savedSearchesBox, _listKey);
    final items = raw?['items'];
    if (items is! List) return null;
    return [
      for (final item in items.whereType<Map<dynamic, dynamic>>())
        ?SavedSearch.fromCache(Map<String, dynamic>.from(item)),
    ];
  }

  /// The tenant's filters, as `POST /saved-searches` takes them: the same
  /// fields as `GET /search`. An empty list is left out rather than sent
  /// empty — "no filter", not "match nothing".
  static SearchCriteria criteriaOf(SearchQuery query) => SearchCriteria(
        (b) {
          b
            ..cityId = query.cityId
            ..rentMin = query.rentMin
            ..rentMax = query.rentMax
            ..roomsMin = query.roomsMin
            ..surfaceMin = query.surfaceMin
            ..surfaceMax = query.surfaceMax
            ..furnished = query.furnished
            ..availableNow = query.availableNow;
          if (query.districtIds.isNotEmpty) b.districtIds.replace(query.districtIds);
          if (query.propertyTypes.isNotEmpty) {
            b.propertyTypes.replace(
              query.propertyTypes.map((t) => SearchCriteriaPropertyTypesEnum.valueOf(t.asSearchParam)),
            );
          }
          if (query.rentalPeriods.isNotEmpty) {
            b.rentalPeriods.replace(
              query.rentalPeriods.map((p) => SearchCriteriaRentalPeriodsEnum.valueOf(p.asSearchParam)),
            );
          }
          if (query.amenities.isNotEmpty) {
            b.amenities.replace(
              query.amenities.map((a) => SearchCriteriaAmenitiesEnum.valueOf(a.asSearchParam)),
            );
          }
          if (query.badges.isNotEmpty) {
            b.badges.replace(query.badges.map((x) => SearchCriteriaBadgesEnum.valueOf(x.asSearchParam)));
          }
        },
      );
}
