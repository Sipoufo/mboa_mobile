import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../bloc/annonce_form_bloc.dart';
import '../../models/annonce_draft.dart';
import 'form_field_shell.dart';
import 'form_text_field.dart';
import 'photo_strip.dart';
import 'rent_conditions_fields.dart';

/// Editor for a residence's unit groups.
///
/// The API creates a residence from *groups* — "6 × Chambre at 45 000" — and
/// expands them server-side, so the form edits groups rather than individual
/// units. Rents live here, not on the residence, which is why the multi-unit
/// form has no single price field.
class UnitGroupEditor extends StatelessWidget {
  const UnitGroupEditor({
    super.key,
    required this.units,
    this.showTitle = true,
    this.withPhotos = false,
    this.uploadingGroup,
  });

  final List<UnitGroupDraft> units;

  /// Off under a step that already asks for the units.
  final bool showTitle;

  /// RM-M10bis-13 — each group's own photos, on creation only: once created,
  /// the units are listings and each keeps its photos on its own.
  final bool withPhotos;

  /// The group whose photo is uploading.
  final int? uploadingGroup;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final bloc = context.read<AnnonceFormBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          Text(l10n.annonceFormUnitsTitle, style: context.mboaText.h3),
          const SizedBox(height: Dimens.spacingSm),
        ],
        for (var index = 0; index < units.length; index++)
          _UnitGroupRow(
            key: ValueKey(index),
            index: index,
            group: units[index],
            withPhotos: withPhotos,
            isUploading: uploadingGroup == index,
            onChanged: (group) => bloc.add(AnnonceFormUnitGroupUpdated(index, group)),
            // Not while a group photo uploads: it lands by the group's place.
            onRemove: uploadingGroup == null ? () => bloc.add(AnnonceFormUnitGroupRemoved(index)) : null,
            onAddPhoto: () async {
              final source = await showCaptureSourceSheet(context);
              if (source != null) bloc.add(AnnonceFormPhotoAdded(source, group: index));
            },
            onRemovePhoto: (key) => bloc.add(AnnonceFormPhotoRemoved(key, group: index)),
          ),
        const SizedBox(height: Dimens.spacingSm),
        Button.outline(
          title: l10n.annonceFormUnitsAdd,
          icon: const Icon(LucideIcons.plus, size: Dimens.icon),
          iconAlignment: IconAlignment.start,
          onPressed: () => bloc.add(const AnnonceFormUnitGroupAdded()),
        ),
      ],
    );
  }
}

class _UnitGroupRow extends StatelessWidget {
  const _UnitGroupRow({
    super.key,
    required this.index,
    required this.group,
    required this.withPhotos,
    required this.isUploading,
    required this.onChanged,
    required this.onRemove,
    required this.onAddPhoto,
    required this.onRemovePhoto,
  });

