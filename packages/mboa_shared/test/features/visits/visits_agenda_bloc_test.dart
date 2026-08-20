import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockVisitsSource extends Mock implements VisitsSource {}

Visit visit({
  String id = 'v-1',
  VisitStatus status = VisitStatus.scheduled,
  DateTime? at,
}) =>
    Visit(
      id: id,
      status: status,
      annonceTitle: 'Studio Bonapriso',
      scheduledAt: at,
    );

/// The agenda both personas read (M16 for the agent, RM-M15-06 for a
/// prestataire showing his own property).
void main() {
  late MockVisitsSource source;

  // A Wednesday, so the week has days either side of "today" in both
  // directions — a Monday or a Sunday would hide an off-by-one in the strip.
  final today = DateTime(2026, 8, 19, 10);
  final monday = DateTime(2026, 8, 17);

  setUp(() {
    source = MockVisitsSource();
    when(() => source.range(from: any(named: 'from'), to: any(named: 'to')))
        .thenAnswer((_) async => []);
  });

  VisitsAgendaBloc build() =>
      VisitsAgendaBloc(source: source, today: today);

  blocTest<VisitsAgendaBloc, VisitsAgendaState>(
    'opens on today, and asks for that week only',
    build: build,
    act: (bloc) => bloc.add(const AgendaRequested()),
    verify: (bloc) {
      final state = bloc.state as VisitsAgendaReady;
      expect(state.weekStart, monday);
      expect(state.selectedDay, DateTime(2026, 8, 19));
      expect(state.isOnToday, isTrue);
      // One week per request: the agenda shows a week, so it reads a week.
      verify(
        () => source.range(from: monday, to: DateTime(2026, 8, 24)),
      ).called(1);
    },
  );

  blocTest<VisitsAgendaBloc, VisitsAgendaState>(
    'the week starts on Monday, like the availability grid',
    build: build,
    act: (bloc) => bloc.add(AgendaRequested(day: DateTime(2026, 8, 23))),
    // 23 August 2026 is a Sunday — the last cell of that week, not the first
    // of the next.
    verify: (bloc) =>
        expect((bloc.state as VisitsAgendaReady).weekStart, monday),
  );

  blocTest<VisitsAgendaBloc, VisitsAgendaState>(
    'groups a day, in time order',
    setUp: () => when(
      () => source.range(from: any(named: 'from'), to: any(named: 'to')),
    ).thenAnswer(
      (_) async => [
        visit(id: 'late', at: DateTime(2026, 8, 19, 16)),
        visit(id: 'early', at: DateTime(2026, 8, 19, 8)),
        visit(id: 'friday', at: DateTime(2026, 8, 21, 9)),
      ],
    ),
    build: build,
    act: (bloc) => bloc.add(const AgendaRequested()),
    verify: (bloc) {
      final state = bloc.state as VisitsAgendaReady;
      expect(state.selectedVisits.map((v) => v.id), ['early', 'late']);
      expect(state.countOn(DateTime(2026, 8, 21)), 1);
    },
  );

  blocTest<VisitsAgendaBloc, VisitsAgendaState>(
    'a cancelled visit stays in the day but not on the dot',
    setUp: () => when(
      () => source.range(from: any(named: 'from'), to: any(named: 'to')),
    ).thenAnswer(
      (_) async => [
        visit(
          id: 'off',
          status: VisitStatus.cancelled,
          at: DateTime(2026, 8, 19, 8),
        ),
      ],
    ),
    build: build,
    act: (bloc) => bloc.add(const AgendaRequested()),
    verify: (bloc) {
      final state = bloc.state as VisitsAgendaReady;
      // Dropping it would answer "nothing that day" for a day something was
      // planned; counting it would send someone to an empty morning.
      expect(state.selectedVisits, hasLength(1));
      expect(state.countOn(DateTime(2026, 8, 19)), 0);
    },
  );

  blocTest<VisitsAgendaBloc, VisitsAgendaState>(
    'selecting a day of another week moves the week with it',
    build: build,
    seed: () => VisitsAgendaReady(
      weekStart: monday,
      selectedDay: DateTime(2026, 8, 19),
      today: DateTime(2026, 8, 19),
    ),
    act: (bloc) => bloc.add(AgendaDaySelected(DateTime(2026, 8, 26))),
    wait: const Duration(milliseconds: 10),
    verify: (bloc) {
      final state = bloc.state as VisitsAgendaReady;
      expect(state.weekStart, DateTime(2026, 8, 24));
      expect(state.selectedDay, DateTime(2026, 8, 26));
      verify(
        () => source.range(
          from: DateTime(2026, 8, 24),
          to: DateTime(2026, 8, 31),
        ),
      ).called(1);
    },
  );

  blocTest<VisitsAgendaBloc, VisitsAgendaState>(
    'selecting a day of the same week asks for nothing',
    build: build,
    seed: () => VisitsAgendaReady(
      weekStart: monday,
      selectedDay: DateTime(2026, 8, 19),
      today: DateTime(2026, 8, 19),
      visits: [visit(at: DateTime(2026, 8, 21, 9))],
    ),
    act: (bloc) => bloc.add(AgendaDaySelected(DateTime(2026, 8, 21))),
    verify: (bloc) {
      // The week is already in hand — re-reading it would blink the list for
      // data the bloc is holding.
      verifyNever(
        () => source.range(from: any(named: 'from'), to: any(named: 'to')),
      );
      expect((bloc.state as VisitsAgendaReady).selectedVisits, hasLength(1));
    },
  );

  blocTest<VisitsAgendaBloc, VisitsAgendaState>(
    'a week being read keeps the previous one on screen',
    build: build,
    seed: () => VisitsAgendaReady(
      weekStart: monday,
      selectedDay: DateTime(2026, 8, 19),
      today: DateTime(2026, 8, 19),
      visits: [visit(at: DateTime(2026, 8, 19, 9))],
    ),
    act: (bloc) => bloc.add(AgendaWeekChanged(DateTime(2026, 8, 24))),
    expect: () => [
      // Blanking the list on every arrow tap makes a week look empty before it
      // has been read.
      isA<VisitsAgendaReady>()
          .having((s) => s.isLoadingWeek, 'isLoadingWeek', isTrue)
          .having((s) => s.visits, 'visits', hasLength(1)),
      isA<VisitsAgendaReady>()
          .having((s) => s.weekStart, 'weekStart', DateTime(2026, 8, 24)),
    ],
  );

  blocTest<VisitsAgendaBloc, VisitsAgendaState>(
    'RM-M15-06 — proposed times are collected across the whole week',
    setUp: () => when(
      () => source.range(from: any(named: 'from'), to: any(named: 'to')),
    ).thenAnswer(
      (_) async => [
        visit(
          id: 'ask',
          status: VisitStatus.requested,
          at: DateTime(2026, 8, 21, 9),
        ),
        visit(id: 'set', at: DateTime(2026, 8, 19, 9)),
      ],
    ),
    build: build,
    act: (bloc) => bloc.add(const AgendaRequested()),
    verify: (bloc) {
      final state = bloc.state as VisitsAgendaReady;
      // They are answered whenever the app is opened, not on the day they
      // fall, so they are not filtered to the selected day.
      expect(state.awaitingAnswer.map((v) => v.id), ['ask']);
      expect(state.selectedVisits.map((v) => v.id), ['set']);
    },
  );

  blocTest<VisitsAgendaBloc, VisitsAgendaState>(
    'a failed read is a failure, not an empty week',
    setUp: () => when(
      () => source.range(from: any(named: 'from'), to: any(named: 'to')),
    ).thenThrow(Exception('offline')),
    build: build,
    act: (bloc) => bloc.add(const AgendaRequested()),
    // An empty agenda and an unreachable one look the same on screen, and one
    // of them means "you have nothing to do today".
    verify: (bloc) => expect(bloc.state, isA<VisitsAgendaFailure>()),
  );
}
