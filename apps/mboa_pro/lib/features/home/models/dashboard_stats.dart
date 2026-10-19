import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Lifecycle state of a listing, mirrored from `AnnonceResponseStatusEnum`.
enum AnnonceStatus { draft, published, reserved, rented, archived, unknown }

/// One M14 figure, exactly as the server decided it (CA-M14-02).
///
/// Four readings, and the screen draws each differently:
///  * [locked] — the tier does not include it: **no value is sent**, so there
///    is nothing to un-blur client-side; [requiredTier] says what unlocks it;
///  * not [available] — nobody can see it yet, whatever the tier: "Bientôt";
///  * available, unlocked, no [value] — nothing to measure yet (a conversion
///    with no views, a position never shown in search): "—", never 0;
///  * otherwise the [value].
class DashboardFigure extends Equatable {
  const DashboardFigure({this.value, this.locked = false, this.requiredTier, this.available = true});

  final num? value;
  final bool locked;
  final SubscriptionTier? requiredTier;
  final bool available;

  static DashboardFigure? fromResponse(DashboardMetric? metric) => metric == null
      ? null
      : DashboardFigure(
          value: metric.value,
          locked: metric.locked ?? false,
          requiredTier: switch (metric.requiredTier) {
            DashboardMetricRequiredTierEnum.BASIC_PLUS => SubscriptionTier.basicPlus,
            DashboardMetricRequiredTierEnum.PRO => SubscriptionTier.pro,
            DashboardMetricRequiredTierEnum.PRO_PLUS => SubscriptionTier.proPlus,
            _ => null,
          },
          available: metric.available ?? true,
        );

  Map<String, dynamic> toCache() => {
        'value': value,
        'locked': locked,
        'tier': requiredTier?.name,
        'available': available,
      };

  static DashboardFigure? fromCache(Object? raw) {
    if (raw is! Map) return null;
    return DashboardFigure(
      value: raw['value'] as num?,
      locked: raw['locked'] as bool? ?? false,
      requiredTier: SubscriptionTier.values.where((t) => t.name == raw['tier']).firstOrNull,
      available: raw['available'] as bool? ?? true,
    );
  }

  @override
  List<Object?> get props => [value, locked, requiredTier, available];
}

/// The prestataire dashboard (CDC M14).
///
/// Two sources. The portfolio — [totalBiens] and the per-status breakdown —
/// comes from the listings page. The six figures come from
/// `GET /prestataires/me/dashboard`, which also decides what the tier may see.
/// A null figure was not loaded (an older cache): it reads as "Bientôt".
class DashboardStats extends Equatable {
  const DashboardStats({
    required this.totalBiens,
    this.byStatus = const {},
    this.views,
    this.contacts,
    this.conversionRate,
    this.agentVisits,
    this.signedContracts,
    this.averagePosition,
  });

  const DashboardStats.empty() : this(totalBiens: 0);

  /// Total listings owned by the prestataire — `totalElements` from the
  /// paginated listings response.
  final int totalBiens;

  /// Listing count per lifecycle status.
  final Map<AnnonceStatus, int> byStatus;

  /// Counted views: one per viewer per 24 h, the owner's own excluded.
  final DashboardFigure? views;

  /// Threads users opened on a listing — a second message is not a second one.
  final DashboardFigure? contacts;

  /// Contacts per 100 views, one decimal — already a percentage.
  final DashboardFigure? conversionRate;

  /// Visits carried out by an agent, not those the owner did himself.
  final DashboardFigure? agentVisits;
  final DashboardFigure? signedContracts;

  /// Where search showed his listings, on average over 30 days. 1.0 is the top.
  final DashboardFigure? averagePosition;

  int countOf(AnnonceStatus status) => byStatus[status] ?? 0;

  /// Listings currently visible to the public.
  int get publishedCount => countOf(AnnonceStatus.published);

  Map<String, dynamic> toCache() => {
        'totalBiens': totalBiens,
        'byStatus': byStatus.map((k, v) => MapEntry(k.name, v)),
        'views': views?.toCache(),
        'contacts': contacts?.toCache(),
        'conversionRate': conversionRate?.toCache(),
        'agentVisits': agentVisits?.toCache(),
        'signedContracts': signedContracts?.toCache(),
        'averagePosition': averagePosition?.toCache(),
      };

  static DashboardStats fromCache(Map<String, dynamic> json) {
    final raw = Map<String, dynamic>.from(
      (json['byStatus'] as Map?) ?? const {},
    );
    return DashboardStats(
      totalBiens: (json['totalBiens'] as num?)?.toInt() ?? 0,
      byStatus: {
        for (final entry in raw.entries)
          AnnonceStatus.values.firstWhere(
            (s) => s.name == entry.key,
            orElse: () => AnnonceStatus.unknown,
          ): (entry.value as num?)?.toInt() ?? 0,
      },
      views: DashboardFigure.fromCache(json['views']),
      contacts: DashboardFigure.fromCache(json['contacts']),
      conversionRate: DashboardFigure.fromCache(json['conversionRate']),
      agentVisits: DashboardFigure.fromCache(json['agentVisits']),
      signedContracts: DashboardFigure.fromCache(json['signedContracts']),
      averagePosition: DashboardFigure.fromCache(json['averagePosition']),
    );
  }

  @override
  List<Object?> get props => [
        totalBiens,
        byStatus,
        views,
        contacts,
        conversionRate,
        agentVisits,
        signedContracts,
        averagePosition,
      ];
}
