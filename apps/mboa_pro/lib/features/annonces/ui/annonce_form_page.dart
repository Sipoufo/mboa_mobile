import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/annonce_form_bloc.dart';
import '../data/location_capture.dart';
import '../models/annonce.dart';
import '../models/annonce_draft.dart';
import 'widgets/form_text_field.dart';
import 'widgets/photo_strip.dart';
import 'widgets/unit_group_editor.dart';

/// Creation and editing for both listing kinds (CDC M10).
///
/// "Enregistrer" saves a **draft** — publishing is a separate action from the
/// list, because the tier limit and the 3-photo rule only bite on publish.
@RoutePage()
class AnnonceFormPage extends StatelessWidget implements AutoRouteWrapper {
  const AnnonceFormPage({super.key, required this.kind, this.annonceId});

  final AnnonceKind kind;

  /// Set when editing.
  final String? annonceId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<AnnonceFormBloc>(
        create: (_) =>
            getIt<AnnonceFormBloc>()..add(AnnonceFormStarted(kind: kind)),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocConsumer<AnnonceFormBloc, AnnonceFormState>(
      listenWhen: (prev, curr) =>
          curr is AnnonceFormSaved ||
          (curr is AnnonceFormEditing && curr.error != null),
      listener: (context, state) {
        switch (state) {
          case AnnonceFormSaved():
            MboaToast.success(
              context: context,
              title: l10n.annonceFormSavedDraft,
            );
            context.router.maybePop();
          case AnnonceFormEditing(:final error?):
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: switch (error) {
                AnnonceFormError.photoUpload => l10n.annonceFormErrorPhoto,
                AnnonceFormError.incomplete => l10n.annonceFormErrorIncomplete,
                AnnonceFormError.save => l10n.annonceFormErrorSave,
              },
            );
          default:
            break;
        }
      },
      builder: (context, state) {
        final editing = switch (state) {
          AnnonceFormEditing() => state,
          AnnonceFormSubmitting(:final draft) => AnnonceFormEditing(draft),
          _ => null,
        };

        return Scaffold(
          backgroundColor: context.mboaColors.surfaceWarm,
          appBar: AppBar(
            title: Text(
              annonceId == null
                  ? l10n.annonceFormTitleNew
                  : l10n.annonceFormTitleEdit,
            ),
          ),
          body: editing == null
              ? const Center(child: Loader())
              : _Form(state: editing),
          bottomNavigationBar: editing == null
              ? null
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.spacing),
                    child: Button.primary(
                      title: l10n.annonceFormSave,
                      isLoading: state is AnnonceFormSubmitting,
                      onPressed: editing.canSubmit
                          ? () => context
                              .read<AnnonceFormBloc>()
                              .add(const AnnonceFormSubmitted())
                          : null,
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({required this.state});

  final AnnonceFormEditing state;

  AnnonceDraft get draft => state.draft;

  void _change(
    BuildContext context,
    AnnonceDraft Function(AnnonceDraft) apply,
  ) =>
      context.read<AnnonceFormBloc>().add(AnnonceFormChanged(apply));

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final isResidence = draft.kind == AnnonceKind.residence;

    return ListView(
      padding: const EdgeInsets.all(Dimens.spacing),
      children: [
        // The kind is fixed once a listing exists — the two are different
        // resources on the backend, so switching would mean re-creating.
        if (!draft.isEditing)
          MboaSegmentedControl<AnnonceKind>(
            value: draft.kind,
            segments: [
              MboaSegment(
                value: AnnonceKind.single,
                label: l10n.annonceFormKindSingle,
              ),
              MboaSegment(
                value: AnnonceKind.residence,
                label: l10n.annonceFormKindMultiple,
              ),
            ],
            onChanged: (kind) => context
                .read<AnnonceFormBloc>()
                .add(AnnonceFormStarted(kind: kind)),
          ),
        const SizedBox(height: Dimens.spacing),
        PhotoStrip(
          photoKeys: draft.photoKeys,
          isUploading: state.uploadingPhoto,
          onAdd: () => _addPhoto(context),
          onRemove: (key) => context
              .read<AnnonceFormBloc>()
              .add(AnnonceFormPhotoRemoved(key)),
        ),
        const SizedBox(height: Dimens.spacingLg),
        FormTextField(
          label: isResidence
              ? l10n.annonceFormFieldName
              : l10n.annonceFormFieldType,
          initialValue: draft.title,
          onChanged: (value) => _change(context, (d) => d.copyWith(title: value)),
        ),
        if (!isResidence) ...[
          const SizedBox(height: Dimens.spacing),
          _PropertyTypeField(
            value: draft.propertyType,
            onChanged: (type) =>
                _change(context, (d) => d.copyWith(propertyType: type)),
          ),
          const SizedBox(height: Dimens.spacing),
          FormTextField(
            label: '${l10n.annonceFormFieldPrice} (XAF)',
            keyboardType: TextInputType.number,
            initialValue: draft.monthlyRent?.toString() ?? '',
            onChanged: (value) => _change(
              context,
              (d) => d.copyWith(monthlyRent: int.tryParse(value)),
            ),
          ),
        ],
        const SizedBox(height: Dimens.spacing),
        Row(
          children: [
            Expanded(
              child: FormTextField(
                label: l10n.annonceFormFieldSurface,
                keyboardType: TextInputType.number,
                initialValue: draft.surfaceArea?.toString() ?? '',
                onChanged: (value) => _change(
                  context,
                  (d) => d.copyWith(surfaceArea: int.tryParse(value)),
                ),
              ),
            ),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: FormTextField(
                label: l10n.annonceFormFieldRooms,
                keyboardType: TextInputType.number,
                initialValue: draft.roomCount?.toString() ?? '',
                onChanged: (value) => _change(
                  context,
                  (d) => d.copyWith(roomCount: int.tryParse(value)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.spacing),
        _LocationField(location: draft.location),
        const SizedBox(height: Dimens.spacing),
        _AvailabilityField(
          value: draft.availableFrom,
          onChanged: (date) =>
              _change(context, (d) => d.copyWith(availableFrom: date)),
        ),
        if (isResidence) ...[
          const SizedBox(height: Dimens.spacingLg),
          UnitGroupEditor(units: draft.units),
        ],
        const SizedBox(height: Dimens.spacing),
        FormTextField(
          label: l10n.annonceFormFieldDescription,
          maxLines: 5,
          initialValue: draft.description ?? '',
          onChanged: (value) =>
              _change(context, (d) => d.copyWith(description: value)),
        ),
      ],
    );
  }

  Future<void> _addPhoto(BuildContext context) async {
    final bloc = context.read<AnnonceFormBloc>();
    final source = await showCaptureSourceSheet(context);
    if (source != null) bloc.add(AnnonceFormPhotoAdded(source));
  }
}

class _PropertyTypeField extends StatelessWidget {
  const _PropertyTypeField({required this.value, required this.onChanged});

  final PropertyType value;
  final ValueChanged<PropertyType> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return DropdownButtonFormField<PropertyType>(
      initialValue: value,
      decoration: InputDecoration(labelText: l10n.annonceFormFieldType),
      items: [
        for (final type in PropertyType.values)
          DropdownMenuItem(value: type, child: Text(_label(type))),
      ],
      onChanged: (type) => type == null ? null : onChanged(type),
    );
  }

  // Property types have no CDC-defined French labels yet; these mirror the
  // designs' vocabulary.
  String _label(PropertyType type) => switch (type) {
        PropertyType.apartment => 'Appartement',
        PropertyType.studio => 'Studio',
        PropertyType.villa => 'Villa',
        PropertyType.room => 'Chambre',
        PropertyType.office => 'Bureau',
        PropertyType.commercialSpace => 'Local commercial',
      };
}

/// Captures GPS and pairs it with a district, satisfying the endpoints'
/// required latitude/longitude behind the design's single "Localisation" field.
class _LocationField extends StatefulWidget {
  const _LocationField({this.location});

  final ListingLocation? location;

  @override
  State<_LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<_LocationField> {
  bool _busy = false;

  Future<void> _capture() async {
    final l10n = I18n.of(context);
    final bloc = context.read<AnnonceFormBloc>();

    setState(() => _busy = true);
    try {
      final city = await showCityPicker(
        context,
        repository: getIt<LocationRepository>(),
      );
      if (city == null || !mounted) return;

      final fix = await const LocationCapture().current();
      if (!mounted) return;

      bloc.add(
        AnnonceFormChanged(
          (draft) => draft.copyWith(
            location: ListingLocation(
              // The city picker doubles as the district choice until a district
              // picker exists — LocationsApi.districts(cityId) is the next step.
              districtId: city.id,
              districtName: city.name,
              cityId: city.id,
              cityName: city.name,
              latitude: fix.latitude,
              longitude: fix.longitude,
            ),
          ),
        ),
      );
    } on LocationCaptureException {
      if (mounted) {
        MboaToast.error(
          context: context,
          title: l10n.commonErrorTitle,
          description: l10n.annonceFormLocationDenied,
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final location = widget.location;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _busy ? null : _capture,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: l10n.annonceFormFieldLocation,
              suffixIcon: _busy
                  ? const Padding(
                      padding: EdgeInsets.all(Dimens.spacingMd),
                      child: Loader(),
                    )
                  : Icon(LucideIcons.mapPinHouse, color: colors.primary),
            ),
            child: Text(
              location?.label ?? l10n.homeLocationEmpty,
              style: context.mboaText.body,
            ),
          ),
        ),
        if (location != null) ...[
          const SizedBox(height: Dimens.spacingSm),
          Text(
            // GPS records where the phone is, not where the property is.
            l10n.annonceFormLocationHint,
            style: context.mboaText.micro.copyWith(color: colors.textTertiary),
          ),
          const SizedBox(height: Dimens.spacingSm),
          FormTextField(
            label: l10n.annonceFormAddress,
            initialValue: location.exactAddress ?? '',
            onChanged: (value) => context.read<AnnonceFormBloc>().add(
                  AnnonceFormChanged(
                    (draft) => draft.copyWith(
                      location: location.copyWith(exactAddress: value),
                    ),
                  ),
                ),
          ),
        ],
      ],
    );
  }
}

class _AvailabilityField extends StatelessWidget {
  const _AvailabilityField({required this.value, required this.onChanged});

  final DateTime? value;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return InkWell(
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? now,
          firstDate: now.subtract(const Duration(days: 365)),
          lastDate: now.add(const Duration(days: 365 * 3)),
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: l10n.annonceFormFieldAvailability,
          suffixIcon: Icon(LucideIcons.calendar, color: colors.primary),
        ),
        child: Text(
          value == null ? '--/--' : DateFormat.yMMMMd().format(value!),
          style: context.mboaText.body,
        ),
      ),
    );
  }
}
