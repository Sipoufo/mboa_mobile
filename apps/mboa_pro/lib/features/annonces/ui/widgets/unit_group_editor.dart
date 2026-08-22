import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../bloc/annonce_form_bloc.dart';
import '../../models/annonce_draft.dart';
import '../../models/annonce.dart';
import 'form_field_shell.dart';
import 'form_text_field.dart';

/// Editor for a residence's unit groups.
///
/// The API creates a residence from *groups* — "6 × Chambre at 45 000" — and
/// expands them server-side, so the form edits groups rather than individual
/// units. Rents live here, not on the residence, which is why the multi-unit
/// form has no single price field.
class UnitGroupEditor extends StatelessWidget {
  const UnitGroupEditor({super.key, required this.units});

  final List<UnitGroupDraft> units;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final bloc = context.read<AnnonceFormBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.annonceFormUnitsTitle, style: context.mboaText.h3),
        const SizedBox(height: Dimens.spacingSm),
        for (var index = 0; index < units.length; index++)
          _UnitGroupRow(
            key: ValueKey(index),
            index: index,
            group: units[index],
            onChanged: (group) => bloc.add(AnnonceFormUnitGroupUpdated(index, group)),
            onRemove: () => bloc.add(AnnonceFormUnitGroupRemoved(index)),
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
    required this.onChanged,
    required this.onRemove,
  });

  final int index;
  final UnitGroupDraft group;
  final ValueChanged<UnitGroupDraft> onChanged;
  final VoidCallback onRemove;

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
                icon: Icon(LucideIcons.trash2, color: colors.error),
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
        ],
      ),
    );
  }
}
