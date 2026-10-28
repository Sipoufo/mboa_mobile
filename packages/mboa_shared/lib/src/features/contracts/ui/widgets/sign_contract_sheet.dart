import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../kyc/models/document_identity.dart';
import '../../../listings/models/rental_period.dart';
import '../../../kyc/ui/document_identity_fields.dart';
import '../../models/contract.dart';
import 'contract_bits.dart';


/// The signature gesture (RM-M08-03).
///
/// `SignContractRequest` carries only a session id, so the confirmation Doc 10
/// asks for — PIN or biometrics — is **entirely local**. Typing the word is the
/// version that needs no sensor, works on every phone, and cannot be done by a
/// distracted tap: signing a bail locks it for good and no one, not even an
/// admin, can change it afterwards.
/// What the sheet answers once confirmed: the identity typed, when the signer
/// had to (§39 D), or none.
typedef SignConfirmation = ({DocumentIdentity? identity});

Future<SignConfirmation?> showSignContractSheet(
  BuildContext context, {
  required Contract contract,
  List<KycDocType> identityTypes = KycDocType.values,
  DocumentIdentity? identityPrefill,
}) {
  final colors = context.mboaColors;

  return showModalBottomSheet<SignConfirmation>(
    context: context,
    backgroundColor: colors.surface,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusLg)),
    ),
    builder: (_) => SignContractSheet(contract: contract, identityTypes: identityTypes, identityPrefill: identityPrefill),
  );
}

/// Public so it can be pumped on its own.
class SignContractSheet extends StatefulWidget {
  const SignContractSheet({
    super.key,
    required this.contract,
    this.identityTypes = KycDocType.values,
    this.identityPrefill,
    this.today,
  });

  final Contract contract;

  /// What the signer may sign with, when they type it (§39 D).
  final List<KycDocType> identityTypes;

  /// What the app already knows of the signer's document, to start from.
  final DocumentIdentity? identityPrefill;

  /// Injected by tests; the clock otherwise.
  final DateTime? today;

  @override
  State<SignContractSheet> createState() => _SignContractSheetState();
}

class _SignContractSheetState extends State<SignContractSheet> {
  final _controller = TextEditingController();
  bool _matches = false;

  /// §39 D — typed only when the signer has no verified identity. The first
  /// type offered is chosen to start with (the CNI, most often).
  late DocumentIdentity _identity = widget.identityPrefill ?? DocumentIdentity(type: widget.identityTypes.firstOrNull);

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
    final needsIdentity = contract.identityRequired;
    final identityReady = !needsIdentity || _identity.isValidOn(widget.today ?? DateTime.now());

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimens.spacingLg,
          right: Dimens.spacingLg,
          bottom: MediaQuery.viewInsetsOf(context).bottom + Dimens.spacingLg,
        ),
        child: SingleChildScrollView(
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
                value: moneyLabel(l10n, deposit),
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
            // §39 D — no verified identity: the document goes with the
            // signature, and the contract says it was declared.
            if (needsIdentity) ...[
              const SizedBox(height: Dimens.spacing),
              Text(l10n.contractSignIdentityTitle, style: context.mboaText.label.copyWith(color: colors.primaryDark)),
              const SizedBox(height: Dimens.spacingXs),
              Text(l10n.contractSignIdentityBody, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
              const SizedBox(height: Dimens.spacingSm),
              DocumentIdentityFields(
                value: _identity,
                types: widget.identityTypes,
                today: widget.today,
                onChanged: (identity) => setState(() => _identity = identity),
              ),
            ],
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
              onPressed: _matches && identityReady
                  ? () => Navigator.of(context).pop((identity: needsIdentity ? _identity : null))
                  : null,
            ),
            const SizedBox(height: Dimens.spacingSm),
          ],
        ),
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
