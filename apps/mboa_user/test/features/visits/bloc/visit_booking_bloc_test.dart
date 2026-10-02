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

  VisitBookingBloc build() => VisitBookingBloc(repository: repository);

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
    'a visitor with no free time is not a choice, whatever their mode',
    setUp: () => when(() => repository.visitorsFor('a-1')).thenAnswer(
      (_) async => [
        visitor(mode: BookingMode.onRequest, reason: NoSlotReason.fullyBooked),
      ],
    ),
    build: build,
    act: (bloc) => bloc.add(const BookingStarted('a-1')),
    verify: (bloc) {
      // `BookVisiteRequest` requires `startsAt`, so there is nothing to send
      // for a visitor who published no time — they are "nothing free".
      expect(bloc.state, isA<BookingUnavailable>());
    },
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
}
