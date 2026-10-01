import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../bloc/search_bloc.dart';
import 'search_hit_card.dart';

/// The map half of the search (CDC M04, CA-M04-03).
///
/// It draws **what the list already holds** and asks for nothing of its own:
/// `GET /search` has no bounding box and no "search this area", so a map with
/// its own query would be inventing a contract. Panning therefore moves the
/// camera, never the result set — the city picker and the filters are still
/// what decides what is on screen.
///
/// RM-M04-06 — a listing is a **disc, not a pin**. The API fuzzes positions by
/// about 200 m until contact is established, and a pin would draw a precision
/// neither it nor the app is allowed to claim. The disc is that uncertainty,
/// at true scale: it grows and shrinks with the zoom because it is metres.
class SearchMapView extends StatefulWidget {
  const SearchMapView({
    super.key,
    required this.state,
    required this.onOpen,
    this.hasMapKey,
  });

  final SearchReady state;
  final void Function(SearchHit hit) onOpen;

  /// Whether this build has a MapTiler key, injectable so the three
  /// "nothing to show" screens can each be reached in a test. Left null it
  /// reads the build, which is the only thing that decides it in production.
  final bool? hasMapKey;

  bool get _hasKey => hasMapKey ?? Environment.hasMapTilerKey;

  /// How far the server's fuzzing can have moved a listing (RM-M04-06).
  static const approxRadiusMetres = 200.0;

  /// Douala, where the camera sits until the hits say otherwise.
  static const fallbackCentre = LatLng(4.0511, 9.7679);

  /// Where the camera goes for a set of hits.
  ///
  /// **It frames the city, not the outliers.** A search is a city (RM-M04-01),
  /// so the camera is built from the hits within [_cityRadiusDegrees] of the
  /// median one and the rest are left off screen — still drawn, still there
  /// when the reader zooms out. The dev seed is the argument: three of
  /// Douala's twelve listings carry San Francisco's coordinates, captured from
  /// a simulator's default position, and a box around all twelve spans a third
  /// of the planet and centres on the open Atlantic. A tenant would have been
  /// shown the ocean because one record is wrong.
  ///
  /// The median rather than the mean, for the same reason: three bad points
  /// drag a mean across the world and leave a median where the city is.
  ///
  /// Bounds of zero width also send the camera somewhere arbitrary, so hits
  /// closer together than [_minSpanDegrees] get a point and a zoom instead.
  ///
  /// Separated from [_fit] because this part can be checked without a live
  /// map, and the camera cannot.
  @visibleForTesting
  static ({LatLng centre, double? zoom, LatLngBounds? bounds}) cameraFor(
    List<SearchHit> hits,
  ) {
    final median = LatLng(
      _median(hits.map((hit) => hit.latitude!).toList()),
      _median(hits.map((hit) => hit.longitude!).toList()),
    );

    final nearby = hits
        .where(
          (hit) =>
              (hit.latitude! - median.latitude).abs() < _cityRadiusDegrees &&
              (hit.longitude! - median.longitude).abs() < _cityRadiusDegrees,
        )
        .toList();

    final lats = nearby.map((hit) => hit.latitude!).toList();
    final lngs = nearby.map((hit) => hit.longitude!).toList();
    final south = lats.reduce(math.min);
    final north = lats.reduce(math.max);
    final west = lngs.reduce(math.min);
    final east = lngs.reduce(math.max);
    final centre = LatLng((south + north) / 2, (west + east) / 2);

    if (north - south < _minSpanDegrees && east - west < _minSpanDegrees) {
      return (centre: centre, zoom: 15, bounds: null);
    }
    return (
      centre: centre,
      zoom: null,
      bounds: LatLngBounds(
        southwest: LatLng(south, west),
        northeast: LatLng(north, east),
      ),
    );
  }

  /// Smallest span that still makes a box — about 220 m.
  static const _minSpanDegrees = 0.002;

  /// How far from the middle of the results a hit can be and still frame the
  /// view: about 55 km, which holds Douala and Yaoundé whole.
  static const _cityRadiusDegrees = 0.5;

  static double _median(List<double> values) {
    final sorted = [...values]..sort();
    final middle = sorted.length ~/ 2;
    return sorted.length.isOdd
        ? sorted[middle]
        : (sorted[middle - 1] + sorted[middle]) / 2;
  }

