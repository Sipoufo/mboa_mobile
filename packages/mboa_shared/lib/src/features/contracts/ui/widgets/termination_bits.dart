import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../bloc/contract_detail_bloc.dart';
import '../../models/contract.dart';

/// "Location" — where a signed contract's tenancy stands, and its latest
/// termination with what the reader may do about it (RM-M08-11, RM-M08-12).
///
/// Answering and withdrawing sit here, next to what they answer — not in the
/// action bar, which keeps one main action and "⋯" (the founder's call).
class TenancyCard extends StatelessWidget {
  const TenancyCard({super.key, required this.contract, required this.viewer, this.isBusy = false});

  final Contract contract;

  /// Which side the reader is on — words "Tu" or "L'autre partie".
  final ContractParty viewer;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final tenancy = contract.tenancy!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    String date(DateTime d) => DateFormat.yMMMMd(locale).format(d);

    final (stateLabel, tone) = switch (tenancy.state) {
      TenancyState.upcoming => (l10n.contractTenancyUpcoming, colors.info),
      TenancyState.running => (l10n.contractTenancyRunning, colors.success),
      TenancyState.ended || TenancyState.unknown => (l10n.contractTenancyEnded, colors.textSecondary),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 2),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(Dimens.radiusFull),
              ),
              child: Text(
                stateLabel,
                style: context.mboaText.caption.copyWith(color: tone, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: Dimens.spacingSm),
            Expanded(
              child: Text(
                switch (tenancy.endsOn) {
                  final end? => l10n.contractTenancyEndsOn(date(end)),
                  null => l10n.contractTenancyTacit,
                },
                style: context.mboaText.body.copyWith(color: colors.ink),
              ),
            ),
          ],
        ),
        if (tenancy.termination case final termination?) ...[
          const SizedBox(height: Dimens.spacing),
          _TerminationNote(termination: termination, viewer: viewer, isBusy: isBusy, date: date),
        ],
      ],
    );
  }
}

class _TerminationNote extends StatelessWidget {
  const _TerminationNote({required this.termination, required this.viewer, required this.isBusy, required this.date});

  final Termination termination;
  final ContractParty viewer;
  final bool isBusy;
  final String Function(DateTime) date;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final t = termination;
    final day = t.effectiveDate == null ? '—' : date(t.effectiveDate!);
    final mine = t.canWithdraw || (viewer != ContractParty.unknown && t.requestedBy == viewer);

    final (text, tone, icon) = switch (t.status) {
      TerminationStatus.proposed when mine => (l10n.contractTerminationProposedByYou(day), colors.warning, LucideIcons.hourglass),
      TerminationStatus.proposed => (l10n.contractTerminationProposedToYou(day), colors.warning, LucideIcons.circleHelp),
      TerminationStatus.notified when mine => (l10n.contractTerminationNotifiedByYou(day), colors.error, LucideIcons.calendarX),
      TerminationStatus.notified => (l10n.contractTerminationNotifiedToYou(day), colors.error, LucideIcons.calendarX),
      TerminationStatus.confirmed => (l10n.contractTerminationConfirmed(day), colors.error, LucideIcons.calendarX),
      TerminationStatus.declined => (l10n.contractTerminationDeclined, colors.textSecondary, LucideIcons.info),
      TerminationStatus.withdrawn || TerminationStatus.unknown =>
        (l10n.contractTerminationWithdrawn, colors.textSecondary, LucideIcons.info),
    };
    final reason = t.reason?.trim();
    final bloc = context.read<ContractDetailBloc>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: Dimens.icon, color: tone),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(child: Text(text, style: context.mboaText.body.copyWith(color: colors.ink))),
            ],
          ),
          if (reason != null && reason.isNotEmpty) ...[
            const SizedBox(height: Dimens.spacingSm),
            Text(
              l10n.contractTerminationReason(reason),
              style: context.mboaText.caption.copyWith(color: colors.textSecondary),
            ),
          ],
          if (t.canAnswer) ...[
            const SizedBox(height: Dimens.spacing),
            Row(
              children: [
                Expanded(
                  child: Button.outline(
                    title: l10n.contractTerminationDecline,
                    height: Dimens.buttonHeightSm,
                    onPressed: isBusy
                        ? null
                        : () async {
                            if (await _confirm(context, l10n.contractTerminationDeclineConfirm, l10n.contractTerminationDecline)) {
                              bloc.add(const ContractTerminationAnswered(confirm: false));
                            }
                          },
                  ),
                ),
                const SizedBox(width: Dimens.spacingSm),
                Expanded(
                  child: Button.primary(
                    title: l10n.contractTerminationAccept,
                    height: Dimens.buttonHeightSm,
                    onPressed: isBusy
                        ? null
                        : () async {
                            if (await _confirm(context, l10n.contractTerminationAcceptConfirm(day), l10n.contractTerminationAccept)) {
                              bloc.add(const ContractTerminationAnswered(confirm: true));
                            }
                          },
                  ),
                ),
              ],
            ),
          ],
          if (t.canWithdraw) ...[
            const SizedBox(height: Dimens.spacingSm),
            TextButton(
              onPressed: isBusy
                  ? null
                  : () async {
                      if (await _confirm(context, l10n.contractTerminationWithdrawConfirm, l10n.contractTerminationWithdraw)) {
                        bloc.add(const ContractTerminationWithdrawn());
                      }
                    },
              child: Text(l10n.contractTerminationWithdraw),
            ),
          ],
        ],
      ),
    );
  }
}

