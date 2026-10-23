import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/favorites/bloc/favorites_bloc.dart';
import 'package:mboa_user/features/saved_searches/bloc/saved_searches_bloc.dart';
import 'package:mboa_user/features/saved_searches/models/saved_search.dart';
import 'package:mboa_user/features/search/bloc/search_bloc.dart';
import 'package:mboa_user/features/search/data/location_service.dart';
import 'package:mboa_user/features/search/data/search_repository.dart' show SearchSort;
import 'package:mboa_user/features/search/ui/search_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class MockSavedSearchesBloc extends MockBloc<SavedSearchesEvent, SavedSearchesState>
    implements SavedSearchesBloc {}

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
  late MockSavedSearchesBloc saved;

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

  setUpAll(() async {
    registerFallbackValue(const SavedSearchesRequested());
    await loadBrandFonts();
  });

  setUp(() {
    bloc = MockSearchBloc();
    favorites = MockFavoritesBloc();
    saved = MockSavedSearchesBloc();
    when(() => saved.state).thenReturn(const SavedSearchesReady(searches: []));
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
            BlocProvider<SavedSearchesBloc>.value(value: saved),
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
    expect(find.text('Tu cherches où ?'), findsOneWidget);
  });

  testWidgets('CE-M04-01 — an empty result offers to widen, not to retry',
      (tester) async {
    when(() => bloc.state)
        .thenReturn(const SearchReady(query: douala, isEmpty: true));
    await pump(tester);

    expect(find.text("Aucun bien ici pour l'instant"), findsOneWidget);
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
    expect(find.text("Aucun bien ici pour l'instant"), findsNothing);
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
      // One floating pill, saying where it leads — not a two-way switch.
      expect(find.text('Liste'), findsNothing);
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

  testWidgets('the search home, with places « à la une »', (tester) async {
    when(() => bloc.state).thenReturn(
      SearchReady(
        query: douala,
        hits: [
          const ListingHit(
            id: 'p-1',
            title: 'Appartement à louer — Deido',
            city: 'Douala',
            district: 'Deido',
            price: 110000,
            roomCount: 4,
            surfaceArea: 65,
            propertyType: PropertyType.apartment,
            tierRank: 3,
            badges: [TrustBadge.trustedProvider],
            rating: PropertyRatingSummary(average: 4.6, reviewCount: 12),
          ),
          const ResidenceHit(
            id: 'r-2',
            title: 'Résidence Akwa',
            city: 'Douala',
            district: 'Akwa',
            fromMonthlyRent: 60000,
            availableUnitCount: 3,
            tierRank: 2,
          ),
          listing('a'),
          residence,
        ],
      ),
    );
    await pump(tester);

    expect(find.text('À la une'), findsOneWidget);
    // The featured are not listed twice.
    expect(find.text('Appartement à louer — Deido'), findsOneWidget);
    await expectLater(find.byType(SearchPage), matchesGoldenFile('goldens/search_featured.png'));
  });

  group('RM-M04-08 — rating, distance, the nearest first', () {
    const here = UserPosition(4.05, 9.7);

    testWidgets('nearest first: one list, each place with how far and its rating', (tester) async {
      when(() => bloc.state).thenReturn(
        const SearchReady(
          query: douala,
          sort: SearchSort.distance,
          position: here,
          hits: [
            ListingHit(
              id: 'p-1',
              title: 'Appartement à louer — Deido',
              city: 'Douala',
              district: 'Deido',
              price: 110000,
              roomCount: 4,
              propertyType: PropertyType.apartment,
              // Pro+: « à la une » in relevance — not ahead of the nearest.
              tierRank: 3,
              distanceKm: 0.7,
              rating: PropertyRatingSummary(average: 4.2, reviewCount: 7),
            ),
            ResidenceHit(
              id: 'r-1',
              title: 'Résidence Akwa',
              city: 'Douala',
              district: 'Akwa',
              fromMonthlyRent: 45000,
              availableUnitCount: 3,
              distanceKm: 2.3,
              rating: PropertyRatingSummary(average: 3.9, reviewCount: 3),
            ),
            ListingHit(
              id: 'p-2',
              title: 'Studio — Bonapriso',
              city: 'Douala',
              district: 'Bonapriso',
              price: 80000,
              propertyType: PropertyType.studio,
              distanceKm: 4.1,
            ),
          ],
        ),
      );
      await pump(tester);

      expect(find.text('À la une'), findsNothing);
      expect(find.text('Les plus proches à Douala'), findsOneWidget);
      expect(find.text('Deido · à 0,7 km'), findsOneWidget);
      expect(find.text('4,2 (7)'), findsOneWidget);
      // No reviews, no rating — never « 0/5 ».
      expect(find.text('Bonapriso · à 4,1 km'), findsOneWidget);
      expect(find.textContaining('(0)'), findsNothing);
      await expectLater(find.byType(SearchPage), matchesGoldenFile('goldens/search_nearby.png'));
    });

    testWidgets('« Près de toi » asks for the order', (tester) async {
      await pump(tester);
      await tester.tap(find.text('Près de toi'));
      verify(() => bloc.add(const SearchSortChanged(SearchSort.distance))).called(1);
    });

    testWidgets('over cached results, no chips: they carry no distance', (tester) async {
      when(() => bloc.state).thenReturn(
        SearchReady(query: douala, hits: [listing('a')], cachedBecause: CacheReason.offline),
      );
      await pump(tester);
      expect(find.text('Près de toi'), findsNothing);
    });

    testWidgets('refused for good: a sheet with the one way to the settings', (tester) async {
      whenListen(
        bloc,
        Stream.value(
          SearchReady(query: douala, hits: [listing('a')], locationRefusal: LocationRefusal.deniedForever),
        ),
        initialState: SearchReady(query: douala, hits: [listing('a')]),
      );
      await pump(tester);

      expect(find.text('Autorise ta position'), findsOneWidget);
      await tester.tap(find.text('Ouvrir les réglages'));
      await tester.pumpAndSettle();
      verify(() => bloc.add(const SearchLocationSettingsRequested(LocationRefusal.deniedForever))).called(1);
    });

    testWidgets('refused this once: a word, no sheet', (tester) async {
      whenListen(
        bloc,
        Stream.value(SearchReady(query: douala, hits: [listing('a')], locationRefusal: LocationRefusal.denied)),
        initialState: SearchReady(query: douala, hits: [listing('a')]),
      );
      await pump(tester);

      expect(find.textContaining('Sans ta position'), findsOneWidget);
      expect(find.text('Ouvrir les réglages'), findsNothing);
      await tester.pumpAndSettle(const Duration(seconds: 6));
    });
  });

  testWidgets('the search screen', (tester) async {
    await pump(tester);

    await expectLater(
      find.byType(SearchPage),
      matchesGoldenFile('goldens/search.png'),
    );
  });

  group('saving the search (RM-M04-07)', () {
    testWidgets('signed in: a sheet, then the search is sent to be saved', (tester) async {
      getIt<SessionSnapshot>().markAuthenticated();
      await pump(tester);

      await tester.tap(find.byTooltip('Sauvegarder la recherche'));
      await tester.pumpAndSettle();
      expect(find.text('Sauvegarder cette recherche'), findsOneWidget);

      await tester.tap(find.text('Sauvegarder'));
      await tester.pumpAndSettle();

      // No name typed: the server names it after the filters.
      verify(() => saved.add(const SavedSearchSaveRequested(douala))).called(1);
    });

    testWidgets('three already saved: the limit is said before the sheet', (tester) async {
      getIt<SessionSnapshot>().markAuthenticated();
      when(() => saved.state).thenReturn(
        const SavedSearchesReady(
          searches: [
            SavedSearch(id: '1', name: 'Akwa'),
            SavedSearch(id: '2', name: 'Bonapriso'),
            SavedSearch(id: '3', name: 'Deido'),
          ],
        ),
      );
      await pump(tester);

      await tester.tap(find.byTooltip('Sauvegarder la recherche'));
      await tester.pumpAndSettle();

      expect(find.text('3 recherches au maximum'), findsOneWidget);
      expect(find.text('Sauvegarder cette recherche'), findsNothing);
      verifyNever(() => saved.add(any()));
    });

    testWidgets('a duplicate is said, once the server answers', (tester) async {
      // Fed after the screen is up: the listener reads a transition, from
      // saving to its outcome, and must be subscribed to see it.
      final states = StreamController<SavedSearchesState>.broadcast();
      addTearDown(states.close);
      whenListen(saved, states.stream, initialState: const SavedSearchesReady(searches: []));
      await pump(tester);

      states.add(const SavedSearchesReady(searches: [], isSaving: true));
      await tester.pump();
      states.add(const SavedSearchesReady(searches: [], outcome: SavedSearchOutcome.alreadySaved));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text('Cette recherche est déjà sauvegardée.'), findsOneWidget);
    });
  });
}