  /// A closed ring of `[lng, lat]` pairs [metres] away from the centre.
  ///
  /// Drawn as a polygon rather than a styled circle because a circle layer's
  /// radius is in screen pixels: it would mean 200 m at one zoom level and
  /// something else at every other. Longitude is divided by cos(latitude) —
  /// near the equator that is close to 1, which is why the discs look round
  /// over Douala and would not over Oslo.
  static List<List<double>> approxRing({
    required double latitude,
    required double longitude,
    required double metres,
    int segments = 48,
  }) {
    const earthRadius = 6378137.0;
    final dLat = metres / earthRadius * 180 / math.pi;
    final dLng = dLat / math.cos(latitude * math.pi / 180);

    return [
      for (var i = 0; i <= segments; i++)
        if (i * 2 * math.pi / segments case final angle)
          [
            longitude + dLng * math.cos(angle),
            latitude + dLat * math.sin(angle),
          ],
    ];
  }

  @override
  State<SearchMapView> createState() => _SearchMapViewState();
}

class _SearchMapViewState extends State<SearchMapView> {
  static const _areaSource = 'mboa-hit-areas';
  static const _pointSource = 'mboa-hit-points';
  static const _areaLayer = 'mboa-hit-areas-fill';
  static const _pointLayer = 'mboa-hit-points-circle';

  MapLibreMapController? _controller;
  SearchHit? _selected;

  /// Only the hits that can be drawn. A listing with no coordinates is not an
  /// error — it is simply not on the map, and the list still has it.
  List<SearchHit> get _placeable =>
      widget.state.hits.where((hit) => hit.hasPosition).toList();

  @override
  void didUpdateWidget(SearchMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // A new page, a new filter, a new city: the same source, new data.
    if (widget.state.hits != oldWidget.state.hits) {
      unawaited(_pushData(recentre: widget.state.query != oldWidget.state.query));
      final selected = _selected;
      if (selected != null && !widget.state.hits.contains(selected)) {
        setState(() => _selected = null);
      }
    }
  }

  Future<void> _onStyleLoaded() async {
    final controller = _controller;
    if (controller == null) return;
    // Read before the first await: the layers are styled from the theme, and
    // the context must not be touched once the platform calls begin.
    final colors = context.mboaColors;

    await controller.addGeoJsonSource(_areaSource, _emptyCollection);
    await controller.addGeoJsonSource(
      _pointSource,
      _emptyCollection,
      // Web needs the id promoted out of the properties; iOS and Android read
      // the top-level one. Both are written, so both platforms tap correctly.
      promoteId: 'id',
    );

    await controller.addFillLayer(
      _areaSource,
      _areaLayer,
      FillLayerProperties(
        fillColor: _tierColourExpression(colors),
        fillOpacity: 0.18,
      ),
    );
    await controller.addCircleLayer(
      _pointSource,
      _pointLayer,
      CircleLayerProperties(
        circleColor: _tierColourExpression(colors),
        circleRadius: 7,
        circleStrokeWidth: 2,
        circleStrokeColor: _hex(colors.onBrand),
      ),
    );

    controller.onFeatureTapped.add(_onFeatureTapped);
    await _pushData(recentre: true);
  }

  void _onFeatureTapped(
    math.Point<double> point,
    LatLng coordinates,
    String id,
    String layerId,
    Annotation? annotation,
  ) {
    final hit = _placeable.where((candidate) => candidate.id == id).firstOrNull;
    if (hit == null) return;
    setState(() => _selected = hit);
  }

  Future<void> _pushData({bool recentre = false}) async {
    final controller = _controller;
    if (controller == null) return;
    final hits = _placeable;

    await controller.setGeoJsonSource(_pointSource, _points(hits));
    await controller.setGeoJsonSource(_areaSource, _areas(hits));
    if (recentre && hits.isNotEmpty) await _fit(controller, hits);
  }

