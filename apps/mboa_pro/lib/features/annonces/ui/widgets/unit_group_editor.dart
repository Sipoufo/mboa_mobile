import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../bloc/annonce_form_bloc.dart';
import '../../models/annonce_draft.dart';
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
            onChanged: (group) =>
                bloc.add(AnnonceFormUnitGroupUpdated(index, group)),
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
                  onChanged: (value) =>
                      onChanged(group.copyWith(namePrefix: value)),
                ),
              ),
              IconButton(
                onPressed: onRemove,
                icon: Icon(LucideIcons.trash2, color: colors.error),
              ),
            ],
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
                  keyboardType: TextInputType.number,
                  initialValue: group.monthlyRent?.toString() ?? '',
                  onChanged: (value) =>
                      onChanged(group.copyWith(monthlyRent: int.tryParse(value))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
