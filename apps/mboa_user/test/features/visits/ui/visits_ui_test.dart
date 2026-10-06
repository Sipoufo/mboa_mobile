import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/visits/bloc/my_visits_bloc.dart';
import 'package:mboa_user/features/visits/bloc/visit_booking_bloc.dart';
import 'package:mboa_user/features/visits/bloc/write_review_bloc.dart';
import 'package:mboa_user/features/visits/models/bookable_visitor.dart';
import 'package:mboa_user/features/visits/ui/book_visit_sheet.dart';
import 'package:mboa_user/features/visits/ui/visit_detail_page.dart';
import 'package:mboa_user/features/visits/ui/write_review_page.dart';
import 'package:mboa_user/features/visits/ui/widgets/visit_card.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockMyVisitsBloc extends MockBloc<MyVisitsEvent, MyVisitsState>
    implements MyVisitsBloc {}

class MockWriteReviewBloc
    extends MockBloc<WriteReviewEvent, WriteReviewState>
    implements WriteReviewBloc {}

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

  /// For a child that scrolls on its own — a `ListView` inside the scroll view
  /// [pump] provides would have no height to lay out in.
  Future<void> pumpScrollable(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<MyVisitsBloc>.value(
          value: visits,
          child: Scaffold(body: child),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

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

    testWidgets('RM-M07bis-01 — a confirmed visit can be reported on',
        (tester) async {
      await pump(
        tester,
        VisitCard(visit: visit(status: VisitStatus.completed, at: later)),
      );

      expect(find.text('Laisser un avis'), findsOneWidget);
    });

    testWidgets('a visit already reported on offers to read, not to write',
        (tester) async {
      await pump(
        tester,
        VisitCard(
          visit: visit(status: VisitStatus.completed, at: later),
          isReviewed: true,
        ),
      );

      // RM-M07bis-01 — one report per visit; offering to write a second is
      // offering a refusal.
      expect(find.text('Laisser un avis'), findsNothing);
      expect(find.text('Voir mon avis'), findsOneWidget);
    });

    testWidgets('CE-M07bis-01 — a visit nobody confirmed cannot',
        (tester) async {
      await pump(
        tester,
        VisitCard(visit: visit(status: VisitStatus.notFulfilled, at: later)),
      );

      // "Effectuée — non confirmée par le client" looks like a visit that
      // happened; the CDC refuses a report because only one side vouched.
      expect(find.text('Laisser un avis'), findsNothing);
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

  group('the visit detail screen', () {
    testWidgets('RM-M07-05 — it says who is still awaited, by name',
        (tester) async {
      await pumpScrollable(
        tester,
        VisitDetailBody(
          visit: visit(at: soon, clientConfirmedAt: DateTime.now()),
        ),
      );

      // "Waiting" on its own is ambiguous: the tenant needs to know whether
      // they are the one being waited for.
      expect(find.text('Vous'), findsOneWidget);
      expect(find.text('Le visiteur'), findsOneWidget);
      expect(find.text('Confirmé'), findsOneWidget);
      expect(find.text('Pas encore'), findsOneWidget);
    });

    testWidgets('RM-M15-06 — a proposed slot cannot be confirmed by the tenant',
        (tester) async {
      await pumpScrollable(
        tester,
        VisitDetailBody(
          visit: visit(status: VisitStatus.requested, at: later),
        ),
      );

      expect(find.textContaining('doit encore confirmer'), findsOneWidget);
    });
  });

  group('writing the report (M07bis)', () {
    late MockWriteReviewBloc review;

    setUp(() {
      review = MockWriteReviewBloc();
      when(() => review.state)
          .thenReturn(const ReviewDraft(visitId: 'v-1'));
    });

    Future<void> pumpForm(WidgetTester tester, ReviewDraft draft) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: MultiBlocProvider(
            providers: [
              BlocProvider<WriteReviewBloc>.value(value: review),
              BlocProvider<MyVisitsBloc>.value(value: visits),
            ],
            child: Scaffold(body: WriteReviewForm(draft: draft)),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('it says it is public and final before a word is written',
        (tester) async {
      await pumpForm(tester, const ReviewDraft(visitId: 'v-1'));

      // RM-M07bis-03 and -05 after the fact would be a trap, not a notice.
      expect(find.textContaining('Publié sur la fiche'), findsOneWidget);
      expect(find.textContaining('ne pourrez plus le modifier'), findsOneWidget);
    });

    testWidgets('only the rating gates publishing', (tester) async {
      final publish = find.widgetWithText(Button, 'Publier mon avis');

      await pumpForm(tester, const ReviewDraft(visitId: 'v-1'));
      expect(tester.widget<Button>(publish).onPressed, isNull);

      // Everything else in M07bis's content table is optional.
      await pumpForm(tester, const ReviewDraft(visitId: 'v-1', rating: 4));
      expect(tester.widget<Button>(publish).onPressed, isNotNull);
    });

    testWidgets('the tenth photo closes the picker', (tester) async {
      await pumpForm(
        tester,
        ReviewDraft(
          visitId: 'v-1',
          photoKeys: [for (var i = 0; i < 10; i++) 'key-$i'],
        ),
      );

      // The photo block is below the fold on a test-sized screen.
      await tester.scrollUntilVisible(
        find.textContaining('10 photos'),
        300,
        scrollable: find.byType(Scrollable).first,
      );

      // The cap is M07bis's; an add button that refuses is worse than none.
      expect(find.byIcon(LucideIcons.plus), findsNothing);
      expect(find.textContaining('10 photos'), findsOneWidget);
    });
  });

  testWidgets('the review route carries both blocs it reads', (tester) async {
    // `/app/visits/:id/review` is pushed from the visit card, outside the
    // list's provider — and publishing makes the list re-read itself, so the
    // page reads `MyVisitsBloc` from a tree that did not have it. Third time
    // this shape has bitten; this is the shape, pinned.
    final review = MockWriteReviewBloc();
    when(() => review.state).thenReturn(const ReviewLoadInProgress());
    getIt.registerLazySingleton<MyVisitsBloc>(() => visits);
    getIt.registerFactory<WriteReviewBloc>(() => review);
    addTearDown(getIt.reset);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Builder(
          builder: (context) =>
              const WriteReviewPage(visitId: 'v-1').wrappedRoute(context),
        ),
      ),
    );
    // `pump`, not `pumpAndSettle`: the loader spins for ever by design.
    await tester.pump();

    // The listener reaches for `MyVisitsBloc` on publish; a missing provider
    // throws while building, exactly as it did on the device.
    expect(tester.takeException(), isNull);
    expect(find.byType(WriteReviewPage), findsOneWidget);
  });

  group('reading the published report (RM-M07bis-03, -06)', () {
    testWidgets('it reads back, locked, and can be taken away',
        (tester) async {
      await pumpScrollable(
        tester,
        const ReviewPublishedView(
          review: VisitReview(
            id: 'r-1',
            rating: 4,
            perceivedCondition: 3,
            comment: 'Lumineux, mais humide au mur nord.',
            pros: ['Quartier calme'],
            cons: ['Humidité'],
            comments: [ReviewComment(authorName: 'Awa', body: 'Repeint depuis.')],
          ),
        ),
      );

      expect(find.text('4/5'), findsOneWidget);
      expect(find.text('Quartier calme'), findsOneWidget);
      expect(find.text('Humidité'), findsOneWidget);
      // RM-M07bis-04 — the visitor answers beside the report, attributed.
      expect(find.text('Repeint depuis.'), findsOneWidget);
      // RM-M07bis-03 — said plainly, not discovered by trying to edit.
      expect(find.textContaining('ne peut plus être modifié'), findsOneWidget);
      expect(find.text('Télécharger en PDF'), findsOneWidget);
    });

    testWidgets('the download is one tap', (tester) async {
      var asked = false;
      await pumpScrollable(
        tester,
        ReviewPublishedView(
          review: const VisitReview(id: 'r-1', rating: 5),
          onDownload: () => asked = true,
        ),
      );

      await tester.tap(find.text('Télécharger en PDF'));
      expect(asked, isTrue);
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
            child: const Scaffold(body: BookVisitSheetBody(annonceId: 'a-1')),
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

    testWidgets('CE-M07-01 — a full week offers the way out of it',
        (tester) async {
      when(() => booking.state).thenReturn(
        const BookingUnavailable(reason: NoSlotReason.fullyBooked),
      );
      await pumpSheet(tester);

      // The provider can open another slot, and messaging is how one asks.
      // A sentence on its own left the tenant with nothing to do.
      expect(find.text('Contacter le prestataire'), findsOneWidget);
    });

    testWidgets('the day strip holds a day per published date', (tester) async {
      when(() => booking.state).thenReturn(
        BookingReady(
          annonceId: 'a-1',
          visitors: [
            visitor(
              slots: [
                VisitSlot(startsAt: DateTime(2026, 10, 5, 9)),
                VisitSlot(startsAt: DateTime(2026, 10, 5, 11)),
                VisitSlot(startsAt: DateTime(2026, 10, 7, 14)),
              ],
            ),
          ],
          selectedVisitorId: 'v-1',
        ),
      );
      await pumpSheet(tester);

      // Two days, and only the first day's hours — seven days of times in one
      // flat list is what the strip replaces.
      expect(find.text('5'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);
      expect(find.text('09:00'), findsOneWidget);
      expect(find.text('11:00'), findsOneWidget);
      expect(find.text('14:00'), findsNothing);

      await tester.tap(find.text('7'));
      await tester.pumpAndSettle();

      expect(find.text('14:00'), findsOneWidget);
      expect(find.text('09:00'), findsNothing);
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
      expect(find.text('Jour'), findsOneWidget);
      expect(find.text('Heure'), findsOneWidget);
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
