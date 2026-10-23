import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../models/home.dart';

/// « ⋯ » in a home's app bar: the rare actions, in red, behind it (Doc05
/// §6.1) — « Signaler un litige » (RM-M30-07), for either party, during the
/// tenancy or after it.
class HomeMoreButton extends StatelessWidget {
  const HomeMoreButton({super.key, required this.onDispute});

  final VoidCallback onDispute;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return IconButton(
      tooltip: l10n.listingMoreActions,
      icon: Icon(LucideIcons.ellipsis, color: colors.primary),
      onPressed: () async {
        final dispute = await showModalBottomSheet<bool>(
          context: context,
          backgroundColor: colors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
          ),
          builder: (sheetContext) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
              child: ListTile(
                leading: Icon(LucideIcons.flag, color: colors.error),
                title: Text(l10n.disputeTitle, style: context.mboaText.label.copyWith(color: colors.error)),
                onTap: () => Navigator.of(sheetContext).pop(true),
              ),
            ),
          ),
        );
        if ((dispute ?? false) && context.mounted) onDispute();
      },
    );
  }
}

/// "150 000 FCFA", in the reader's locale.
String fcfaOf(BuildContext context, int amount) =>
    '${NumberFormat.decimalPattern(Localizations.localeOf(context).toLanguageTag()).format(amount)} '
    '${I18n.of(context).annonceFormCurrency}';

/// What a declaration is for, as a title says it: « Loyer · 2 échéances »,
/// « Caution », « Facture ».
String declarationWhat(I18n l10n, Declaration d) => switch (d.kind) {
      DeclarationKind.rent => l10n.declarationRentCount(d.dueIndexes.length),
      DeclarationKind.deposit => l10n.myHomeDeposit,
      DeclarationKind.invoice => l10n.declarationInvoice,
    };

/// A receipt's title, as its PDF says it (§29.5).
String receiptKindTitle(I18n l10n, ReceiptKind kind) => switch (kind) {
      ReceiptKind.rent => l10n.receiptKindRent,
      ReceiptKind.rentPartial => l10n.receiptKindRentPartial,
      ReceiptKind.deposit => l10n.receiptKindDeposit,
      ReceiptKind.invoice => l10n.receiptKindInvoice,
      ReceiptKind.unknown => l10n.receiptTitle,
    };

/// A receipt in a space: what, for which period (or when it was issued),
/// how much — or that it is still being made.
class ReceiptRow extends StatelessWidget {
  const ReceiptRow({super.key, required this.receipt, this.onTap});

  final HomeReceipt receipt;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    String day(DateTime d) => DateFormat.yMMMd(locale).format(d);
    final line = switch (receipt) {
      // Whatever its kind: « Quittance » would be wrong for a partial one.
      HomeReceipt(ready: false) => l10n.receiptRowPreparing,
      // The year once, at the end: « 23 sept. – 22 nov. 2026 ».
      HomeReceipt(:final periodStart?, :final periodEnd?) =>
        '${DateFormat.MMMd(locale).format(periodStart)} – ${day(periodEnd)}',
      HomeReceipt(:final issuedAt?) => l10n.receiptIssuedOn(day(issuedAt)),
      _ => null,
    };

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: colors.primaryPale, borderRadius: BorderRadius.circular(Dimens.radius)),
              child: Icon(LucideIcons.fileCheck2, size: Dimens.icon, color: colors.primary),
            ),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(receiptKindTitle(l10n, receipt.kind), style: context.mboaText.label.copyWith(color: colors.ink)),
                  if (line != null)
                    Text(
                      line,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                    ),
                ],
              ),
            ),
            const SizedBox(width: Dimens.spacingSm),
            Text(fcfaOf(context, receipt.amount), style: context.mboaText.label.copyWith(color: colors.ink)),
            if (onTap != null) Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
          ],
        ),
      ),
    );
  }
}

/// How an échéance reads, its icon and its tone.
({String label, IconData icon, Color tone}) dueLook(BuildContext context, DueStatus status) {
  final l10n = I18n.of(context);
  final colors = context.mboaColors;
  return switch (status) {
    DueStatus.confirmed => (label: l10n.dueConfirmed, icon: LucideIcons.circleCheck, tone: colors.success),
    DueStatus.declared => (label: l10n.dueDeclared, icon: LucideIcons.hourglass, tone: colors.warning),
    DueStatus.unconfirmed => (label: l10n.dueUnconfirmed, icon: LucideIcons.hourglass, tone: colors.warning),
    DueStatus.contested => (label: l10n.dueContested, icon: LucideIcons.circleX, tone: colors.error),
    DueStatus.late => (label: l10n.dueLate, icon: LucideIcons.triangleAlert, tone: colors.error),
    DueStatus.due => (label: l10n.dueDue, icon: LucideIcons.calendarClock, tone: colors.primary),
    DueStatus.upcoming => (label: l10n.dueUpcoming, icon: LucideIcons.calendar, tone: colors.textSecondary),
    DueStatus.untracked || DueStatus.unknown =>
      (label: l10n.dueUntracked, icon: LucideIcons.minus, tone: colors.textTertiary),
  };
}

/// A declaration's state, as a pill.
class DeclarationStatusChip extends StatelessWidget {
  const DeclarationStatusChip({super.key, required this.status});

  final DeclarationStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final (label, tone) = switch (status) {
      DeclarationStatus.declared => (l10n.declStatusDeclared, colors.warning),
      DeclarationStatus.unconfirmed => (l10n.declStatusUnconfirmed, colors.warning),
      DeclarationStatus.confirmed => (l10n.declStatusConfirmed, colors.success),
      DeclarationStatus.contested => (l10n.declStatusContested, colors.error),
      DeclarationStatus.unknown => (l10n.reservationStatusUnknown, colors.textSecondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 2),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(Dimens.radiusFull)),
      child: Text(label, style: context.mboaText.caption.copyWith(color: tone, fontWeight: FontWeight.w600)),
    );
  }
}

String methodLabel(I18n l10n, RentPaymentMethod method) => switch (method) {
      RentPaymentMethod.mobileMoney => l10n.methodMobileMoney,
      RentPaymentMethod.orangeMoney => l10n.methodOrangeMoney,
      RentPaymentMethod.cash => l10n.methodCash,
      RentPaymentMethod.transfer => l10n.methodTransfer,
      RentPaymentMethod.other => l10n.methodOther,
    };

/// The method's tile — the mockup's coloured squares (MTN yellow, Orange
/// orange), drawn rather than a brand's logo.
class MethodTile extends StatelessWidget {
  const MethodTile({super.key, required this.method, this.size = 44});

  final RentPaymentMethod method;
  final double size;

  static const _mtn = Color(0xFFFFCC00);
  static const _orange = Color(0xFFFF7900);

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final (background, foreground, icon) = switch (method) {
      RentPaymentMethod.mobileMoney => (_mtn, colors.ink, LucideIcons.smartphone),
      RentPaymentMethod.orangeMoney => (_orange, colors.onBrand, LucideIcons.smartphone),
      RentPaymentMethod.cash => (colors.primaryPale, colors.primary, LucideIcons.banknote),
      RentPaymentMethod.transfer => (colors.primaryPale, colors.primary, LucideIcons.landmark),
      RentPaymentMethod.other => (colors.surfaceWarm, colors.textSecondary, LucideIcons.wallet),
    };

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(Dimens.radius)),
      child: Icon(icon, color: foreground, size: size * 0.5),
    );
  }
}
