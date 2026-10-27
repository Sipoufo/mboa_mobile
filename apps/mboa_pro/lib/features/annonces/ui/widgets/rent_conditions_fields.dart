import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import 'form_text_field.dart';

/// §37 C — the advance and the deposit, in months of rent, side by side.
///
/// Declared, never collected: the tenant pays them to the landlord after the
/// contract (RM-M29-09), which the help says. Empty means « not said ».
class RentConditionsFields extends StatelessWidget {
  const RentConditionsFields({
    super.key,
    required this.advanceMonths,
    required this.depositMonths,
    required this.onAdvanceChanged,
    required this.onDepositChanged,
  });

  final int? advanceMonths;
  final int? depositMonths;

  /// Null when the field is emptied.
  final ValueChanged<int?> onAdvanceChanged;
  final ValueChanged<int?> onDepositChanged;

  /// The server's bound (`VALIDATION_ERROR` beyond it).
  static const int maxMonths = 24;

  /// What was typed, as a count of months: empty is null, more than [maxMonths]
  /// is [maxMonths].
  static int? parse(String value) {
    final months = int.tryParse(value.trim());
    if (months == null) return null;
    return months > maxMonths ? maxMonths : months;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final formatters = [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FormTextField(
            label: l10n.annonceFormFieldAdvance,
            helpText: l10n.annonceFormHelpConditions,
            suffixText: l10n.annonceFormMonths,
            keyboardType: TextInputType.number,
            inputFormatters: formatters,
            initialValue: advanceMonths?.toString() ?? '',
            onChanged: (value) => onAdvanceChanged(parse(value)),
          ),
        ),
        const SizedBox(width: Dimens.spacingMd),
        Expanded(
          child: FormTextField(
            label: l10n.annonceFormFieldDeposit,
            // The same help on both: each field explains itself, and the two
            // labels keep one height.
            helpText: l10n.annonceFormHelpConditions,
            suffixText: l10n.annonceFormMonths,
            keyboardType: TextInputType.number,
            inputFormatters: formatters,
            initialValue: depositMonths?.toString() ?? '',
            onChanged: (value) => onDepositChanged(parse(value)),
          ),
        ),
      ],
    );
  }
}
