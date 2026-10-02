import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/favorites/bloc/favorites_bloc.dart';
import 'package:mboa_user/features/search/bloc/search_bloc.dart';
import 'package:mboa_user/features/search/ui/search_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

/// The search screen (CDC M04) — the one screen that must work without an
/// account (CA-M04-04).
/// The heart on a result card reads `FavoritesBloc`, which the **shell**
/// provides — the search screen is a tab under it. Pumping it here is what
/// says so; a test that provided nothing would pass while the real screen
/// threw, and a test that provided everything would hide the dependency.
void main() {
  late MockSearchBloc bloc;
  late MockFavoritesBloc favorites;

  const douala = SearchQuery(cityId: 'c-1', cityName: 'Douala');

  ListingHit listing(String id) => ListingHit(
        id: id,
        title: 'Studio meublé — Bonapriso',
        city: 'Douala',
        district: 'Bonapriso',
        price: 110000,
        roomCount: 2,
        surfaceArea: 45,
        propertyType: PropertyType.studio,
      );

  const residence = ResidenceHit(
    id: 'r-1',
    title: 'Résidence Deido',
    city: 'Douala',
    district: 'Deido',
    fromMonthlyRent: 45000,
    availableUnitCount: 6,
  );

  setUpAll(loadBrandFonts);

  setUp(() {
    bloc = MockSearchBloc();
    favorites = MockFavoritesBloc();
    when(() => favorites.state).thenReturn(const FavoritesInitial());
    if (!getIt.isRegistered<SessionSnapshot>()) {
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    }
    when(() => bloc.state).thenReturn(
      SearchReady(query: douala, hits: [listing('a'), residence]),
    );
  });

  tearDown(getIt.reset);

  Future<void> pump(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<SearchBloc>.value(value: bloc),
            BlocProvider<FavoritesBloc>.value(value: favorites),
          ],
          child: const SearchPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('a listing and a residence are not the same card',
      (tester) async {
    await pump(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('Studio meublé — Bonapriso'), findsOneWidget);
    // The residence announces what it is and what it starts at.
    expect(find.text('Résidence'), findsOneWidget);
    expect(find.text('6 unités disponibles'), findsOneWidget);
  });

  testWidgets('RM-M04-01 — no city, no results, and the screen says why',
      (tester) async {
    when(() => bloc.state).thenReturn(const SearchReady(query: SearchQuery()));
    await pump(tester);

    expect(find.text('Choisir une ville'), findsOneWidget);
    expect(find.text('Où cherchez-vous ?'), findsOneWidget);
  });

  testWidgets('CE-M04-01 — an empty result offers to widen, not to retry',
      (tester) async {
    when(() => bloc.state)
        .thenReturn(const SearchReady(query: douala, isEmpty: true));
    await pump(tester);

    expect(find.text('Aucun bien trouvé'), findsOneWidget);
    expect(find.text('Réinitialiser'), findsOneWidget);
  });

  testWidgets('CE-M04-02 — cached results are named as such', (tester) async {
    when(() => bloc.state).thenReturn(
      SearchReady(
        query: douala,
        hits: [listing('a')],
        cachedBecause: CacheReason.offline,
      ),
    );
    await pump(tester);

    // Showing stale results silently would be worse than showing none.
    expect(find.textContaining('hors ligne'), findsOneWidget);
    // Nothing to retry without a line — the request would fail the same way.
    expect(find.text('Réessayer'), findsNothing);
  });

  testWidgets('CE-M04-03 — a server that answered badly is not "offline"',
      (tester) async {
    when(() => bloc.state).thenReturn(
      SearchReady(
        query: douala,
        hits: [listing('a')],
        cachedBecause: CacheReason.unreachable,
      ),
    );
    await pump(tester);

    // Telling someone their connection is down while it plainly is not sends
    // them to fix the wrong thing. This one is worth retrying.
    expect(find.textContaining('hors ligne'), findsNothing);
    expect(find.textContaining('non actualisés'), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });

  testWidgets('CE-M04-03 — a server error is a retry, not an empty list',
      (tester) async {
    when(() => bloc.state).thenReturn(const SearchFailure(query: douala));
    await pump(tester);

    expect(find.text('Réessayer'), findsOneWidget);
    expect(find.text('Aucun bien trouvé'), findsNothing);
  });

  testWidgets('RM-M20 — a badged listing shows it on the card', (tester) async {
    when(() => bloc.state).thenReturn(
      const SearchReady(
        query: douala,
        hits: [
          ListingHit(
            id: 'a',
            title: 'Studio meublé — Bonapriso',
            city: 'Douala',
            district: 'Bonapriso',
            price: 110000,
            propertyType: PropertyType.studio,
            badges: [
              TrustBadge.trustedProvider,
              TrustBadge.verifiedPhotos,
            ],
          ),
        ],
      ),
    );
    await pump(tester);

    // Icons only on a card — four labels would wrap onto three lines and bury
    // the price. The words are on the fiche.
    expect(find.byTooltip('Prestataire de confiance'), findsOneWidget);
    expect(find.byTooltip('Photos vérifiées'), findsOneWidget);
  });

  testWidgets('the filters badge counts what is on', (tester) async {
    when(() => bloc.state).thenReturn(
      SearchReady(
        query: douala.copyWith(rentMax: 150000, roomsMin: 2, furnished: true),
      ),
    );
    await pump(tester);

    expect(find.text('3'), findsOneWidget);
  });

  group('the list/map toggle (CA-M04-03)', () {
    testWidgets('appears once there is something to show on a map',
        (tester) async {
      await pump(tester);

      expect(find.text('Carte'), findsOneWidget);
      expect(find.text('Liste'), findsOneWidget);
    });

    testWidgets('stays away until a city is chosen', (tester) async {
      when(() => bloc.state)
          .thenReturn(const SearchReady(query: SearchQuery()));
      await pump(tester);

      // RM-M04-01 — nothing has been searched yet, so an empty map would be a
      // second way of saying "choose a city", in a worse place.
      expect(find.text('Carte'), findsNothing);
    });

    testWidgets('switches the half on screen, and comes back', (tester) async {
      await pump(tester);
      expect(find.text('Studio meublé — Bonapriso'), findsOneWidget);

      await tester.tap(find.text('Carte'));
      await tester.pumpAndSettle();

      // A test build has no MapTiler key, so the map half is its own
      // "no key" screen rather than a map — which is the point: the toggle
      // swapped the halves, and neither of them is a blank square.
      // (`SearchMapView` takes `hasMapKey` so the other states can be reached;
      // here the real screen's default is what is being checked.)
      expect(find.text('Carte indisponible'), findsOneWidget);
      expect(find.text('Studio meublé — Bonapriso'), findsNothing);

      await tester.tap(find.text('Liste'));
      await tester.pumpAndSettle();

      expect(find.text('Studio meublé — Bonapriso'), findsOneWidget);
    });
  });

  testWidgets('the search screen', (tester) async {
    await pump(tester);

    await expectLater(
      find.byType(SearchPage),
      matchesGoldenFile('goldens/search.png'),
    );
  });
}
