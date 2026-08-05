import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../models/subscription_models.dart';

/// Asks which Mobile Money provider to charge. Returns null if dismissed.
Future<PaymentMethod?> showPaymentMethodSheet(BuildContext context) {
  return showModalBottomSheet<PaymentMethod>(
    context: context,
    showDragHandle: true,
    builder: (context) {
      final l10n = I18n.of(context);
      final colors = context.mboaColors;

      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing),
              child: Text(
                l10n.paymentMethodTitle,
                style: context.mboaText.h3,
              ),
            ),
            const SizedBox(height: Dimens.spacingSm),
            ListTile(
              leading: Icon(LucideIcons.smartphone, color: colors.primary),
              title: Text(l10n.paymentMethodMtn),
              onTap: () => Navigator.of(context).pop(PaymentMethod.mtnMomo),
            ),
            ListTile(
              leading: Icon(LucideIcons.smartphone, color: colors.action),
              title: Text(l10n.paymentMethodOrange),
              onTap: () =>
                  Navigator.of(context).pop(PaymentMethod.orangeMoney),
            ),
            const SizedBox(height: Dimens.spacing),
          ],
        ),
      );
    },
  );
}
