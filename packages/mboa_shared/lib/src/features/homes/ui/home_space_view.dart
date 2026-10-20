import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/home_space_bloc.dart';
import '../models/home.dart';
import 'home_bits.dart';

/// One space of "Mon Logement" (CDC M30), after the founder's "Porte feuille"
/// mockup — **without a balance, a top-up or a transfer**: Mboa holds and
/// moves no money (RM-M30-06). The big figure is what is due next (or late),
/// the round buttons declare, and the dated timeline is the schedule.
///
/// Shared by both apps. [onDeclare] is the tenant's alone — null on the
/// landlord's side, so the buttons are absent rather than refused; both may
/// open a declaration.
class HomeSpaceView extends StatelessWidget {
  const HomeSpaceView({super.key, this.onDeclare, this.onDeclareDeposit, this.onOpenDeclaration});

  /// Declare rent — preselecting [due] when a row was tapped.
  final void Function(HomeSpaceReady state, RentDue? due)? onDeclare;
  final void Function(HomeSpaceReady state)? onDeclareDeposit;
  final void Function(Declaration declaration)? onOpenDeclaration;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<HomeSpaceBloc, HomeSpaceState>(
      listenWhen: (_, current) => current is HomeSpaceReady && current.olderFailed,
      listener: (context, _) => MboaToast.error(context: context, title: l10n.commonError),
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          leading: const MboaHeaderBackButton(),
          title: Text(
            state is HomeSpaceReady ? (state.home.annonceTitle ?? l10n.myHomeTitle) : l10n.myHomeTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: switch (state) {
          HomeSpaceLoading() => const Center(child: Loader()),
          HomeSpaceFailure(:final contractId) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.commonError, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
                  TextButton(
                    onPressed: () => context.read<HomeSpaceBloc>().add(HomeSpaceRequested(contractId)),
                    child: Text(l10n.commonRetry),
                  ),
                ],
              ),
            ),
          final HomeSpaceReady ready => RefreshIndicator(
              onRefresh: () async => context.read<HomeSpaceBloc>().add(HomeSpaceRequested(ready.home.contractId)),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
                children: [
                  if (ready.isOffline) ...[
                    _Notice(icon: LucideIcons.wifiOff, tone: colors.warning, text: l10n.myHomeOffline),
                    const SizedBox(height: Dimens.spacing),
                  ],
                  _Header(home: ready.home),
                  if (onDeclare != null && ready.home.isWritable && !ready.isOffline) ...[
                    const SizedBox(height: Dimens.spacingLg),
                    _RoundActions(
                      onDeclare: () => onDeclare!(ready, null),
                      onDeposit: ready.home.deposit.amount > 0 && onDeclareDeposit != null
                          ? () => onDeclareDeposit!(ready)
                          : null,
                    ),
                  ],
                  if (ready.totals case final totals?) ...[
                    const SizedBox(height: Dimens.spacingLg),
                    _Totals(totals: totals),
                  ],
                  if (onDeclare != null) ...[
                    const SizedBox(height: Dimens.spacing),
                    _Notice(icon: LucideIcons.shieldCheck, tone: colors.primary, text: l10n.myHomeNoMoney),
                  ],
                  const SizedBox(height: Dimens.spacingLg),
                  _SectionTitle(l10n.myHomeScheduleTitle),
                  if (ready.schedule.moreBefore && !ready.isOffline)
                    Center(
                      child: TextButton.icon(
                        onPressed: ready.loadingOlder
                            ? null
                            : () => context.read<HomeSpaceBloc>().add(const HomeSpaceOlderRequested()),
                        icon: ready.loadingOlder
                            ? const Loader(size: Dimens.loaderSizeXs)
                            : const Icon(LucideIcons.chevronUp, size: Dimens.iconSm),
                        label: Text(l10n.myHomeOlder),
                      ),
                    ),
                  for (final (index, due) in ready.schedule.dues.indexed)
                    _DueRow(
                      due: due,
                      last: index == ready.schedule.dues.length - 1,
                      onTap: () {
                        final declarations = ready.declarationsOf(due);
                        if (declarations.isNotEmpty && onOpenDeclaration != null) {
                          onOpenDeclaration!(declarations.last);
                        } else if (due.status.isOpen && onDeclare != null && ready.home.isWritable && !ready.isOffline) {
                          onDeclare!(ready, due);
                        }
                      },
                    ),
                  if (ready.declarations.isNotEmpty) ...[
                    const SizedBox(height: Dimens.spacingLg),
                    _SectionTitle(l10n.myHomeDeclarationsTitle),
                    for (final declaration in ready.declarations)
                      DeclarationRow(
                        declaration: declaration,
                        onTap: onOpenDeclaration == null ? null : () => onOpenDeclaration!(declaration),
                      ),
                  ],
                ],
              ),
            ),
        },
      ),
    );
  }
}

