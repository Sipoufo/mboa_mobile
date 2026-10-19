import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// "660 000 FCFA", in the reader's locale.
String fcfa(BuildContext context, int amount) =>
    '${NumberFormat.decimalPattern(Localizations.localeOf(context).toLanguageTag()).format(amount)} '
    '${I18n.of(context).annonceFormCurrency}';

/// RM-M29-09, said where money could be expected: nothing is paid through
/// Mboa, and nothing before the contract is signed.
class NoMoneyNotice extends StatelessWidget {
  const NoMoneyNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Dimens.radius),
        border: Border.all(color: colors.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LucideIcons.shieldAlert, size: Dimens.iconSm, color: colors.warning),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Text(
              I18n.of(context).reservationNoMoney,
              style: context.mboaText.caption.copyWith(color: colors.ink),
            ),
          ),
        ],
      ),
    );
  }
}
