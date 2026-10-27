import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The optional criteria (CDC M04).
///
/// Everything here is cumulative and optional — the city lives in the bar
/// because RM-M04-01 makes it the only mandatory one. The sheet edits a draft
/// and hands it back on "Voir les résultats": a search per keystroke would
/// page the backend for nothing.
///
/// What most searches touch comes first, in three cards — where, what, how
/// much, and the place itself; the rest (surface, amenities, badges) waits
/// behind « Plus de filtres », counted, never removed.
Future<SearchQuery?> showSearchFiltersSheet(
  BuildContext context, {
  required SearchQuery query,
  List<CityOption> districts = const [],
}) =>
    showModalBottomSheet<SearchQuery>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _FiltersSheet(query: query, districts: districts),
    );

class _FiltersSheet extends StatefulWidget {
  const _FiltersSheet({required this.query, required this.districts});

  final SearchQuery query;
  final List<CityOption> districts;

  @override
  State<_FiltersSheet> createState() => _FiltersSheetState();
}

class _FiltersSheetState extends State<_FiltersSheet> {
  late SearchQuery _draft = widget.query;

  /// Bumped on « Réinitialiser » so the typed fields start again empty.
  int _generation = 0;

  void _set(SearchQuery draft) => setState(() => _draft = draft);

