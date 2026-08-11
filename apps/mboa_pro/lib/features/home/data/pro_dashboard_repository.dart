import 'package:mboa_core/mboa_core.dart';

import '../models/dashboard_stats.dart';

/// Loads the prestataire dashboard counters (CDC M14).
///
/// There is no stats endpoint, so the figures are derived from the listings
/// page: `totalElements` gives the headline count and the page content gives
/// the per-status breakdown. Replace with a real aggregate endpoint when one
/// exists — the bloc and UI won't need to change.
class ProDashboardRepository {
  ProDashboardRepository({
    required DioClient dioClient,
    required HiveCache cache,
  })  : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  static const String _cacheKey = 'stats';

  /// One page large enough to cover any realistic prestataire portfolio, so the
  /// status breakdown doesn't need pagination. Guard rail, not a promise.
  static const int _pageSize = 100;

  /// Cached stats, or null when absent/stale. Synchronous — used for the first
  /// paint before the network call resolves.
  DashboardStats? cached() {
    final json = _cache.get(
      StorageKeys.dashboardBox,
      _cacheKey,
      ttl: CacheTtl.dashboard,
    );
    return json == null ? null : DashboardStats.fromCache(json);
  }

  Future<DashboardStats> fetch() async {
    final response = await _dioClient.api.getAnnoncesApi().listMyAnnonces(
          pageable: Pageable((b) => b
            ..page = 0
            ..size = _pageSize),
        );

    final page = response.data;
    final content = page?.content ?? const <AnnonceResponse>[];

    final byStatus = <AnnonceStatus, int>{};
    var views = 0;
    var sawViewCount = false;
    for (final annonce in content) {
      final status = _mapStatus(annonce.status);
      byStatus[status] = (byStatus[status] ?? 0) + 1;
      if (annonce.viewCount case final count?) {
        views += count;
        sawViewCount = true;
      }
    }

    final stats = DashboardStats(
      // Prefer the server's total; it survives a portfolio bigger than a page.
      totalBiens: page?.totalElements ?? content.length,
      byStatus: byStatus,
      // Summed from the page, like the status breakdown — so a portfolio past
      // one page undercounts. Null, not 0, when the field is absent everywhere:
      // an older backend must keep reading as "no data" and render "Bientôt",
      // not claim nobody has looked at the listings.
      views: sawViewCount ? views : null,
    );

    await _cache.put(StorageKeys.dashboardBox, _cacheKey, stats.toCache());
    return stats;
  }

  AnnonceStatus _mapStatus(AnnonceResponseStatusEnum? status) => switch (status) {
        AnnonceResponseStatusEnum.DRAFT => AnnonceStatus.draft,
        AnnonceResponseStatusEnum.PUBLISHED => AnnonceStatus.published,
        AnnonceResponseStatusEnum.RESERVED => AnnonceStatus.reserved,
        AnnonceResponseStatusEnum.RENTED => AnnonceStatus.rented,
        AnnonceResponseStatusEnum.ARCHIVED => AnnonceStatus.archived,
        _ => AnnonceStatus.unknown,
      };
}
