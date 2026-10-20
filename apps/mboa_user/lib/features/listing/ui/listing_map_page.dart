import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../search/ui/widgets/search_map_view.dart';

/// Where a listing is, full screen — opened from the fiche's "Localisation"
/// card.
///
/// The same honesty as the search map (RM-M04-06): until contact the point is
/// fuzzed, so it is drawn as the 200 m disc it may be anywhere in, with the
/// notice; once the server says it is exact, as a point. The written address
/// waits for the signed contract either way (RM-M05-02).
@RoutePage()
class ListingMapPage extends StatefulWidget {
  const ListingMapPage({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.exact,
    this.title,
  });

  final double latitude;
  final double longitude;
  final bool exact;
  final String? title;

  @override
  State<ListingMapPage> createState() => _ListingMapPageState();
}

class _ListingMapPageState extends State<ListingMapPage> {
  static const _area = 'mboa-listing-area';
  static const _point = 'mboa-listing-point';

  MapLibreMapController? _controller;

  Future<void> _onStyleLoaded() async {
    final controller = _controller;
    if (controller == null) return;
    final colors = context.mboaColors;
    String hex(Color color) => '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

    if (!widget.exact) {
      await controller.addGeoJsonSource(_area, {
        'type': 'FeatureCollection',
        'features': [
          {
            'type': 'Feature',
            'properties': <String, dynamic>{},
            'geometry': {
              'type': 'Polygon',
              'coordinates': [
                SearchMapView.approxRing(
                  latitude: widget.latitude,
                  longitude: widget.longitude,
                  metres: SearchMapView.approxRadiusMetres,
                ),
              ],
            },
          },
        ],
      });
      await controller.addFillLayer(_area, '$_area-fill', FillLayerProperties(fillColor: hex(colors.primary), fillOpacity: 0.18));
    }
    await controller.addGeoJsonSource(_point, {
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'properties': <String, dynamic>{},
          'geometry': {
            'type': 'Point',
            'coordinates': [widget.longitude, widget.latitude],
          },
        },
      ],
    });
    await controller.addCircleLayer(
      _point,
      '$_point-circle',
      CircleLayerProperties(
        circleColor: hex(colors.primary),
        circleRadius: widget.exact ? 9 : 7,
        circleStrokeWidth: widget.exact ? 3 : 2,
        circleStrokeColor: hex(colors.onBrand),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: const MboaHeaderBackButton(),
        title: Text(widget.title ?? l10n.listingMapTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: Environment.hasMapTilerKey
          ? Stack(
              children: [
                Positioned.fill(
                  child: MapLibreMap(
                    styleString: Environment.mapStyleUrl,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.latitude, widget.longitude),
                      zoom: widget.exact ? 16 : 14.5,
                    ),
                    onMapCreated: (controller) => _controller = controller,
                    onStyleLoadedCallback: () => unawaited(_onStyleLoaded()),
                    compassEnabled: false,
                    tiltGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                  ),
                ),
                if (!widget.exact)
                  const Positioned(
                    top: Dimens.spacingSm,
                    left: Dimens.spacing,
                    right: Dimens.spacing,
                    child: MapApproxNotice(),
                  ),
              ],
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingXl),
                child: Text(
                  l10n.searchMapStyleFailedBody,
                  textAlign: TextAlign.center,
                  style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
                ),
              ),
            ),
    );
  }
}
