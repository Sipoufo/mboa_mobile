import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/app/notifications_bootstrap.dart';
import 'package:mboa_pro/app/router/app_router.dart';
import 'package:mboa_pro/app/router/app_router.gr.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/reservations/bloc/incoming_reservation_bloc.dart';
import 'package:mboa_pro/features/reservations/bloc/incoming_reservations_bloc.dart';
import 'package:mboa_pro/features/reservations/ui/incoming_reservation_page.dart';
import 'package:mboa_pro/features/reservations/ui/incoming_reservations_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockIncomingReservationsBloc extends MockBloc<IncomingReservationsEvent, IncomingReservationsState>
    implements IncomingReservationsBloc {}

class MockIncomingReservationBloc extends MockBloc<IncomingReservationEvent, IncomingReservationState>
    implements IncomingReservationBloc {}

class MockAppRouter extends Mock implements AppRouter {}

class _FakeRoute extends Fake implements PageRouteInfo<dynamic> {}

/// CDC M29 — the prestataire's reservation screens.
void main() {
  const client = ReservationParty(accountId: 'u-1', name: 'Hector Gunther');

  final pending = Reservation(
    id: 'r-1',
    status: ReservationStatus.pending,
    annonceId: 'a-1',
    annonceTitle: 'Appartement à louer — Deido',
    userAccountId: 'u-1',
    client: client,
    desiredStartDate: DateTime(2026, 11, 1),
    durationUnits: 6,
    rentalPeriod: RentalPeriod.month,
    message: 'Je travaille à Akwa, je cherche un logement calme.',
    expiresAt: DateTime(2026, 10, 21, 9, 10),
    conversationId: 'c-1',
    createdAt: DateTime(2026, 10, 19, 9, 10),
    canAccept: true,
    canRefuse: true,
  );

  final accepted = Reservation(
    id: 'f3a91c7e-0000-4000-8000-000000000001',
    status: ReservationStatus.accepted,
    annonceId: 'a-1',
    annonceTitle: 'Appartement à louer — Deido',
    client: client,
    desiredStartDate: DateTime(2026, 11, 1),
    durationUnits: 6,
    rentalPeriod: RentalPeriod.month,
    reservedUntil: DateTime(2026, 10, 26, 18),
    createdAt: DateTime(2026, 10, 18, 14, 2),
    canExtend: true,
    canCancel: true,
    canDraftContract: true,
  );

  const listing = Annonce(
    id: 'a-1',
    title: 'Appartement à louer — Deido',
    status: AnnonceStatus.published,
    propertyType: PropertyType.apartment,
    price: 110000,
    rentalPeriod: RentalPeriod.month,
  );

  setUpAll(() async {
    await loadBrandFonts();
    registerFallbackValue(const IncomingReservationAccepted());
  });

  Future<void> pump(WidgetTester tester, Widget child) async {
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
        home: child,
      ),
    );
    await tester.pumpAndSettle();
  }

  group('the inbox', () {
    late MockIncomingReservationsBloc bloc;

    setUp(() => bloc = MockIncomingReservationsBloc());

    Widget view({String? title}) => BlocProvider<IncomingReservationsBloc>.value(
          value: bloc,
          child: IncomingReservationsView(annonceTitle: title),
        );

    testWidgets('waiting first; every request under "Toutes"', (tester) async {
      when(() => bloc.state).thenReturn(IncomingReservationsReady(items: [pending, accepted]));
      await pump(tester, view());

      expect(find.text('En attente (1)'), findsOneWidget);
      expect(find.text('Hector Gunther · Appartement à louer — Deido'), findsOneWidget);
      expect(find.text('Réservée'), findsNothing);

      await tester.tap(find.text('Toutes (2)'));
      await tester.pumpAndSettle();

      expect(find.text('Réservée'), findsOneWidget);
      // One day each: the timeline's dates.
      expect(find.text('19'), findsOneWidget);
      expect(find.text('18'), findsOneWidget);
    });

    testWidgets('one listing\'s requests say which listing', (tester) async {
      when(() => bloc.state).thenReturn(const IncomingReservationsReady(items: []));
      await pump(tester, view(title: 'Studio Bonapriso'));

      expect(find.text('Studio Bonapriso'), findsOneWidget);
      expect(find.text('Aucune demande n\'attend ta réponse.'), findsOneWidget);
    });

    testWidgets('offline, it says so', (tester) async {
      when(() => bloc.state).thenReturn(IncomingReservationsReady(items: [pending], isOffline: true));
      await pump(tester, view());

      expect(find.textContaining('Hors ligne'), findsOneWidget);
    });

    testWidgets('the inbox', (tester) async {
      when(() => bloc.state).thenReturn(IncomingReservationsReady(items: [pending, accepted]));
      await pump(tester, view());
      await tester.tap(find.text('Toutes (2)'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(IncomingReservationsView), matchesGoldenFile('goldens/reservations_inbox.png'));
    });
  });

  group('a request', () {
    late MockIncomingReservationBloc bloc;

    setUp(() => bloc = MockIncomingReservationBloc());

    Widget view() => BlocProvider<IncomingReservationBloc>.value(value: bloc, child: const IncomingReservationView());

    testWidgets('waiting: the stay, the indicative total, who asks — and the 48 h', (tester) async {
      when(() => bloc.state).thenReturn(IncomingReservationReady(pending, listing: listing, otherPending: 2));
      await pump(tester, view());

      expect(find.text('Hector Gunther'), findsOneWidget);
      expect(find.text('Voir son Mboa Score'), findsOneWidget);
      expect(find.textContaining(RegExp(r'^Sur la durée : 660.000 FCFA · indicatif$')), findsOneWidget);
      expect(find.text('2 autres demandes pour ce bien'), findsOneWidget);
      expect(find.textContaining('À traiter avant le'), findsOneWidget);
      // One main action, the rest behind "⋯".
      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Accepter la demande'), findsOneWidget);
    });

    testWidgets('accepting asks first, then sends', (tester) async {
      when(() => bloc.state).thenReturn(IncomingReservationReady(pending));
      await pump(tester, view());

      await tester.tap(find.text('Accepter la demande'));
      await tester.pumpAndSettle();
      expect(find.text('Accepter cette demande ?'), findsOneWidget);
      await tester.tap(find.text('Accepter'));
      await tester.pumpAndSettle();

      verify(() => bloc.add(const IncomingReservationAccepted())).called(1);
    });

    testWidgets('RM-M29-06 — refusing needs a reason, then sends it with the note', (tester) async {
      when(() => bloc.state).thenReturn(IncomingReservationReady(pending));
      await pump(tester, view());

      await tester.tap(find.byTooltip('Plus d\'actions'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Refuser la demande'));
      await tester.pumpAndSettle();

      final send = find.widgetWithText(Button, 'Refuser la demande');
      expect(tester.widget<Button>(send).onPressed, isNull);

      await tester.tap(find.text('Dates incompatibles'));
      await tester.enterText(find.byType(TextField), 'Libre en janvier');
      await tester.pumpAndSettle();
      await tester.tap(send);
      await tester.pumpAndSettle();

      verify(
        () => bloc.add(const IncomingReservationRefused(reason: RefusalReason.datesIncompatible, note: 'Libre en janvier')),
      ).called(1);
    });

    testWidgets('accepted: the ticket, and the contract as the main action', (tester) async {
      when(() => bloc.state).thenReturn(IncomingReservationReady(accepted, listing: listing));
      await pump(tester, view());

      expect(find.text('Réservation confirmée'), findsOneWidget);
      expect(find.textContaining('Établis le Contrat Mboa'), findsOneWidget);
      expect(find.text('Établir le contrat'), findsOneWidget);

      await tester.tap(find.byTooltip('Plus d\'actions'));
      await tester.pumpAndSettle();
      expect(find.text('Prolonger la réservation'), findsOneWidget);
      expect(find.text('Annuler la réservation'), findsOneWidget);
      expect(find.text('Refuser la demande'), findsNothing);
    });

    testWidgets('§28 — a contract already drawn up from it is opened, not drawn again', (tester) async {
      // The server's own answer: canDraftContract false, and the contract's id.
      final drawn = Reservation(
        id: accepted.id,
        status: ReservationStatus.accepted,
        annonceId: 'a-1',
        annonceTitle: accepted.annonceTitle,
        client: client,
        reservedUntil: accepted.reservedUntil,
        canExtend: true,
        canCancel: true,
        contractId: 'c-2',
      );
      when(() => bloc.state).thenReturn(IncomingReservationReady(drawn, listing: listing));
      await pump(tester, view());

      expect(find.text('Voir le contrat'), findsOneWidget);
      expect(find.text('Établir le contrat'), findsNothing);
    });

    testWidgets('closed: what happened and why — and nothing left to do', (tester) async {
      when(() => bloc.state).thenReturn(
        const IncomingReservationReady(
          Reservation(id: 'r-2', status: ReservationStatus.refused, ownerReason: RefusalReason.datesIncompatible),
        ),
      );
      await pump(tester, view());

      expect(find.text('Tu as refusé cette demande. Motif : Dates incompatibles'), findsOneWidget);
      expect(find.byTooltip('Plus d\'actions'), findsNothing);
      expect(find.byType(Button), findsNothing);
    });

    testWidgets('a request waiting', (tester) async {
      when(() => bloc.state).thenReturn(IncomingReservationReady(pending, listing: listing, otherPending: 2));
      await pump(tester, view());

      await expectLater(find.byType(IncomingReservationView), matchesGoldenFile('goldens/reservation_pending.png'));
    });

    testWidgets('a request accepted', (tester) async {
      when(() => bloc.state).thenReturn(IncomingReservationReady(accepted, listing: listing));
      await pump(tester, view());

      await expectLater(find.byType(IncomingReservationView), matchesGoldenFile('goldens/reservation_accepted.png'));
    });
  });

  group('a reservation notification', () {
    late MockAppRouter router;

    setUpAll(() => registerFallbackValue(_FakeRoute()));

    setUp(() {
      router = MockAppRouter();
      when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
      when(() => router.navigate(any())).thenAnswer((_) async {});
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    });

    tearDown(getIt.reset);

    test('N-32 takes the owner to the request', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);

      routeNotificationTap(router, const PushMessage(type: PushType.reservation, entityId: 'r-1'));

      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, IncomingReservationRoute.name);
      expect((route.args! as IncomingReservationRouteArgs).id, 'r-1');
    });

    test('without an id, to the inbox', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);

      routeNotificationTap(router, const PushMessage(type: PushType.reservation));

      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, IncomingReservationsRoute.name);
    });

    test('an agent has no requests: the shell', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.agent);

      routeNotificationTap(router, const PushMessage(type: PushType.reservation, entityId: 'r-1'));

      verifyNever(() => router.push<Object?>(any()));
    });
  });
}
