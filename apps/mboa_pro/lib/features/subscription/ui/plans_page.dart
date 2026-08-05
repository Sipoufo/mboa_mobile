import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
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

    await showPaymentFlowSheet(context, tier: option.tier, method: method);
    if (!mounted) return;

    // Whatever the outcome, re-read the plan — the tier may have changed.
    context.read<SubscriptionBloc>().add(const SubscriptionRefreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.surfaceWarm,
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
          final current = context.watch<SubscriptionBloc>().state.tier;

          return ListView(
            padding: const EdgeInsets.all(Dimens.spacing),
            children: [
              for (final option in options) ...[
                _PlanTile(
                  option: option,
                  isCurrent: option.tier == current,
                  onChoose: () => _choose(option),
                ),
                const SizedBox(height: Dimens.spacingMd),
              ],
              const SizedBox(height: Dimens.spacingSm),
              Text(
                // RM-M13-03 — say it before they pay, not after.
                l10n.plansDowngradeNote,
                style: context.mboaText.micro
                    .copyWith(color: context.mboaColors.textTertiary),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  const _PlanTile({
    required this.option,
    required this.isCurrent,
    required this.onChoose,
  });

  final TierOption option;
  final bool isCurrent;
  final VoidCallback onChoose;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final price = option.monthlyPrice ?? 0;

    return Container(
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        border: Border.all(
          color: isCurrent ? colors.primary : colors.border,
          width: isCurrent ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(option.tier.label, style: context.mboaText.h3),
              const SizedBox(width: Dimens.spacingSm),
              if (isCurrent)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.spacingSm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primaryPale,
                    borderRadius: BorderRadius.circular(Dimens.radiusFull),
                  ),
                  child: Text(
                    l10n.plansCurrent,
                    style: context.mboaText.micro
                        .copyWith(color: colors.primary),
                  ),
                ),
            ],
          ),
          const SizedBox(height: Dimens.spacingXs),
          Text(
            price == 0
                ? l10n.plansPriceFree
                // Grouped thousands — "15 000" reads far faster than "15000".
                : l10n.plansPriceMonthly(NumberFormat.decimalPattern().format(price)),
            style: context.mboaText.bodyLarge
                .copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: Dimens.spacingMd),
          _Benefit(
            icon: LucideIcons.building2,
            label: option.activeListingLimit == null
                ? l10n.subscriptionListingLimitUnlimited
                : l10n.subscriptionListingLimit(option.activeListingLimit!),
          ),
          if (option.residenceUnitAllowance case final units?
              when units > 0) ...[
            const SizedBox(height: Dimens.spacingXs),
            _Benefit(
              icon: LucideIcons.hotel,
              label: l10n.plansResidenceAllowance(units),
            ),
          ],
          if (!isCurrent) ...[
            const SizedBox(height: Dimens.spacing),
            SizedBox(
              width: double.infinity,
              child: Button.outline(
                title: l10n.plansChoose,
                onPressed: onChoose,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Row(
      children: [
        Icon(icon, size: Dimens.iconSm, color: colors.primary),
        const SizedBox(width: Dimens.spacingSm),
        Expanded(
          child: Text(
            label,
            style: context.mboaText.caption
                .copyWith(color: colors.textSecondary),
          ),
        ),
      ],
    );
  }
}
