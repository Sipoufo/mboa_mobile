import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/visits/bloc/my_visits_bloc.dart';
import 'package:mboa_user/features/visits/bloc/visit_booking_bloc.dart';
import 'package:mboa_user/features/visits/models/bookable_visitor.dart';
import 'package:mboa_user/features/visits/ui/book_visit_sheet.dart';
import 'package:mboa_user/features/visits/ui/widgets/visit_card.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockMyVisitsBloc extends MockBloc<MyVisitsEvent, MyVisitsState>
    implements MyVisitsBloc {}

class MockVisitBookingBloc
    extends MockBloc<VisitBookingEvent, VisitBookingState>
    implements VisitBookingBloc {}

/// The visit screens (CDC M07).
void main() {
  late MockMyVisitsBloc visits;

  // Fixed so the four-hour rule is decided by the data, not by the clock the
  // suite happens to run on.
  final soon = DateTime.now().add(const Duration(hours: 1));
  final later = DateTime.now().add(const Duration(days: 2));

  Visit visit({
    VisitStatus status = VisitStatus.scheduled,
    DateTime? at,
    VisitorKind kind = VisitorKind.agent,
    DateTime? clientConfirmedAt,
  }) =>
      Visit(
        id: 'v-1',
        status: status,
        annonceId: 'a-1',
        annonceTitle: 'Studio Bonapriso',
        scheduledAt: at,
        visitorKind: kind,
        clientConfirmedAt: clientConfirmedAt,
      );

  setUpAll(loadBrandFonts);

  setUp(() {
    visits = MockMyVisitsBloc();
    when(() => visits.state).thenReturn(const MyVisitsReady());
  });

  Future<void> pump(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<MyVisitsBloc>.value(
          value: visits,
          child: Scaffold(body: SingleChildScrollView(child: child)),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('a visit card offers what it is the tenant\'s turn to do', () {
    testWidgets('two days out: cancel, and nothing else', (tester) async {
      await pump(tester, VisitCard(visit: visit(at: later)));

      expect(find.text('Annuler la visite'), findsOneWidget);
      // Too early to be standing in front of the gate.
      expect(find.text('Je suis sur place'), findsNothing);
    });

    testWidgets('CE-M07-03 — within four hours, cancelling is gone and said',
        (tester) async {
      await pump(tester, VisitCard(visit: visit(at: soon)));

      // The visitor may already be on their way; a button that is refused
      // would be worse than the sentence that explains it.
      expect(find.text('Annuler la visite'), findsNothing);
      expect(find.textContaining('n\'est plus possible'), findsOneWidget);
    });

    testWidgets('RM-M07-05 — around the hour, "I am here"', (tester) async {
      await pump(tester, VisitCard(visit: visit(at: soon)));

      await tester.tap(find.text('Je suis sur place'));
      verify(() => visits.add(const VisitPresenceConfirmed('v-1'))).called(1);
    });

    testWidgets('RM-M07-05 — one half in, the screen says who is awaited',
        (tester) async {
      await pump(
        tester,
        VisitCard(visit: visit(at: soon, clientConfirmedAt: DateTime.now())),
      );

      expect(find.textContaining('En attente du visiteur'), findsOneWidget);
      expect(find.text('Je suis sur place'), findsNothing);
    });

    testWidgets('RM-M07-07 — an agent is rated, an owner is not',
        (tester) async {
      await pump(
        tester,
        VisitCard(visit: visit(status: VisitStatus.completed, at: later)),
      );
      expect(find.text('Noter le visiteur'), findsOneWidget);

      await pump(
        tester,
        VisitCard(
          visit: visit(
            status: VisitStatus.completed,
            at: later,
            kind: VisitorKind.owner,
          ),
        ),
      );
      // The rating is of an agent's service; a prestataire showing their own
      // property has none to rate (RM-M07-07).
      expect(find.text('Noter le visiteur'), findsNothing);
    });

    testWidgets('a rating already given is not asked for twice',
        (tester) async {
      await pump(
        tester,
        VisitCard(
          visit: visit(status: VisitStatus.completed, at: later),
          isRated: true,
        ),
      );

      expect(find.textContaining('Merci'), findsOneWidget);
      expect(find.text('Noter le visiteur'), findsNothing);
    });

    testWidgets('a cancelled visit offers nothing at all', (tester) async {
      await pump(
        tester,
        VisitCard(visit: visit(status: VisitStatus.cancelled, at: later)),
      );

      expect(find.text('Annulée'), findsOneWidget);
      expect(find.text('Annuler la visite'), findsNothing);
      // Nor should it claim it is too late to cancel what is already gone.
      expect(find.textContaining('n\'est plus possible'), findsNothing);
    });
  });

  group('the booking sheet', () {
    late MockVisitBookingBloc booking;

    BookableVisitor visitor({String id = 'v-1', List<VisitSlot> slots = const []}) =>
        BookableVisitor(
          accountId: id,
          kind: VisitorKind.agent,
          displayName: 'Awa Nkeng',
          completedVisitCount: 24,
          slots: slots,
        );

    setUp(() {
      booking = MockVisitBookingBloc();
      when(() => booking.state).thenReturn(const BookingLoadInProgress());
    });

    Future<void> pumpSheet(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<VisitBookingBloc>.value(
            value: booking,
            child: const Scaffold(body: BookVisitSheetBody()),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('CE-M07-01 — says which kind of "nothing free" this is',
        (tester) async {
      when(() => booking.state).thenReturn(
        const BookingUnavailable(reason: NoSlotReason.noAvailability),
      );
      await pumpSheet(tester);

      // "Contactez le prestataire" was the old answer to four situations; the
      // true one here is that nobody declared their hours (RM-M15-01).
      expect(find.textContaining('déclaré'), findsOneWidget);
    });

    testWidgets('CA-M07-01 — one visitor, so the slot is the only choice',
        (tester) async {
      when(() => booking.state).thenReturn(
        BookingReady(
          annonceId: 'a-1',
          visitors: [
            visitor(slots: [VisitSlot(startsAt: later)]),
          ],
          selectedVisitorId: 'v-1',
        ),
      );
      await pumpSheet(tester);

      // The visitor picker would be a list of one.
      expect(find.text('Qui vous fait visiter'), findsNothing);
      expect(find.text('Choisissez un créneau'), findsOneWidget);
      // RM-M07-02 — said before the tap, not after.
      expect(find.textContaining('offerte'), findsOneWidget);
    });

    testWidgets('two visitors are a choice, with what tells them apart',
        (tester) async {
      when(() => booking.state).thenReturn(
        BookingReady(
          annonceId: 'a-1',
          visitors: [
            visitor(slots: [VisitSlot(startsAt: later)]),
            visitor(id: 'v-2', slots: [VisitSlot(startsAt: later)]),
          ],
        ),
      );
      await pumpSheet(tester);

      expect(find.text('Qui vous fait visiter'), findsOneWidget);
      expect(find.textContaining('24 visites'), findsNWidgets(2));
    });
  });
}
