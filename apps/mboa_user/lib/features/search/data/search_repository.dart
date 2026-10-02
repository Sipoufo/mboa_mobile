import 'package:built_collection/built_collection.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// One page of results, plus where they came from.
class SearchPage {
  const SearchPage({
    required this.hits,
    required this.page,
    required this.isLast,
    this.fromCache = false,
  });

  final List<SearchHit> hits;
  final int page;
  final bool isLast;

  /// CE-M04-02 — the screen says so; results an hour old are not a lie, but
  /// pretending they are live would be.
  final bool fromCache;
}

/// Searching for a property (CDC M04).
///
/// Public: `GET /search` needs no account (CA-M04-04), and the interceptor adds
/// a token only when there is one.
class SearchRepository {
  SearchRepository({
    required DioClient dioClient,
    required HiveCache cache,
    required NetworkMonitor network,
  })  : _dioClient = dioClient,
        _cache = cache,
        _network = network;

  final DioClient _dioClient;
  final HiveCache _cache;
  final NetworkMonitor _network;

  /// Whether the device has a connection at all.
  ///
  /// Asked only once a search has already failed, to tell the two failures
  /// apart: no line (CE-M04-02) or a server that answered badly (CE-M04-03).
  /// Checking it up front would be a second source of truth about whether the
  /// network works — the request itself is the first.
  Future<bool> isOffline() async => !await _network.isOnline;

  static const int _pageSize = 20; // RM-M04-03
  static const String _lastQueryKey = 'lastQuery';
  static const String _lastResultsKey = 'lastResults';

  SearchApi get _api => _dioClient.api.getSearchApi();

  /// Runs the search, and keeps the first page for when the network goes.
  ///
  /// **Results are used in the order they arrive.** The server applies the
  /// visibility algorithm (Pro+ → Pro → Basic+ → Gratuit, CA-M04-02); sorting
  /// again here would be a second implementation of that rule.
  Future<SearchPage> search(SearchQuery query, {int page = 0}) async {
    final response = await _api.searchListings(
      cityId: query.cityId,
      districtIds: query.districtIds.isEmpty
          ? null
          : BuiltList<String>(query.districtIds),
      propertyTypes: query.propertyTypes.isEmpty
          ? null
          : BuiltList<String>(query.propertyTypes.map((t) => t.asSearchParam)),
      rentalPeriods: query.rentalPeriods.isEmpty
          ? null
          : BuiltList<String>(query.rentalPeriods.map((p) => p.asSearchParam)),
      rentMin: query.rentMin,
      rentMax: query.rentMax,
      roomsMin: query.roomsMin,
      surfaceMin: query.surfaceMin,
      surfaceMax: query.surfaceMax,
      furnished: query.furnished,
      availableNow: query.availableNow,
      amenities: query.amenities.isEmpty
          ? null
          : BuiltList<String>(query.amenities.map((a) => a.asSearchParam)),
      badges: query.badges.isEmpty
          ? null
          : BuiltList<String>(query.badges.map((b) => b.asSearchParam)),
      page: page,
      size: _pageSize,
    );

    final data = response.data;
    final hits = (data?.content ?? const <SearchResult>[])
        .map(SearchHit.fromResponse)
        .nonNulls
        .toList();

    if (page == 0) await _cacheFirstPage(query, hits);

    return SearchPage(
      hits: hits,
      page: data?.page ?? page,
      isLast: data?.last ?? hits.length < _pageSize,
    );
  }

  /// RM-M04-02 — the last search, restored on the next launch.
  SearchQuery? lastQuery() {
    final raw = _cache.get(StorageKeys.searchBox, _lastQueryKey);
    if (raw == null) return null;
    try {
      return SearchQuery.fromJson(raw);
    } catch (_) {
      // A query written by an older build is not worth a failed launch.
      return null;
    }
  }

  /// CE-M04-02 — the 20 results kept for an hour, shown behind the offline
  /// banner when the network is gone.
  SearchPage? cachedFirstPage() {
    final raw = _cache.get(
      StorageKeys.searchBox,
      _lastResultsKey,
      ttl: CacheTtl.search,
    );
    final items =
        (raw?['hits'] as List?)?.whereType<Map<dynamic, dynamic>>() ??
            const <Map<dynamic, dynamic>>[];
    if (items.isEmpty) return null;

    return SearchPage(
      hits: [
        for (final item in items)
          ?_hitFromCache(Map<String, dynamic>.from(item)),
      ],
      page: 0,
      isLast: true,
      fromCache: true,
    );
  }

  Future<void> _cacheFirstPage(SearchQuery query, List<SearchHit> hits) async {
    await _cache.put(StorageKeys.searchBox, _lastQueryKey, query.toJson());
    await _cache.put(StorageKeys.searchBox, _lastResultsKey, {
      'hits': hits.map(_hitToCache).toList(),
    });
  }

  /// Only what a card draws. A cache that stored the whole payload would need
  /// migrating every time the API grows a field.
  static Map<String, dynamic> _hitToCache(SearchHit hit) => switch (hit) {
        ListingHit() => {
            'kind': 'listing',
            'id': hit.id,
            'title': hit.title,
            'city': hit.city,
            'district': hit.district,
            'photo': hit.primaryPhotoKey,
            'price': hit.displayPrice,
            'period': hit.rentalPeriod.name,
            'type': hit.propertyType.name,
            'rooms': hit.roomCount,
            'surface': hit.surfaceArea,
          },
        ResidenceHit() => {
            'kind': 'residence',
            'id': hit.id,
            'title': hit.title,
            'city': hit.city,
            'district': hit.district,
            'photo': hit.primaryPhotoKey,
            'from': hit.fromMonthlyRent,
            'available': hit.availableUnitCount,
          },
      };

  static SearchHit? _hitFromCache(Map<String, dynamic> json) {
    final id = json['id'] as String?;
    if (id == null) return null;

    if (json['kind'] == 'residence') {
      return ResidenceHit(
        id: id,
        title: json['title'] as String?,
        city: json['city'] as String?,
        district: json['district'] as String?,
        primaryPhotoKey: json['photo'] as String?,
        fromMonthlyRent: json['from'] as int?,
        availableUnitCount: json['available'] as int?,
      );
    }

    return ListingHit(
      id: id,
      title: json['title'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      primaryPhotoKey: json['photo'] as String?,
      price: json['price'] as int?,
      rentalPeriod: RentalPeriod.values
              .where((p) => p.name == json['period'])
              .firstOrNull ??
          RentalPeriod.fallback,
      propertyType: PropertyType.values
              .where((t) => t.name == json['type'])
              .firstOrNull ??
          PropertyType.apartment,
      roomCount: json['rooms'] as int?,
      surfaceArea: json['surface'] as int?,
    );
  }
}
