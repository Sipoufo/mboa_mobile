import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/agent_profile_bloc.dart';

/// Where the agent will work (RM-M15-04).
///
/// A zone is **either** a whole city **or** a single district — the backend
/// stores them that way and never as a pair. So each city offers "the whole
/// city" as one choice, with its districts underneath as alternatives; picking
/// the city clears the districts beneath it, because covering the city already
/// covers them and sending both would record the same ground twice.
@RoutePage()
class AgentZonesPage extends StatefulWidget {
  const AgentZonesPage({super.key});

  @override
  State<AgentZonesPage> createState() => _AgentZonesPageState();
}

class _AgentZonesPageState extends State<AgentZonesPage> {
  final _locations = getIt<LocationRepository>();

  List<CityOption> _cities = const [];
  final Map<String, List<CityOption>> _districts = {};
  final Set<String> _cityIds = {};
  final Set<String> _districtIds = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final state = context.read<AgentProfileBloc>().state;
    if (state is AgentProfileReady) {
      _cityIds.addAll(state.profile.cityZoneIds);
      _districtIds.addAll(state.profile.districtZoneIds);
    }

    final cities = await _locations.cities();
    // Districts are fetched per city so an already-chosen district can be shown
    // ticked without the agent having to expand its city first.
    for (final city in cities) {
      _districts[city.id] = await _locations.districts(city.id);
    }
    if (!mounted) return;
    setState(() {
      _cities = cities;
      _loading = false;
    });
  }

  bool get _hasSelection => _cityIds.isNotEmpty || _districtIds.isNotEmpty;

  void _toggleCity(CityOption city, bool selected) {
    setState(() {
      if (selected) {
        _cityIds.add(city.id);
        // The whole city already covers them.
        _districtIds.removeAll(
          (_districts[city.id] ?? const []).map((d) => d.id),
        );
      } else {
        _cityIds.remove(city.id);
      }
    });
  }

  void _toggleDistrict(String cityId, CityOption district, bool selected) {
    setState(() {
      if (selected) {
        _districtIds.add(district.id);
        // Picking a district is narrower than the whole city.
        _cityIds.remove(cityId);
      } else {
        _districtIds.remove(district.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.agentZonesTitle)),
      body: BlocConsumer<AgentProfileBloc, AgentProfileState>(
        listenWhen: (prev, curr) => curr is AgentProfileReady && curr.justSaved,
        listener: (context, state) => context.router.maybePop(),
        builder: (context, state) {
          if (_loading) return const Center(child: Loader());

          return ListView(
            padding: const EdgeInsets.all(Dimens.spacing),
            children: [
              Text(
                l10n.agentZonesHelp,
                style: context.mboaText.caption
                    .copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: Dimens.spacing),
              for (final city in _cities) ...[
                _CityGroup(
                  city: city,
                  districts: _districts[city.id] ?? const [],
                  wholeCitySelected: _cityIds.contains(city.id),
                  selectedDistrictIds: _districtIds,
                  onCityToggled: (value) => _toggleCity(city, value),
                  onDistrictToggled: (district, value) =>
                      _toggleDistrict(city.id, district, value),
                ),
                const SizedBox(height: Dimens.spacingSm),
              ],
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: BlocBuilder<AgentProfileBloc, AgentProfileState>(
            builder: (context, state) => Button.primary(
              title: l10n.profileSave,
              isLoading: state is AgentProfileReady && state.isSaving,
              // The backend refuses an update with both lists empty, so the
              // button explains rather than letting the call fail.
              onPressed: _hasSelection
                  ? () => context.read<AgentProfileBloc>().add(
                        AgentZonesSaved(
                          cityIds: _cityIds.toList(),
                          districtIds: _districtIds.toList(),
                        ),
                      )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _CityGroup extends StatelessWidget {
  const _CityGroup({
    required this.city,
    required this.districts,
    required this.wholeCitySelected,
    required this.selectedDistrictIds,
    required this.onCityToggled,
    required this.onDistrictToggled,
  });

  final CityOption city;
  final List<CityOption> districts;
  final bool wholeCitySelected;
  final Set<String> selectedDistrictIds;
  final ValueChanged<bool> onCityToggled;
  final void Function(CityOption district, bool selected) onDistrictToggled;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final chosen =
        districts.where((d) => selectedDistrictIds.contains(d.id)).length;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: ExpansionTile(
        shape: const Border(),
        title: Text(city.name, style: context.mboaText.label),
        subtitle: wholeCitySelected
            ? Text(
                l10n.agentZonesWholeCity,
                style: context.mboaText.caption.copyWith(color: colors.primary),
              )
            : chosen > 0
                ? Text(
                    l10n.agentZonesSubtitle(chosen),
                    style: context.mboaText.caption
                        .copyWith(color: colors.primary),
                  )
                : null,
        children: [
          CheckboxListTile(
            value: wholeCitySelected,
            onChanged: (value) => onCityToggled(value ?? false),
            title: Text(l10n.agentZonesWholeCity),
            dense: true,
          ),
          for (final district in districts)
            CheckboxListTile(
              value: selectedDistrictIds.contains(district.id),
              // Ticking the whole city already covers every district in it.
              onChanged: wholeCitySelected
                  ? null
                  : (value) => onDistrictToggled(district, value ?? false),
              title: Text(district.name),
              dense: true,
            ),
        ],
      ),
    );
  }
}