/// The mockup's "Solde actuel": here, what is due next — or late, or nothing.
class _Header extends StatelessWidget {
  const _Header({required this.home});

  final Home home;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    String date(DateTime d) => DateFormat.MMMMd(locale).format(d);
    final next = home.nextDue;

    final (String label, int? amount, String? line, Color tone) = switch (home) {
      _ when home.state == HomeStage.readOnly => (l10n.myHomeEnded, null, null, colors.textSecondary),
      _ when home.isOverdue => (
          l10n.myHomeOverdue,
          home.overdueAmount,
          l10n.myHomeOverdueCount(home.overdueCount),
          colors.error,
        ),
      _ when home.state == HomeStage.upcoming => (
          l10n.myHomeUpcomingState,
          next?.remaining ?? home.rent,
          home.startDate == null ? null : l10n.myHomeStartsOn(date(home.startDate!)),
          colors.primary,
        ),
      _ when next != null => (
          l10n.myHomeNextRent,
          next.remaining,
          next.dueDate == null ? null : l10n.myHomeDueOn(date(next.dueDate!)),
          colors.primaryDark,
        ),
      _ => (l10n.myHomeUpToDate, null, null, colors.success),
    };

    return Column(
      children: [
        Text(label, style: context.mboaText.bodyLarge.copyWith(color: colors.textSecondary)),
        if (amount != null) ...[
          const SizedBox(height: Dimens.spacingSm),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  NumberFormat.decimalPattern(locale).format(amount),
                  style: context.mboaText.display.copyWith(color: tone, fontSize: 44, height: 1.1),
                ),
                const SizedBox(width: Dimens.spacingSm),
                Text(l10n.annonceFormCurrency, style: context.mboaText.h3.copyWith(color: tone)),
              ],
            ),
          ),
        ] else ...[
          const SizedBox(height: Dimens.spacingSm),
          Icon(LucideIcons.circleCheck, color: tone, size: Dimens.iconLg),
        ],
        if (line != null) ...[
          const SizedBox(height: Dimens.spacingXs),
          Text(line, style: context.mboaText.label.copyWith(color: tone)),
        ],
      ],
    );
  }
}

/// The mockup's two round buttons — here, declaring rent and the deposit.
class _RoundActions extends StatelessWidget {
  const _RoundActions({required this.onDeclare, this.onDeposit});

  final VoidCallback onDeclare;
  final VoidCallback? onDeposit;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Round(icon: LucideIcons.send, label: l10n.myHomeDeclareShort, onTap: onDeclare),
        if (onDeposit case final deposit?) ...[
          const SizedBox(width: Dimens.spacingXl),
          _Round(icon: LucideIcons.shieldCheck, label: l10n.myHomeDeposit, onTap: deposit),
        ],
      ],
    );
  }
}

class _Round extends StatelessWidget {
  const _Round({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return SizedBox(
      width: 112,
      child: Column(
        children: [
          Material(
            color: colors.primaryPale,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onTap,
              child: SizedBox.square(dimension: 72, child: Icon(icon, color: colors.primaryDark, size: 28)),
            ),
          ),
          const SizedBox(height: Dimens.spacingSm),
          Text(
            label,
            textAlign: TextAlign.center,
            style: context.mboaText.label.copyWith(color: colors.primaryDark),
          ),
        ],
      ),
    );
  }
}

/// The server's totals (RM-M30-08) — never added up here.
class _Totals extends StatelessWidget {
  const _Totals({required this.totals});

  final HomeTotals totals;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    Widget cell(String label, int amount, Color tone) => Expanded(
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(fcfaOf(context, amount), style: context.mboaText.label.copyWith(color: tone)),
              ),
              const SizedBox(height: 2),
              Text(label, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
            ],
          ),
        );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingMd, horizontal: Dimens.spacingSm),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusMd)),
      child: Row(
        children: [
          cell(l10n.myHomeConfirmedTotal, totals.confirmedTotal, colors.success),
          cell(l10n.myHomeDeclaredTotal, totals.declaredTotal, colors.warning),
          cell(l10n.myHomeContestedTotal, totals.contestedTotal, colors.error),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
        child: Text(text, style: context.mboaText.h3.copyWith(color: context.mboaColors.primaryDark)),
      );
}