  Future<void> _fit(MapLibreMapController controller, List<SearchHit> hits) {
    final camera = SearchMapView.cameraFor(hits);
    final bounds = camera.bounds;

    return controller.animateCamera(
      bounds == null
          ? CameraUpdate.newLatLngZoom(camera.centre, camera.zoom!)
          : CameraUpdate.newLatLngBounds(
              bounds,
              left: 48,
              right: 48,
              top: 48,
              // Room for the card a tapped marker opens.
              bottom: 160,
            ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    // Three ways a map can have nothing to show, and each says which one it
    // is: a blank grey square would read as a bug in all three.
    if (!widget._hasKey) {
      return _MapNotice(
        icon: LucideIcons.mapPinOff,
        title: l10n.searchMapNoKeyTitle,
        body: l10n.searchMapNoKeyBody,
      );
    }
    if (widget.state.isOffline) {
      // CE-M04-02 — the cached results survive a lost line; the tiles do not.
      return _MapNotice(
        icon: LucideIcons.wifiOff,
        title: l10n.searchMapOfflineTitle,
        body: l10n.searchMapOfflineBody,
      );
    }
    if (_placeable.isEmpty) {
      return _MapNotice(
        icon: LucideIcons.mapPinOff,
        title: l10n.searchMapNoPositionTitle,
        body: l10n.searchMapNoPositionBody,
      );
    }

    final selected = _selected;

    return Stack(
      children: [
        Positioned.fill(
          child: MapLibreMap(
            styleString: Environment.mapStyleUrl,
            initialCameraPosition: CameraPosition(
              target: _placeable.first.hasPosition
                  ? LatLng(
                      _placeable.first.latitude!,
                      _placeable.first.longitude!,
                    )
                  : SearchMapView.fallbackCentre,
              zoom: 12,
            ),
            onMapCreated: (controller) => _controller = controller,
            onStyleLoadedCallback: _onStyleLoaded,
            onMapClick: (_, _) {
              if (_selected != null) setState(() => _selected = null);
            },
            compassEnabled: false,
            tiltGesturesEnabled: false,
            rotateGesturesEnabled: false,
          ),
        ),
        const Positioned(
          top: Dimens.spacingSm,
          left: Dimens.spacing,
          right: Dimens.spacing,
          child: MapApproxNotice(),
        ),
        if (selected != null)
          Positioned(
            left: Dimens.spacing,
            right: Dimens.spacing,
            bottom: Dimens.spacing,
            child: SearchHitCard.compact(
              hit: selected,
              onTap: () => widget.onOpen(selected),
            ),
          ),
      ],
    );
  }

  // --- GeoJSON ------------------------------------------------------------

  static const _emptyCollection = <String, dynamic>{
    'type': 'FeatureCollection',
    'features': <Map<String, dynamic>>[],
  };

  Map<String, dynamic> _points(List<SearchHit> hits) => {
        'type': 'FeatureCollection',
        'features': [
          for (final hit in hits)
            {
              'type': 'Feature',
              'id': hit.id,
              'properties': {'id': hit.id, 'tier': hit.tierRank ?? 0},
              'geometry': {
                'type': 'Point',
                'coordinates': [hit.longitude, hit.latitude],
              },
            },
        ],
      };

  Map<String, dynamic> _areas(List<SearchHit> hits) => {
        'type': 'FeatureCollection',
        'features': [
          for (final hit in hits)
            {
              'type': 'Feature',
              'id': hit.id,
              'properties': {'id': hit.id, 'tier': hit.tierRank ?? 0},
              'geometry': {
                'type': 'Polygon',
                'coordinates': [
                  SearchMapView.approxRing(
                    latitude: hit.latitude!,
                    longitude: hit.longitude!,
                    metres: SearchMapView.approxRadiusMetres,
                  ),
                ],
              },
            },
        ],
      };

  /// Pro+ → Pro → Basic+ → Gratuit, the visibility ladder of CA-M04-02, read
  /// straight off `tierRank` (3 → 0, the order of the API's own enum).
  static List<dynamic> _tierColourExpression(MboaColorScheme colors) => [
        'match',
        ['get', 'tier'],
        3, _hex(colors.action),
        2, _hex(colors.primary),
        1, _hex(colors.info),
        _hex(colors.textSecondary),
      ];

  static String _hex(Color color) =>
      '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';
}

/// RM-M04-06, said once and kept on screen: nobody should read a disc as an
/// address.
///
/// Public so the rule can be tested. The map it sits on is a platform view and
/// cannot be mounted in a widget test — `MapLibreMap` throws on dispose with no
/// channel — so the wording is pinned here, on its own.
class MapApproxNotice extends StatelessWidget {
  const MapApproxNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Align(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.spacing,
          vertical: Dimens.spacingXs,
        ),
        decoration: BoxDecoration(
          color: colors.surface.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(Dimens.radiusLg),
          border: Border.all(color: colors.border),
        ),
        child: Text(
          I18n.of(context).searchMapApprox,
          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
        ),
      ),
    );
  }
}

/// Why the map is not there, in the words of the reason it is not there.
class _MapNotice extends StatelessWidget {
  const _MapNotice({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: Dimens.iconLg, color: colors.textTertiary),
            const SizedBox(height: Dimens.spacing),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              body,
              textAlign: TextAlign.center,
              style: context.mboaText.body
                  .copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
