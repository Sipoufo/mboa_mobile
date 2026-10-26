import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/subscription_bloc.dart';
import '../data/subscription_repository.dart';
import '../models/subscription_models.dart';
import 'payment_method_sheet.dart';
import 'payment_flow_sheet.dart';

/// The purchasable plans (CDC M13).
@RoutePage()
class PlansPage extends StatefulWidget {
  const PlansPage({super.key});

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  late Future<List<TierOption>> _tiers;

  @override
  void initState() {
    super.initState();
    // A static catalogue, read once — no bloc state to model beyond the future.
    _tiers = getIt<SubscriptionRepository>().tiers();
  }

  Future<void> _choose(TierOption option) async {
    final method = await showPaymentMethodSheet(context);
    if (method == null || !mounted) return;

    await showPaymentFlowSheet(context, purchase: TierPurchase(option.tier), method: method);
    if (!mounted) return;

    // Whatever the outcome, re-read the plan — the tier may have changed.
    context.read<SubscriptionBloc>().add(const SubscriptionRefreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.plansTitle)),
      body: FutureBuilder<List<TierOption>>(
        future: _tiers,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: Loader());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingXl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.commonError, style: context.mboaText.body),
                    const SizedBox(height: Dimens.spacingSm),
                    TextButton(
                      onPressed: () => setState(
                        () => _tiers = getIt<SubscriptionRepository>().tiers(),
                      ),
                      child: Text(l10n.commonRetry),
                    ),
                  ],
                ),
              ),
            );
          }

          final options = snapshot.data ?? const <TierOption>[];
          final subscription = context.watch<SubscriptionBloc>().state;
          final current = subscription.tier;
          final periodEnd = switch (subscription) {
            SubscriptionReady(:final plan) when current != SubscriptionTier.gratuit => plan.periodEnd,
            _ => null,
          };
          final currentRank = options.where((o) => o.tier == current).firstOrNull?.rank ?? 0;

          return ListView(
            padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacingSm, Dimens.screenMargin, Dimens.spacingXl),
            children: [
              const _Hero(),
              const SizedBox(height: Dimens.spacingLg),
              for (final option in options) ...[
                _PlanTile(
                  option: option,
                  isCurrent: option.tier == current,
                  isLower: (option.rank ?? 0) < currentRank,
                  periodEnd: option.tier == current ? periodEnd : null,
                  onChoose: () => _choose(option),
                ),
                const SizedBox(height: Dimens.spacingMd),
              ],
              const SizedBox(height: Dimens.spacingSm),
              // RM-M13-03 / RM-M13-04 — said before they pay, not after.
              for (final note in [l10n.plansUpgradeNote, l10n.plansDowngradeNote])
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.spacingXs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(LucideIcons.info, size: Dimens.iconSm, color: context.mboaColors.textTertiary),
                      const SizedBox(width: Dimens.spacingSm),
                      Expanded(
                        child: Text(
                          note,
                          style: context.mboaText.caption.copyWith(color: context.mboaColors.textTertiary),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// The page's top, on the brand colour: what to do, and what it never does.
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Material(
      color: colors.primary,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(child: MboaBrandPattern(color: colors.onBrand, opacity: 0.08, scale: 0.6)),
          Padding(
            padding: const EdgeInsets.all(Dimens.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.plansHeroTitle, style: context.mboaText.h2.copyWith(color: colors.onBrand)),
                const SizedBox(height: Dimens.spacingSm),
                Text(
                  l10n.plansHeroBody,
                  style: context.mboaText.body.copyWith(color: colors.onBrand.withValues(alpha: 0.9)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// One plan. The one held sits on the brand colour, with the M's — the
/// others on white, each with its one way there.
class _PlanTile extends StatelessWidget {
  const _PlanTile({
    required this.option,
    required this.isCurrent,
    required this.isLower,
    required this.onChoose,
    this.periodEnd,
  });

  final TierOption option;
  final bool isCurrent;

  /// Below the plan held: takes effect at the next cycle (RM-M13-03).
  final bool isLower;
  final DateTime? periodEnd;
  final VoidCallback onChoose;

  static IconData _mark(SubscriptionTier tier) => switch (tier) {
        SubscriptionTier.gratuit => LucideIcons.sprout,
        SubscriptionTier.basicPlus => LucideIcons.house,
        SubscriptionTier.pro => LucideIcons.building2,
        SubscriptionTier.proPlus => LucideIcons.gem,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context);
    final price = option.monthlyPrice ?? 0;
    final ink = isCurrent ? colors.onBrand : colors.ink;
    final soft = isCurrent ? colors.onBrand.withValues(alpha: 0.85) : colors.textSecondary;
    final description = option.description(locale.languageCode);

    final benefits = [
      option.activeListingLimit == null
          ? l10n.subscriptionListingLimitUnlimited
          : l10n.subscriptionListingLimit(option.activeListingLimit!),
      switch (option.residenceUnitAllowance) {
        null => l10n.plansResidenceUnlimited,
        final units => l10n.plansResidenceAllowance(units),
      },
      // RM-M13-09 — the finance tools come with the plans, not apart.
      if (option.includesFinance) l10n.plansFinanceIncluded,
    ];

    final content = Padding(
      padding: const EdgeInsets.all(Dimens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isCurrent ? colors.onBrand.withValues(alpha: 0.16) : colors.primaryPale,
                  borderRadius: BorderRadius.circular(Dimens.radius),
                ),
                child: Icon(_mark(option.tier), size: Dimens.icon, color: isCurrent ? colors.onBrand : colors.primary),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(child: Text(option.tier.label, style: context.mboaText.h3.copyWith(color: ink))),
            ],
          ),
          if (isCurrent) ...[
            const SizedBox(height: Dimens.spacingSm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 4),
              decoration: BoxDecoration(
                color: colors.onBrand.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(Dimens.radiusFull),
              ),
              child: Text(
                periodEnd == null
                    ? l10n.plansCurrent
                    : l10n.plansCurrentUntil(DateFormat.yMMMd(locale.toLanguageTag()).format(periodEnd!)),
                style: context.mboaText.micro.copyWith(color: colors.onBrand, fontWeight: FontWeight.w700),
              ),
            ),
          ],
          const SizedBox(height: Dimens.spacing),
          // « 0 FCFA / mois » rather than « Gratuit » again under its name.
          Text.rich(
              TextSpan(
                children: [
                  // Grouped thousands — "7 500" reads far faster than "7500".
                  TextSpan(text: NumberFormat.decimalPattern(locale.toLanguageTag()).format(price)),
                  TextSpan(
                    text: ' ${l10n.plansPriceUnit}',
                    style: context.mboaText.label.copyWith(color: soft, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              style: context.mboaText.h2.copyWith(color: ink),
            ),
          if (description != null) ...[
            const SizedBox(height: Dimens.spacingSm),
            Text(description, style: context.mboaText.caption.copyWith(color: soft)),
          ],
          const SizedBox(height: Dimens.spacing),
          for (final benefit in benefits)
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.spacingXs),
              child: Row(
                children: [
                  Icon(LucideIcons.circleCheck, size: Dimens.iconSm, color: isCurrent ? colors.onBrand : colors.primary),
                  const SizedBox(width: Dimens.spacingSm),
                  Expanded(child: Text(benefit, style: context.mboaText.label.copyWith(color: ink))),
                ],
              ),
            ),
          if (!isCurrent) ...[
            const SizedBox(height: Dimens.spacingMd),
            SizedBox(
              width: double.infinity,
              // A higher plan is the step forward; a lower one, quieter.
              child: isLower
                  ? Button.outline(title: l10n.plansSwitchTo(option.tier.label), onPressed: onChoose)
                  : Button.primary(title: l10n.plansSwitchTo(option.tier.label), onPressed: onChoose),
            ),
          ],
        ],
      ),
    );

    return Material(
      color: isCurrent ? colors.primary : colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        side: isCurrent ? BorderSide.none : BorderSide(color: colors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: isCurrent
          ? Stack(
              children: [
                Positioned.fill(child: MboaBrandPattern(color: colors.onBrand, opacity: 0.08, scale: 0.6)),
                content,
              ],
            )
          : content,
    );
  }
}
