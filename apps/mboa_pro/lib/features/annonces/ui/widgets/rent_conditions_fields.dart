import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import 'form_text_field.dart';

/// §37 C — the advance and the deposit, side by side, counted in the
/// listing's own [period] (§40 G: « 2 semaines » on a weekly listing, where
/// they used to be months whatever the period).
///
/// Declared, never collected: the tenant pays them to the landlord after the
/// contract (RM-M29-09), which the help says. Empty means « not said ».
class RentConditionsFields extends StatelessWidget {
  const RentConditionsFields({
    super.key,
    required this.advancePeriods,
    required this.depositPeriods,
    required this.period,
    required this.onAdvanceChanged,
    required this.onDepositChanged,
  });

  final int? advancePeriods;
  final int? depositPeriods;

  /// The listing's: the unit beside each count follows it.
  final RentalPeriod period;

  /// Null when the field is emptied.
  final ValueChanged<int?> onAdvanceChanged;
  final ValueChanged<int?> onDepositChanged;

  /// The server's bound (`VALIDATION_ERROR` beyond it), whatever the period.
  static const int maxPeriods = 24;

  /// What was typed, as a count of periods: empty is null, more than
  /// [maxPeriods] is [maxPeriods].
  static int? parse(String value) {
    final count = int.tryParse(value.trim());
    if (count == null) return null;
    return count > maxPeriods ? maxPeriods : count;
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
            // Agreed with what is typed; plural while empty.
            suffixText: period.unitLabel(l10n, advancePeriods ?? 2),
            keyboardType: TextInputType.number,
            inputFormatters: formatters,
            initialValue: advancePeriods?.toString() ?? '',
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
            suffixText: period.unitLabel(l10n, depositPeriods ?? 2),
            keyboardType: TextInputType.number,
            inputFormatters: formatters,
            initialValue: depositPeriods?.toString() ?? '',
            onChanged: (value) => onDepositChanged(parse(value)),
          ),
        ),
      ],
    );
  }
}
