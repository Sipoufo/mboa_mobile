import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Where the landlord stands with the finance tools (RM-M13-09): they come
/// with the plans that include them — Pro and Pro+ today, the admin decides —
/// and are sold nowhere else.
///
/// The plan held now decides **writing**. Reading and exporting stay open to
/// whoever held them once; the app cannot tell that up front, so a read the
/// server refuses (`FINANCE_PLAN_REQUIRED`) is said where it happens.
class FinanceAccess extends Equatable {
  const FinanceAccess({
    this.tier = SubscriptionTier.gratuit,
    this.periodEnd,
    this.includesFinance = false,
    this.includedFromTier,
    this.includedFromPrice,
  });

  /// The plan held now — Gratuit once its period has run out.
  final SubscriptionTier tier;
  final DateTime? periodEnd;

  /// That plan includes the finance tools.
  final bool includesFinance;

  /// The cheapest plan that includes them, and its price — the server's.
  final SubscriptionTier? includedFromTier;
  final int? includedFromPrice;

  /// Creating, changing, deleting.
  bool get canWrite => includesFinance;

  Map<String, dynamic> toCache() => {
        'tier': tier.name,
        'periodEnd': periodEnd?.toIso8601String(),
        'includes': includesFinance,
        'fromTier': includedFromTier?.name,
        'fromPrice': includedFromPrice,
      };

  static FinanceAccess? fromCache(Object? raw) {
    if (raw is! Map) return null;
    SubscriptionTier? tierOf(Object? name) =>
        name is String ? SubscriptionTier.values.asNameMap()[name] : null;
    return FinanceAccess(
      tier: tierOf(raw['tier']) ?? SubscriptionTier.gratuit,
      periodEnd: raw['periodEnd'] is String ? DateTime.tryParse(raw['periodEnd'] as String) : null,
      includesFinance: raw['includes'] as bool? ?? false,
      includedFromTier: tierOf(raw['fromTier']),
      includedFromPrice: raw['fromPrice'] as int?,
    );
  }

  @override
  List<Object?> get props => [tier, periodEnd, includesFinance, includedFromTier, includedFromPrice];
}
