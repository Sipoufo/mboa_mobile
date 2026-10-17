import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/favorites/bloc/favorites_bloc.dart';
import 'package:mboa_user/features/listing/bloc/listing_detail_bloc.dart';
import 'package:mboa_user/features/favorites/ui/widgets/favorite_heart.dart';
import 'package:mboa_user/features/listing/ui/listing_detail_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockListingDetailBloc
    extends MockBloc<ListingDetailEvent, ListingDetailState>
    implements ListingDetailBloc {}

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

/// The public fiche (CDC M05).
void main() {
  late MockListingDetailBloc bloc;
  late MockFavoritesBloc favorites;

  ListingDetail detail({
    bool canContact = true,
    bool canPlanVisit = true,
    PropertyRatingSummary rating = const PropertyRatingSummary(),
    ListingAvailability availability = ListingAvailability.available,
  }) =>
      ListingDetail(
        id: 'a-1',
        title: 'Studio meublé — Bonapriso',
        propertyType: PropertyType.studio,
        price: 110000,
        rentalPeriod: RentalPeriod.month,
        city: 'Douala',
        district: 'Bonapriso',
        surfaceArea: 45,
        roomCount: 2,
        bathroomCount: 1,
        furnished: true,
        chargesIncluded: false,
        description: 'Studio lumineux à deux pas du marché.',
        amenities: const [Amenity.airConditioning, Amenity.wifi],
        photoKeys: const ['p1', 'p2', 'p3', 'p4'],
        provider: const ProviderSummary(
          displayName: 'Agence Deido',
          type: PrestataireKind.agence,
          badges: [TrustBadge.trustedProvider, TrustBadge.verifiedIdentity],
        ),
        canContact: canContact,
        canPlanVisit: canPlanVisit,
        rating: rating,
        availability: availability,
      );

  setUpAll(loadBrandFonts);

  setUp(() {
    bloc = MockListingDetailBloc();
    favorites = MockFavoritesBloc();
    when(() => favorites.state).thenReturn(const FavoritesInitial());
    when(() => bloc.state).thenReturn(ListingDetailReady(detail: detail()));

    if (!getIt.isRegistered<SessionSnapshot>()) {
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    }
  });

  tearDown(getIt.reset);

  /// The page has two scrollables — the list and the photo carousel — so the
  /// one to travel has to be named.
  Finder pageList() => find
      .descendant(
        of: find.byType(ListingDetailPage),
        matching: find.byType(Scrollable),
      )
      .first;

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
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ListingDetailBloc>.value(value: bloc),
            BlocProvider<FavoritesBloc>.value(value: favorites),
          ],
          child: const ListingDetailPage(id: 'a-1'),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('CA-M05-03 — no exact address, and the fiche says why',
      (tester) async {
    await pump(tester);

    expect(tester.takeException(), isNull);
    expect(find.textContaining('Localisation approximative'), findsOneWidget);
    expect(find.text('Bonapriso, Douala'), findsOneWidget);
  });

  testWidgets('RM-M05-03 — badges come in prestige order', (tester) async {
    await pump(tester);
    await scrollTo(tester, find.text('Agence Deido'));

    final trusted = tester.getTopLeft(find.text('Prestataire de confiance'));
    final identity = tester.getTopLeft(find.text('Identité vérifiée'));
    // 🏆 before ✅ in reading order — they wrap onto two lines at this width,
    // so comparing x alone would pass for the wrong reason.
    expect(
      trusted.dy < identity.dy ||
          (trusted.dy == identity.dy && trusted.dx < identity.dx),
      isTrue,
    );
  });

  testWidgets('RM-M05-08 — no review, no rating block', (tester) async {
    await pump(tester);

    // A "0/5" would read as a bad property rather than an unrated one.
    expect(find.text('Avis sur le bien'), findsNothing);
  });

  testWidgets('RM-M05-08 — a rated property shows its average', (tester) async {
    when(() => bloc.state).thenReturn(
      ListingDetailReady(
        detail: detail(
          rating: const PropertyRatingSummary(average: 4.2, reviewCount: 7),
        ),
        reviews: [
          ReviewEntry(
            id: 'r-1',
            kind: ReviewKind.resident,
            authorName: 'Awa Nkeng',
            rating: 4,
            comment: 'Quartier vivant, eau régulière.',
            residenceMonths: 14,
            publishedAt: DateTime(2026, 8, 12),
          ),
        ],
      ),
    );
    await pump(tester);
    await scrollTo(tester, find.text('Avis sur le bien'));

    expect(find.textContaining('4.2'), findsOneWidget);
    // RG-06 — the kind of testimony is named, since they do not weigh the same.
    expect(find.text('Locataire'), findsOneWidget);
  });

  testWidgets(
    'RM-M27-02 — a corrected review says so, and a short let says nothing',
    (tester) async {
      when(() => bloc.state).thenReturn(
        ListingDetailReady(
          detail: detail(
            rating: const PropertyRatingSummary(average: 4.0, reviewCount: 2),
          ),
          reviews: [
            ReviewEntry(
              id: 'r-1',
              kind: ReviewKind.resident,
              authorName: 'Awa Nkeng',
              rating: 4,
              comment: 'Corrigé après six mois.',
              residenceMonths: 14,
              residenceDuration: 14,
              residencePeriod: RentalPeriod.month,
              publishedAt: DateTime(2026, 8, 12),
              editedAt: DateTime(2026, 9, 3),
            ),
            ReviewEntry(
              id: 'r-2',
              kind: ReviewKind.resident,
              authorName: 'Ndongo Bile',
              rating: 5,
              comment: 'Séjour court mais impeccable.',
              // §24.2 — a 5-day let. It used to round to residenceMonths:0 and
              // show "0 mois"; now it carries its real unit and reads "5 jours".
              residenceMonths: 0,
              residenceDuration: 5,
              residencePeriod: RentalPeriod.day,
              publishedAt: DateTime(2026, 9, 20),
            ),
          ],
        ),
      );
      await pump(tester);
      await scrollTo(tester, find.text('Corrigé après six mois.'));

      // The copy for this has existed since the feed shipped and was never
      // rendered, so a revised review looked identical to an original one.
      expect(find.textContaining('Corrigé le'), findsOneWidget);
      expect(find.text('14 mois sur place'), findsOneWidget);
      // §24.2 — the short let reads its real unit, "5 jours sur place", instead
      // of rounding to the wrong, insulting "0 mois".
      expect(find.text('5 jours sur place'), findsOneWidget);
      expect(find.textContaining('0 mois'), findsNothing);
    },
  );

  testWidgets('RM-M27-06 — every review can be reported', (tester) async {
    when(() => bloc.state).thenReturn(
      ListingDetailReady(
        detail: detail(
          rating: const PropertyRatingSummary(average: 4.0, reviewCount: 1),
        ),
        reviews: [
          ReviewEntry(
            id: 'r-1',
            kind: ReviewKind.resident,
            authorName: 'Awa Nkeng',
            rating: 1,
            comment: 'Propos diffamatoires.',
            residenceMonths: 3,
            publishedAt: DateTime(2026, 8, 12),
          ),
        ],
      ),
    );
    await pump(tester);
    await scrollTo(tester, find.text('Propos diffamatoires.'));

    // One upheld report removes a review, where a listing takes three — so
    // the affordance exists, quietly, on every entry of the feed.
    expect(find.text('Signaler'), findsOneWidget);
  });

  testWidgets('M07bis — a visit report shows its bullets, not just its text',
      (tester) async {
    when(() => bloc.state).thenReturn(
      ListingDetailReady(
        detail: detail(
          rating: const PropertyRatingSummary(average: 4.0, reviewCount: 1),
        ),
        reviews: [
          ReviewEntry(
            id: 'r-1',
            kind: ReviewKind.visit,
            authorName: 'Awa Nkeng',
            rating: 4,
            pros: const ['Quartier calme'],
            cons: const ['Humidité au mur'],
            publishedAt: DateTime(2026, 9, 30),
          ),
        ],
      ),
    );
    await pump(tester);
    await scrollTo(tester, find.text('Quartier calme'));

    // The bullets are half of what M07bis asks a visitor to write; the fiche
    // showed only the free text until the tenant app could write them.
    expect(find.text('Quartier calme'), findsOneWidget);
    expect(find.text('Humidité au mur'), findsOneWidget);
    expect(find.text('Visite'), findsOneWidget);
  });

  testWidgets('RM-M05-07 — no bookable visitor, no booking button',
      (tester) async {
    // Signed in: the sign-in line would otherwise take the place of the
    // explanation, and this test is about the other half of the rule.
    getIt<SessionSnapshot>().markAuthenticated();
    when(() => bloc.state)
        .thenReturn(ListingDetailReady(detail: detail(canPlanVisit: false)));
    await pump(tester);

    // The button would open a booking screen with no slots in it.
    expect(find.text('Planifier une visite'), findsNothing);
    expect(find.textContaining('n\'accepte pas encore de visites'), findsOneWidget);
  });

  testWidgets('RM-M04-05 — a visitor reads the fiche and cannot contact',
      (tester) async {
    when(() => bloc.state)
        .thenReturn(ListingDetailReady(detail: detail(canContact: false)));
    await pump(tester);

    final button = tester.widget<Button>(find.byType(Button).first);
    expect(button.onPressed, isNull);
    expect(find.textContaining('Connecte-toi'), findsOneWidget);
  });

  testWidgets('§20 — an off-market fiche says so before anything else',
      (tester) async {
    when(() => bloc.state).thenReturn(
      ListingDetailReady(
        detail: detail(availability: ListingAvailability.rented),
      ),
    );
    await pump(tester);

    // Read by someone with a visit still to happen; without the banner it
    // would look like a property that can still be had.
    expect(find.text('Ce bien est déjà loué.'), findsOneWidget);
  });

  testWidgets('a live listing has no such banner', (tester) async {
    when(() => bloc.state).thenReturn(ListingDetailReady(detail: detail()));
    await pump(tester);

    expect(find.text('Ce bien est déjà loué.'), findsNothing);
    expect(find.text('Cette annonce n\'est plus en ligne.'), findsNothing);
  });

  testWidgets('CE-M05-01 — a withdrawn listing is not a retry', (tester) async {
    when(() => bloc.state).thenReturn(const ListingGone());
    await pump(tester);

    expect(find.text('Ce bien n\'est plus disponible'), findsOneWidget);
    expect(find.text('Réessayer'), findsNothing);
  });

  testWidgets('an offline fiche offers no action at all', (tester) async {
    when(() => bloc.state).thenReturn(
      ListingDetailReady(detail: detail(), isOffline: true),
    );
    await pump(tester);

    expect(find.textContaining('hors ligne'), findsOneWidget);
    expect(find.byType(Button), findsNothing);
  });

  testWidgets('the fiche', (tester) async {
    await pump(tester);

    await expectLater(
      find.byType(ListingDetailPage),
      matchesGoldenFile('goldens/listing_detail.png'),
    );
  });

  /// **The route carries its own scope.**
  ///
  /// `/listings/:id` is a root route, a sibling of the tab shell, so nothing
  /// above it provides the shell's `FavoritesBloc`. The heart sits inside the
  /// carousel's `Stack`, so the missing provider did not just hide a heart —
  /// it threw while building and took the whole gallery with it, which is how
  /// it was reported ("the photos don't work").
  ///
  /// Every other test here hands both blocs down from above, the way the shell
  /// would. This one pumps what auto_route actually pumps: `wrappedRoute`,
  /// with an empty tree above it.
  testWidgets('the fiche opens outside the shell, heart and all',
      (tester) async {
    getIt.registerFactory<ListingDetailBloc>(() => bloc);
    getIt.registerLazySingleton<FavoritesBloc>(() => favorites);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Builder(
          builder: (context) =>
              const ListingDetailPage(id: 'a-1').wrappedRoute(context),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(FavoriteHeart), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
  });
}
