import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/reservations/bloc/my_reservations_bloc.dart';
import 'package:mboa_user/features/reservations/bloc/reservation_bloc.dart';
import 'package:mboa_user/features/reservations/bloc/reservation_request_bloc.dart';
import 'package:mboa_user/features/reservations/data/reservations_repository.dart';
import 'package:mboa_user/features/reservations/models/reservation_draft.dart';
import 'package:mboa_user/features/reservations/ui/my_reservations_page.dart';
import 'package:mboa_user/features/reservations/ui/request_reservation_page.dart';
import 'package:mboa_user/features/reservations/ui/reservation_detail_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockReservationRequestBloc extends MockBloc<ReservationRequestEvent, ReservationRequestState>
    implements ReservationRequestBloc {}

class MockReservationBloc extends MockBloc<ReservationEvent, ReservationState> implements ReservationBloc {}

class MockMyReservationsBloc extends MockBloc<MyReservationsEvent, MyReservationsState>
    implements MyReservationsBloc {}

/// CDC M29 — the tenant's reservation screens.
void main() {
  const listing = ReservationListing(
    id: 'a-1',
    title: 'Appartement à louer',
    district: 'Deido',
    city: 'Douala',
    price: 110000,
    rentalPeriod: RentalPeriod.month,
  );

  final accepted = Reservation(
    id: 'f3a91c7e-0000-4000-8000-000000000001',
    status: ReservationStatus.accepted,
    annonceId: 'a-1',
    annonceTitle: 'Appartement à louer',
    desiredStartDate: DateTime(2026, 11, 1),
    durationUnits: 6,
    rentalPeriod: RentalPeriod.month,
    message: 'Je travaille à Akwa, je cherche un logement calme.',
    reservedUntil: DateTime(2026, 10, 26, 18),
    conversationId: 'c-1',
    canCancel: true,
  );

  setUpAll(() async {
    await loadBrandFonts();
    registerFallbackValue(const ReservationCancelRequested());
    registerFallbackValue(ReservationRequestSubmitted(annonceId: 'x', start: DateTime(2026), units: 1));
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

  group('the request', () {
    late MockReservationRequestBloc bloc;

    setUp(() {
      bloc = MockReservationRequestBloc();
      when(() => bloc.state).thenReturn(const ReservationRequestIdle());
    });

    Widget form() => BlocProvider<ReservationRequestBloc>.value(
          value: bloc,
          child: RequestReservationForm(listing: listing, today: DateTime(2026, 10, 19)),
        );

    Future<void> pickFirstOfNovember(WidgetTester tester) async {
      await tester.tap(find.text('Choisir').first);
      await tester.pumpAndSettle();
      // The picker opens on today's month; one step on to November.
      await tester.tap(find.byTooltip('Mois suivant'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('1'));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
    }

    Button send(WidgetTester tester) => tester.widget<Button>(find.widgetWithText(Button, 'Envoyer la demande'));

    testWidgets('nothing to send before a start is chosen', (tester) async {
      await pump(tester, form());

      expect(send(tester).onPressed, isNull);
    });

    testWidgets('RM-M29-09 — the rent and the reminder; never "paiement"', (tester) async {
      await pump(tester, form());

      // French groups thousands with a narrow no-break space.
      expect(find.textContaining(RegExp(r'^110.000 FCFA / mois$')), findsOneWidget);
      expect(find.textContaining('Ne verse aucun argent'), findsOneWidget);
      expect(find.textContaining(RegExp('paiement', caseSensitive: false)), findsNothing);
    });

    testWidgets('the end follows the start and the duration; the total is indicative', (tester) async {
      await pump(tester, form());
      await pickFirstOfNovember(tester);

      expect(find.text('30 nov. 2026'), findsOneWidget);
      await tester.tap(find.byTooltip('Allonger'));
      await tester.pumpAndSettle();

      expect(find.text('31 déc. 2026'), findsOneWidget);
      expect(find.textContaining(RegExp(r'^Sur la durée : 220.000 FCFA · indicatif$')), findsOneWidget);
    });

    testWidgets('sends what was chosen', (tester) async {
      await pump(tester, form());
      await pickFirstOfNovember(tester);
      await tester.tap(find.byTooltip('Allonger'));
      await tester.enterText(find.byType(TextField), 'Bonjour');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Envoyer la demande'));

      verify(
        () => bloc.add(
          ReservationRequestSubmitted(annonceId: 'a-1', start: DateTime(2026, 11), units: 2, message: 'Bonjour'),
        ),
      ).called(1);
    });

    testWidgets('a refusal is told in words', (tester) async {
      whenListen(
        bloc,
        Stream.fromIterable(const [
          ReservationRequestSubmitting(),
          ReservationRequestRefusedState(RequestRefusal.limitReached),
        ]),
        initialState: const ReservationRequestIdle(),
      );
      await pump(tester, form());

      expect(find.textContaining('trop de demandes en attente'), findsOneWidget);
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('the request screen', (tester) async {
      await pump(tester, form());
      await pickFirstOfNovember(tester);
      for (var i = 0; i < 5; i++) {
        await tester.tap(find.byTooltip('Allonger'));
      }
      await tester.pumpAndSettle();

      await expectLater(find.byType(RequestReservationForm), matchesGoldenFile('goldens/request_reservation.png'));
    });
  });

  group('the request, afterwards', () {
    late MockReservationBloc bloc;

    setUp(() => bloc = MockReservationBloc());

    Widget view() => BlocProvider<ReservationBloc>.value(value: bloc, child: const ReservationDetailView());

    testWidgets('accepted: the ticket — reference, hold, next step, no money', (tester) async {
      when(() => bloc.state).thenReturn(ReservationReady(accepted));
      await pump(tester, view());

      expect(find.text('Réservation confirmée'), findsOneWidget);
      expect(find.text('F3A91C7E'), findsOneWidget);
      expect(find.text('26 oct. 2026'), findsOneWidget);
      expect(find.textContaining('Contrat Mboa'), findsWidgets);
      expect(find.textContaining('Ne verse aucun argent'), findsOneWidget);
    });

    testWidgets('RM-M29-16 — another unit given: said under its name, the one asked for named', (tester) async {
      when(() => bloc.state).thenReturn(
        ReservationReady(
          Reservation(
            id: accepted.id,
            status: ReservationStatus.accepted,
            annonceId: 'a-4',
            annonceTitle: 'Chambre 4',
            residenceName: 'Résidence Deido',
            requestedAnnonceId: 'a-1',
            requestedAnnonceTitle: 'Chambre 2',
            reservedUntil: accepted.reservedUntil,
          ),
        ),
      );
      await pump(tester, view());

      expect(find.text('Chambre 4 · Résidence Deido'), findsOneWidget);
      expect(find.text('Attribuée à la place de « Chambre 2 »'), findsOneWidget);
    });

    testWidgets('the unit asked for: nothing more said', (tester) async {
      when(() => bloc.state).thenReturn(ReservationReady(accepted));
      await pump(tester, view());

      expect(find.textContaining('à la place de'), findsNothing);
    });

    testWidgets('RM-M29-06 — a refusal gives its reason and the word that came with it', (tester) async {
      when(() => bloc.state).thenReturn(
        const ReservationReady(
          Reservation(
            id: 'r-2',
            status: ReservationStatus.refused,
            annonceTitle: 'Studio',
            ownerReason: RefusalReason.datesIncompatible,
            ownerNote: 'Libre seulement en janvier.',
          ),
        ),
      );
      await pump(tester, view());

      expect(find.text('Motif : Dates incompatibles'), findsOneWidget);
      expect(find.text('« Libre seulement en janvier. »'), findsOneWidget);
      expect(find.text('Annuler ma demande'), findsNothing);
    });

    testWidgets('cancelling asks first, then sends', (tester) async {
      when(() => bloc.state).thenReturn(ReservationReady(accepted));
      await pump(tester, view());

      await tester.scrollUntilVisible(find.text('Annuler ma demande'), 200);
      await tester.tap(find.text('Annuler ma demande'));
      await tester.pumpAndSettle();
      expect(find.text('Annuler ta demande ?'), findsOneWidget);

      await tester.tap(find.text('Oui, annuler'));
      await tester.pumpAndSettle();

      verify(() => bloc.add(const ReservationCancelRequested())).called(1);
    });

    testWidgets('§28 — the contract sent from it is one tap away', (tester) async {
      when(() => bloc.state).thenReturn(
        ReservationReady(
          Reservation(
            id: accepted.id,
            status: ReservationStatus.accepted,
            annonceId: 'a-1',
            annonceTitle: accepted.annonceTitle,
            reservedUntil: accepted.reservedUntil,
            contractId: 'c-2',
          ),
        ),
      );
      await pump(tester, view());

      await tester.scrollUntilVisible(find.text('Voir le contrat'), 200);
      expect(find.text('Voir le contrat'), findsOneWidget);
    });

    testWidgets('kept: nothing is sent', (tester) async {
      when(() => bloc.state).thenReturn(ReservationReady(accepted));
      await pump(tester, view());

      await tester.scrollUntilVisible(find.text('Annuler ma demande'), 200);
      await tester.tap(find.text('Annuler ma demande'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Garder ma demande'));
      await tester.pumpAndSettle();

      verifyNever(() => bloc.add(any()));
    });

    testWidgets('a confirmed reservation', (tester) async {
      when(() => bloc.state).thenReturn(ReservationReady(accepted));
      await pump(tester, view());

      await expectLater(find.byType(ReservationDetailView), matchesGoldenFile('goldens/reservation_accepted.png'));
    });
  });

  group('the list', () {
    late MockMyReservationsBloc bloc;

    setUp(() => bloc = MockMyReservationsBloc());

    Widget view() => BlocProvider<MyReservationsBloc>.value(value: bloc, child: const MyReservationsView());

    testWidgets('each request with where it stands', (tester) async {
      when(() => bloc.state).thenReturn(
        MyReservationsReady(
          items: [
            accepted,
            const Reservation(id: 'r-2', status: ReservationStatus.expired, annonceTitle: 'Studio Bonapriso'),
          ],
        ),
      );
      await pump(tester, view());

      expect(find.text('Appartement à louer'), findsOneWidget);
      expect(find.text('Dès le 1 nov. 2026 · 6 mois'), findsOneWidget);
      expect(find.text('Réservée'), findsOneWidget);
      expect(find.text('Sans réponse'), findsOneWidget);
      expect(find.textContaining('Hors ligne'), findsNothing);
    });

    testWidgets('offline, the copy — and it says so', (tester) async {
      when(() => bloc.state).thenReturn(MyReservationsReady(items: [accepted], isOffline: true));
      await pump(tester, view());

      expect(find.textContaining('Hors ligne'), findsOneWidget);
      expect(find.text('Appartement à louer'), findsOneWidget);
    });

    testWidgets('none yet: where requests come from', (tester) async {
      when(() => bloc.state).thenReturn(const MyReservationsReady(items: []));
      await pump(tester, view());

      expect(find.text('Aucune demande'), findsOneWidget);
    });
  });
}
