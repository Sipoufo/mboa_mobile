import 'package:flutter/material.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../models/dashboard_stats.dart';
import 'metric_tile.dart';

/// "Statistiques Globales" — the M14 dashboard card.
///
/// The headline count and the status breakdown are real (derived from the
/// listings endpoint). The rest of the M14 table has no backing endpoint yet
/// and renders as unavailable; tier-gated metrics render blurred with a single
/// upgrade CTA (CA-M14-02).
class GlobalStatsCard extends StatelessWidget {
  const GlobalStatsCard({
    super.key,
    required this.stats,
    required this.access,
    this.policy = const AccessPolicy(),
    this.onUpgrade,
  });

  final DashboardStats stats;

  /// Account facts the gating decisions are made from.
  final AccessContext access;
  final AccessPolicy policy;
  final VoidCallback? onUpgrade;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final metrics = <(FeatureKey, String, String?)>[
      (FeatureKey.statsVues, l10n.homeStatsViews, _asCount(stats.views)),
      (FeatureKey.statsContacts, l10n.homeStatsContacts, _asCount(stats.contacts)),
      (
        FeatureKey.statsConversion,
        l10n.homeStatsConversion,
        _asPercent(stats.conversionRate),
      ),
      (FeatureKey.statsVisites, l10n.homeStatsVisits, _asCount(stats.agentVisits)),
      (
        FeatureKey.statsContrats,
        l10n.homeStatsContracts,
        _asCount(stats.signedContracts),
      ),
      (FeatureKey.statsPosition, l10n.homeStatsRank, _asRank(stats.averageRank)),
    ];

    final lockedTier = _lowestLockedTier(metrics.map((m) => m.$1));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.homeStatsTitle, style: context.mboaText.h3),
          const SizedBox(height: Dimens.spacing),

          // Headline: the one figure that is genuinely available today.
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${stats.totalBiens}', style: context.mboaText.display),
              const SizedBox(width: Dimens.spacingSm),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.spacingXs),
                child: Text(
                  l10n.homeStatsBiens,
                  style: context.mboaText.h3.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          if (stats.totalBiens == 0) ...[
            const SizedBox(height: Dimens.spacingSm),
            Text(
              l10n.homeEmptyBiens,
              style: context.mboaText.caption
                  .copyWith(color: colors.textSecondary),
            ),
          ] else ...[
            const SizedBox(height: Dimens.spacingSm),
            _StatusBreakdown(stats: stats),
          ],

          const Divider(height: Dimens.spacingXl),

          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // A fixed extent rather than an aspect ratio: the tile height is
            // driven by the text scale, not by the column width.
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 62,
              mainAxisSpacing: Dimens.spacingMd,
              crossAxisSpacing: Dimens.spacingMd,
            ),
            children: [
              for (final (feature, label, value) in metrics)
                MetricTile(
                  label: label,
                  value: value,
                  decision: policy.check(feature, access),
                ),
            ],
          ),

          if (lockedTier != null) ...[
            const SizedBox(height: Dimens.spacingMd),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: onUpgrade,
                child: Text(l10n.accessUpgradeCta(lockedTier.label)),
              ),
            ),
          ] else if (metrics.any((m) => m.$3 == null)) ...[
            const SizedBox(height: Dimens.spacingSm),
            Text(
              l10n.homeStatsUnavailableHint,
              style: context.mboaText.micro
                  .copyWith(color: colors.textTertiary),
            ),
          ],
        ],
      ),
    );
  }

  /// The cheapest tier that would unlock something currently locked — that's
  /// what the single CTA should point at.
  SubscriptionTier? _lowestLockedTier(Iterable<FeatureKey> features) {
    SubscriptionTier? lowest;
    for (final feature in features) {
      final decision = policy.check(feature, access);
      if (decision is! AccessDenied) continue;
      final required = decision.requiredTier;
      if (required == null) continue;
      if (lowest == null || required.index < lowest.index) lowest = required;
    }
    return lowest;
  }

  static String? _asCount(int? value) => value?.toString();

  static String? _asPercent(double? value) =>
      value == null ? null : '${(value * 100).toStringAsFixed(1)}%';

  static String? _asRank(double? value) =>
      value == null ? null : '#${value.toStringAsFixed(1)}';
}

class _StatusBreakdown extends StatelessWidget {
  const _StatusBreakdown({required this.stats});

  final DashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final entries = <(String, int)>[
      (l10n.homeStatsPublished, stats.countOf(AnnonceStatus.published)),
      (l10n.homeStatsReserved, stats.countOf(AnnonceStatus.reserved)),
      (l10n.homeStatsRented, stats.countOf(AnnonceStatus.rented)),
    ];

    return Wrap(
      spacing: Dimens.spacingSm,
      runSpacing: Dimens.spacingSm,
      children: [
        for (final (label, count) in entries)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.spacingMd,
              vertical: Dimens.spacingXs,
            ),
            decoration: BoxDecoration(
              color: colors.primaryPale,
              borderRadius: BorderRadius.circular(Dimens.radiusFull),
            ),
            child: Text(
              '$count $label',
              style: context.mboaText.caption.copyWith(color: colors.primary),
            ),
          ),
      ],
    );
  }
}
