import 'package:flutter/material.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../models/dashboard_stats.dart';
import 'metric_tile.dart';

/// "Statistiques Globales" — the M14 dashboard card.
///
/// The headline count and the status breakdown come from the listings; the
/// six figures from the dashboard endpoint, **locked or not as the server
/// says** (CA-M14-02): it sends no value for what the tier does not include,
/// so the app has nothing to decide and nothing to un-blur. One upgrade CTA,
/// towards the cheapest tier that unlocks something.
class GlobalStatsCard extends StatelessWidget {
  const GlobalStatsCard({
    super.key,
    required this.stats,
    this.onUpgrade,
  });

  final DashboardStats stats;
  final VoidCallback? onUpgrade;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final metrics = <(String, DashboardFigure?, String Function(num))>[
      (l10n.homeStatsViews, stats.views, _count),
      (l10n.homeStatsContacts, stats.contacts, _count),
      (l10n.homeStatsConversion, stats.conversionRate, _percent),
      (l10n.homeStatsVisits, stats.agentVisits, _count),
      (l10n.homeStatsContracts, stats.signedContracts, _count),
      (l10n.homeStatsRank, stats.averagePosition, _rank),
    ];
    final figures = metrics.map((m) => m.$2).nonNulls;
    final lockedTier = _cheapest(figures.where((f) => f.locked).map((f) => f.requiredTier).nonNulls);
    final somethingSoon = metrics.any((m) => m.$2 == null || !m.$2!.available);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.homeStatsTitle, style: context.mboaText.h3),
          const SizedBox(height: Dimens.spacing),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${stats.totalBiens}', style: context.mboaText.display),
              const SizedBox(width: Dimens.spacingSm),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.spacingXs),
                child: Text(
                  l10n.homeStatsBiens,
                  style: context.mboaText.h3.copyWith(color: colors.textSecondary),
                ),
              ),
            ],
          ),
          if (stats.totalBiens == 0) ...[
            const SizedBox(height: Dimens.spacingSm),
            Text(
              l10n.homeEmptyBiens,
              style: context.mboaText.caption.copyWith(color: colors.textSecondary),
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
              for (final (label, figure, format) in metrics)
                MetricTile(label: label, figure: figure, format: format),
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
          ] else if (somethingSoon) ...[
            const SizedBox(height: Dimens.spacingSm),
            Text(
              l10n.homeStatsUnavailableHint,
              style: context.mboaText.micro.copyWith(color: colors.textTertiary),
            ),
          ],
        ],
      ),
    );
  }

  /// The cheapest tier that unlocks something — what the single CTA offers.
  static SubscriptionTier? _cheapest(Iterable<SubscriptionTier> tiers) =>
      tiers.isEmpty ? null : tiers.reduce((a, b) => a.index <= b.index ? a : b);

  static String _count(num value) => value.toInt().toString();

  /// Already a percentage on the wire (contacts per 100 views, one decimal).
  static String _percent(num value) => '${value.toStringAsFixed(1)} %';

  /// 1.0 is always at the top of search.
  static String _rank(num value) => '#${value.toStringAsFixed(1)}';
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
