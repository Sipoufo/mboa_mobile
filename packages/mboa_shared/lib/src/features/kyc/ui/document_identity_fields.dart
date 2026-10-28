import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../models/document_identity.dart';

/// The name a document type goes by.
String kycDocTypeLabel(I18n l10n, KycDocType type) => switch (type) {
      KycDocType.cni => l10n.kycDocCni,
      KycDocType.passport => l10n.kycDocPassport,
      KycDocType.drivingLicence => l10n.kycDocDrivingLicence,
    };

/// What is printed on an identity document (§39): its number, when and where
/// it was issued, until when it is valid — in the KYC, and at signing for
/// whoever has no verified identity.
///
/// [types]: the type is chosen here too (at signing); null when it was chosen
/// before (the KYC's own step).
class DocumentIdentityFields extends StatefulWidget {
  const DocumentIdentityFields({
    super.key,
    required this.value,
    required this.onChanged,
    this.types,
    this.today,
  });

  final DocumentIdentity value;
  final ValueChanged<DocumentIdentity> onChanged;
  final List<KycDocType>? types;

  /// Injected by tests; the clock otherwise.
  final DateTime? today;

  @override
  State<DocumentIdentityFields> createState() => _DocumentIdentityFieldsState();
}

class _DocumentIdentityFieldsState extends State<DocumentIdentityFields> {
  late final _number = TextEditingController(text: widget.value.number);
  late final _place = TextEditingController(text: widget.value.issuedAt);

  @override
  void dispose() {
    _number.dispose();
    _place.dispose();
    super.dispose();
  }

  DateTime get _today => widget.today ?? DateTime.now();

  Future<DateTime?> _pick({DateTime? initial, required DateTime first, required DateTime last}) => showDatePicker(
        context: context,
        initialDate: initial ?? (_today.isBefore(last) ? _today : last),
        firstDate: first,
        lastDate: last,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final value = widget.value;
    final types = widget.types;
    final locale = Localizations.localeOf(context).toLanguageTag();
    // Said once both dates are there: an empty field is not yet a mistake.
    final problem = value.problemOn(_today);

    Widget dateField(String label, DateTime? date, VoidCallback onTap, {String? error}) => InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Dimens.radius),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              errorText: error,
              suffixIcon: Icon(LucideIcons.calendar, size: Dimens.iconSm, color: colors.primary),
            ),
            child: Text(
              date == null ? '' : DateFormat.yMMMd(locale).format(date),
              style: context.mboaText.body.copyWith(color: colors.ink),
            ),
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (types != null) ...[
          Wrap(
            spacing: Dimens.spacingSm,
            runSpacing: Dimens.spacingSm,
            children: [
              for (final type in types)
                ChoiceChip(
                  label: Text(kycDocTypeLabel(l10n, type)),
                  selected: value.type == type,
                  onSelected: (_) => widget.onChanged(value.copyWith(type: type)),
                ),
            ],
          ),
          const SizedBox(height: Dimens.spacing),
        ],
        TextField(
          controller: _number,
          maxLength: DocumentIdentity.maxNumber,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(labelText: l10n.kycIdNumber, counterText: ''),
          onChanged: (number) => widget.onChanged(value.copyWith(number: number)),
        ),
        const SizedBox(height: Dimens.spacing),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: dateField(
                l10n.kycIssuedOn,
                value.issuedOn,
                () async {
                  final date = await _pick(initial: value.issuedOn, first: DateTime(1960), last: _today);
                  if (date != null) widget.onChanged(value.copyWith(issuedOn: date));
                },
                error: problem == DocumentIdentityProblem.issuedInFuture ? l10n.kycIssuedInFuture : null,
              ),
            ),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: dateField(
                l10n.kycExpiresOn,
                value.expiresOn,
                () async {
                  final date = await _pick(initial: value.expiresOn, first: DateTime(1990), last: DateTime(_today.year + 30));
                  if (date != null) widget.onChanged(value.copyWith(expiresOn: date));
                },
                error: problem == DocumentIdentityProblem.expired ? l10n.kycDocumentExpired : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.spacing),
        TextField(
          controller: _place,
          maxLength: DocumentIdentity.maxPlace,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(labelText: l10n.kycIssuedAt, counterText: ''),
          onChanged: (place) => widget.onChanged(value.copyWith(issuedAt: place)),
        ),
      ],
    );
  }
}
