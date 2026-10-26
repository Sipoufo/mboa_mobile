import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/finance_access_bloc.dart';
import '../models/finance_access.dart';

/// « Gestion financière » (M24–M26): the invoices, the register, the
/// intervenants — included in the plans that carry them (RM-M13-09). No
/// money moves through Mboa: the landlord notes what is paid, Mboa keeps the
/// register.
@RoutePage()
class FinancePage extends StatelessWidget implements AutoRouteWrapper {
  const FinancePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<FinanceAccessBloc>(
        create: (_) => getIt<FinanceAccessBloc>()..add(const FinanceAccessRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => FinanceView(
        onPlans: () async {
          final bloc = context.read<FinanceAccessBloc>();
          await context.router.push(const PlansRoute());
          // A new plan is what opens writing: read where it stands now.
          bloc.add(const FinanceAccessRequested());
        },
        // Writing needs a plan that includes it; the lists then offer their
        // main action. Reading is the server's to refuse.
        onInvoices: (access) => context.router.push(OwnerInvoicesRoute(canWrite: access.canWrite)),
        onLedger: (access) => context.router.push(LedgerRoute(canWrite: access.canWrite)),
        onProviders: (access) => context.router.push(ProvidersRoute(canWrite: access.canWrite)),
      );
}

/// The hub under its bloc — public so it can be pumped with a mock one.
class FinanceView extends StatelessWidget {
  const FinanceView({super.key, required this.onPlans, this.onInvoices, this.onLedger, this.onProviders});

  /// The plans screen, where the plans that include it are.
  final VoidCallback onPlans;

  /// Each part. Null: shown, not opened.
  final ValueChanged<FinanceAccess>? onInvoices;
  final ValueChanged<FinanceAccess>? onLedger;
  final ValueChanged<FinanceAccess>? onProviders;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<FinanceAccessBloc, FinanceAccessState>(
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.financeAddonName)),
        body: switch (state) {
          FinanceAccessLoading() => const Center(child: Loader()),
          FinanceAccessFailure() => Center(
              child: TextButton(
                onPressed: () => context.read<FinanceAccessBloc>().add(const FinanceAccessRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          FinanceAccessReady(:final access, :final isOffline) => RefreshIndicator(
              onRefresh: () async => context.read<FinanceAccessBloc>().add(const FinanceAccessRequested()),
              child: ListView(
                padding: const EdgeInsets.all(Dimens.screenMargin),
                children: [
                  if (isOffline) ...[
                    Text(l10n.financeOffline, style: context.mboaText.caption.copyWith(color: colors.warning)),
                    const SizedBox(height: Dimens.spacingMd),
                  ],
                  _StatusCard(access: access),
                  const SizedBox(height: Dimens.spacingLg),
                  Text(
                    l10n.financeIncluded,
                    style: context.mboaText.h3.copyWith(color: colors.primaryDark),
                  ),
                  const SizedBox(height: Dimens.spacingSm),
                  for (final (icon, title, hint, open) in [
                    (
                      LucideIcons.receiptText,
                      l10n.invoicesTitle,
                      l10n.financeInvoicesHint,
                      onInvoices == null ? null : () => onInvoices!(access),
                    ),
                    (
                      LucideIcons.bookOpenText,
                      l10n.financeLedgerTitle,
                      l10n.financeLedgerHint,
                      onLedger == null ? null : () => onLedger!(access),
                    ),
                    (
                      LucideIcons.hardHat,
                      l10n.financeProvidersTitle,
                      l10n.financeProvidersHint,
                      onProviders == null ? null : () => onProviders!(access),
                    ),
                  ])
                    // Always open: what was held once still reads, and a
                    // never-held read is refused, and said, on its page.
                    _PartRow(icon: icon, title: title, hint: hint, onTap: open),
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
        // Only while the plan does not include it: then the plans are what the
        // page is for.
        bottomNavigationBar: switch (state) {
          FinanceAccessReady(:final access, isOffline: false) when !access.canWrite => Container(
              decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
              child: SafeArea(
                minimum: const EdgeInsets.all(Dimens.spacing),
                child: Button.primary(title: l10n.financeSeePlans, onPressed: onPlans),
              ),
            ),
          _ => null,
        },
      ),
    );
  }
}

/// The finance tools on the brand colour: what they are, and whether the plan
/// held includes them.
class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.access});

  final FinanceAccess access;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final end = access.periodEnd;
    final from = access.includedFromTier;

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
                if (access.canWrite) ...[
                  const SizedBox(height: Dimens.spacingSm),
                  _Pill(
                    text: end == null
                        ? l10n.financeIncludedIn(access.tier.label)
                        : l10n.financeIncludedUntil(access.tier.label, DateFormat.yMMMd(locale).format(end)),
                    active: true,
                  ),
                ],
                const SizedBox(height: Dimens.spacingSm),
                Text(
                  access.canWrite || from == null ? l10n.financeIntro : l10n.financeNotIncludedBody(from.label),
                  style: context.mboaText.body.copyWith(color: colors.onBrand.withValues(alpha: 0.9)),
                ),
                if (!access.canWrite && from != null && access.includedFromPrice != null) ...[
                  const SizedBox(height: Dimens.spacing),
                  Text(
                    l10n.financeFromPrice(from.label, fcfaOf(context, access.includedFromPrice!)),
                    style: context.mboaText.label.copyWith(color: colors.onBrand, fontWeight: FontWeight.w700),
                  ),
                ],
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