/// One échéance on the mockup's timeline: the date, the dotted line, the
/// tile, the period and its state, the amount.
class _DueRow extends StatelessWidget {
  const _DueRow({required this.due, required this.last, required this.onTap});

  final RentDue due;
  final bool last;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final look = dueLook(context, due.status);
    final dueDate = due.dueDate;
    final untracked = due.status == DueStatus.untracked;
    String short(DateTime d) => DateFormat.MMMd(locale).format(d);

    final period = due.periodStart != null && due.periodEnd != null
        ? l10n.myHomePeriod(short(due.periodStart!), short(due.periodEnd!))
        : null;
    final status = due.isPartlyPaid
        ? '${look.label} · ${l10n.duePartial(fcfaOf(context, due.confirmedTotal), fcfaOf(context, due.amount))}'
        : (due.late && due.status != DueStatus.late ? '${look.label} · ${l10n.dueLate}' : look.label);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 44,
              child: Column(
                children: [
                  if (dueDate != null) ...[
                    Text(
                      DateFormat.d(locale).format(dueDate),
                      style: context.mboaText.h2.copyWith(color: untracked ? colors.textTertiary : colors.primaryDark),
                    ),
                    Text(
                      DateFormat.MMM(locale).format(dueDate),
                      style: context.mboaText.caption.copyWith(color: untracked ? colors.textTertiary : colors.primaryDark),
                    ),
                  ],
                  if (!last) Expanded(child: CustomPaint(painter: _Dots(colors.primaryDark.withValues(alpha: 0.4)))),
                ],
              ),
            ),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: Dimens.spacing, top: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: look.tone.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(Dimens.radius),
                      ),
                      child: Icon(look.icon, size: Dimens.icon, color: look.tone),
                    ),
                    const SizedBox(width: Dimens.spacingMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (period != null)
                            Text(
                              period,
                              style: context.mboaText.label.copyWith(color: untracked ? colors.textTertiary : colors.ink),
                            ),
                          Text(status, style: context.mboaText.caption.copyWith(color: look.tone)),
                        ],
                      ),
                    ),
                    const SizedBox(width: Dimens.spacingSm),
                    Text(
                      fcfaOf(context, due.amount),
                      style: context.mboaText.label.copyWith(
                        color: switch (due.status) {
                          DueStatus.confirmed => colors.success,
                          DueStatus.late => colors.error,
                          DueStatus.untracked => colors.textTertiary,
                          _ => colors.ink,
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A declaration in a list: how it was paid, what for, how much, where it is.
class DeclarationRow extends StatelessWidget {
  const DeclarationRow({super.key, required this.declaration, this.onTap, this.subtitle});

  final Declaration declaration;
  final VoidCallback? onTap;

  /// Instead of the date paid — the landlord's inbox names the tenant.
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final d = declaration;
    final what = d.kind == DeclarationKind.deposit ? l10n.myHomeDeposit : l10n.declarationRentCount(d.dueIndexes.length);
    final paidOn = d.paidOn == null ? null : DateFormat.yMMMd(locale).format(d.paidOn!);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        child: Row(
          children: [
            MethodTile(method: d.method),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(what, style: context.mboaText.label.copyWith(color: colors.ink)),
                  Text(
                    [subtitle ?? paidOn, methodLabel(l10n, d.method), if (!d.hasProof) l10n.myHomeNoProof]
                        .nonNulls
                        .join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Dimens.spacingSm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(fcfaOf(context, d.amount), style: context.mboaText.label.copyWith(color: colors.ink)),
                const SizedBox(height: 2),
                DeclarationStatusChip(status: d.status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.icon, required this.tone, required this.text});

  final IconData icon;
  final Color tone;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(Dimens.spacingMd),
        decoration: BoxDecoration(color: tone.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(Dimens.radius)),
        child: Row(
          children: [
            Icon(icon, size: Dimens.iconSm, color: tone),
            const SizedBox(width: Dimens.spacingSm),
            Expanded(child: Text(text, style: context.mboaText.caption.copyWith(color: context.mboaColors.ink))),
          ],
        ),
      );
}

class _Dots extends CustomPainter {
  const _Dots(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;
    for (var y = 4.0; y < size.height; y += 6) {
      canvas.drawLine(Offset(size.width / 2, y), Offset(size.width / 2, y + 2.5), paint);
    }
  }

  @override
  bool shouldRepaint(_Dots old) => old.color != color;
}
