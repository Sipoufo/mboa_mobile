import 'dart:math';

import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// A listing's public fiche and the reviews on it (CDC M05 / M27).
///
/// Public: `GET /search/annonces/{id}` needs no account (CA-M04-04), and the
/// interceptor adds a token only when there is one.
class ListingRepository {
  ListingRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  static const String _deviceIdKey = 'deviceId';
  static const int _reviewPageSize = 10;

  SearchApi get _api => _dioClient.api.getSearchApi();

  /// The fiche, and a copy kept for 24h so it survives a tunnel.
  ///
  /// RM-M05-06 — the view is counted once per device per day, which is what
  /// [_deviceId] is for: without it an anonymous reader would be uncountable,
  /// and the prestataire's "X personnes ont consulté" would only ever reflect
  /// signed-in traffic.
  Future<ListingDetail> one(String id) async {
    final response = await _api.getAnnonceDetail(
      id: id,
      xDeviceId: await _deviceId(),
    );
    final data = response.data;
    if (data == null) throw StateError('Listing $id not found');

    final detail = ListingDetail.fromResponse(data);
    await _cacheViewed(detail);
    return detail;
  }

  Future<ResidenceDetail> residence(String id) async {
    final response = await _api.getResidenceDetail(id: id);
    final data = response.data;
    if (data == null) throw StateError('Residence $id not found');
    return ResidenceDetail.fromResponse(data);
  }

  /// RM-M05-08 — visits and tenancies in one feed, newest first.
  Future<List<ReviewEntry>> reviews(String id, {int page = 0}) async {
    final response = await _api.listAnnonceReviews(
      id: id,
      pageable: Pageable((b) => b
        ..page = page
        ..size = _reviewPageSize),
    );
    return (response.data?.content ?? const <PropertyReview>[])
        .map(ReviewEntry.fromResponse)
        .toList();
  }

  /// CE-M04-02's counterpart for a fiche: the last ones read, for a day.
  ///
  /// Only what the page draws without a network — the photos are URLs to a CDN
  /// and will not load offline anyway, so this is text and figures.
  ListingDetail? cached(String id) {
    final raw = _cache.get(StorageKeys.viewedBox, id, ttl: CacheTtl.viewed);
    if (raw == null) return null;
    try {
      return ListingDetail(
        id: id,
        title: raw['title'] as String?,
        city: raw['city'] as String?,
        district: raw['district'] as String?,
        price: raw['price'] as int?,
        rentalPeriod: RentalPeriod.values
                .where((p) => p.name == raw['period'])
                .firstOrNull ??
            RentalPeriod.fallback,
        propertyType: PropertyType.values
                .where((t) => t.name == raw['type'])
                .firstOrNull ??
            PropertyType.apartment,
        roomCount: raw['rooms'] as int?,
        bathroomCount: raw['bathrooms'] as int?,
        surfaceArea: raw['surface'] as int?,
        furnished: raw['furnished'] as bool?,
        description: raw['description'] as String?,
        photoKeys:
            (raw['photos'] as List?)?.whereType<String>().toList() ?? const [],
        // Deliberately false: a cached fiche must not offer to contact or to
        // book. Both are server verdicts (RM-M04-05, RM-M05-07) and a stale
        // "yes" would open a screen that fails.
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _cacheViewed(ListingDetail detail) => _cache.put(
        StorageKeys.viewedBox,
        detail.id,
        {
          'title': detail.title,
          'city': detail.city,
          'district': detail.district,
          'price': detail.displayPrice,
          'period': detail.rentalPeriod.name,
          'type': detail.propertyType.name,
          'rooms': detail.roomCount,
          'bathrooms': detail.bathroomCount,
          'surface': detail.surfaceArea,
          'furnished': detail.furnished,
          'description': detail.description,
          'photos': detail.photoKeys,
        },
      );

  /// A stable id for this install, minted once.
  ///
  /// Not a device fingerprint and not a secret: it exists so RM-M05-06 can
  /// count an anonymous reader once a day. It lives in the ordinary cache
  /// rather than secure storage for that reason — losing it costs one
  /// double-counted view.
  Future<String> _deviceId() async {
    final existing =
        _cache.get(StorageKeys.appSettingsBox, _deviceIdKey)?['value'];
    if (existing is String && existing.isNotEmpty) return existing;

    final random = Random.secure();
    final id = List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();

    await _cache.put(StorageKeys.appSettingsBox, _deviceIdKey, {'value': id});
    return id;
  }
}
