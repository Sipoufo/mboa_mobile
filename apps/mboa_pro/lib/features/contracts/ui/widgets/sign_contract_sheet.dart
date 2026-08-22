import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import 'contract_bits.dart';

/// The signature gesture (RM-M08-03).
///
/// `SignContractRequest` carries only a session id, so the confirmation Doc 10
/// asks for — PIN or biometrics — is **entirely local**. Typing the word is the
/// version that needs no sensor, works on every phone, and cannot be done by a
/// distracted tap: signing a bail locks it for good and no one, not even an
/// admin, can change it afterwards.
Future<bool?> showSignContractSheet(
  BuildContext context, {
  required Contract contract,
}) {
  final colors = context.mboaColors;

  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: colors.surface,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusLg)),
    ),
    builder: (_) => _SignSheet(contract: contract),
  );
}

class _SignSheet extends StatefulWidget {
  const _SignSheet({required this.contract});

  final Contract contract;

  @override
  State<_SignSheet> createState() => _SignSheetState();
}

class _SignSheetState extends State<_SignSheet> {
  final _controller = TextEditingController();
  bool _matches = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final contract = widget.contract;
    final word = l10n.contractSignWord;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimens.spacingLg,
          right: Dimens.spacingLg,
          bottom: MediaQuery.viewInsetsOf(context).bottom + Dimens.spacingLg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.contractSign, style: context.mboaText.h3),
            const SizedBox(height: Dimens.spacingSm),
            // The terms, one last time: what is being locked, in figures.
            if (contract.price case final price?)
              _Line(
                label: l10n.contractTermPrice,
                value: contract.rentalPeriod.priceLabel(l10n, price),
              ),
            if (contract.depositAmount case final deposit?)
              _Line(
                label: l10n.contractTermDeposit,
                value: moneyLabel(deposit),
              ),
            if (contract.startDate case final start?)
              _Line(
                label: l10n.contractTermStart,
                value: DateFormat.yMMMMd().format(start),
              ),
            if (contract.durationUnits case final units?)
              _Line(
                label: l10n.contractTermDuration,
                value: durationLabel(l10n, units, contract.rentalPeriod),
              ),
            const SizedBox(height: Dimens.spacing),
            Text(
              l10n.contractSignWarning,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: Dimens.spacing),
            Input(
              controller: _controller,
              labelText: l10n.contractSignPrompt(word),
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) => setState(
                () => _matches = value.trim().toUpperCase() == word,
              ),
            ),
            const SizedBox(height: Dimens.spacing),
            Button.primary(
              title: l10n.contractSign,
              onPressed: _matches
                  ? () => Navigator.of(context).pop(true)
                  : null,
            ),
            const SizedBox(height: Dimens.spacingSm),
          ],
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: Dimens.spacingXs),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: context.mboaText.body
                    .copyWith(color: context.mboaColors.textSecondary),
              ),
            ),
            Text(
              value,
              style: context.mboaText.label
                  .copyWith(color: context.mboaColors.ink),
            ),
          ],
        ),
      );
}
