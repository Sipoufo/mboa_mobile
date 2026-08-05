import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../bloc/annonce_form_bloc.dart';
import '../../data/location_capture.dart';
import '../../models/annonce_draft.dart';
import 'form_field_shell.dart';
import 'form_text_field.dart';

/// The design's single "Localisation" field, over the three values the API
/// actually requires: `districtId`, `latitude`, `longitude`.
///
/// Flow: GPS fix → reverse geocode to a city → preselect it in the catalogue →
/// load **that city's districts** → the prestataire picks one. The city is only
/// ever a means of narrowing the district list; the listing is filed against
/// the district.
///
/// Every automatic step is overridable, because the fix is the phone's
/// position, not the property's.
class LocationField extends StatefulWidget {
  const LocationField({super.key, required this.location});

  final ListingLocation? location;

  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  bool _busy = false;
  String? _status;

  LocationRepository get _locations => getIt<LocationRepository>();

  Future<void> _start() async {
    final l10n = I18n.of(context);

    setState(() {
      _busy = true;
      _status = l10n.annonceFormDetectingCity;
    });

    try {
      final fix = await const LocationCapture().current();
      if (!mounted) return;

      final cities = await _locations.cities();
      if (!mounted) return;

      final detected = _locations.matchCity(cities, fix.cityName);
      setState(() {
        _status = detected == null
            ? l10n.annonceFormCityNotDetected
            : l10n.annonceFormCityDetected(detected.name);
      });

      // Detected or not, the city is confirmable — geocoding is a hint.
      final city = await showCityPicker(context, repository: _locations);
      final chosen = city ?? detected;
      if (chosen == null || !mounted) return;

      await _pickDistrict(chosen, fix);
    } on LocationCaptureException catch (e) {
      if (!mounted) return;
      MboaToast.error(
        context: context,
        title: l10n.commonErrorTitle,
        description: switch (e.failure) {
          LocationFailure.denied ||
          LocationFailure.deniedForever =>
            l10n.annonceFormLocationDenied,
          LocationFailure.disabled ||
          LocationFailure.unavailable =>
            l10n.commonError,
        },
      );
    } catch (_) {
      if (mounted) {
        MboaToast.error(context: context, title: l10n.commonErrorTitle);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _pickDistrict(CityOption city, LocationFix fix) async {
    final l10n = I18n.of(context);
    final bloc = context.read<AnnonceFormBloc>();

    final districts = await _locations.districts(city.id);
    if (!mounted) return;

    if (districts.isEmpty) {
      // No district means no valid listing — say so rather than silently
      // filing it against the city, which the API would reject.
      MboaToast.warning(
        context: context,
        title: l10n.annonceFormNoDistricts,
      );
      return;
    }

    final district = await showOptionPicker(
      context,
      title: l10n.annonceFormPickDistrict,
      options: districts,
    );
    if (district == null || !mounted) return;

    bloc.add(
      AnnonceFormChanged(
        (draft) => draft.copyWith(
          location: ListingLocation(
            districtId: district.id,
            districtName: district.name,
            cityId: city.id,
            cityName: city.name,
            latitude: fix.latitude,
            longitude: fix.longitude,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final location = widget.location;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFieldShell(
          label: l10n.annonceFormFieldLocation,
          onTap: _busy ? null : _start,
          trailing: _busy
              ? const SizedBox(
                  width: Dimens.loaderSizeSm,
                  height: Dimens.loaderSizeSm,
                  child: Loader(),
                )
              : Icon(LucideIcons.mapPinHouse, color: colors.primary),
          child: Text(location?.label ?? l10n.homeLocationEmpty),
        ),
        if (_busy && _status != null) ...[
          const SizedBox(height: Dimens.spacingXs),
          Text(
            _status!,
            style: context.mboaText.micro.copyWith(color: colors.textSecondary),
          ),
        ],
        if (location != null) ...[
          const SizedBox(height: Dimens.spacingSm),
          Text(
            l10n.annonceFormLocationHint,
            style: context.mboaText.micro.copyWith(color: colors.textTertiary),
          ),
          const SizedBox(height: Dimens.spacingSm),
          FormTextField(
            label: l10n.annonceFormAddress,
            initialValue: location.exactAddress ?? '',
            onChanged: (value) => context.read<AnnonceFormBloc>().add(
                  AnnonceFormChanged(
                    (draft) => draft.copyWith(
                      location: location.copyWith(exactAddress: value),
                    ),
                  ),
                ),
          ),
        ],
      ],
    );
  }
}
