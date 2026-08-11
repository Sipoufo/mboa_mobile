import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/agent/bloc/agent_availability_bloc.dart';
import 'package:mboa_pro/features/agent/data/agent_repository.dart';
import 'package:mboa_pro/features/agent/models/availability.dart';
import 'package:mocktail/mocktail.dart';

class MockAvailabilityRepository extends Mock
    implements AgentAvailabilityRepository {}

AvailabilityRule rule(int day, int from, int to) => AvailabilityRule(
      dayOfWeek: day,
      start: TimeOfDay(hour: from, minute: 0),
      end: TimeOfDay(hour: to, minute: 0),
    );

/// The weekly pattern is edited locally and PUT as a whole; days off are saved
/// the moment they are tapped, because blocking one cancels the visits already
/// booked on it (RM-M15-03).
void main() {
  late MockAvailabilityRepository repository;

  final monday = rule(1, 8, 12);

  setUpAll(() => registerFallbackValue(const Availability()));

  setUp(() => repository = MockAvailabilityRepository());

  AgentAvailabilityBloc build() =>
      AgentAvailabilityBloc(repository: repository);

  AvailabilityReady seeded([Availability? availability]) {
    final value = availability ?? Availability(rules: [monday]);
    return AvailabilityReady(saved: value, draft: value);
  }

  blocTest<AgentAvailabilityBloc, AgentAvailabilityState>(
    'loads the week',
    setUp: () => when(repository.load)
        .thenAnswer((_) async => Availability(rules: [monday])),
    build: build,
    act: (bloc) => bloc.add(const AvailabilityLoadRequested()),
    verify: (bloc) {
      final state = bloc.state as AvailabilityReady;
      expect(state.draft.rules, [monday]);
      // Nothing edited yet, so nothing to save.
      expect(state.isDirty, isFalse);
    },
  );

  group('editing the week', () {
    blocTest<AgentAvailabilityBloc, AgentAvailabilityState>(
      'adding a window marks the form dirty without touching the server',
      build: build,
      seed: seeded,
      act: (bloc) => bloc.add(AvailabilityRuleAdded(rule(2, 9, 17))),
      verify: (bloc) {
        final state = bloc.state as AvailabilityReady;
        expect(state.draft.rules, hasLength(2));
        expect(state.isDirty, isTrue);
        verifyNever(() => repository.save(any()));
      },
    );

    blocTest<AgentAvailabilityBloc, AgentAvailabilityState>(
      'refuses a window that overlaps one on the same day',
      build: build,
      seed: seeded,
      act: (bloc) => bloc.add(AvailabilityRuleAdded(rule(1, 11, 15))),
      verify: (bloc) {
        final state = bloc.state as AvailabilityReady;
        // Two overlapping windows are two ways of writing one; the backend
        // stores them verbatim, so the form is where this is caught.
        expect(state.draft.rules, hasLength(1));
        expect(state.rejected, isTrue);
      },
    );

    blocTest<AgentAvailabilityBloc, AgentAvailabilityState>(
      'accepts a window that merely touches another',
      build: build,
      seed: seeded,
      act: (bloc) => bloc.add(AvailabilityRuleAdded(rule(1, 12, 18))),
      verify: (bloc) => expect(
        (bloc.state as AvailabilityReady).draft.rules,
        hasLength(2),
      ),
    );

    blocTest<AgentAvailabilityBloc, AgentAvailabilityState>(
      'refuses a window that ends before it starts',
      build: build,
      seed: seeded,
      act: (bloc) => bloc.add(AvailabilityRuleAdded(rule(3, 18, 8))),
      verify: (bloc) => expect(
        (bloc.state as AvailabilityReady).rejected,
        isTrue,
      ),
    );

    blocTest<AgentAvailabilityBloc, AgentAvailabilityState>(
      'editing a window does not clash with itself',
      build: build,
      seed: seeded,
      act: (bloc) => bloc.add(
        AvailabilityRuleChanged(before: monday, after: rule(1, 9, 13)),
      ),
      verify: (bloc) {
        final state = bloc.state as AvailabilityReady;
        expect(state.draft.rules.single, rule(1, 9, 13));
        expect(state.rejected, isFalse);
      },
    );

    blocTest<AgentAvailabilityBloc, AgentAvailabilityState>(
      'clamps the visit duration to what the endpoint accepts',
      build: build,
      seed: seeded,
      act: (bloc) => bloc
        ..add(const VisitDurationChanged(5))
        ..add(const VisitDurationChanged(900)),
      verify: (bloc) => expect(
        (bloc.state as AvailabilityReady).draft.visitDurationMinutes,
        Availability.maxVisitMinutes,
      ),
    );
  });

  blocTest<AgentAvailabilityBloc, AgentAvailabilityState>(
    'saving replaces the whole week and clears the dirty flag',
    setUp: () => when(() => repository.save(any())).thenAnswer(
      (invocation) async => invocation.positionalArguments.first as Availability,
    ),
    build: build,
    seed: seeded,
    act: (bloc) => bloc
      ..add(AvailabilityRuleAdded(rule(2, 9, 17)))
      ..add(const AvailabilitySaveRequested()),
    verify: (bloc) {
      final state = bloc.state as AvailabilityReady;
      expect(state.isDirty, isFalse);
      expect(state.saved.rules, hasLength(2));
    },
  );

  blocTest<AgentAvailabilityBloc, AgentAvailabilityState>(
    'a clean form does not call the server',
    build: build,
    seed: seeded,
    act: (bloc) => bloc.add(const AvailabilitySaveRequested()),
    verify: (_) => verifyNever(() => repository.save(any())),
  );

  group('days off (RM-M15-03)', () {
    final day = DateTime(2026, 8, 20);

    blocTest<AgentAvailabilityBloc, AgentAvailabilityState>(
      'blocking a day saves immediately, not behind the form',
      setUp: () =>
          when(() => repository.blockDay(day)).thenAnswer((_) async {}),
      build: build,
      seed: seeded,
      act: (bloc) => bloc.add(DayOffBlocked(day)),
      verify: (bloc) {
        final state = bloc.state as AvailabilityReady;
        // It cancels visits already booked that day — not a side effect to
        // leave sitting in an unsaved form.
        expect(state.saved.isDayOff(day), isTrue);
        expect(state.isDirty, isFalse);
        verify(() => repository.blockDay(day)).called(1);
      },
    );

    blocTest<AgentAvailabilityBloc, AgentAvailabilityState>(
      'unblocking removes it',
      setUp: () =>
          when(() => repository.unblockDay(day)).thenAnswer((_) async {}),
      build: build,
      seed: () => seeded(Availability(rules: [monday], daysOff: [day])),
      act: (bloc) => bloc.add(DayOffUnblocked(day)),
      verify: (bloc) => expect(
        (bloc.state as AvailabilityReady).saved.isDayOff(day),
        isFalse,
      ),
    );

    blocTest<AgentAvailabilityBloc, AgentAvailabilityState>(
      'a failed block does not pretend the day is off',
      setUp: () => when(() => repository.blockDay(day)).thenThrow(Exception()),
      build: build,
      seed: seeded,
      act: (bloc) => bloc.add(DayOffBlocked(day)),
      verify: (bloc) {
        final state = bloc.state as AvailabilityReady;
        expect(state.saved.isDayOff(day), isFalse);
        expect(state.lastActionFailed, isTrue);
      },
    );
  });
}
