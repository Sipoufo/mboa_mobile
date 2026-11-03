import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// §40 A — every country, Central Africa first, found by name or dial code.
/// Null if dismissed.
Future<MboaCountry?> showCountryPicker(BuildContext context, {MboaCountry? selected}) =>
    showModalBottomSheet<MboaCountry>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.mboaColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl))),
      builder: (_) => CountryPickerSheet(selected: selected),
    );

/// Public so it can be pumped on its own.
class CountryPickerSheet extends StatefulWidget {
  const CountryPickerSheet({super.key, this.selected});

  final MboaCountry? selected;

  @override
  State<CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<CountryPickerSheet> {
  final _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  /// Accents and case aside: « cote » finds « Côte d’Ivoire ».
  static String _fold(String text) => text
      .toLowerCase()
      .replaceAll(RegExp('[àâä]'), 'a')
      .replaceAll(RegExp('[éèêë]'), 'e')
      .replaceAll(RegExp('[îï]'), 'i')
      .replaceAll(RegExp('[ôö]'), 'o')
      .replaceAll(RegExp('[ùûü]'), 'u')
      .replaceAll('ç', 'c');

  bool _matches(MboaCountry country, Locale locale) {
    if (_query.isEmpty) return true;
    final query = _fold(_query.trim());
    return _fold(country.name(locale)).contains(query) ||
        country.dialCode.contains(query.replaceAll('+', '')) ||
        country.code.toLowerCase() == query;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context);

    final central = MboaCountry.centralAfrica.where((c) => _matches(c, locale)).toList();
    final others = MboaCountry.all.where((c) => !MboaCountry.centralAfrica.contains(c) && _matches(c, locale)).toList()
      ..sort((a, b) => _fold(a.name(locale)).compareTo(_fold(b.name(locale))));

    Widget row(MboaCountry country) => ListTile(
          leading: Text(country.flag, style: const TextStyle(fontSize: 24)),
          title: Text(country.name(locale), style: context.mboaText.label.copyWith(color: colors.ink)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(country.dialCode, style: context.mboaText.label.copyWith(color: colors.textSecondary)),
              if (country == widget.selected) ...[
                const SizedBox(width: Dimens.spacingSm),
                Icon(LucideIcons.check, size: Dimens.icon, color: colors.primary),
              ],
            ],
          ),
          onTap: () => Navigator.of(context).pop(country),
        );

    Widget heading(String text) => Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.spacing, Dimens.spacing, Dimens.spacing, Dimens.spacingXs),
          child: Text(text, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
        );

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.85,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimens.spacing, Dimens.spacing, Dimens.spacing, 0),
              child: Input(
                controller: _search,
                hintText: l10n.countryPickerSearch,
                prefixIcon: Icon(LucideIcons.search, color: colors.textSecondary),
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
                children: [
                  if (central.isNotEmpty) ...[heading(l10n.countryPickerCentralAfrica), for (final c in central) row(c)],
                  if (others.isNotEmpty) ...[heading(l10n.countryPickerAll), for (final c in others) row(c)],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
