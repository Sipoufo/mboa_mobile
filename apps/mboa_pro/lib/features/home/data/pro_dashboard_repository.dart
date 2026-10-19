import 'package:mboa_core/mboa_core.dart';

import '../models/dashboard_stats.dart';

/// Loads the prestataire dashboard (CDC M14).
///
/// Two reads, side by side. The listings page gives the headline count
/// (`totalElements`) and the per-status breakdown. `GET
/// /prestataires/me/dashboard` gives the six figures — and, with them, what
/// the tier may see: a locked figure arrives with no value, so the gating is
/// the server's, not the app's (CA-M14-02).
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
    final (listings, dashboard) = await (
      _dioClient.api.getAnnoncesApi().listMyAnnonces(
            pageable: Pageable((b) => b
              ..page = 0
              ..size = _pageSize),
          ),
      _dioClient.api.getPrestataireDashboardApi().getMyDashboard(),
    ).wait;

    final page = listings.data;
    final content = page?.content ?? const <AnnonceResponse>[];
    final byStatus = <AnnonceStatus, int>{};
    for (final annonce in content) {
      final status = _mapStatus(annonce.status);
      byStatus[status] = (byStatus[status] ?? 0) + 1;
    }

    final totals = dashboard.data?.totals;
    final stats = DashboardStats(
      // Prefer the server's total; it survives a portfolio bigger than a page.
      totalBiens: page?.totalElements ?? content.length,
      byStatus: byStatus,
      views: DashboardFigure.fromResponse(totals?.views),
      contacts: DashboardFigure.fromResponse(totals?.contacts),
      conversionRate: DashboardFigure.fromResponse(totals?.conversionRate),
      agentVisits: DashboardFigure.fromResponse(totals?.agentVisits),
      signedContracts: DashboardFigure.fromResponse(totals?.signedContracts),
      averagePosition: DashboardFigure.fromResponse(dashboard.data?.averagePosition),
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
