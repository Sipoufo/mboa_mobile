import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../data/location_repository.dart';
import '../models/city_option.dart';

/// Opens a searchable city picker and resolves to the chosen [CityOption]
/// (or null if dismissed).
Future<CityOption?> showCityPicker(
  BuildContext context, {
  required LocationRepository repository,
}) {
  return showModalBottomSheet<CityOption>(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.mboaColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
    ),
    builder: (context) => _CityPickerSheet(repository: repository),
  );
}

class _CityPickerSheet extends StatefulWidget {
  const _CityPickerSheet({required this.repository});

  final LocationRepository repository;

  @override
  State<_CityPickerSheet> createState() => _CityPickerSheetState();
}

class _CityPickerSheetState extends State<_CityPickerSheet> {
  final _searchController = TextEditingController();
  late Future<List<CityOption>> _future;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _future = widget.repository.cities();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: FractionallySizedBox(
        heightFactor: 0.85,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingLg),
            child: Column(
              children: [
                Text(l10n.cityPickerTitle, style: context.mboaText.h3.copyWith(color: colors.primary)),
                const SizedBox(height: Dimens.spacing),
                Input(
                  controller: _searchController,
                  hintText: l10n.cityPickerSearchHint,
                  prefixIcon: Icon(LucideIcons.search, color: colors.textSecondary, size: Dimens.icon),
                  onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
                ),
                const SizedBox(height: Dimens.spacing),
                Expanded(
                  child: FutureBuilder<List<CityOption>>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Loader();
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text(l10n.commonError, style: context.mboaText.body));
                      }
                      final cities = (snapshot.data ?? const [])
                          .where((c) => _query.isEmpty || c.name.toLowerCase().contains(_query))
                          .toList(growable: false);
                      if (cities.isEmpty) {
                        return Center(child: Text(l10n.cityPickerEmpty, style: context.mboaText.body));
                      }
                      return ListView.separated(
                        itemCount: cities.length,
                        separatorBuilder: (_, _) => Divider(color: colors.border, height: 1),
                        itemBuilder: (context, i) {
                          final city = cities[i];
                          return ListTile(
                            title: Text(city.name, style: context.mboaText.bodyLarge),
                            onTap: () => Navigator.of(context).pop(city),
                          );
                        },
                      );
                    },
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
