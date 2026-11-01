import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/annonces/bloc/annonces_bloc.dart';
import 'package:mboa_pro/app/router/app_router.gr.dart';
import 'package:mboa_pro/features/annonces/bloc/listing_stats_bloc.dart';
import 'package:mboa_pro/features/annonces/bloc/listing_tenancies_bloc.dart';
import 'package:mboa_pro/features/annonces/bloc/residences_bloc.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/models/residence.dart';
import 'package:mboa_pro/features/annonces/ui/annonce_detail_page.dart';
import 'package:mboa_pro/features/annonces/ui/residence_detail_page.dart';
import 'package:mboa_pro/features/home/models/dashboard_stats.dart' show DashboardFigure;
import 'package:mboa_pro/features/home/models/listing_figures.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_pro/features/subscription/bloc/subscription_bloc.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockAnnoncesBloc extends MockBloc<AnnoncesEvent, AnnoncesState> implements AnnoncesBloc {}

class MockResidencesBloc extends MockBloc<ResidencesEvent, ResidencesState> implements ResidencesBloc {}

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState> implements ProProfileBloc {}

class MockSubscriptionBloc extends MockBloc<SubscriptionEvent, SubscriptionState> implements SubscriptionBloc {}

class MockListingStatsBloc extends MockBloc<ListingStatsEvent, ListingStatsState> implements ListingStatsBloc {}

class MockListingTenanciesBloc extends MockBloc<ListingTenanciesEvent, ListingTenanciesState>
    implements ListingTenanciesBloc {}

class MockStackRouter extends Mock implements StackRouter {
  // The page is pumped alone: nothing under it, so no back arrow.
  @override
  bool canPop({bool ignoreChildRoutes = false, bool ignoreParentRoutes = false, bool ignorePagelessRoutes = false}) =>
      false;
}

class _FakeRoute extends Fake implements PageRouteInfo<Object?> {}

