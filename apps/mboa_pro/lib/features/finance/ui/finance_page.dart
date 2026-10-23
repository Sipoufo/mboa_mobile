import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../subscription/models/subscription_models.dart';
import '../../subscription/ui/payment_flow_sheet.dart';
import '../../subscription/ui/payment_method_sheet.dart';
import '../bloc/finance_addon_bloc.dart';
import '../models/finance_addon.dart';

/// « Gestion financière » (M24–M26): the add-on and what it opens — the
/// invoices, the register, the intervenants. No money moves through Mboa:
/// the landlord notes what is paid, Mboa keeps the register.
@RoutePage()
class FinancePage extends StatelessWidget implements AutoRouteWrapper {
  const FinancePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<FinanceAddonBloc>(
        create: (_) => getIt<FinanceAddonBloc>()..add(const FinanceAddonRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => FinanceView(
        onBuy: () async {
          final bloc = context.read<FinanceAddonBloc>();
          final method = await showPaymentMethodSheet(context);
          if (method == null || !context.mounted) return;
          await showPaymentFlowSheet(context, purchase: const FinanceAddonPurchase(), method: method);
          // The webhook opens the period: read where it stands now.
          bloc.add(const FinanceAddonRequested());
        },
      );
}

/// The hub under its bloc — public so it can be pumped with a mock one.
class FinanceView extends StatelessWidget {
  const FinanceView({super.key, required this.onBuy, this.onInvoices, this.onLedger, this.onProviders});

  /// Buy 30 days: the first, the next, or again.
  final VoidCallback onBuy;

  /// Each part, once it can be read. Null: shown, not opened.
  final VoidCallback? onInvoices;
  final VoidCallback? onLedger;
  final VoidCallback? onProviders;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<FinanceAddonBloc, FinanceAddonState>(
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.financeAddonName)),
        body: switch (state) {
          FinanceAddonLoading() => const Center(child: Loader()),
          FinanceAddonFailure() => Center(
              child: TextButton(
                onPressed: () => context.read<FinanceAddonBloc>().add(const FinanceAddonRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          FinanceAddonReady(:final addon, :final isOffline) => RefreshIndicator(
              onRefresh: () async => context.read<FinanceAddonBloc>().add(const FinanceAddonRequested()),
              child: ListView(
                padding: const EdgeInsets.all(Dimens.screenMargin),
                children: [
                  if (isOffline) ...[
                    Text(l10n.financeOffline, style: context.mboaText.caption.copyWith(color: colors.warning)),
                    const SizedBox(height: Dimens.spacingMd),
                  ],
                  _StatusCard(addon: addon, onExtend: isOffline ? null : onBuy),
                  const SizedBox(height: Dimens.spacingLg),
                  Text(
                    l10n.financeIncluded,
                    style: context.mboaText.h3.copyWith(color: colors.primaryDark),
                  ),
                  const SizedBox(height: Dimens.spacingSm),
                  for (final (icon, title, hint, open) in [
                    (LucideIcons.receiptText, l10n.invoicesTitle, l10n.financeInvoicesHint, onInvoices),
                    (LucideIcons.bookOpenText, l10n.financeLedgerTitle, l10n.financeLedgerHint, onLedger),
                    (LucideIcons.hardHat, l10n.financeProvidersTitle, l10n.financeProvidersHint, onProviders),
                  ])
                    _PartRow(icon: icon, title: title, hint: hint, onTap: addon.canRead ? open : null),
                  const SizedBox(height: Dimens.spacing),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(LucideIcons.shieldCheck, size: Dimens.iconSm, color: colors.primary),
                      const SizedBox(width: Dimens.spacingSm),
                      Expanded(
                        child: Text(
                          l10n.financeNoMoney,
                          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        },
        // Only while it is not running: then buying is what the page is for.
        bottomNavigationBar: switch (state) {
          FinanceAddonReady(:final addon, isOffline: false) when !addon.active && addon.monthlyPrice != null =>
            _BuyBar(addon: addon, onBuy: onBuy),
          _ => null,
        },
      ),
    );
  }
}

/// The add-on on the brand colour: what it is, and where it stands.
class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.addon, required this.onExtend});

  final FinanceAddon addon;
  final VoidCallback? onExtend;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    String day(DateTime d) => DateFormat.yMMMMd(locale).format(d);
    final end = addon.periodEnd;

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
                Row(
                  children: [
                    Icon(LucideIcons.wallet, color: colors.onBrand, size: Dimens.iconMd),
                    const SizedBox(width: Dimens.spacingSm),
                    Expanded(
                      child: Text(
                        l10n.financeAddonName,
                        style: context.mboaText.h3.copyWith(color: colors.onBrand),
                      ),
                    ),
                  ],
                ),
                // Its own line: beside the title, a long date crushed it.
                if (end != null && (addon.active || addon.everSubscribed)) ...[
                  const SizedBox(height: Dimens.spacingSm),
                  _Pill(
                    text: addon.active ? l10n.financeActiveUntil(day(end)) : l10n.financeExpiredOn(day(end)),
                    active: addon.active,
                  ),
                ],
                const SizedBox(height: Dimens.spacingSm),
                Text(
                  addon.active || !addon.everSubscribed ? l10n.financeIntro : l10n.financeExpiredBody,
                  style: context.mboaText.body.copyWith(color: colors.onBrand.withValues(alpha: 0.9)),
                ),
                if (addon.monthlyPrice case final price?) ...[
                  const SizedBox(height: Dimens.spacing),
                  Text(
                    l10n.financePrice(fcfaOf(context, price)),
                    style: context.mboaText.label.copyWith(color: colors.onBrand, fontWeight: FontWeight.w700),
                  ),
                ],
                // Running: adding 30 more is possible, never expected.
                if (addon.active && onExtend != null)
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton.icon(
                      onPressed: onExtend,
                      style: TextButton.styleFrom(foregroundColor: colors.onBrand, padding: EdgeInsets.zero),
                      icon: const Icon(LucideIcons.calendarPlus, size: Dimens.icon),
                      label: Text(l10n.financeExtend),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.active});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 4),
      decoration: BoxDecoration(
        color: active ? colors.onBrand.withValues(alpha: 0.18) : colors.warning,
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
      ),
      child: Text(
        text,
        style: context.mboaText.micro.copyWith(color: colors.onBrand, fontWeight: FontWeight.w700),
      ),
    );
  }
}

/// One part of the add-on — opened once it can be read.
class _PartRow extends StatelessWidget {
  const _PartRow({required this.icon, required this.title, required this.hint, this.onTap});

  final IconData icon;
  final String title;
  final String hint;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimens.radiusMd),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMd),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: colors.primaryPale, borderRadius: BorderRadius.circular(Dimens.radius)),
                  child: Icon(icon, color: colors.primary, size: Dimens.icon),
                ),
                const SizedBox(width: Dimens.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: context.mboaText.label.copyWith(color: colors.ink)),
                      Text(hint, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                    ],
                  ),
                ),
                if (onTap != null) Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BuyBar extends StatelessWidget {
  const _BuyBar({required this.addon, required this.onBuy});

  final FinanceAddon addon;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final price = fcfaOf(context, addon.monthlyPrice!);

    return Container(
      decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
      child: SafeArea(
        minimum: const EdgeInsets.all(Dimens.spacing),
        child: Button.primary(
          title: addon.everSubscribed ? l10n.financeReactivate(price) : l10n.financeActivate(price),
          onPressed: onBuy,
        ),
      ),
    );
  }
}