  static List<T> _toggled<T>(List<T> list, T value) =>
      list.contains(value) ? (List.of(list)..remove(value)) : [...list, value];

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final more = [
      _draft.surfaceMin != null || _draft.surfaceMax != null,
      _draft.amenities.isNotEmpty,
      _draft.badges.isNotEmpty,
    ].where((on) => on).length;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
      child: ColoredBox(
        color: colors.background,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Header(
                count: _draft.activeFilterCount,
                onReset: () => setState(() {
                  _draft = _draft.clearedFilters();
                  _generation++;
                }),
              ),
              Flexible(
                child: ListView(
                  key: ValueKey(_generation),
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(Dimens.spacing, Dimens.spacing, Dimens.spacing, 0),
                  children: [
                    if (widget.districts.isNotEmpty)
                      _Card(
                        icon: LucideIcons.mapPin,
                        title: l10n.searchDistricts,
                        child: _Districts(
                          districts: widget.districts,
                          selected: _draft.districtIds,
                          onToggle: (id) => _set(_draft.copyWith(districtIds: _toggled(_draft.districtIds, id))),
                        ),
                      ),
                    _Card(
                      icon: LucideIcons.house,
                      title: l10n.annonceFormFieldType,
                      child: Wrap(
                        spacing: Dimens.spacingSm,
                        runSpacing: Dimens.spacingSm,
                        children: [
                          for (final type in PropertyType.values)
                            _Pill(
                              label: type.label(l10n),
                              icon: _typeIcon(type),
                              selected: _draft.propertyTypes.contains(type),
                              onTap: () => _set(_draft.copyWith(propertyTypes: _toggled(_draft.propertyTypes, type))),
                            ),
                        ],
                      ),
                    ),
                    _Card(
                      icon: LucideIcons.wallet,
                      title: l10n.searchBudget,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: Dimens.spacingSm,
                            runSpacing: Dimens.spacingSm,
                            children: [
                              for (final period in RentalPeriod.values)
                                _Pill(
                                  label: period.label(l10n),
                                  selected: _draft.rentalPeriods.contains(period),
                                  onTap: () =>
                                      _set(_draft.copyWith(rentalPeriods: _toggled(_draft.rentalPeriods, period))),
                                ),
                            ],
                          ),
                          const SizedBox(height: Dimens.spacingMd),
                          _RangeRow(
                            suffix: 'FCFA',
                            minValue: _draft.rentMin,
                            maxValue: _draft.rentMax,
                            onChanged: (min, max) => _set(
                              min == null && max == null
                                  ? _draft.copyWith(clearRent: true)
                                  : _draft.copyWith(rentMin: min, rentMax: max),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _Card(
                      icon: LucideIcons.doorOpen,
                      title: l10n.searchHousing,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FieldLabel(l10n.searchRoomsAtLeast),
                          _Segments<int?>(
                            value: _draft.roomsMin,
                            options: [
                              // « Peu importe » would not fit beside four numbers.
                              (null, l10n.searchCategoryAll),
                              for (final rooms in const [1, 2, 3, 4]) (rooms, l10n.searchRoomsPlus(rooms)),
                            ],
                            onChanged: (rooms) => _set(
                              rooms == null ? _draft.copyWith(clearRooms: true) : _draft.copyWith(roomsMin: rooms),
                            ),
                          ),
                          const SizedBox(height: Dimens.spacingMd),
                          // Three states, not two: « Peu importe » is the
                          // default and has to be reachable again.
                          _FieldLabel(l10n.annonceFormFieldFurnished),
                          _YesNo(
                            value: _draft.furnished,
                            onChanged: (value) => _set(
                              value == null
                                  ? _draft.copyWith(clearFurnished: true)
                                  : _draft.copyWith(furnished: value),
                            ),
                          ),
                          const SizedBox(height: Dimens.spacingMd),
                          _FieldLabel(l10n.searchAvailableNow),
                          _YesNo(
                            value: _draft.availableNow,
                            onChanged: (value) => _set(
                              value == null
                                  ? _draft.copyWith(clearAvailableNow: true)
                                  : _draft.copyWith(availableNow: value),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _MoreFilters(
                      count: more,
                      children: [
                        _FieldLabel(l10n.searchSurfaceRange),
                        _RangeRow(
                          suffix: 'm²',
                          minValue: _draft.surfaceMin,
                          maxValue: _draft.surfaceMax,
                          onChanged: (min, max) => _set(
                            min == null && max == null
                                ? _draft.copyWith(clearSurface: true)
                                : _draft.copyWith(surfaceMin: min, surfaceMax: max),
                          ),
                        ),
                        const SizedBox(height: Dimens.spacingMd),
                        // Doc 10 M04 listed both of these from the start; the
                        // endpoint only grew them on 2026-10-02.
                        _FieldLabel(l10n.searchAmenities),
                        Wrap(
                          spacing: Dimens.spacingSm,
                          runSpacing: Dimens.spacingSm,
                          children: [
                            for (final amenity in Amenity.values)
                              _Pill(
                                label: amenity.label(l10n),
                                selected: _draft.amenities.contains(amenity),
                                onTap: () => _set(_draft.copyWith(amenities: _toggled(_draft.amenities, amenity))),
                              ),
                          ],
                        ),
                        const SizedBox(height: Dimens.spacingMd),
                        _FieldLabel(l10n.searchBadges),
                        Wrap(
                          spacing: Dimens.spacingSm,
                          runSpacing: Dimens.spacingSm,
                          children: [
                            for (final badge in TrustBadge.values)
                              _Pill(
                                label: badge.label(l10n),
                                selected: _draft.badges.contains(badge),
                                onTap: () => _set(_draft.copyWith(badges: _toggled(_draft.badges, badge))),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: colors.surface,
                  border: Border(top: BorderSide(color: colors.border)),
                ),
                child: SafeArea(
                  top: false,
                  minimum: const EdgeInsets.all(Dimens.spacing),
                  child: Button.primary(
                    title: l10n.searchApply,
                    onPressed: () => Navigator.of(context).pop(_draft),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _typeIcon(PropertyType type) => switch (type) {
        PropertyType.apartment => LucideIcons.building,
        PropertyType.studio => LucideIcons.bedSingle,
        PropertyType.villa => LucideIcons.house,
        PropertyType.room => LucideIcons.bedDouble,
        PropertyType.office => LucideIcons.briefcase,
        PropertyType.commercialSpace => LucideIcons.store,
      };
}

/// The brand's green, the « M » texture faint on it, and what the draft
/// already asks for.
class _Header extends StatelessWidget {
  const _Header({required this.count, required this.onReset});

  final int count;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return ColoredBox(
      color: colors.primary,
      child: Stack(
        children: [
          Positioned.fill(child: MboaBrandPattern(color: colors.onBrand, scale: 0.6)),
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.spacingLg, Dimens.spacingSm, Dimens.spacingSm, Dimens.spacing),
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.onBrand.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(Dimens.radiusFull),
                  ),
                ),
                const SizedBox(height: Dimens.spacingMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.searchFilters, style: context.mboaText.h2.copyWith(color: colors.onBrand)),
                          Text(
                            l10n.searchFiltersActive(count),
                            style: context.mboaText.caption.copyWith(color: colors.onBrand.withValues(alpha: 0.85)),
                          ),
                        ],
                      ),
                    ),
                    if (count > 0)
                      TextButton.icon(
                        onPressed: onReset,
                        style: TextButton.styleFrom(foregroundColor: colors.onBrand),
                        icon: const Icon(LucideIcons.rotateCcw, size: Dimens.iconSm),
                        label: Text(l10n.searchClearFilters),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// One group of criteria: a white card, its icon and its name.
class _Card extends StatelessWidget {
  const _Card({required this.icon, required this.title, required this.child});

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingMd),
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusLg)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: icon, title: title),
          const SizedBox(height: Dimens.spacingMd),
          child,
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Row(
      children: [
        Icon(icon, size: Dimens.iconSm, color: colors.primary),
        const SizedBox(width: Dimens.spacingSm),
        Text(title, style: context.mboaText.label.copyWith(color: colors.primaryDark, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

/// Surface, amenities and badges — kept, counted, folded.
class _MoreFilters extends StatefulWidget {
  const _MoreFilters({required this.count, required this.children});

  /// How many of them are on: said on the folded card.
  final int count;
  final List<Widget> children;

  @override
  State<_MoreFilters> createState() => _MoreFiltersState();
}

class _MoreFiltersState extends State<_MoreFilters> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacing),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusLg)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _open = !_open),
            child: Padding(
              padding: const EdgeInsets.all(Dimens.spacing),
              child: Row(
                children: [
                  Expanded(child: _CardTitle(icon: LucideIcons.slidersHorizontal, title: l10n.searchMoreFilters)),
                  if (widget.count > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 2),
                      margin: const EdgeInsets.only(right: Dimens.spacingSm),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(Dimens.radiusFull),
                      ),
                      child: Text(
                        '${widget.count}',
                        style: context.mboaText.caption.copyWith(color: colors.onBrand, fontWeight: FontWeight.w700),
                      ),
                    ),
                  Icon(
                    _open ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                    size: Dimens.icon,
                    color: colors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (_open)
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimens.spacing, 0, Dimens.spacing, Dimens.spacing),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: widget.children),
            ),
        ],
      ),
    );
  }
}

/// Doc 10 M04 « Quartier(s) » — the city's, eight at first; a chosen one is
/// never folded away.
class _Districts extends StatefulWidget {
  const _Districts({required this.districts, required this.selected, required this.onToggle});

  final List<CityOption> districts;
  final List<String> selected;
  final ValueChanged<String> onToggle;

  static const int folded = 8;

  @override
  State<_Districts> createState() => _DistrictsState();
}

class _DistrictsState extends State<_Districts> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final all = widget.districts;
    final shown = [
      for (final (index, district) in all.indexed)
        if (_open || index < _Districts.folded || widget.selected.contains(district.id)) district,
    ];
    final hidden = all.length - shown.length;

    return Wrap(
      spacing: Dimens.spacingSm,
      runSpacing: Dimens.spacingSm,
      children: [
        for (final district in shown)
          _Pill(
            label: district.name,
            selected: widget.selected.contains(district.id),
            onTap: () => widget.onToggle(district.id),
          ),
        if (hidden > 0)
          _Pill(label: l10n.searchDistrictsMore(hidden), outlined: true, onTap: () => setState(() => _open = true))
        else if (_open && all.length > _Districts.folded)
          _Pill(label: l10n.searchDistrictsLess, outlined: true, onTap: () => setState(() => _open = false)),
      ],
    );
  }
}

/// A choice as a pill: the brand's green once chosen, a warm tint otherwise —
/// no border to weigh on a screen full of them.
class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.onTap, this.selected = false, this.icon, this.outlined = false});

  final String label;
  final VoidCallback onTap;
  final bool selected;
  final IconData? icon;

  /// « +7 », « Moins »: an action among choices, drawn apart from them.
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final foreground = selected ? colors.onBrand : (outlined ? colors.primary : colors.ink);

    return Semantics(
      selected: outlined ? null : selected,
      button: true,
      child: Material(
        color: selected ? colors.primary : (outlined ? colors.surface : colors.surfaceWarm),
        shape: StadiumBorder(side: outlined ? BorderSide(color: colors.primaryLight) : BorderSide.none),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingMd, vertical: Dimens.spacingSm),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 15, color: selected ? colors.onBrand : colors.primary),
                  const SizedBox(width: 6),
                ],
                Text(
                  label,
                  style: context.mboaText.caption.copyWith(
                    color: foreground,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
        child: Text(text, style: context.mboaText.caption.copyWith(color: context.mboaColors.textSecondary)),
      );
}

/// One of a few, side by side in one track — lighter than a row of chips.
class _Segments<T> extends StatelessWidget {
  const _Segments({required this.value, required this.options, required this.onChanged});

  final T value;
  final List<(T, String)> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: colors.surfaceWarm, borderRadius: BorderRadius.circular(Dimens.radiusFull)),
      child: Row(
        children: [
          for (final (option, label) in options)
            Expanded(
              child: Semantics(
                selected: option == value,
                button: true,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onChanged(option),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
                    decoration: BoxDecoration(
                      color: option == value ? colors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(Dimens.radiusFull),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.caption.copyWith(
                        color: option == value ? colors.onBrand : colors.textSecondary,
                        fontWeight: option == value ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// « Peu importe · Oui · Non ».
class _YesNo extends StatelessWidget {
  const _YesNo({required this.value, required this.onChanged});

  final bool? value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return _Segments<bool?>(
      value: value,
      options: [(null, l10n.searchAny), (true, l10n.commonYes), (false, l10n.commonNo)],
      onChanged: onChanged,
    );
  }
}

/// Owns its two controllers, seeded once from the draft: rebuilding them on
/// every keystroke would move the caret to the start of the field.
class _RangeRow extends StatefulWidget {
  const _RangeRow({required this.suffix, required this.minValue, required this.maxValue, required this.onChanged});

  final String suffix;
  final int? minValue;
  final int? maxValue;
  final void Function(int? min, int? max) onChanged;

  @override
  State<_RangeRow> createState() => _RangeRowState();
}

class _RangeRowState extends State<_RangeRow> {
  late final _min = TextEditingController(text: widget.minValue?.toString() ?? '');
  late final _max = TextEditingController(text: widget.maxValue?.toString() ?? '');

  @override
  void dispose() {
    _min.dispose();
    _max.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    Widget field(TextEditingController controller, String hint, void Function(String) onChanged) => TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          style: context.mboaText.label.copyWith(color: colors.ink),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: colors.surfaceWarm,
            hintText: hint,
            hintStyle: context.mboaText.body.copyWith(color: colors.textTertiary),
            suffixText: widget.suffix,
            suffixStyle: context.mboaText.caption.copyWith(color: colors.textSecondary),
            contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.spacing, vertical: Dimens.spacingMd),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.radius),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.radius),
              borderSide: BorderSide(color: colors.primary),
            ),
          ),
        );

    return Row(
      children: [
        Expanded(
          child: field(_min, l10n.searchMin, (value) => widget.onChanged(int.tryParse(value), int.tryParse(_max.text))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm),
          child: Text('–', style: context.mboaText.label.copyWith(color: colors.textTertiary)),
        ),
        Expanded(
          child: field(_max, l10n.searchMax, (value) => widget.onChanged(int.tryParse(_min.text), int.tryParse(value))),
        ),
      ],
    );
  }
}
