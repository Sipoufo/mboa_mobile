import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/visits/bloc/visit_booking_bloc.dart';
import 'package:mboa_user/features/visits/data/visits_repository.dart';
import 'package:mboa_user/features/visits/models/bookable_visitor.dart';
import 'package:mocktail/mocktail.dart';

class MockVisitsRepository extends Mock implements VisitsRepository {}

/// Planning a visit (CDC M07).
void main() {
  late MockVisitsRepository repository;

  final slot = VisitSlot(startsAt: DateTime(2026, 10, 5, 10));
  final laterSlot = VisitSlot(startsAt: DateTime(2026, 10, 5, 15));

  BookableVisitor visitor({
    String id = 'v-1',
    VisitorKind kind = VisitorKind.agent,
    BookingMode mode = BookingMode.slots,
    List<VisitSlot> slots = const [],
    NoSlotReason? reason,
  }) =>
      BookableVisitor(
        accountId: id,
        kind: kind,
        displayName: 'Awa Nkeng',
        mode: mode,
        slots: slots,
        reason: reason,
      );

  Visit booked() => const Visit(id: 'visit-1', status: VisitStatus.scheduled);

  setUp(() {
    repository = MockVisitsRepository();
    when(
      () => repository.book(
        annonceId: any(named: 'annonceId'),
        visitorAccountId: any(named: 'visitorAccountId'),
        startsAt: any(named: 'startsAt'),
      ),
    ).thenAnswer((_) async => booked());
  });

  // A fixed clock: the slots below are on 5 October, a day after this.
  final now = DateTime(2026, 10, 4, 10);

  VisitBookingBloc build() =>
      VisitBookingBloc(repository: repository, now: () => now);

  blocTest<VisitBookingBloc, VisitBookingState>(
    'CA-M07-01 — a lone visitor is preselected, so the slot is the first tap',
    setUp: () => when(() => repository.visitorsFor('a-1')).thenAnswer(
      (_) async => [
        visitor(slots: [slot, laterSlot]),
      ],
    ),
    build: build,
    act: (bloc) => bloc.add(const BookingStarted('a-1')),
    verify: (bloc) {
      final state = bloc.state as BookingReady;
      expect(state.selectedVisitor?.accountId, 'v-1');
      expect(state.hasVisitorChoice, isFalse);
      // Nothing is booked until a time is chosen.
      expect(state.canSubmit, isFalse);
    },
  );

  blocTest<VisitBookingBloc, VisitBookingState>(
    'two visitors means a choice, and nothing is chosen for the tenant',
    setUp: () => when(() => repository.visitorsFor('a-1')).thenAnswer(
      (_) async => [
        visitor(slots: [slot]),
        visitor(id: 'v-2', kind: VisitorKind.owner, slots: [laterSlot]),
      ],
    ),
    build: build,
    act: (bloc) => bloc.add(const BookingStarted('a-1')),
    verify: (bloc) {
      final state = bloc.state as BookingReady;
      expect(state.hasVisitorChoice, isTrue);
      expect(state.selectedVisitorId, isNull);
    },
  );

  blocTest<VisitBookingBloc, VisitBookingState>(
    'changing visitor drops the time picked in the other one\'s calendar',
    setUp: () => when(() => repository.visitorsFor('a-1')).thenAnswer(
      (_) async => [
        visitor(slots: [slot]),
        visitor(id: 'v-2', slots: [laterSlot]),
      ],
    ),
    build: build,
    act: (bloc) => bloc
      ..add(const BookingStarted('a-1'))
      ..add(const BookingVisitorSelected('v-1'))
      ..add(BookingSlotSelected(slot))
      ..add(const BookingVisitorSelected('v-2')),
    verify: (bloc) {
      // Keeping it would book a time the new visitor never offered.
      expect((bloc.state as BookingReady).selectedSlot, isNull);
    },
  );

  blocTest<VisitBookingBloc, VisitBookingState>(
    '§19 — an owner who publishes no slots is still a choice',
    setUp: () => when(() => repository.visitorsFor('a-1')).thenAnswer(
      (_) async => [visitor(kind: VisitorKind.owner, mode: BookingMode.onRequest)],
    ),
    build: build,
    act: (bloc) => bloc.add(const BookingStarted('a-1')),
    verify: (bloc) {
      // This test used to assert the opposite — "nothing to send for a visitor
      // who published no time" — which is exactly why a listing shown only by
      // its owner could not be booked. The tenant proposes the time instead.
      final state = bloc.state as BookingReady;
      expect(state.selectedVisitor?.mode, BookingMode.onRequest);
      // No calendar to page through for an owner alone.
      expect(state.pageable, isFalse);
    },
  );

  blocTest<VisitBookingBloc, VisitBookingState>(
    'a slot visitor with nothing free this week is not a choice',
    setUp: () => when(() => repository.visitorsFor('a-1')).thenAnswer(
      (_) async => [visitor(reason: NoSlotReason.fullyBooked)],
    ),
    build: build,
    act: (bloc) => bloc.add(const BookingStarted('a-1')),
    verify: (bloc) => expect(bloc.state, isA<BookingUnavailable>()),
  );

  blocTest<VisitBookingBloc, VisitBookingState>(
    'CE-M07-01 — nothing free comes with the reason, not an empty list',
    setUp: () => when(() => repository.visitorsFor('a-1')).thenAnswer(
      (_) async => [visitor(reason: NoSlotReason.noAvailability)],
    ),
    build: build,
    act: (bloc) => bloc.add(const BookingStarted('a-1')),
    verify: (bloc) {
      // Without it the screen could only say "contact the prestataire", while
      // the real answer is that nobody declared their hours (RM-M15-01).
      expect(
        (bloc.state as BookingUnavailable).reason,
        NoSlotReason.noAvailability,
      );
    },
  );

  blocTest<VisitBookingBloc, VisitBookingState>(
    'RM-M07-03 — a second visit on the same property is not a failure',
    setUp: () {
      when(() => repository.visitorsFor('a-1')).thenAnswer(
        (_) async => [
          visitor(slots: [slot]),
        ],
      );
      when(
        () => repository.book(
          annonceId: any(named: 'annonceId'),
          visitorAccountId: any(named: 'visitorAccountId'),
          startsAt: any(named: 'startsAt'),
        ),
      ).thenThrow(const VisitAlreadyBooked());
    },
    build: build,
    act: (bloc) => bloc
      ..add(const BookingStarted('a-1'))
      ..add(BookingSlotSelected(slot))
      ..add(const BookingSubmitted()),
    verify: (bloc) {
      final state = bloc.state as BookingReady;
      // The visit they already have is the answer; the sheet stays open to
      // say so rather than reporting that something went wrong.
      expect(state.alreadyBooked, isTrue);
      expect(state.failed, isFalse);
    },
  );

  blocTest<VisitBookingBloc, VisitBookingState>(
    'a booking carries how it was made, because the wording differs',
    setUp: () => when(() => repository.visitorsFor('a-1')).thenAnswer(
      (_) async => [
        visitor(mode: BookingMode.onRequest, slots: [slot]),
      ],
    ),
    build: build,
    act: (bloc) => bloc
      ..add(const BookingStarted('a-1'))
      ..add(BookingSlotSelected(slot))
      ..add(const BookingSubmitted()),
    verify: (bloc) {
      // A published slot is confirmed; a request still waits on the visitor.
      expect((bloc.state as BookingDone).mode, BookingMode.onRequest);
    },
  );

  group('§21 — paging through the calendar', () {
    blocTest<VisitBookingBloc, VisitBookingState>(
      'the next week starts at midnight, seven days on',
      setUp: () {
        when(() => repository.visitorsFor('a-1'))
            .thenAnswer((_) async => [visitor(slots: [slot])]);
        when(
          () => repository.visitorsFor('a-1', from: DateTime(2026, 10, 11)),
        ).thenAnswer((_) async => [visitor(slots: [laterSlot])]);
      },
      build: build,
      act: (bloc) => bloc
        ..add(const BookingStarted('a-1'))
        ..add(const BookingWeekChanged(1)),
      verify: (bloc) {
        // Midnight, not "now + 7 days": a page is whole days, and the fourth
        // one then ends exactly on the 28th day the server allows.
        verify(
          () => repository.visitorsFor('a-1', from: DateTime(2026, 10, 11)),
        ).called(1);
        final state = bloc.state as BookingReady;
        expect(state.weekOffset, 1);
        expect(state.windowStart, DateTime(2026, 10, 11));
      },
    );

    blocTest<VisitBookingBloc, VisitBookingState>(
      'turning the page keeps who the tenant chose',
      setUp: () {
        when(() => repository.visitorsFor('a-1')).thenAnswer(
          (_) async => [
            visitor(id: 'v-1', slots: [slot]),
            visitor(id: 'v-2', slots: [laterSlot]),
          ],
        );
        when(
          () => repository.visitorsFor('a-1', from: any(named: 'from')),
        ).thenAnswer(
          (_) async => [
            visitor(id: 'v-1', slots: [slot]),
            visitor(id: 'v-2', slots: [laterSlot]),
          ],
        );
      },
      build: build,
      act: (bloc) => bloc
        ..add(const BookingStarted('a-1'))
        ..add(const BookingVisitorSelected('v-2'))
        ..add(const BookingWeekChanged(1)),
      verify: (bloc) =>
          expect((bloc.state as BookingReady).selectedVisitorId, 'v-2'),
    );

    blocTest<VisitBookingBloc, VisitBookingState>(
      'the calendar stops at the 28th day',
      setUp: () => when(
        () => repository.visitorsFor('a-1', from: any(named: 'from')),
      ).thenAnswer((_) async => [visitor(slots: [slot])]),
      build: build,
      seed: () => BookingReady(
        annonceId: 'a-1',
        visitors: [visitor(slots: [slot])],
        weekOffset: VisitBookingBloc.maxWeekOffset,
      ),
      act: (bloc) => bloc.add(const BookingWeekChanged(99)),
      verify: (bloc) {
        // Clamped to the last week rather than sent to be refused
        // (`400 INVALID_WINDOW`).
        expect(
          (bloc.state as BookingReady).weekOffset,
          VisitBookingBloc.maxWeekOffset,
        );
        expect((bloc.state as BookingReady).canGoNextWeek, isFalse);
      },
    );

    blocTest<VisitBookingBloc, VisitBookingState>(
      'a full week can be paged past; an unset agenda cannot',
      setUp: () => when(() => repository.visitorsFor('a-1')).thenAnswer(
        (_) async => [visitor(reason: NoSlotReason.fullyBooked)],
      ),
      build: build,
      act: (bloc) => bloc.add(const BookingStarted('a-1')),
      verify: (bloc) =>
          expect((bloc.state as BookingUnavailable).canSeeNextWeek, isTrue),
    );
  });

  group('§19 — proposing a time to the owner', () {
    BookingReady proposing(DateTime at) => BookingReady(
          annonceId: 'a-1',
          visitors: [
            visitor(kind: VisitorKind.owner, mode: BookingMode.onRequest),
          ],
          selectedVisitorId: 'v-1',
          selectedSlot: VisitSlot(startsAt: at),
        );

    blocTest<VisitBookingBloc, VisitBookingState>(
      'less than an hour ahead is refused before it is sent',
      build: build,
      seed: () => proposing(now.add(const Duration(minutes: 30))),
      act: (bloc) => bloc.add(const BookingSubmitted()),
      verify: (bloc) {
        expect((bloc.state as BookingReady).timeRejected, isTrue);
        verifyNever(
          () => repository.book(
            annonceId: any(named: 'annonceId'),
            visitorAccountId: any(named: 'visitorAccountId'),
            startsAt: any(named: 'startsAt'),
          ),
        );
      },
    );

    blocTest<VisitBookingBloc, VisitBookingState>(
      'more than 60 days out is refused before it is sent',
      build: build,
      seed: () => proposing(now.add(const Duration(days: 61))),
      act: (bloc) => bloc.add(const BookingSubmitted()),
      verify: (bloc) =>
          expect((bloc.state as BookingReady).timeRejected, isTrue),
    );

    blocTest<VisitBookingBloc, VisitBookingState>(
      'a valid proposal is sent, and becomes a request',
      build: build,
      seed: () => proposing(now.add(const Duration(days: 3))),
      act: (bloc) => bloc.add(const BookingSubmitted()),
      verify: (bloc) =>
          expect((bloc.state as BookingDone).mode, BookingMode.onRequest),
    );

    blocTest<VisitBookingBloc, VisitBookingState>(
      'the server refusing the time says which rule, not "an error"',
      setUp: () => when(
        () => repository.book(
          annonceId: any(named: 'annonceId'),
          visitorAccountId: any(named: 'visitorAccountId'),
          startsAt: any(named: 'startsAt'),
        ),
      ).thenThrow(const VisitTimeRejected()),
      build: build,
      seed: () => proposing(now.add(const Duration(days: 3))),
      act: (bloc) => bloc.add(const BookingSubmitted()),
      verify: (bloc) {
        final state = bloc.state as BookingReady;
        expect(state.timeRejected, isTrue);
        expect(state.failed, isFalse);
      },
    );
  });
}