Future<bool> _confirm(BuildContext context, String body, String action) async =>
    await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        content: Text(body),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: Text(I18n.of(context).commonCancel)),
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: Text(action)),
        ],
      ),
    ) ??
    false;

/// What the termination sheet resolves to.
typedef TerminationDraft = ({DateTime lastDay, String reason, bool mutual});

/// RM-M08-11 — ending a signed contract: by agreement (proposed, answered,
/// withdrawable) or alone with notice (binding at once). The sheet only
/// gathers; the screen dispatches. Alone asks once more, since it is final.
Future<TerminationDraft?> showTerminationSheet(BuildContext context, {required Contract contract, DateTime? today}) =>
    showModalBottomSheet<TerminationDraft>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.mboaColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
      ),
      builder: (_) => TerminationSheet(contract: contract, today: today),
    );

/// Public so it can be pumped on its own.
class TerminationSheet extends StatefulWidget {
  const TerminationSheet({super.key, required this.contract, this.today});

  final Contract contract;

  /// Injected by tests; the clock otherwise.
  final DateTime? today;

  @override
  State<TerminationSheet> createState() => _TerminationSheetState();
}

/// Form state only: nothing is sent from here.
class _TerminationSheetState extends State<TerminationSheet> {
  bool _mutual = true;
  DateTime? _lastDay;
  final _reason = TextEditingController();

  DateTime get _today {
    final now = widget.today ?? DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Alone, no earlier than the notice allows; by agreement, from today.
  DateTime get _firstDay => _mutual ? _today : (widget.contract.tenancy?.earliestNoticeDate ?? _today);

  /// Never after the contract's own end (TERMINATION_AFTER_TERM).
  DateTime get _lastAllowed {
    final end = widget.contract.endDate;
    final cap = DateTime(_today.year + 5, _today.month, _today.day);
    return end == null || end.isAfter(cap) ? cap : end;
  }

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final first = _firstDay;
    final picked = await showDatePicker(
      context: context,
      initialDate: _lastDay != null && !_lastDay!.isBefore(first) ? _lastDay! : first,
      firstDate: first,
      lastDate: _lastAllowed.isBefore(first) ? first : _lastAllowed,
    );
    if (picked != null) setState(() => _lastDay = picked);
  }

  Future<void> _send() async {
    final l10n = I18n.of(context);
    final navigator = Navigator.of(context);
    if (!_mutual && !await _confirm(context, l10n.contractTerminationNotifyConfirm, l10n.contractTerminationNotify)) {
      return;
    }
    navigator.pop<TerminationDraft>((lastDay: _lastDay!, reason: _reason.text.trim(), mutual: _mutual));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final earliest = widget.contract.tenancy?.earliestNoticeDate ?? _today;
    // A day picked under one mode may not hold under the other.
    final lastDay = _lastDay != null && !_lastDay!.isBefore(_firstDay) ? _lastDay : null;
    final ready = lastDay != null && _reason.text.trim().isNotEmpty;

    Widget mode({required bool mutual, required String title, required String body}) {
      final selected = _mutual == mutual;
      return Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _mutual = mutual),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.all(Dimens.spacingMd),
            decoration: BoxDecoration(
              color: selected ? colors.primaryPale : colors.surface,
              borderRadius: BorderRadius.circular(Dimens.radiusMd),
              border: Border.all(color: selected ? colors.primary : colors.border, width: selected ? 1.5 : 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.mboaText.label.copyWith(color: selected ? colors.primary : colors.ink)),
                const SizedBox(height: Dimens.spacingXs),
                Text(body, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.contractTerminate, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
              const SizedBox(height: Dimens.spacing),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    mode(mutual: true, title: l10n.contractTerminationMutual, body: l10n.contractTerminationMutualBody),
                    const SizedBox(width: Dimens.spacingSm),
                    mode(
                      mutual: false,
                      title: l10n.contractTerminationAlone,
                      body: l10n.contractTerminationAloneBody(DateFormat.yMMMd(locale).format(earliest)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimens.spacing),
              InkWell(
                onTap: _pick,
                borderRadius: BorderRadius.circular(Dimens.radius),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
                  child: Row(
                    children: [
                      Icon(LucideIcons.calendarX, size: Dimens.icon, color: colors.primary),
                      const SizedBox(width: Dimens.spacingSm),
                      Expanded(
                        child: Text(
                          l10n.contractTerminationLastDay,
                          style: context.mboaText.body.copyWith(color: colors.textSecondary),
                        ),
                      ),
                      Text(
                        lastDay == null ? l10n.reservationPickDate : DateFormat.yMMMMd(locale).format(lastDay),
                        style: context.mboaText.label.copyWith(color: lastDay == null ? colors.primary : colors.ink),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Dimens.spacingSm),
              TextField(
                controller: _reason,
                maxLength: 500,
                minLines: 2,
                maxLines: 4,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  labelText: l10n.contractTerminationReasonLabel,
                  hintText: l10n.contractTerminationReasonHint,
                ),
              ),
              const SizedBox(height: Dimens.spacing),
              Button.primary(
                title: _mutual ? l10n.contractTerminationPropose : l10n.contractTerminationNotify,
                onPressed: ready ? _send : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