  final int index;
  final UnitGroupDraft group;
  final bool withPhotos;
  final bool isUploading;
  final ValueChanged<UnitGroupDraft> onChanged;
  final VoidCallback? onRemove;
  final VoidCallback onAddPhoto;
  final ValueChanged<String> onRemovePhoto;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingMd),
      padding: const EdgeInsets.all(Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radius),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FormTextField(
                  label: l10n.annonceFormUnitPrefix,
                  initialValue: group.namePrefix,
                  onChanged: (value) => onChanged(group.copyWith(namePrefix: value)),
                ),
              ),
              IconButton(
                onPressed: onRemove,
                icon: Icon(LucideIcons.trash2, color: onRemove == null ? colors.textTertiary : colors.error),
              ),
            ],
          ),
          const SizedBox(height: Dimens.spacingSm),
          FormFieldShell(
            label: l10n.annonceFormFieldType,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<PropertyType>(
                value: group.propertyType,
                isExpanded: true,
                icon: Icon(LucideIcons.chevronDown, size: Dimens.icon, color: colors.textSecondary),
                isDense: true,
                style: context.mboaText.label.copyWith(fontWeight: FontWeight.w500),
                items: [
                  for (final type in PropertyType.values) DropdownMenuItem(value: type, child: Text(type.label(l10n))),
                ],
                onChanged: (type) => type == null ? null : onChanged(group.copyWith(propertyType: type)),
              ),
            ),
          ),
          const SizedBox(height: Dimens.spacingSm),
          Row(
            children: [
              Expanded(
                child: FormTextField(
                  label: l10n.annonceFormUnitCount,
                  keyboardType: TextInputType.number,
                  initialValue: '${group.count}',
                  onChanged: (value) => onChanged(
                    group.copyWith(count: int.tryParse(value) ?? group.count),
                  ),
                ),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: FormTextField(
                  label: l10n.annonceFormFieldPrice,
                  suffixText: l10n.annonceFormCurrency,
                  keyboardType: TextInputType.number,
                  initialValue: group.price?.toString() ?? '',
                  onChanged: (value) => onChanged(group.copyWith(price: int.tryParse(value))),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.spacingSm),
          // RM-M10-09 — each group carries its own period: a hotel room may be
          // let monthly while a shop in the same building is let yearly.
          FormFieldShell(
            label: l10n.annonceFormFieldPeriod,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<RentalPeriod>(
                value: group.rentalPeriod,
                isExpanded: true,
                icon: Icon(LucideIcons.chevronDown, size: Dimens.icon, color: colors.textSecondary),
                items: [
                  for (final period in RentalPeriod.values)
                    DropdownMenuItem(
                      value: period,
                      child: Text(period.label(l10n)),
                    ),
                ],
                onChanged: (period) => period == null ? null : onChanged(group.copyWith(rentalPeriod: period)),
              ),
            ),
          ),
          const SizedBox(height: Dimens.spacingSm),
          Row(
            children: [
              Expanded(
                child: FormTextField(
                  label: l10n.annonceFormFieldSurface,
                  suffixText: l10n.annonceFormUnitSquareMetres,
                  keyboardType: TextInputType.number,
                  initialValue: group.surfaceArea?.toString() ?? '',
                  onChanged: (value) => onChanged(group.copyWith(surfaceArea: int.tryParse(value))),
                ),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: FormTextField(
                  label: l10n.annonceFormFieldRooms,
                  keyboardType: TextInputType.number,
                  initialValue: group.roomCount?.toString() ?? '',
                  onChanged: (value) => onChanged(group.copyWith(roomCount: int.tryParse(value))),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.spacingSm),
          Row(
            children: [
              Expanded(
                child: FormTextField(
                  label: l10n.annonceFormFieldBathrooms,
                  keyboardType: TextInputType.number,
                  initialValue: group.bathroomCount?.toString() ?? '',
                  onChanged: (value) => onChanged(
                    group.copyWith(bathroomCount: int.tryParse(value)),
                  ),
                ),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: FormFieldShell(
                  label: l10n.annonceFormFieldFurnished,
                  trailing: Switch(
                    value: group.furnished ?? false,
                    onChanged: (value) => onChanged(group.copyWith(furnished: value)),
                  ),
                  child: const SizedBox.shrink(),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.spacingSm),
          FormFieldShell(
            label: l10n.annonceFormFieldCharges,
            trailing: Switch(
              value: group.chargesIncluded ?? false,
              onChanged: (value) => onChanged(group.copyWith(chargesIncluded: value)),
            ),
            child: const SizedBox.shrink(),
          ),
          if (group.chargesIncluded != true) ...[
            const SizedBox(height: Dimens.spacingSm),
            FormTextField(
              label: l10n.annonceFormFieldChargesAmount,
              suffixText: l10n.annonceFormCurrency,
              keyboardType: TextInputType.number,
              initialValue: group.chargesAmount?.toString() ?? '',
              onChanged: (value) => onChanged(group.copyWith(chargesAmount: int.tryParse(value))),
            ),
          ],
          const SizedBox(height: Dimens.spacingSm),
          RentConditionsFields(
            advanceMonths: group.advanceMonths,
            depositMonths: group.depositMonths,
            onAdvanceChanged: (months) => onChanged(
              months == null ? group.copyWith(clearAdvance: true) : group.copyWith(advanceMonths: months),
            ),
            onDepositChanged: (months) => onChanged(
              months == null ? group.copyWith(clearDeposit: true) : group.copyWith(depositMonths: months),
            ),
          ),
          if (withPhotos) ...[
            const SizedBox(height: Dimens.spacingMd),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.annonceFormUnitPhotosLabel,
                style: context.mboaText.label.copyWith(color: colors.ink),
              ),
            ),
            const SizedBox(height: Dimens.spacingSm),
            PhotoStrip(
              photoKeys: group.photoKeys,
              isUploading: isUploading,
              onAdd: onAddPhoto,
              onRemove: onRemovePhoto,
              hint: l10n.annonceFormUnitPhotosHint(AnnonceDraft.minPhotos),
            ),
          ],
        ],
      ),
    );
  }
}
