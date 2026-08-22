import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The contract's status, in one word and one colour.
class ContractStatusChip extends StatelessWidget {
  const ContractStatusChip({super.key, required this.status});

  final ContractStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final (label, color) = switch (status) {
      ContractStatus.draft => (l10n.contractStatusDraft, colors.textSecondary),
      ContractStatus.sent => (l10n.contractStatusSent, colors.primary),
      ContractStatus.changesRequested => (
          l10n.contractStatusChangesRequested,
          colors.warning,
        ),
      ContractStatus.accepted => (l10n.contractStatusAccepted, colors.info),
      ContractStatus.signed => (l10n.contractStatusSigned, colors.success),
      ContractStatus.cancelled => (l10n.contractStatusCancelled, colors.error),
      ContractStatus.unknown => ('', colors.textTertiary),
    };

    if (label.isEmpty) return const SizedBox.shrink();

    return Chip(
      label: Text(label),
      labelStyle: context.mboaText.caption.copyWith(color: color),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }
}

/// RM-M08-09 — whose move it is, said in words rather than left to be worked
/// out from the status.
class AwaitingLine extends StatelessWidget {
  const AwaitingLine({super.key, required this.awaiting});

  final ContractParty awaiting;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final (label, color) = switch (awaiting) {
      ContractParty.prestataire => (l10n.contractAwaitingYou, colors.warning),
      ContractParty.tenant => (l10n.contractAwaitingTenant, colors.primary),
      ContractParty.both => (l10n.contractAwaitingBoth, colors.primary),
      ContractParty.nobody => (l10n.contractAwaitingNobody, colors.textTertiary),
      ContractParty.unknown => ('', colors.textTertiary),
    };

    if (label.isEmpty) return const SizedBox.shrink();

    return Row(
      children: [
        // A drawn dot rather than an icon: it needs no font, which is one
        // less thing to load wrong.
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: Dimens.spacingSm),
        Expanded(
          child: Text(
            label,
            style: context.mboaText.caption.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}

/// "12 mois", in the contract's own periodicity (RM-M08-08).
String durationLabel(I18n l10n, int units, RentalPeriod period) =>
    l10n.contractDurationValue(units, period.label(l10n).toLowerCase());

String moneyLabel(int amount) =>
    '${NumberFormat.decimalPattern().format(amount)} XAF';
