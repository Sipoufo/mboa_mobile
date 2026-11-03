import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../location/data/location_repository.dart';
import '../../location/ui/city_picker_sheet.dart';
import '../../location/ui/option_picker_sheet.dart';

import '../models/document_identity.dart';
import '../models/kyc_draft.dart';
import '../models/kyc_status.dart';
import 'document_identity_fields.dart';

/// RM-M01bis-10 — the NUI, typed as printed. Answers the text (empty to
/// remove it from a draft), or null when dismissed.
///
/// [isAddition]: an approved KYC receiving it — no new review, and no going
/// back once sent, which the sheet says.
Future<String?> showNuiSheet(
  BuildContext context, {
  String? initial,
  bool required = false,
  bool isAddition = false,
}) =>
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.mboaColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl))),
      builder: (_) => NuiSheet(initial: initial, required: required, isAddition: isAddition),
    );

/// Public so it can be pumped on its own.
class NuiSheet extends StatefulWidget {
  const NuiSheet({super.key, this.initial, this.required = false, this.isAddition = false});

  final String? initial;
  final bool required;
  final bool isAddition;

  @override
  State<NuiSheet> createState() => _NuiSheetState();
}

class _NuiSheetState extends State<NuiSheet> {
  late final _field = TextEditingController(text: widget.initial ?? '');

  @override
  void dispose() {
    _field.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final nui = KycDraft.normalizeNui(_field.text);
    final malformed = nui != null && !KycDraft.isValidNui(nui);
    // Empty may be saved (it removes the NUI) unless one is owed, or being added.
    final canSave = nui == null ? !(widget.required || widget.isAddition) : !malformed;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.kycNuiTitle, style: context.mboaText.h3.copyWith(color: colors.ink)),
              const SizedBox(height: Dimens.spacingSm),
              Text(
                widget.isAddition ? l10n.kycNuiAddBody : l10n.kycNuiBody,
                style: context.mboaText.body.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: Dimens.spacingLg),
              TextField(
                controller: _field,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  labelText: l10n.kycItemNui,
                  hintText: 'M0123 4567 8901X',
                  errorText: malformed ? l10n.kycNuiInvalid : null,
                ),
              ),
              const SizedBox(height: Dimens.spacingLg),
              Button.primary(
                title: widget.isAddition ? l10n.kycAddNui : l10n.commonSave,
                onPressed: canSave ? () => Navigator.of(context).pop(_field.text) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// What the address sheet answers: an address, or « remove it ».
typedef AddressChoice = ({DeclaredAddress? address});

/// RM-M01bis-11 — the district from the catalogue and a landmark. Answers
/// the choice, or null when dismissed.
Future<AddressChoice?> showAddressSheet(BuildContext context, {DeclaredAddress? initial}) =>
    showModalBottomSheet<AddressChoice>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.mboaColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl))),
      builder: (_) => AddressSheet(initial: initial),
    );

/// Public so it can be pumped on its own.
class AddressSheet extends StatefulWidget {
  const AddressSheet({super.key, this.initial});

  final DeclaredAddress? initial;

  @override
  State<AddressSheet> createState() => _AddressSheetState();
}

class _AddressSheetState extends State<AddressSheet> {
  late DeclaredAddress? _place = widget.initial;
  late final _details = TextEditingController(text: widget.initial?.details ?? '');

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  /// The city, then one of its districts — the catalogue's, as for a listing.
  Future<void> _pickDistrict() async {
    final l10n = I18n.of(context);
    final locations = getIt<LocationRepository>();
    final city = await showCityPicker(context, repository: locations);
    if (city == null || !mounted) return;
    final districts = await locations.districts(city.id);
    if (!mounted) return;
    if (districts.isEmpty) {
      MboaToast.warning(context: context, title: l10n.annonceFormNoDistricts);
      return;
    }
    final district = await showOptionPicker(context, title: l10n.annonceFormPickDistrict, options: districts);
    if (district == null || !mounted) return;
    setState(() => _place = DeclaredAddress(districtId: district.id, city: city.name, district: district.name));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final place = _place;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.kycAddressTitle, style: context.mboaText.h3.copyWith(color: colors.ink)),
              const SizedBox(height: Dimens.spacingSm),
              Text(l10n.kycAddressBody, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
              const SizedBox(height: Dimens.spacingLg),
              OutlinedButton.icon(
                onPressed: _pickDistrict,
                icon: const Icon(LucideIcons.mapPin, size: Dimens.iconSm),
                label: Text(place?.label ?? l10n.annonceFormPickDistrict),
              ),
              const SizedBox(height: Dimens.spacing),
              TextField(
                controller: _details,
                maxLength: DeclaredAddress.maxDetails,
                decoration: InputDecoration(labelText: l10n.kycAddressDetails),
              ),
              const SizedBox(height: Dimens.spacing),
              Button.primary(
                title: l10n.commonSave,
                onPressed: place == null
                    ? null
                    : () => Navigator.of(context).pop((
                          address: DeclaredAddress(
                            districtId: place.districtId,
                            city: place.city,
                            district: place.district,
                            details: _details.text.trim().isEmpty ? null : _details.text.trim(),
                          ),
                        )),
              ),
              if (widget.initial != null)
                TextButton(
                  onPressed: () => Navigator.of(context).pop((address: null)),
                  child: Text(l10n.kycAddressRemove, style: TextStyle(color: colors.error)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// §40 F — the document's details, for a KYC approved before §39 B asked for
/// them: typed once, they fill every contract after. Null if dismissed.
Future<DocumentIdentity?> showDocumentSheet(
  BuildContext context, {
  List<KycDocType> types = KycDocType.values,
  DocumentIdentity? initial,
}) =>
    showModalBottomSheet<DocumentIdentity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.mboaColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl))),
      builder: (_) => DocumentSheet(types: types, initial: initial),
    );

/// Public so it can be pumped on its own.
class DocumentSheet extends StatefulWidget {
  const DocumentSheet({super.key, this.types = KycDocType.values, this.initial, this.today});

  final List<KycDocType> types;
  final DocumentIdentity? initial;

  /// Injected by tests; the clock otherwise.
  final DateTime? today;

  @override
  State<DocumentSheet> createState() => _DocumentSheetState();
}

class _DocumentSheetState extends State<DocumentSheet> {
  late DocumentIdentity _identity = widget.initial ?? DocumentIdentity(type: widget.types.firstOrNull);

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final ready = _identity.isValidOn(widget.today ?? DateTime.now());

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.kycDocumentSheetTitle, style: context.mboaText.h3.copyWith(color: colors.ink)),
              const SizedBox(height: Dimens.spacingXs),
              Text(l10n.kycDocumentSheetBody, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
              const SizedBox(height: Dimens.spacing),
              DocumentIdentityFields(
                value: _identity,
                types: widget.types,
                today: widget.today,
                onChanged: (identity) => setState(() => _identity = identity),
              ),
              const SizedBox(height: Dimens.spacingLg),
              Button.primary(
                title: l10n.commonSave,
                onPressed: ready ? () => Navigator.of(context).pop(_identity) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
