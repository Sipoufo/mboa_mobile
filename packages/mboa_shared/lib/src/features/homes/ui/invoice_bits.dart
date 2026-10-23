import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../models/home.dart';
import 'home_bits.dart';

/// An invoice's kind, as a word and an icon.
({String label, IconData icon}) invoiceKindLook(I18n l10n, InvoiceKind kind) => switch (kind) {
      InvoiceKind.water => (label: l10n.invoiceKindWater, icon: LucideIcons.droplet),
      InvoiceKind.electricity => (label: l10n.invoiceKindElectricity, icon: LucideIcons.zap),
      InvoiceKind.other => (label: l10n.invoiceKindOther, icon: LucideIcons.receiptText),
    };

/// Where an invoice stands — the server's word.
class InvoiceStatusChip extends StatelessWidget {
  const InvoiceStatusChip({super.key, required this.status, this.pastDue = false});

  final InvoiceStatus status;

  /// Past its date, within the 5 days before « En retard » (RM-M24-07).
  final bool pastDue;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final (label, tone) = switch (status) {
      InvoiceStatus.toPay when pastDue => (l10n.ownerInvoicePastDue, colors.warning),
      InvoiceStatus.toPay => (l10n.invoiceStatusToPay, colors.primary),
      InvoiceStatus.overdue => (l10n.invoiceStatusOverdue, colors.error),
      InvoiceStatus.paid => (l10n.invoiceStatusPaid, colors.success),
      InvoiceStatus.cancelled => (l10n.invoiceStatusCancelled, colors.textTertiary),
      InvoiceStatus.unknown => (l10n.reservationStatusUnknown, colors.textSecondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 2),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(Dimens.radiusFull)),
      child: Text(label, style: context.mboaText.caption.copyWith(color: tone, fontWeight: FontWeight.w600)),
    );
  }
}

/// The kind's tile — pale green, like the échéances'.
class InvoiceKindTile extends StatelessWidget {
  const InvoiceKindTile({super.key, required this.kind, this.size = 40});

  final InvoiceKind kind;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: colors.primaryPale, borderRadius: BorderRadius.circular(Dimens.radius)),
      child: Icon(invoiceKindLook(I18n.of(context), kind).icon, size: size * 0.5, color: colors.primary),
    );
  }
}

/// An invoice in a list: what, until when, how much, where it stands — and,
/// in the landlord's list across properties ([showPlace]), for which.
class InvoiceRow extends StatelessWidget {
  const InvoiceRow({super.key, required this.invoice, required this.onTap, this.showPlace = false});

  final HomeInvoice invoice;
  final VoidCallback onTap;
  final bool showPlace;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final kind = invoiceKindLook(l10n, invoice.kind);
    final day = switch (invoice) {
      HomeInvoice(status: InvoiceStatus.paid, :final paidAt?) => l10n.invoicePaidOn(DateFormat.yMMMd(locale).format(paidAt)),
      HomeInvoice(:final dueDate?) when invoice.status.isOpen => l10n.invoiceDueOn(DateFormat.yMMMd(locale).format(dueDate)),
      _ => null,
    };

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        child: Row(
          children: [
            InvoiceKindTile(kind: invoice.kind),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice.label ?? kind.label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.label.copyWith(color: colors.ink),
                  ),
                  if (showPlace && invoice.annonceTitle != null)
                    Text(
                      invoice.annonceTitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                    ),
                  if (day != null)
                    Text(day, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                ],
              ),
            ),
            const SizedBox(width: Dimens.spacingSm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(fcfaOf(context, invoice.amount), style: context.mboaText.label.copyWith(color: colors.ink)),
                const SizedBox(height: 2),
                InvoiceStatusChip(status: invoice.status, pastDue: invoice.pastDue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