/// The two "détail" screens of M10, as they render.
void main() {
  late MockAnnoncesBloc annonces;
  late MockResidencesBloc residences;
  late MockProProfileBloc profile;
  late MockSubscriptionBloc subscription;
  late MockListingTenanciesBloc tenancies;
  late MockListingStatsBloc stats;

  final listing = Annonce(
    id: 'a1',
    title: 'Appartement à louer',
    status: AnnonceStatus.published,
    propertyType: PropertyType.apartment,
    city: 'Douala',
    district: 'Deido',
    price: 110000,
    rentalPeriod: RentalPeriod.month,
    surfaceArea: 30,
    roomCount: 6,
    bathroomCount: 2,
    furnished: true,
    chargesIncluded: false,
    availableFrom: DateTime(2026, 9, 1),
    description: 'Appartement lumineux, à deux pas du marché de Deido.',
    amenities: const [Amenity.airConditioning, Amenity.parking, Amenity.wifi],
    ownerVisitsEnabled: true,
  );

  const residence = Residence(
    id: 'r1',
    name: 'Résidence Deido',
    status: AnnonceStatus.published,
    district: 'Deido',
    unitCount: 8,
    publishedUnitCount: 5,
    units: [
      ResidenceUnit(
        id: 'u1',
        title: 'Chambre 1',
        status: AnnonceStatus.published,
        propertyType: PropertyType.room,
        price: 45000,
      ),
      ResidenceUnit(
        id: 'u2',
        title: 'Chambre 2',
        status: AnnonceStatus.rented,
        propertyType: PropertyType.room,
        price: 45000,
      ),
      ResidenceUnit(
        id: 'u3',
        title: 'Chambre 3',
        status: AnnonceStatus.draft,
        propertyType: PropertyType.room,
        price: 50000,
      ),
    ],
  );

  const profileData = ProfileData(
    firstName: 'Inesse',
    lastName: 'Kiawantio',
    role: AccountRole.prestataire,
    mainCity: 'Douala',
  );

  setUpAll(() async {
    await loadBrandFonts();
    registerFallbackValue(_FakeRoute());
    registerFallbackValue(const ListingTenanciesHistoryExpanded());
  });

  setUp(() {
    annonces = MockAnnoncesBloc();
    residences = MockResidencesBloc();
    profile = MockProProfileBloc();
    subscription = MockSubscriptionBloc();

    when(() => annonces.state).thenReturn(
      AnnoncesReady(items: [listing], filter: AnnonceFilter.available),
    );
    when(() => residences.state).thenReturn(const ResidencesReady(items: [residence]));
    when(() => profile.state).thenReturn(const ProProfileReady(profileData));
    when(() => subscription.state).thenReturn(const SubscriptionReady(SubscriptionPlan.free()));

    tenancies = MockListingTenanciesBloc();
    when(() => tenancies.state).thenReturn(const ListingTenanciesReady());
    stats = MockListingStatsBloc();
    when(() => stats.state).thenReturn(const ListingStatsReady(null));
    getIt
      ..registerFactory<ListingTenanciesBloc>(() => tenancies)
      ..registerFactory<ListingStatsBloc>(() => stats);
  });

  tearDown(getIt.reset);

  Future<void> pump(WidgetTester tester, Widget child, {StackRouter? router}) async {
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
        home: _maybeRouted(
          router,
          MultiBlocProvider(
            providers: [
              BlocProvider<AnnoncesBloc>.value(value: annonces),
              BlocProvider<ResidencesBloc>.value(value: residences),
              BlocProvider<ProProfileBloc>.value(value: profile),
              BlocProvider<SubscriptionBloc>.value(value: subscription),
            ],
            child: child,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the listing detail', (tester) async {
    await pump(tester, const AnnonceDetailPage(id: 'a1'));

    await expectLater(
      find.byType(AnnonceDetailPage),
      matchesGoldenFile('goldens/annonce_detail.png'),
    );
  });

  testWidgets('M14 — its own figures, locked as the server says', (tester) async {
    when(() => stats.state).thenReturn(
      const ListingStatsReady(
        ListingFigures(
          views: DashboardFigure(value: 128),
          viewsLast7Days: DashboardFigure(value: 31),
          contacts: DashboardFigure(locked: true),
          averagePosition: DashboardFigure(value: 2.4),
        ),
      ),
    );
    await pump(tester, const AnnonceDetailPage(id: 'a1'));
    await tester.scrollUntilVisible(find.text('Statistiques'), 300, scrollable: find.byType(Scrollable).first);
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -200));
    await tester.pumpAndSettle();

    expect(find.text('128'), findsOneWidget);
    expect(find.text('dont 31 ces 7 jours'), findsOneWidget);
    expect(find.text('#2.4'), findsOneWidget);
    await expectLater(find.byType(AnnonceDetailPage), matchesGoldenFile('goldens/annonce_detail_stats.png'));
  });

  group('M29 / RM-M10-10 — reserved', () {
    Annonce reserved({String? requestId}) => Annonce(
      id: 'a1',
      title: 'Appartement à louer',
      status: AnnonceStatus.reserved,
      propertyType: PropertyType.apartment,
      city: 'Douala',
      district: 'Deido',
      price: 110000,
      rentalPeriod: RentalPeriod.month,
      reservationRequestId: requestId,
      reservedUntil: requestId == null ? null : DateTime(2026, 10, 26, 18),
    );

    testWidgets('by a request: until when, and the request it is managed from', (tester) async {
      when(() => annonces.state).thenReturn(
        AnnoncesReady(
          items: [reserved(requestId: 'r-1')],
          filter: AnnonceFilter.occupied,
        ),
      );
      await pump(tester, const AnnonceDetailPage(id: 'a1'));

      expect(find.text('Réservée pour un client'), findsOneWidget);
      expect(find.textContaining('26 octobre 2026'), findsOneWidget);
      expect(find.text('Voir la demande'), findsOneWidget);

      // Not lifted from the listing's menu either.
      await tester.tap(find.byIcon(LucideIcons.ellipsisVertical));
      await tester.pumpAndSettle();
      expect(find.text('Lever la réservation'), findsNothing);
    });

    testWidgets('by hand: lifted from the notice', (tester) async {
      when(() => annonces.state).thenReturn(
        AnnoncesReady(items: [reserved()], filter: AnnonceFilter.occupied),
      );
      await pump(tester, const AnnonceDetailPage(id: 'a1'));

      expect(find.text('Réservée'), findsWidgets);
      await tester.tap(find.widgetWithText(Button, 'Lever la réservation'));
      await tester.pump();

      verify(() => annonces.add(const AnnonceStatusChangeRequested('a1', AnnonceTransition.unreserve))).called(1);
    });

    testWidgets('the listing, reserved by a request', (tester) async {
      when(() => annonces.state).thenReturn(
        AnnoncesReady(
          items: [reserved(requestId: 'r-1')],
          filter: AnnonceFilter.occupied,
        ),
      );
      await pump(tester, const AnnonceDetailPage(id: 'a1'));

      await expectLater(
        find.byType(AnnonceDetailPage),
        matchesGoldenFile('goldens/annonce_detail_reserved.png'),
      );
    });
  });

  group('RM-M31-09 — who lives there, and who did', () {
    Home home(
      String id,
      String name,
      HomeStage state, {
      DateTime? start,
      DateTime? end,
      int overdue = 0,
    }) => Home(
      contractId: 'c-$id',
      annonceId: 'a1',
      tenant: ContractParticipant(displayName: name),
      state: state,
      rent: 110000,
      startDate: start,
      endDate: end,
      overdueCount: overdue,
      overdueAmount: overdue * 110000,
    );

    final awa = home('awa', 'Awa Nkeng', HomeStage.active, start: DateTime(2026, 3, 1), overdue: 2);
    final paul = home('paul', 'Paul Essomba', HomeStage.upcoming, start: DateTime(2027, 3, 1));
    final past = [
      home('marie', 'Marie Ngo', HomeStage.readOnly, start: DateTime(2025), end: DateTime(2026, 2, 28)),
      home('jean', 'Jean Mbarga', HomeStage.readOnly, start: DateTime(2024), end: DateTime(2024, 12, 31)),
      home('aline', 'Aline Fouda', HomeStage.readOnly, start: DateTime(2023, 2), end: DateTime(2023, 12, 31)),
      home('eric', 'Éric Tchoua', HomeStage.readOnly, start: DateTime(2022), end: DateTime(2022, 12, 31)),
    ];

    Future<void> scrollTo(WidgetTester tester, String text) async {
      await tester.scrollUntilVisible(find.text(text), 300, scrollable: find.byType(Scrollable).first);
      await tester.pumpAndSettle();
    }

    testWidgets('the occupant, where their rent stands, who follows — and the ones before', (tester) async {
      when(() => tenancies.state).thenReturn(ListingTenanciesReady(occupant: awa, next: paul, past: past));
      await pump(tester, const AnnonceDetailPage(id: 'a1'));
      await scrollTo(tester, 'Occupant');
      await tester.drag(find.byType(Scrollable).first, const Offset(0, -150));
      await tester.pumpAndSettle();

      expect(find.text('Awa Nkeng'), findsOneWidget);
      expect(find.textContaining('Depuis le 1 mars 2026'), findsOneWidget);
      expect(find.text('2 échéances en retard'), findsOneWidget);
      expect(find.text('Ensuite : Paul Essomba, le 1 mars 2027'), findsOneWidget);
      await expectLater(find.byType(AnnonceDetailPage), matchesGoldenFile('goldens/annonce_detail_tenancies.png'));

      await scrollTo(tester, 'Voir tout (4)');
      // The three latest; the fourth behind « Voir tout ».
      expect(find.text('Marie Ngo'), findsOneWidget);
      expect(find.textContaining('janv. 2025 – févr. 2026'), findsOneWidget);
      expect(find.text('Éric Tchoua'), findsNothing);

      await tester.tap(find.text('Voir tout (4)'));
      verify(() => tenancies.add(const ListingTenanciesHistoryExpanded())).called(1);
    });

    testWidgets('never let: free, and no history', (tester) async {
      when(() => tenancies.state).thenReturn(const ListingTenanciesReady());
      await pump(tester, const AnnonceDetailPage(id: 'a1'));
      await scrollTo(tester, 'Aucun locataire pour l\'instant');

      expect(find.text('Libre pour le moment'), findsOneWidget);
      // Only the statistics, which count nothing here, still say there is
      // nothing to know — not the occupant's card, not the history.
      expect(find.textContaining('Aucune information'), findsOneWidget);
    });

    testWidgets('moving in soon: says from when', (tester) async {
      when(() => tenancies.state).thenReturn(ListingTenanciesReady(occupant: paul, past: [past.first]));
      await pump(tester, const AnnonceDetailPage(id: 'a1'));
      await scrollTo(tester, 'Paul Essomba');

      expect(find.textContaining('Entre le 1 mars 2027'), findsOneWidget);
    });

    testWidgets('a tenancy opens its space — the occupant\'s, or a past one read only', (tester) async {
      final router = MockStackRouter();
      when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
      when(() => tenancies.state).thenReturn(ListingTenanciesReady(occupant: awa, past: [past.first]));
      await pump(tester, const AnnonceDetailPage(id: 'a1'), router: router);

      await scrollTo(tester, 'Awa Nkeng');
      await tester.tap(find.text('Awa Nkeng'));
      await scrollTo(tester, 'Marie Ngo');
      await tester.tap(find.text('Marie Ngo'));

      final pushed = verify(() => router.push<Object?>(captureAny())).captured;
      expect(pushed, [TenantHomeRoute(contractId: 'c-awa'), TenantHomeRoute(contractId: 'c-marie')]);
    });

    testWidgets('nothing read and nothing cached: tried again from the card', (tester) async {
      when(() => tenancies.state).thenReturn(const ListingTenanciesFailure());
      await pump(tester, const AnnonceDetailPage(id: 'a1'));
      await scrollTo(tester, 'Réessayer');

      await tester.tap(find.text('Réessayer'));
      verify(() => tenancies.add(const ListingTenanciesRequested('a1'))).called(2);
    });

    testWidgets('offline, the cards say so', (tester) async {
      when(() => tenancies.state).thenReturn(ListingTenanciesReady(occupant: awa, isOffline: true));
      await pump(tester, const AnnonceDetailPage(id: 'a1'));
      await scrollTo(tester, 'Awa Nkeng');

      expect(find.text('Hors ligne — tels que lus la dernière fois.'), findsWidgets);
    });
  });

  testWidgets('the residence detail', (tester) async {
    await pump(tester, const ResidenceDetailPage(id: 'r1'));

    await expectLater(
      find.byType(ResidenceDetailPage),
      matchesGoldenFile('goldens/residence_detail.png'),
    );
  });
}

Widget _maybeRouted(StackRouter? router, Widget child) =>
    router == null ? child : StackRouterScope(controller: router, stateHash: 0, child: child);
