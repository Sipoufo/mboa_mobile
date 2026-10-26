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
import '../models/annonce_draft.dart';
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
    create: (_) => getIt<AnnonceFormBloc>()..add(AnnonceFormStarted(kind: kind, annonceId: annonceId)),
    child: this,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<AnnonceFormBloc>();

    return BlocConsumer<AnnonceFormBloc, AnnonceFormState>(
      listenWhen: (prev, curr) => curr is AnnonceFormSaved || (curr is AnnonceFormEditing && curr.error != null),
      listener: (context, state) {
        switch (state) {
          case AnnonceFormSaved(:final kind):
            // The list is session-scoped, so refreshing it here means the new
            // listing is there when the user lands back on it.
            switch (kind) {
              case AnnonceKind.single:
                context.read<AnnoncesBloc>().add(const AnnoncesRefreshRequested());
              case AnnonceKind.residence:
                context.read<ResidencesBloc>().add(const ResidencesRefreshRequested());
            }
            MboaToast.success(
              context: context,
              title: l10n.annonceFormSavedDraft,
            );
            // After the rebuild that lets the route go (canPop below).
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) context.router.maybePop();
            });
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
          AnnonceFormSubmitting(:final draft, :final step) => AnnonceFormEditing(draft, step: step),
          _ => null,
        };
        final submitting = state is AnnonceFormSubmitting;
        final failedToLoad = state is AnnonceFormLoadFailure;
        final draft = editing?.draft;
        final steps = draft?.steps ?? const <AnnonceFormStep>[];
        final index = editing == null ? 0 : steps.indexOf(editing.step);
        final previous = index > 0 ? steps[index - 1] : null;
        final next = editing != null && index < steps.length - 1 ? steps[index + 1] : null;

        void goTo(AnnonceFormStep step) {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.add(AnnonceFormStepRequested(step));
        }

        return PopScope(
          canPop: previous == null || submitting,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop && previous != null) goTo(previous);
          },
          child: Scaffold(
            backgroundColor: colors.background,
            appBar: AppBar(
              leading: previous == null
                  ? null
                  : IconButton(
                      icon: Icon(LucideIcons.arrowLeft, color: colors.ink),
                      onPressed: submitting ? null : () => goTo(previous),
                    ),
              title: Text(
                annonceId == null ? l10n.annonceFormTitleNew : l10n.annonceFormTitleEdit,
              ),
            ),
            body: switch ((editing, failedToLoad)) {
              (_, true) => Center(child: Text(l10n.annonceFormLoadFailed)),
              (final AnnonceFormEditing e, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(Dimens.spacing, 0, Dimens.spacing, Dimens.spacing),
                    child: MboaStepHeader(
                      current: index + 1,
                      total: steps.length,
                      title: _stepTitle(l10n, e.draft, e.step),
                      onStepTap: submitting ? null : (n) => goTo(steps[n - 1]),
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: KeyedSubtree(
                        key: ValueKey((e.draft.kind, e.step)),
                        child: _StepBody(state: e),
                      ),
                    ),
                  ),
                ],
              ),
              _ => const Center(child: Loader()),
            },
            bottomNavigationBar: editing == null
                ? null
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.spacing),
                      // Creating: on to the next step, the last one saves.
                      // Correcting: saved from any step.
                      child: next != null && !editing.draft.isEditing
                          ? Button.primary(
                              title: l10n.commonContinue,
                              onPressed: editing.draft.isStepComplete(editing.step) ? () => goTo(next) : null,
                            )
                          : Button.primary(
                              title: l10n.annonceFormSave,
                              isLoading: submitting,
                              onPressed: editing.canSubmit ? () => bloc.add(const AnnonceFormSubmitted()) : null,
                            ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  static String _stepTitle(I18n l10n, AnnonceDraft draft, AnnonceFormStep step) => switch (step) {
    AnnonceFormStep.basics => l10n.annonceStepBasics,
    AnnonceFormStep.place => l10n.annonceStepPlace,
    AnnonceFormStep.details => draft.kind == AnnonceKind.residence ? l10n.annonceStepUnits : l10n.annonceStepDetails,
    AnnonceFormStep.rent => l10n.annonceStepRent,
    AnnonceFormStep.media => l10n.annonceStepMedia,
  };
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

/// One step's fields.
class _StepBody extends StatelessWidget {
  const _StepBody({required this.state});

  final AnnonceFormEditing state;

  AnnonceDraft get draft => state.draft;

  void _change(
    BuildContext context,
    AnnonceDraft Function(AnnonceDraft) apply,
  ) => context.read<AnnonceFormBloc>().add(AnnonceFormChanged(apply));

  @override
  Widget build(BuildContext context) {
    final isResidence = draft.kind == AnnonceKind.residence;

    return ListView(
      padding: const EdgeInsets.fromLTRB(Dimens.spacing, 0, Dimens.spacing, Dimens.spacingXl),
      children: switch (state.step) {
        AnnonceFormStep.basics => _basics(context, isResidence),
        AnnonceFormStep.place => [LocationField(location: draft.location)],
        AnnonceFormStep.details => isResidence ? _units(context) : _details(context),
        AnnonceFormStep.rent => _rent(context),
        AnnonceFormStep.media => _media(context),
      },
    );
  }

  /// What it is: the kind — fixed once a listing exists —, its name, its type.
  List<Widget> _basics(BuildContext context, bool isResidence) {
    final l10n = I18n.of(context);
    return [
      // The kind is fixed once a listing exists — the two are different
      // resources on the backend, so switching would mean re-creating.
      if (!draft.isEditing) ...[
        _HelpLabel(
          label: l10n.annonceFormKindLabel,
          helpText: l10n.annonceFormHelpKind,
        ),
        const SizedBox(height: Dimens.spacingSm),
        for (final kind in AnnonceKind.values) ...[
          _KindCard(
            kind: kind,
            selected: draft.kind == kind,
            // A new kind is a new form; the name typed so far follows.
            onTap: () => context.read<AnnonceFormBloc>().add(
              AnnonceFormStarted(kind: kind, draft: AnnonceDraft(kind: kind, title: draft.title)),
            ),
          ),
          const SizedBox(height: Dimens.spacingSm),
        ],
        const SizedBox(height: Dimens.spacing),
      ],
      FormTextField(
        // Doc 10 makes "Titre" obligatoire; the mockup omits it, and reusing
        // the "Type" label here collided with the property-type dropdown.
        label: isResidence ? l10n.annonceFormFieldName : l10n.annonceFormFieldTitle,
        initialValue: draft.title,
        onChanged: (value) => _change(context, (d) => d.copyWith(title: value)),
      ),
      if (!isResidence) ...[
        const SizedBox(height: Dimens.spacing),
        _PropertyTypeField(
          value: draft.propertyType,
          onChanged: (type) => _change(context, (d) => d.copyWith(propertyType: type)),
        ),
      ],
    ];
  }

  /// What is inside — all optional, but what tenants filter on.
  List<Widget> _details(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    return [
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
                onChanged: (value) => _change(context, (d) => d.copyWith(furnished: value)),
              ),
              child: const SizedBox.shrink(),
            ),
          ),
        ],
      ),
      const SizedBox(height: Dimens.spacing),
      _HelpLabel(
        label: l10n.annonceFormFieldAmenities,
        helpText: l10n.annonceFormHelpAmenities,
      ),
      const SizedBox(height: Dimens.spacingXs),
      // Chips rather than a column of checkboxes: six short labels wrap
      // into two rows instead of pushing the rest of the form down a page.
      Wrap(
        spacing: Dimens.spacingSm,
        runSpacing: Dimens.spacingXs,
        children: [
          for (final amenity in Amenity.values)
            FilterChip(
              label: Text(amenity.label(l10n)),
              selected: draft.amenities.contains(amenity),
              // The brand's green, like the search's filters — the theme's own
              // selected colour is the coral of alerts.
              selectedColor: colors.primaryPale,
              checkmarkColor: colors.primary,
              side: BorderSide(color: draft.amenities.contains(amenity) ? colors.primary : colors.border),
              labelStyle: context.mboaText.label.copyWith(
                color: draft.amenities.contains(amenity) ? colors.primaryDark : colors.textSecondary,
                fontWeight: draft.amenities.contains(amenity) ? FontWeight.w700 : FontWeight.w500,
              ),
              onSelected: (selected) => _change(context, (d) {
                final next = [...d.amenities];
                selected ? next.add(amenity) : next.remove(amenity);
                return d.copyWith(amenities: next);
              }),
            ),
        ],
      ),
    ];
  }

  /// A residence's units, by groups — their rents with them —, and when
  /// they are free.
  List<Widget> _units(BuildContext context) => [
    UnitGroupEditor(units: draft.units, showTitle: false),
    const SizedBox(height: Dimens.spacing),
    _AvailabilityField(
      value: draft.availableFrom,
      onChanged: (date) => _change(context, (d) => d.copyWith(availableFrom: date)),
    ),
  ];

  /// The rent, its period, the charges, and from when.
  List<Widget> _rent(BuildContext context) {
    final l10n = I18n.of(context);
    return [
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
        onChanged: (period) => _change(context, (d) => d.copyWith(rentalPeriod: period)),
      ),
      const SizedBox(height: Dimens.spacing),
      FormFieldShell(
        label: l10n.annonceFormFieldCharges,
        helpText: l10n.annonceFormHelpCharges,
        trailing: Switch(
          value: draft.chargesIncluded ?? false,
          onChanged: (value) => _change(context, (d) => d.copyWith(chargesIncluded: value)),
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
      const SizedBox(height: Dimens.spacing),
      _AvailabilityField(
        value: draft.availableFrom,
        onChanged: (date) => _change(context, (d) => d.copyWith(availableFrom: date)),
      ),
    ];
  }

  /// The photos — three to publish, not to save — and the words.
  List<Widget> _media(BuildContext context) {
    final l10n = I18n.of(context);
    return [
      _HelpLabel(
        label: l10n.annonceFormPhotosLabel,
        helpText: l10n.annonceFormHelpPhotos,
      ),
      PhotoStrip(
        photoKeys: draft.photoKeys,
        isUploading: state.uploadingPhoto,
        onAdd: () => _addPhoto(context),
        onRemove: (key) => context.read<AnnonceFormBloc>().add(AnnonceFormPhotoRemoved(key)),
      ),
      const SizedBox(height: Dimens.spacingLg),
      FormTextField(
        label: l10n.annonceFormFieldDescription,
        helpText: l10n.annonceFormHelpDescription,
        minLines: 4,
        maxLines: 8,
        initialValue: draft.description ?? '',
        onChanged: (value) => _change(context, (d) => d.copyWith(description: value)),
      ),
    ];
  }

  Future<void> _addPhoto(BuildContext context) async {
    final bloc = context.read<AnnonceFormBloc>();
    final source = await showCaptureSourceSheet(context);
    if (source != null) bloc.add(AnnonceFormPhotoAdded(source));
  }
}

