import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../data/subscription_repository.dart';
import '../../models/subscription_models.dart';

/// Payment receipts (RM-M13-07).
///
/// Reads the locally-remembered payments — see the note in
/// `SubscriptionRepository`: with no payments-list endpoint, `paymentId` is
/// only ever returned once, so this list is device-local and says so.
class ReceiptList extends StatelessWidget {
  const ReceiptList({super.key, this.repository});

  final SubscriptionRepository? repository;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final payments =
        (repository ?? getIt<SubscriptionRepository>()).knownPayments();

    if (payments.isEmpty) {
      return Text(
        l10n.subscriptionNoReceipts,
        style: context.mboaText.body.copyWith(color: colors.textSecondary),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final payment in payments)
          _ReceiptTile(payment: payment, repository: repository),
        const SizedBox(height: Dimens.spacingSm),
        Text(
          l10n.subscriptionReceiptsLocalHint,
          style: context.mboaText.micro.copyWith(color: colors.textTertiary),
        ),
      ],
    );
  }
}

class _ReceiptTile extends StatefulWidget {
  const _ReceiptTile({required this.payment, this.repository});

  final PaymentAttempt payment;
  final SubscriptionRepository? repository;

  @override
  State<_ReceiptTile> createState() => _ReceiptTileState();
}

class _ReceiptTileState extends State<_ReceiptTile> {
  bool _loading = false;

  Future<void> _open() async {
    setState(() => _loading = true);
    final l10n = I18n.of(context);
    try {
      final repository =
          widget.repository ?? getIt<SubscriptionRepository>();
      final url = await repository.receiptUrl(widget.payment.paymentId);
      if (!mounted) return;

      if (url == null || url.isEmpty) {
        MboaToast.error(context: context, title: l10n.commonErrorTitle);
        return;
      }
      // TODO(M13): open `url` once url_launcher is added. Surfacing it as a
      // toast keeps the flow honest rather than silently doing nothing.
      MboaToast.info(context: context, title: l10n.subscriptionReceiptOpen, description: url);
    } catch (_) {
      if (mounted) {
        MboaToast.error(context: context, title: l10n.commonErrorTitle);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final payment = widget.payment;
    final date = payment.initiatedAt;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(LucideIcons.receipt, color: colors.primary),
      title: Text(payment.tier.label, style: context.mboaText.label),
      subtitle: Text(
        [
          if (payment.amount != null) '${payment.amount} FCFA',
          if (date != null) DateFormat.yMMMd().format(date),
        ].join(' · '),
        style: context.mboaText.caption.copyWith(color: colors.textSecondary),
      ),
      trailing: _loading
          ? const SizedBox(
              width: Dimens.loaderSizeSm,
              height: Dimens.loaderSizeSm,
              child: Loader(),
            )
          : Icon(LucideIcons.externalLink, size: Dimens.icon, color: colors.primary),
      onTap: _loading ? null : _open,
    );
  }
}
