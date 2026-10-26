import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/listing/bloc/residence_detail_bloc.dart';
import 'package:mboa_user/features/listing/ui/residence_detail_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockResidenceDetailBloc extends MockBloc<ResidenceDetailEvent, ResidenceDetailState>
    implements ResidenceDetailBloc {}

/// A residence's public fiche (M10bis, §36).
void main() {
  late MockResidenceDetailBloc bloc;

  ListingUnit room(int n, {int price = 35000}) => ListingUnit(
        id: 'u-$n',
        title: 'Chambre $n',
        propertyType: PropertyType.room,
        price: price + n * 1000,
        rentalPeriod: RentalPeriod.month,
        surfaceArea: 14,
      );

  ResidenceDetail residence({
    PropertyRatingSummary rating = const PropertyRatingSummary(average: 4.5, reviewCount: 2),
    List<ListingUnit>? units,
    double? latitude = 4.09,
  }) =>
      ResidenceDetail(
        id: 'r-1',
        name: 'Cité blanche',
        city: 'Douala',
        district: 'Bonamoussadi',
        description: 'Au calme, gardiennage jour et nuit, forage.',
        latitude: latitude,
        longitude: 9.74,
        units: units ??
            [
              for (var n = 1; n <= 5; n++) room(n),
              const ListingUnit(
                id: 's-1',
                title: 'Studio A',
                propertyType: PropertyType.studio,
                price: 90000,
                rentalPeriod: RentalPeriod.month,
                roomCount: 1,
                surfaceArea: 28,
              ),
            ],
        provider: const ProviderSummary(
          displayName: 'Angel Proprio',
          type: PrestataireKind.promoteur,
          badges: [TrustBadge.trustedProvider, TrustBadge.verifiedPhotos],
        ),
        rating: rating,
      );

  final reviews = [
    ReviewEntry(
      id: 'v-1',
      kind: ReviewKind.visit,
      annonceId: 'u-4',
      authorName: 'Awa Nkeng',
      rating: 5,
      comment: 'Chambre propre, gardien aimable.',
      publishedAt: DateTime(2026, 10, 2),
    ),
    ReviewEntry(
      id: 'v-2',
      kind: ReviewKind.resident,
      // A unit no longer live: it still counts, and has no name to give.
      annonceId: 'gone',
      authorName: 'Ndongo Bile',
      rating: 4,
      residenceDuration: 8,
      residencePeriod: RentalPeriod.month,
      publishedAt: DateTime(2026, 9, 20),
    ),
  ];

  setUpAll(loadBrandFonts);

  setUp(() {
    bloc = MockResidenceDetailBloc();
    when(() => bloc.state).thenReturn(ResidenceDetailReady(detail: residence(), reviews: reviews));
    if (!getIt.isRegistered<SessionSnapshot>()) {
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    }
  });

  tearDown(getIt.reset);

  Finder pageList() =>
      find.descendant(of: find.byType(ResidenceDetailPage), matching: find.byType(Scrollable)).first;

  Future<void> scrollTo(WidgetTester tester, Finder finder) =>
      tester.scrollUntilVisible(finder, 200, scrollable: pageList());

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
        home: BlocProvider<ResidenceDetailBloc>.value(
          value: bloc,
          child: const ResidenceDetailPage(id: 'r-1'),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the photo carries the name, the place and what it starts at', (tester) async {
    await pump(tester);

    expect(find.text('Cité blanche'), findsOneWidget);
    expect(find.text('Bonamoussadi, Douala'), findsOneWidget);
    // The cheapest room: 35 000 + 1 000.
    expect(find.textContaining('À partir de 36'), findsWidgets);
  });

  testWidgets('§36 — who lets it, with the residence\'s badges', (tester) async {
    await pump(tester);
    await scrollTo(tester, find.text('Angel Proprio'));

    expect(find.text('Prestataire de confiance'), findsOneWidget);
    expect(find.text('Photos vérifiées'), findsOneWidget);
  });

  testWidgets('the units by type, three each, the rest behind « Voir les 5 chambres »', (tester) async {
    // No reviews: the one on « Chambre 4 » would name it too.
    when(() => bloc.state).thenReturn(ResidenceDetailReady(detail: residence()));
    await pump(tester);
    await scrollTo(tester, find.text('Voir les 5 chambres'));
    await tester.ensureVisible(find.text('Voir les 5 chambres'));
    await tester.pumpAndSettle();

    expect(find.text('Chambre 3'), findsOneWidget);
    expect(find.text('Chambre 4'), findsNothing);
    // A group of one has nothing to fold.
    expect(find.text('Studio A'), findsOneWidget);
    expect(find.textContaining('Voir les 1'), findsNothing);

    await tester.tap(find.text('Voir les 5 chambres'));
    await tester.pumpAndSettle();

    expect(find.text('Chambre 4'), findsOneWidget);
    expect(find.text('Chambre 5'), findsOneWidget);
    expect(find.text('Voir moins'), findsOneWidget);
  });

  testWidgets('no action bar: what the page expects is the choice of a unit', (tester) async {
    await pump(tester);

    expect(find.byType(Button), findsNothing);
  });

  testWidgets('§36 — a review names its unit, when that unit is still live', (tester) async {
    await pump(tester);
    await scrollTo(tester, find.text('Ndongo Bile'));

    expect(find.text('Avis sur la résidence'), findsOneWidget);
    // « Chambre 4 » is folded away among the units, so this one is the review's.
    expect(find.text('Chambre 4'), findsOneWidget);
  });

  testWidgets('no rating, no reviews block', (tester) async {
    when(() => bloc.state)
        .thenReturn(ResidenceDetailReady(detail: residence(rating: const PropertyRatingSummary())));
    await pump(tester);
    // To the very end, where the block would be.
    await tester.drag(pageList(), const Offset(0, -4000));
    await tester.pumpAndSettle();

    expect(find.text('Voir les 5 chambres'), findsOneWidget);
    expect(find.text('Avis sur la résidence'), findsNothing);
    expect(find.text('Avis'), findsNothing);
  });

  testWidgets('no live unit is said in words, never as « 0 unité »', (tester) async {
    when(() => bloc.state).thenReturn(ResidenceDetailReady(detail: residence(units: const [])));
    await pump(tester);
    await scrollTo(tester, find.text('Aucune unité disponible pour l\'instant.'));

    expect(find.textContaining('unité disponible'), findsOneWidget);
  });

  testWidgets('offline — the copy is shown, and says so', (tester) async {
    when(() => bloc.state).thenReturn(ResidenceDetailReady(detail: residence(), isOffline: true));
    await pump(tester);

    expect(find.textContaining('hors ligne'), findsOneWidget);
  });

  testWidgets('withdrawn — said, nothing to retry', (tester) async {
    when(() => bloc.state).thenReturn(const ResidenceGone());
    await pump(tester);

    expect(find.text('Cette résidence n\'est plus en ligne'), findsOneWidget);
    expect(find.text('Réessayer'), findsNothing);
  });

  testWidgets('the fiche', (tester) async {
    await pump(tester);

    await expectLater(find.byType(ResidenceDetailPage), matchesGoldenFile('goldens/residence_detail.png'));
  });

  testWidgets('the fiche — the units and the reviews', (tester) async {
    await pump(tester);
    await scrollTo(tester, find.text('Voir les 5 chambres'));
    await tester.drag(pageList(), const Offset(0, -260));
    await tester.pumpAndSettle();

    await expectLater(find.byType(ResidenceDetailPage), matchesGoldenFile('goldens/residence_detail_units.png'));
  });
}
