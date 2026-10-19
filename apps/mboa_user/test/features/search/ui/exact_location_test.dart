import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/search/ui/widgets/search_map_view.dart';

/// RM-M04-06 — a disc until contact, a pin after: the server says which.
void main() {
  const fuzzy = ListingHit(id: 'a-1', latitude: 4.05, longitude: 9.70);
  const exact = ListingHit(id: 'a-2', latitude: 4.06, longitude: 9.71, exactLocation: true);

  test('the server\'s verdict is read from the search card, and absent means fuzzy', () {
    final contacted = SearchHit.fromResponse(
      SearchResult(
        (b) => b
          ..type = SearchResultTypeEnum.LISTING
          ..listing.id = 'a-2'
          ..listing.exactLocation = true,
      ),
    );
    final stranger = SearchHit.fromResponse(
      SearchResult(
        (b) => b
          ..type = SearchResultTypeEnum.LISTING
          ..listing.id = 'a-1',
      ),
    );

    expect(contacted?.exactLocation, isTrue);
    expect(stranger?.exactLocation, isFalse);
  });

  test('every hit is a point, and each says whether it is exact', () {
    final features = SearchMapView.pointFeatures(const [fuzzy, exact])['features'] as List;

    expect(features.length, 2);
    expect([for (final f in features) (f as Map)['properties']['exact']], [false, true]);
  });

  test('only an approximate point gets a 200 m disc', () {
    final features = SearchMapView.areaFeatures(const [fuzzy, exact])['features'] as List;

    expect([for (final f in features) (f as Map)['id']], ['a-1']);
  });

  testWidgets('with some points exact, the notice says which are not', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: const Scaffold(body: MapApproxNotice(someExact: true)),
      ),
    );

    expect(find.textContaining('sauf pour les biens que tu as contactés'), findsOneWidget);
  });
}
