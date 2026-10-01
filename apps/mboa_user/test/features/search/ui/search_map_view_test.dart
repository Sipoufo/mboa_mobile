import 'dart:math' as math;

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/favorites/bloc/favorites_bloc.dart';
import 'package:mboa_user/features/search/bloc/search_bloc.dart';
import 'package:mboa_user/features/search/ui/widgets/search_hit_card.dart';
import 'package:mboa_user/features/search/ui/widgets/search_map_view.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

/// The map half of the search (CDC M04).
///
/// The map itself is a platform view and renders nothing in a widget test, so
/// what is pinned here is everything around it: the geometry of RM-M04-06, and
/// the three ways the map can have nothing to show. Each of those three is a
/// screen a tenant can actually land on — a build with no key, a lost line, a
/// city whose listings carry no position — and all three used to be the same
/// grey square.
void main() {
  late MockFavoritesBloc favorites;

  ListingHit hit(String id, {double? lat, double? lng, int? tier}) => ListingHit(
        id: id,
        title: 'Studio $id',
        city: 'Douala',
        district: 'Akwa',
        price: 110000,
        rentalPeriod: RentalPeriod.month,
        tierRank: tier,
        latitude: lat,
        longitude: lng,
      );

  SearchReady ready({
    required List<SearchHit> hits,
    bool isOffline = false,
  }) =>
      SearchReady(
        query: const SearchQuery(cityId: 'c-1', cityName: 'Douala'),
        hits: hits,
        isOffline: isOffline,
      );

  setUpAll(loadBrandFonts);

  setUp(() {
    favorites = MockFavoritesBloc();
    when(() => favorites.state).thenReturn(const FavoritesInitial());
  });

  Future<void> pump(
    WidgetTester tester,
    SearchReady state, {
    bool hasMapKey = true,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<FavoritesBloc>.value(
          value: favorites,
          child: Scaffold(
            body: SearchMapView(
              state: state,
              onOpen: (_) {},
              hasMapKey: hasMapKey,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('RM-M04-06 — a 200 m disc, not a pin', () {
    test('the ring is 200 m from its centre, all the way round', () {
      const centre = (lat: 4.0511, lng: 9.7679); // Douala.
      final ring = _SearchMapViewProbe.ring(centre.lat, centre.lng);

      // Every vertex, not just one: a ring that is right at the poles of its
      // own parametrisation and wrong on the diagonals would still look round.
      for (final point in ring) {
        final metres = _haversine(centre.lat, centre.lng, point[1], point[0]);
        expect(metres, closeTo(200, 1));
      }
    });

    test('the ring closes on itself', () {
      final ring = _SearchMapViewProbe.ring(4.0511, 9.7679);

      // An unclosed polygon is undefined behaviour in GeoJSON, and renderers
      // disagree about what to do with it.
      expect(ring.first[0], closeTo(ring.last[0], 1e-9));
      expect(ring.first[1], closeTo(ring.last[1], 1e-9));
    });

    testWidgets('and the screen says so in words', (tester) async {
      // Pumped on its own: the map underneath it is a platform view, and
      // `MapLibreMap` throws on dispose in a widget test, so a map with hits
      // cannot be mounted here at all.
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: const Scaffold(body: MapApproxNotice()),
        ),
      );

      // The disc is only half of the rule. A reader who takes it for an
      // address has been misled by a map that was technically correct.
      expect(find.textContaining('approximatives'), findsOneWidget);
    });
  });

  group('where the camera goes', () {
    test('results spread across a city get a box around them', () {
      final camera = SearchMapView.cameraFor([
        hit('a-1', lat: 4.01, lng: 9.70),
        hit('a-2', lat: 4.09, lng: 9.80),
      ]);

      expect(camera.bounds?.southwest.latitude, closeTo(4.01, 1e-9));
      expect(camera.bounds?.northeast.longitude, closeTo(9.80, 1e-9));
      expect(camera.zoom, isNull);
    });

    test('results on top of each other get a point, not a box', () {
      // A box of zero width sends MapLibre's camera somewhere arbitrary, and a
      // city with one listing in it is an ordinary Tuesday here.
      final camera = SearchMapView.cameraFor([
        hit('a-1', lat: 4.050018, lng: 9.700023),
        hit('a-2', lat: 4.050158, lng: 9.699099),
      ]);

      expect(camera.bounds, isNull);
      expect(camera.zoom, 15);
      expect(camera.centre.latitude, closeTo(4.05009, 1e-4));
    });

    test('one listing on the wrong continent does not frame the map', () {
      // Not hypothetical: three of the dev seed's twelve Douala listings carry
      // San Francisco's coordinates, captured from a simulator's default
      // position. A box around all of them spans a third of the planet and
      // opens on the open Atlantic — which is exactly what the app did.
      final camera = SearchMapView.cameraFor([
        hit('a-1', lat: 4.0497, lng: 9.6988),
        hit('a-2', lat: 4.0501, lng: 9.7010),
        hit('a-3', lat: 4.0506, lng: 9.7003),
        hit('bad', lat: 37.7852, lng: -122.4069),
      ]);

      // Douala, to within a street. The bad listing is still drawn — it is
      // simply not what the camera is built from.
      expect(camera.centre.latitude, closeTo(4.05, 1e-2));
      expect(camera.centre.longitude, closeTo(9.70, 1e-2));
    });

    test('a single result is a point too', () {
      final camera = SearchMapView.cameraFor([hit('a-1', lat: 4.05, lng: 9.76)]);

      expect(camera.bounds, isNull);
      expect(camera.centre.latitude, closeTo(4.05, 1e-9));
    });
  });

  testWidgets('the card over a map is the compact one', (tester) async {
    // The full card is two thirds of a phone screen; over a map that is most
    // of the map, and the reader loses what they switched views for.
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<FavoritesBloc>.value(
          value: favorites,
          child: Scaffold(
            body: SearchHitCard.compact(hit: hit('a-1', lat: 4.05, lng: 9.76)),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final height = tester.getSize(find.byType(SearchHitCard)).height;
    expect(height, lessThan(120));
    // And it still says the three things that decide whether to tap.
    expect(find.textContaining('XAF'), findsOneWidget);
    expect(find.text('Studio a-1'), findsOneWidget);
    expect(find.text('Akwa, Douala'), findsOneWidget);
  });

  group('a map with nothing to show says which nothing', () {
    testWidgets('no results carry a position', (tester) async {
      await pump(tester, ready(hits: [hit('a-1'), hit('a-2')]));

      expect(find.text('Aucun bien à placer'), findsOneWidget);
      // The list still has them, and the notice says so rather than implying
      // the search failed.
      expect(find.textContaining('en liste'), findsOneWidget);
    });

    testWidgets('CE-M04-02 — offline, where tiles are not cached',
        (tester) async {
      await pump(
        tester,
        ready(hits: [hit('a-1', lat: 4.05, lng: 9.76)], isOffline: true),
      );

      // Cached *results* survive a lost line; the map's tiles do not, and
      // pretending otherwise would hang on a blank canvas.
      expect(find.text('Carte indisponible hors ligne'), findsOneWidget);
    });

    testWidgets('a build with no MapTiler key', (tester) async {
      // The state of every checkout without env/dev.json — including CI, which
      // is why it has to be a screen and not a crash.
      expect(Environment.hasMapTilerKey, isFalse);
      await pump(
        tester,
        ready(hits: [hit('a-1', lat: 4.05, lng: 9.76)]),
        hasMapKey: false,
      );

      expect(find.text('Carte indisponible'), findsOneWidget);
    });
  });
}

/// The ring maths is static and pure on purpose — it is the one piece of this
/// screen that can be checked without a platform view.
class _SearchMapViewProbe {
  static List<List<double>> ring(double lat, double lng) =>
      SearchMapView.approxRing(
        latitude: lat,
        longitude: lng,
        metres: SearchMapView.approxRadiusMetres,
      );
}

/// Great-circle distance in metres — the independent check on the ring.
double _haversine(double lat1, double lng1, double lat2, double lng2) {
  const earthRadius = 6371008.8;
  double radians(double degrees) => degrees * math.pi / 180;

  final dLat = radians(lat2 - lat1);
  final dLng = radians(lng2 - lng1);
  final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(radians(lat1)) *
          math.cos(radians(lat2)) *
          math.sin(dLng / 2) *
          math.sin(dLng / 2);
  return earthRadius * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
}