/// One of the two kinds, as a card: what it is, and what it is for.
class _KindCard extends StatelessWidget {
  const _KindCard({required this.kind, required this.selected, required this.onTap});

  final AnnonceKind kind;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final (icon, title, hint) = switch (kind) {
      AnnonceKind.single => (LucideIcons.house, l10n.annonceFormKindSingle, l10n.annonceKindSingleHint),
      AnnonceKind.residence => (LucideIcons.building2, l10n.annonceFormKindMultiple, l10n.annonceKindMultipleHint),
    };

    return Material(
      color: selected ? colors.primaryPale : colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        side: BorderSide(color: selected ? colors.primary : colors.border, width: selected ? 1.5 : 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: selected ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingMd),
          child: Row(
            children: [
              Icon(icon, size: 28, color: selected ? colors.primary : colors.textSecondary),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.mboaText.label.copyWith(
                        color: selected ? colors.primaryDark : colors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(hint, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                  ],
                ),
              ),
              Icon(
                selected ? LucideIcons.circleCheck : LucideIcons.circle,
                size: Dimens.icon,
                color: selected ? colors.primary : colors.border,
              ),
            ],
          ),
        ),
      ),
    );
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
          icon: Icon(LucideIcons.chevronDown, size: Dimens.icon, color: context.mboaColors.textSecondary),
          items: [
            for (final period in RentalPeriod.values) DropdownMenuItem(value: period, child: Text(period.label(l10n))),
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
          icon: Icon(LucideIcons.chevronDown, size: Dimens.icon, color: context.mboaColors.textSecondary),
          isDense: true,
          style: context.mboaText.label.copyWith(fontWeight: FontWeight.w500),
          items: [
            for (final type in PropertyType.values) DropdownMenuItem(value: type, child: Text(_label(type))),
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
