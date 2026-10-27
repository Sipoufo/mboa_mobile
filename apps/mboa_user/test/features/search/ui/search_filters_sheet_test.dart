import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/search/ui/widgets/search_filters_sheet.dart';

import '../../../_helpers/load_brand_fonts.dart';

/// The filters (CDC M04): lighter, nothing removed, the districts added.
void main() {
  const douala = SearchQuery(cityId: 'dla', cityName: 'Douala');
  const names = [
    'Akwa', 'Bassa', 'Bepanda', 'Bonaberi', 'Bonamoussadi', 'Bonanjo', 'Bonapriso', 'Deïdo', //
    'Kotto', 'Logbessou', 'Logpom', 'Makepe', 'Ndokotti', 'New Bell', 'PK14',
  ];
  final districts = [for (final name in names) CityOption(id: 'd-$name', name: name)];

  setUpAll(loadBrandFonts);

  /// Opens the sheet over a blank screen; what it hands back lands in [out].
  Future<void> open(
    WidgetTester tester, {
    SearchQuery query = douala,
    List<CityOption>? withDistricts,
    List<SearchQuery?>? out,
  }) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () async {
                  final result =
                      await showSearchFiltersSheet(context, query: query, districts: withDistricts ?? districts);
                  out?.add(result);
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  Future<void> apply(WidgetTester tester) async {
    await tester.tap(find.text('Voir les résultats'));
    await tester.pumpAndSettle();
  }

  Finder sheetList() => find.byType(Scrollable).first;

  testWidgets('Doc 10 M04 — a district chosen goes with the search', (tester) async {
    final out = <SearchQuery?>[];
    await open(tester, out: out);

    await tester.tap(find.text('Bonapriso'));
    await tester.pump();
    await apply(tester);

    expect(out.single!.districtIds, ['d-Bonapriso']);
    expect(out.single!.cityId, 'dla');
  });

  testWidgets('eight districts at first, the rest one tap away', (tester) async {
    await open(tester);

    expect(find.text('Deïdo'), findsOneWidget);
    expect(find.text('Kotto'), findsNothing);

    await tester.tap(find.text('+7'));
    await tester.pump();

    expect(find.text('PK14'), findsOneWidget);
    expect(find.text('Moins'), findsOneWidget);
  });

  testWidgets('a chosen district is never folded away', (tester) async {
    await open(tester, query: douala.copyWith(districtIds: ['d-PK14']));

    expect(find.text('PK14'), findsOneWidget);
    expect(find.text('+6'), findsOneWidget);
  });

  testWidgets('a city the catalogue has no districts for has no districts card', (tester) async {
    await open(tester, withDistricts: const []);

    expect(find.text('Quartiers'), findsNothing);
    expect(find.text('Type'), findsOneWidget);
  });

  testWidgets('the rooms are a segment: « 2+ » sets a minimum, « Tous » lifts it', (tester) async {
    final out = <SearchQuery?>[];
    await open(tester, out: out);
    await tester.scrollUntilVisible(find.text('2+'), 200, scrollable: sheetList());

    await tester.tap(find.text('2+'));
    await tester.pump();
    await apply(tester);
    expect(out.last!.roomsMin, 2);

    await open(tester, query: douala.copyWith(roomsMin: 2), out: out);
    await tester.scrollUntilVisible(find.text('2+'), 200, scrollable: sheetList());
    await tester.tap(find.text('Tous'));
    await tester.pump();
    await apply(tester);
    expect(out.last!.roomsMin, isNull);
  });

  testWidgets('nothing removed: surface, amenities and badges wait behind « Plus de filtres », counted',
      (tester) async {
    final out = <SearchQuery?>[];
    await open(tester, query: douala.copyWith(amenities: [Amenity.wifi]), out: out);
    await tester.scrollUntilVisible(find.text('Plus de filtres'), 200, scrollable: sheetList());

    expect(find.text('Climatisation'), findsNothing);
    // One of the folded criteria is on, and the folded card says so.
    expect(find.descendant(of: find.ancestor(of: find.text('Plus de filtres'), matching: find.byType(InkWell)), matching: find.text('1')), findsOneWidget);

    await tester.tap(find.text('Plus de filtres'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Climatisation'), 200, scrollable: sheetList());
    await tester.ensureVisible(find.text('Climatisation'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Climatisation'));
    await tester.pump();
    await apply(tester);

    expect(out.single!.amenities, [Amenity.wifi, Amenity.airConditioning]);
  });

  testWidgets('« Réinitialiser » keeps the city, drops the rest, and empties the typed rents', (tester) async {
    final out = <SearchQuery?>[];
    await open(
      tester,
      query: douala.copyWith(districtIds: ['d-Akwa'], rentMax: 150000, propertyTypes: [PropertyType.studio]),
      out: out,
    );
    expect(find.text('3 filtres actifs'), findsOneWidget);
    expect(find.text('150000'), findsOneWidget);

    await tester.tap(find.text('Réinitialiser'));
    await tester.pump();

    expect(find.text('Affine ta recherche'), findsOneWidget);
    expect(find.text('150000'), findsNothing);
    await apply(tester);
    expect(out.single, douala);
  });

  testWidgets('the sheet', (tester) async {
    await open(
      tester,
      query: douala.copyWith(districtIds: ['d-Akwa', 'd-Bonapriso'], propertyTypes: [PropertyType.studio], rentMax: 150000),
    );

    await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/search_filters.png'));
  });

  testWidgets('the sheet — the place, and « Plus de filtres » opened', (tester) async {
    await open(tester, query: douala.copyWith(roomsMin: 2, furnished: true, amenities: [Amenity.wifi]));
    await tester.scrollUntilVisible(find.text('Plus de filtres'), 200, scrollable: sheetList());
    await tester.tap(find.text('Plus de filtres'));
    await tester.pumpAndSettle();
    await tester.drag(sheetList(), const Offset(0, -260));
    await tester.pumpAndSettle();

    await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/search_filters_more.png'));
  });
}
