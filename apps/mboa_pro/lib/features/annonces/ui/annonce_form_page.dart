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
import '../bloc/annonces_bloc.dart';
import '../bloc/residences_bloc.dart';
import '../models/annonce.dart';
import '../models/annonce_draft.dart';
import '../models/rental_period.dart';
import 'widgets/form_field_shell.dart';
import 'widgets/form_text_field.dart';
import 'widgets/location_field.dart';
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
        create: (_) => getIt<AnnonceFormBloc>()
          ..add(AnnonceFormStarted(kind: kind, annonceId: annonceId)),
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
          case AnnonceFormSaved(:final kind):
            // The list is session-scoped, so refreshing it here means the new
            // listing is there when the user lands back on it.
            switch (kind) {
              case AnnonceKind.single:
                context
                    .read<AnnoncesBloc>()
                    .add(const AnnoncesRefreshRequested());
              case AnnonceKind.residence:
                context
                    .read<ResidencesBloc>()
                    .add(const ResidencesRefreshRequested());
            }
            MboaToast.success(
              context: context,
              title: l10n.annonceFormSavedDraft,
            );
            context.router.maybePop();
          case AnnonceFormEditing(:final error?, :final apiError):
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: switch (error) {
                AnnonceFormError.photoUpload => l10n.annonceFormErrorPhoto,
                AnnonceFormError.incomplete => l10n.annonceFormErrorIncomplete,
                AnnonceFormError.save => _saveMessage(l10n, apiError),
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
        final failedToLoad = state is AnnonceFormLoadFailure;

        return Scaffold(
          backgroundColor: context.mboaColors.background,
          appBar: AppBar(
            title: Text(
              annonceId == null
                  ? l10n.annonceFormTitleNew
                  : l10n.annonceFormTitleEdit,
            ),
          ),
          body: switch ((editing, failedToLoad)) {
            (_, true) => Center(child: Text(l10n.annonceFormLoadFailed)),
            (final AnnonceFormEditing e, _) => _Form(state: e),
            _ => const Center(child: Loader()),
          },
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

/// Turns a backend error into something actionable.
///
/// Codes are the real ones from `api/docs/api-error-codes.md` (63 of them,
/// generated from the source). An earlier guessed list was wrong on three rows
/// of four — never invent these.
///
/// An unrecognised code still shows the backend's own `message`; only a truly
/// opaque failure falls back to "try again". `message` is prose and gets
/// reworded upstream, so nothing branches on it.
String _saveMessage(I18n l10n, ApiError? error) {
  if (error == null) return l10n.annonceFormErrorSave;

  if (error.hasCode('RESIDENCE_UNIT_LIMIT')) return l10n.errorResidenceUnitLimit;
  if (error.hasCode('LISTING_LIMIT_REACHED')) return l10n.errorListingLimit;
  if (error.hasCode('PROFILE_INCOMPLETE')) return l10n.errorProfileIncomplete;
  if (error.hasCode('INSUFFICIENT_PHOTOS')) return l10n.errorInsufficientPhotos;
  if (error.hasCode('INVALID_STATUS_TRANSITION')) {
    return l10n.errorInvalidTransition;
  }
  if (error.hasCode('CONSTRAINT_VIOLATION')) {
    return l10n.errorConstraintViolation;
  }
  if (error.hasCode('ACCESS_DENIED')) return l10n.errorAccessDenied;

  // VALIDATION_ERROR carries a per-field breakdown; the first one is the most
  // useful thing to show on a form.
  if (error.hasCode('VALIDATION_ERROR')) {
    return error.firstFieldMessage ?? error.message ?? l10n.errorValidation;
  }

  return error.message ?? l10n.annonceFormErrorSave;
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
        if (!draft.isEditing) ...[
          _HelpLabel(
            label: l10n.annonceFormKindLabel,
            helpText: l10n.annonceFormHelpKind,
          ),
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
        ],
        const SizedBox(height: Dimens.spacing),
        _HelpLabel(
          label: l10n.annonceFormPhotosLabel,
          helpText: l10n.annonceFormHelpPhotos,
        ),
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
          // Doc 10 makes "Titre" obligatoire; the mockup omits it, and reusing
          // the "Type" label here collided with the property-type dropdown.
          label: isResidence
              ? l10n.annonceFormFieldName
              : l10n.annonceFormFieldTitle,
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
            label: l10n.annonceFormFieldPrice,
            helpText: l10n.annonceFormHelpPrice,
            suffixText: l10n.annonceFormCurrency,
            keyboardType: TextInputType.number,
            initialValue: draft.price?.toString() ?? '',
            onChanged: (value) => _change(
              context,
              (d) => d.copyWith(price: int.tryParse(value)),
            ),
          ),
          const SizedBox(height: Dimens.spacing),
          _RentalPeriodField(
            value: draft.rentalPeriod,
            onChanged: (period) =>
                _change(context, (d) => d.copyWith(rentalPeriod: period)),
          ),
        ],
        if (!isResidence) ...[
        const SizedBox(height: Dimens.spacing),
        Row(
          children: [
            Expanded(
              child: FormTextField(
                label: l10n.annonceFormFieldSurface,
                helpText: l10n.annonceFormHelpOptionalFilters,
                suffixText: l10n.annonceFormUnitSquareMetres,
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
        Row(
          children: [
            Expanded(
              child: FormTextField(
                label: l10n.annonceFormFieldBathrooms,
                keyboardType: TextInputType.number,
                initialValue: draft.bathroomCount?.toString() ?? '',
                onChanged: (value) => _change(
                  context,
                  (d) => d.copyWith(bathroomCount: int.tryParse(value)),
                ),
              ),
            ),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: FormFieldShell(
                label: l10n.annonceFormFieldFurnished,
                trailing: Switch(
                  value: draft.furnished ?? false,
                  onChanged: (value) =>
                      _change(context, (d) => d.copyWith(furnished: value)),
                ),
                child: const SizedBox.shrink(),
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.spacing),
        FormFieldShell(
          label: l10n.annonceFormFieldCharges,
          helpText: l10n.annonceFormHelpCharges,
          trailing: Switch(
            value: draft.chargesIncluded ?? false,
            onChanged: (value) =>
                _change(context, (d) => d.copyWith(chargesIncluded: value)),
          ),
          child: const SizedBox.shrink(),
        ),
        // Only meaningful when charges are separate from the rent.
        if (draft.chargesIncluded != true) ...[
          const SizedBox(height: Dimens.spacing),
          FormTextField(
            label: l10n.annonceFormFieldChargesAmount,
            suffixText: l10n.annonceFormCurrency,
            keyboardType: TextInputType.number,
            initialValue: draft.chargesAmount?.toString() ?? '',
            onChanged: (value) => _change(
              context,
              (d) => d.copyWith(chargesAmount: int.tryParse(value)),
            ),
          ),
        ],
        ],
        const SizedBox(height: Dimens.spacing),
        LocationField(location: draft.location),
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
          helpText: l10n.annonceFormHelpDescription,
          minLines: 4,
          maxLines: 8,
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

/// RM-M10-09 — the rent's period. Month is the default because it is what every
/// listing predating the rule was, and what most of them still are.
class _RentalPeriodField extends StatelessWidget {
  const _RentalPeriodField({required this.value, required this.onChanged});

  final RentalPeriod value;
  final ValueChanged<RentalPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return FormFieldShell(
      label: l10n.annonceFormFieldPeriod,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<RentalPeriod>(
          value: value,
          isExpanded: true,
          items: [
            for (final period in RentalPeriod.values)
              DropdownMenuItem(value: period, child: Text(period.label(l10n))),
          ],
          onChanged: (period) => period == null ? null : onChanged(period),
        ),
      ),
    );
  }
}

/// A label + info icon for the sections that are not fields — the kind
/// selector and the photo strip — so they carry the same affordance as the
/// labelled inputs below them.
class _HelpLabel extends StatelessWidget {
  const _HelpLabel({required this.label, required this.helpText});

  final String label;
  final String helpText;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Flexible(
            child: Text(
              label,
              style: context.mboaText.label.copyWith(
                fontWeight: FontWeight.w400,
                color: context.mboaColors.textSecondary,
              ),
            ),
          ),
          FieldHelp(label: label, text: helpText),
        ],
      );
}

class _PropertyTypeField extends StatelessWidget {
  const _PropertyTypeField({required this.value, required this.onChanged});

  final PropertyType value;
  final ValueChanged<PropertyType> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return FormFieldShell(
      label: l10n.annonceFormFieldType,
      helpText: l10n.annonceFormHelpPropertyType,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<PropertyType>(
          value: value,
          isExpanded: true,
          isDense: true,
          style: context.mboaText.label.copyWith(fontWeight: FontWeight.w500),
          items: [
            for (final type in PropertyType.values)
              DropdownMenuItem(value: type, child: Text(_label(type))),
          ],
          onChanged: (type) => type == null ? null : onChanged(type),
        ),
      ),
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
      child: FormFieldShell(
        label: l10n.annonceFormFieldAvailability,
        helpText: l10n.annonceFormHelpAvailability,
        trailing: Icon(LucideIcons.calendar, color: colors.primary),
        child: Text(
          value == null ? '--/--' : DateFormat.yMMMMd().format(value!),
        ),
      ),
    );
  }
}
