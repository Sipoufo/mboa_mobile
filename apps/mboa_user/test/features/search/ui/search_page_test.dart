import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/search/bloc/search_bloc.dart';
import 'package:mboa_user/features/search/ui/search_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

/// The search screen (CDC M04) — the one screen that must work without an
/// account (CA-M04-04).
void main() {
  late MockSearchBloc bloc;

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
    when(() => bloc.state).thenReturn(
      SearchReady(query: douala, hits: [listing('a'), residence]),
    );
  });

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
        home: BlocProvider<SearchBloc>.value(
          value: bloc,
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
      SearchReady(query: douala, hits: [listing('a')], isOffline: true),
    );
    await pump(tester);

    // Showing stale results silently would be worse than showing none.
    expect(find.textContaining('hors ligne'), findsOneWidget);
  });

  testWidgets('CE-M04-03 — a server error is a retry, not an empty list',
      (tester) async {
    when(() => bloc.state).thenReturn(const SearchFailure(query: douala));
    await pump(tester);

    expect(find.text('Réessayer'), findsOneWidget);
    expect(find.text('Aucun bien trouvé'), findsNothing);
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

  testWidgets('the search screen', (tester) async {
    await pump(tester);

    await expectLater(
      find.byType(SearchPage),
      matchesGoldenFile('goldens/search.png'),
    );
  });
}
