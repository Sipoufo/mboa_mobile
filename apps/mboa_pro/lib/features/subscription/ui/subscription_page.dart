import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/subscription_bloc.dart';
import '../models/subscription_models.dart';
import 'widgets/receipt_list.dart';

/// "Mon abonnement" (CDC M13) — the current plan, and the receipts we know of.
@RoutePage()
class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.subscriptionTitle)),
      body: RefreshIndicator(
        onRefresh: () async => context
            .read<SubscriptionBloc>()
            .add(const SubscriptionRefreshRequested()),
        child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
          builder: (context, state) {
            if (state is! SubscriptionReady) {
              return const Center(child: Loader());
            }

            return ListView(
              padding: const EdgeInsets.all(Dimens.spacing),
              children: [
                _PlanCard(plan: state.plan, fromFallback: state.fromFallback),
                const SizedBox(height: Dimens.spacing),
                Button.primary(
                  title: l10n.subscriptionChangePlan,
                  icon: const Icon(LucideIcons.sparkles, size: Dimens.icon),
                  iconAlignment: IconAlignment.start,
                  onPressed: () => context.router.push(const PlansRoute()),
                ),
                const SizedBox(height: Dimens.spacingXl),
                Text(l10n.subscriptionReceipts, style: context.mboaText.h3),
                const SizedBox(height: Dimens.spacingSm),
                const ReceiptList(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan, required this.fromFallback});

  final SubscriptionPlan plan;
  final bool fromFallback;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final expired = plan.hasLapsed;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.subscriptionCurrentPlan,
            style: context.mboaText.caption.copyWith(
              color: colors.onBrand.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: Dimens.spacingXs),
          Text(
            plan.effectiveTier.label,
            style: context.mboaText.display.copyWith(color: colors.onBrand),
          ),
          const SizedBox(height: Dimens.spacingSm),
          Text(
            switch ((expired, plan.periodEnd)) {
              (true, _) => l10n.subscriptionExpired,
              (false, final DateTime end) =>
                l10n.subscriptionRenewsOn(DateFormat.yMMMMd().format(end)),
              _ => l10n.subscriptionNoExpiry,
            },
            style: context.mboaText.body.copyWith(color: colors.onBrand),
          ),
          const SizedBox(height: Dimens.spacingSm),
          Row(
            children: [
              Icon(
                LucideIcons.building2,
                size: Dimens.iconSm,
                color: colors.onBrand,
              ),
              const SizedBox(width: Dimens.spacingXs),
              Text(
                plan.activeListingLimit == null
                    ? l10n.subscriptionListingLimitUnlimited
                    : l10n.subscriptionListingLimit(plan.activeListingLimit!),
                style: context.mboaText.caption.copyWith(color: colors.onBrand),
              ),
            ],
          ),
          if (fromFallback) ...[
            const SizedBox(height: Dimens.spacingMd),
            Text(
              l10n.subscriptionUnknown,
              style: context.mboaText.caption.copyWith(
                color: colors.onBrand.withValues(alpha: 0.85),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
