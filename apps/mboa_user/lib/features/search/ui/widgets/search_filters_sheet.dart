import 'package:flutter/material.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The optional criteria (CDC M04).
///
/// Everything here is cumulative and optional — the city lives in the bar
/// because RM-M04-01 makes it the only mandatory one. The sheet edits a draft
/// and hands it back on "Appliquer": a search per keystroke would page the
/// backend for nothing.
Future<SearchQuery?> showSearchFiltersSheet(
  BuildContext context, {
  required SearchQuery query,
}) {
  final colors = context.mboaColors;

  return showModalBottomSheet<SearchQuery>(
    context: context,
    backgroundColor: colors.surface,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusLg)),
    ),
    builder: (_) => _FiltersSheet(query: query),
  );
}

class _FiltersSheet extends StatefulWidget {
  const _FiltersSheet({required this.query});

  final SearchQuery query;

  @override
  State<_FiltersSheet> createState() => _FiltersSheetState();
}

class _FiltersSheetState extends State<_FiltersSheet> {
  late SearchQuery _draft = widget.query;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingLg),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.searchFilters,
                      style: context.mboaText.h3,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        setState(() => _draft = _draft.clearedFilters()),
                    child: Text(l10n.searchClearFilters),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                padding: const EdgeInsets.all(Dimens.spacingLg),
                shrinkWrap: true,
                children: [
                  _Label(l10n.annonceFormFieldType),
                  const SizedBox(height: Dimens.spacingSm),
                  Wrap(
                    spacing: Dimens.spacingSm,
                    runSpacing: Dimens.spacingSm,
                    children: [
                      for (final type in PropertyType.values)
                        _Choice(
                          label: type.label(l10n),
                          selected: _draft.propertyTypes.contains(type),
                          onTap: () => setState(() {
                            final types = [..._draft.propertyTypes];
                            types.contains(type)
                                ? types.remove(type)
                                : types.add(type);
                            _draft = _draft.copyWith(propertyTypes: types);
                          }),
                        ),
                    ],
                  ),
                  const SizedBox(height: Dimens.spacingLg),

                  _Label(l10n.contractTermPeriod),
                  const SizedBox(height: Dimens.spacingSm),
                  Wrap(
                    spacing: Dimens.spacingSm,
                    runSpacing: Dimens.spacingSm,
                    children: [
                      for (final period in RentalPeriod.values)
                        _Choice(
                          label: period.label(l10n),
                          selected: _draft.rentalPeriods.contains(period),
                          onTap: () => setState(() {
                            final periods = [..._draft.rentalPeriods];
                            periods.contains(period)
                                ? periods.remove(period)
                                : periods.add(period);
                            _draft = _draft.copyWith(rentalPeriods: periods);
                          }),
                        ),
                    ],
                  ),
                  const SizedBox(height: Dimens.spacingLg),

                  _Label(l10n.searchRentRange),
                  _RangeRow(
                    minValue: _draft.rentMin,
                    maxValue: _draft.rentMax,
                    onChanged: (min, max) => setState(
                      () => _draft = min == null && max == null
                          ? _draft.copyWith(clearRent: true)
                          : _draft.copyWith(rentMin: min, rentMax: max),
                    ),
                  ),
                  const SizedBox(height: Dimens.spacingLg),

                  _Label(l10n.searchSurfaceRange),
                  _RangeRow(
                    minValue: _draft.surfaceMin,
                    maxValue: _draft.surfaceMax,
                    onChanged: (min, max) => setState(
                      () => _draft = min == null && max == null
                          ? _draft.copyWith(clearSurface: true)
                          : _draft.copyWith(surfaceMin: min, surfaceMax: max),
                    ),
                  ),
                  const SizedBox(height: Dimens.spacingLg),

                  _Label(l10n.searchRoomsMin),
                  const SizedBox(height: Dimens.spacingSm),
                  Wrap(
                    spacing: Dimens.spacingSm,
                    children: [
                      for (final rooms in const [1, 2, 3, 4])
                        _Choice(
                          label: rooms == 4
                              ? l10n.searchRoomsPlus(rooms)
                              : '$rooms',
                          selected: _draft.roomsMin == rooms,
                          onTap: () => setState(
                            () => _draft = _draft.roomsMin == rooms
                                ? _draft.copyWith(clearRooms: true)
                                : _draft.copyWith(roomsMin: rooms),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: Dimens.spacing),

                  // Three states, not two: "peu importe" is the default and has
                  // to be reachable again once a choice is made.
                  _TriState(
                    label: l10n.annonceFormFieldFurnished,
                    value: _draft.furnished,
                    onChanged: (value) => setState(
                      () => _draft = value == null
                          ? _draft.copyWith(clearFurnished: true)
                          : _draft.copyWith(furnished: value),
                    ),
                  ),
                  _TriState(
                    label: l10n.searchAvailableNow,
                    value: _draft.availableNow,
                    onChanged: (value) => setState(
                      () => _draft = value == null
                          ? _draft.copyWith(clearAvailableNow: true)
                          : _draft.copyWith(availableNow: value),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.spacingLg),
              child: Button.primary(
                title: l10n.searchApply,
                onPressed: () => Navigator.of(context).pop(_draft),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: context.mboaText.label
              .copyWith(color: context.mboaColors.primaryDark),
        ),
      );
}

class _Choice extends StatelessWidget {
  const _Choice({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      labelStyle: context.mboaText.caption
          .copyWith(color: selected ? colors.onBrand : colors.textSecondary),
      selectedColor: colors.primary,
      backgroundColor: colors.surface,
      side: BorderSide(color: colors.border),
      showCheckmark: false,
    );
  }
}

/// Owns its two controllers, seeded once from the draft: rebuilding them on
/// every keystroke would move the caret to the start of the field.
class _RangeRow extends StatefulWidget {
  const _RangeRow({
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  });

  final int? minValue;
  final int? maxValue;
  final void Function(int? min, int? max) onChanged;

  @override
  State<_RangeRow> createState() => _RangeRowState();
}

class _RangeRowState extends State<_RangeRow> {
  late final _min = TextEditingController(
    text: widget.minValue?.toString() ?? '',
  );
  late final _max = TextEditingController(
    text: widget.maxValue?.toString() ?? '',
  );

  @override
  void dispose() {
    _min.dispose();
    _max.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Row(
      children: [
        Expanded(
          child: Input(
            controller: _min,
            labelText: l10n.searchMin,
            keyboardType: TextInputType.number,
            variant: InputVariant.underline,
            onChanged: (value) =>
                widget.onChanged(int.tryParse(value), int.tryParse(_max.text)),
          ),
        ),
        const SizedBox(width: Dimens.spacing),
        Expanded(
          child: Input(
            controller: _max,
            labelText: l10n.searchMax,
            keyboardType: TextInputType.number,
            variant: InputVariant.underline,
            onChanged: (value) =>
                widget.onChanged(int.tryParse(_min.text), int.tryParse(value)),
          ),
        ),
      ],
    );
  }
}

class _TriState extends StatelessWidget {
  const _TriState({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
      child: Row(
        children: [
          Expanded(child: Text(label, style: context.mboaText.body)),
          for (final option in const [null, true, false])
            Padding(
              padding: const EdgeInsets.only(left: Dimens.spacingXs),
              child: _Choice(
                label: switch (option) {
                  null => l10n.searchAny,
                  true => l10n.commonYes,
                  false => l10n.commonNo,
                },
                selected: value == option,
                onTap: () => onChanged(option),
              ),
            ),
        ],
      ),
    );
  }
}
