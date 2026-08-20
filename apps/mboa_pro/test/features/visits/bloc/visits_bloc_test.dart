import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/annonces/data/location_capture.dart';
import 'package:mboa_pro/features/visits/bloc/agent_visits_bloc.dart';
import 'package:mboa_pro/features/visits/bloc/visit_detail_bloc.dart';
import 'package:mboa_pro/features/visits/data/agent_visit_repository.dart';
import 'package:mboa_pro/features/visits/models/agent_visit.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockAgentVisitRepository extends Mock implements AgentVisitRepository {}

class MockLocationCapture extends Mock implements LocationCapture {}

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

/// The agent's visits (CDC M16).
void main() {
  late MockAgentVisitRepository repository;
  late MockLocationCapture location;

  final now = DateTime.now();
  final earlierToday = DateTime(now.year, now.month, now.day, 8);
  final laterToday = DateTime(now.year, now.month, now.day, 23, 59);
  final tomorrow = now.add(const Duration(days: 1));
  final lastWeek = now.subtract(const Duration(days: 7));

  setUp(() {
    repository = MockAgentVisitRepository();
    location = MockLocationCapture();
  });

  group('the list', () {
    AgentVisitsBloc build() => AgentVisitsBloc(repository: repository);

    blocTest<AgentVisitsBloc, AgentVisitsState>(
      'opens on today — the agent wants to know where they are going now',
      setUp: () => when(repository.list).thenAnswer((_) async => []),
      build: build,
      act: (bloc) => bloc.add(const VisitsLoadRequested()),
      verify: (bloc) => expect(
        (bloc.state as VisitsReady).filter,
        VisitFilter.today,
      ),
    );

    blocTest<AgentVisitsBloc, AgentVisitsState>(
      'a visit earlier today is still today, not past',
      setUp: () => when(repository.list)
          .thenAnswer((_) async => [visit(at: earlierToday)]),
      build: build,
      act: (bloc) => bloc.add(const VisitsLoadRequested()),
      verify: (bloc) {
        final state = bloc.state as VisitsReady;
        // 08:00 is still the agent's work at 09:00; treating "past" as "before
        // now" would empty the tab they rely on during the day.
        expect(state.today, hasLength(1));
        expect(state.past, isEmpty);
        expect(state.upcoming, isEmpty);
      },
    );

    blocTest<AgentVisitsBloc, AgentVisitsState>(
      'splits today, upcoming and past',
      setUp: () => when(repository.list).thenAnswer(
        (_) async => [
          visit(id: 'today', at: laterToday),
          visit(id: 'tomorrow', at: tomorrow),
          visit(id: 'done', status: VisitStatus.completed, at: lastWeek),
          visit(id: 'cancelled', status: VisitStatus.cancelled, at: tomorrow),
        ],
      ),
      build: build,
      act: (bloc) => bloc.add(const VisitsLoadRequested()),
      verify: (bloc) {
        final state = bloc.state as VisitsReady;
        expect(state.today.map((v) => v.id), ['today']);
        expect(state.upcoming.map((v) => v.id), ['tomorrow']);
        // A cancelled visit is over whatever its date said.
        expect(state.past.map((v) => v.id), containsAll(['done', 'cancelled']));
      },
    );

    blocTest<AgentVisitsBloc, AgentVisitsState>(
      'a scheduled visit whose slot has passed shows under past',
      setUp: () => when(repository.list).thenAnswer(
        (_) async => [visit(id: 'missed', at: lastWeek)],
      ),
      build: build,
      act: (bloc) => bloc.add(const VisitsLoadRequested()),
      verify: (bloc) {
        // Never carried out and never cancelled — the one an agent most needs
        // to see, so it must not vanish from every tab.
        final state = bloc.state as VisitsReady;
        expect(state.past.map((v) => v.id), ['missed']);
      },
    );

    blocTest<AgentVisitsBloc, AgentVisitsState>(
      'today is ordered by time',
      setUp: () => when(repository.list).thenAnswer(
        (_) async => [
          visit(id: 'late', at: laterToday),
          visit(id: 'early', at: earlierToday),
        ],
      ),
      build: build,
      act: (bloc) => bloc.add(const VisitsLoadRequested()),
      verify: (bloc) => expect(
        (bloc.state as VisitsReady).today.map((v) => v.id),
        ['early', 'late'],
      ),
    );

    blocTest<AgentVisitsBloc, AgentVisitsState>(
      'cancelling reloads — the server owns the one-hour cutoff',
      setUp: () {
        when(repository.list).thenAnswer((_) async => []);
        when(() => repository.cancel('v-1')).thenAnswer((_) async {});
      },
      build: build,
      seed: () => VisitsReady(visits: [visit(at: tomorrow)]),
      act: (bloc) => bloc.add(VisitCancelled(visit(at: tomorrow))),
      verify: (bloc) {
        // RM-M16-04 — the app does not re-derive the deadline.
        verify(repository.list).called(1);
        expect((bloc.state as VisitsReady).mutatingId, isNull);
      },
    );

    blocTest<AgentVisitsBloc, AgentVisitsState>(
      'a refused cancellation leaves the visit standing',
      setUp: () =>
          when(() => repository.cancel('v-1')).thenThrow(Exception('too late')),
      build: build,
      seed: () => VisitsReady(visits: [visit(at: tomorrow)]),
      act: (bloc) => bloc.add(VisitCancelled(visit(at: tomorrow))),
      verify: (bloc) {
        final state = bloc.state as VisitsReady;
        expect(state.lastActionFailed, isTrue);
        expect(state.upcoming, hasLength(1));
      },
    );
  });

  group('confirming presence (RM-M07-05 / RM-M16-02)', () {
    const nearby = (latitude: 4.0500, longitude: 9.7000, cityName: 'Douala');
    // ~1.1 km away.
    const faraway = (latitude: 4.0600, longitude: 9.7000, cityName: 'Douala');

    AgentVisitDetail detail({bool canConfirm = true}) => AgentVisitDetail(
          id: 'v-1',
          status: VisitStatus.scheduled,
          annonceTitle: 'Studio Bonapriso',
          latitude: 4.0500,
          longitude: 9.7000,
          canConfirm: canConfirm,
        );

    VisitDetailBloc build() =>
        VisitDetailBloc(repository: repository, location: location);

    blocTest<VisitDetailBloc, VisitDetailState>(
      'inside the radius confirms without asking anything',
      setUp: () {
        when(location.current).thenAnswer((_) async => nearby);
        when(() => repository.confirmPresence(
              'v-1',
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              overrideReason: any(named: 'overrideReason'),
            )).thenAnswer((_) async {});
        when(() => repository.detail('v-1'))
            .thenAnswer((_) async => detail());
      },
      build: build,
      seed: () => VisitDetailReady(detail()),
      act: (bloc) => bloc.add(const VisitPresenceConfirmed()),
      verify: (bloc) {
        expect((bloc.state as VisitDetailReady).needsOverride, isFalse);
        verify(() => repository.confirmPresence(
              'v-1',
              latitude: nearby.latitude,
              longitude: nearby.longitude,
              overrideReason: null,
            )).called(1);
      },
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'beyond 500 m asks for a justification instead of confirming',
      setUp: () => when(location.current).thenAnswer((_) async => faraway),
      build: build,
      seed: () => VisitDetailReady(detail()),
      act: (bloc) => bloc.add(const VisitPresenceConfirmed()),
      verify: (bloc) {
        final state = bloc.state as VisitDetailReady;
        expect(state.needsOverride, isTrue);
        expect(state.distanceMetres, greaterThan(500));
        // Nothing sent yet — the agent has not explained themselves.
        verifyNever(() => repository.confirmPresence(
              any(),
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              overrideReason: any(named: 'overrideReason'),
            ));
      },
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'the justification is sent with the fix that triggered it',
      setUp: () {
        when(() => repository.confirmPresence(
              'v-1',
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              overrideReason: any(named: 'overrideReason'),
            )).thenAnswer((_) async {});
        when(() => repository.detail('v-1'))
            .thenAnswer((_) async => detail());
      },
      build: build,
      seed: () => VisitDetailReady(
        detail(),
        pendingFix: faraway,
        distanceMetres: 1100,
      ),
      act: (bloc) =>
          bloc.add(const VisitPresenceOverridden('GPS imprécis, je suis au portail')),
      verify: (_) => verify(() => repository.confirmPresence(
            'v-1',
            latitude: faraway.latitude,
            longitude: faraway.longitude,
            overrideReason: 'GPS imprécis, je suis au portail',
          )).called(1),
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'a property with no coordinates never demands a justification',
      setUp: () {
        when(location.current).thenAnswer((_) async => faraway);
        when(() => repository.confirmPresence(
              'v-1',
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              overrideReason: any(named: 'overrideReason'),
            )).thenAnswer((_) async {});
        when(() => repository.detail('v-1')).thenAnswer(
          (_) async => const AgentVisitDetail(
            id: 'v-1',
            status: VisitStatus.scheduled,
          ),
        );
      },
      build: build,
      seed: () => const VisitDetailReady(
        AgentVisitDetail(id: 'v-1', status: VisitStatus.scheduled),
      ),
      act: (bloc) => bloc.add(const VisitPresenceConfirmed()),
      verify: (bloc) {
        // The listing is missing its position; refusing to confirm would
        // punish the agent for somebody else's omission.
        expect((bloc.state as VisitDetailReady).needsOverride, isFalse);
        verify(() => repository.confirmPresence(
              'v-1',
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              overrideReason: null,
            )).called(1);
      },
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'confirming is only half — the visit waits on the client (RM-M07-05)',
      setUp: () {
        when(location.current).thenAnswer((_) async => nearby);
        when(() => repository.confirmPresence(
              'v-1',
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              overrideReason: any(named: 'overrideReason'),
            )).thenAnswer((_) async {});
        // What the server sends back: the agent is in, the client is not, and
        // the status is still SCHEDULED.
        when(() => repository.detail('v-1')).thenAnswer(
          (_) async => AgentVisitDetail(
            id: 'v-1',
            status: VisitStatus.scheduled,
            canConfirm: false,
            visitorConfirmedAt: DateTime.now(),
          ),
        );
      },
      build: build,
      seed: () => VisitDetailReady(detail()),
      act: (bloc) => bloc.add(const VisitPresenceConfirmed()),
      verify: (bloc) {
        final visit = (bloc.state as VisitDetailReady).visit;
        expect(visit.hasConfirmed, isTrue);
        // Neither party can supply the other's confirmation, so the screen
        // says who is being waited on rather than offering the button again.
        expect(visit.isAwaitingClient, isTrue);
        expect(visit.status, VisitStatus.scheduled);
      },
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'a refused location says which permission is missing',
      setUp: () => when(location.current).thenThrow(
        const LocationCaptureException(LocationFailure.deniedForever),
      ),
      build: build,
      seed: () => VisitDetailReady(detail()),
      act: (bloc) => bloc.add(const VisitPresenceConfirmed()),
      verify: (bloc) {
        final state = bloc.state as VisitDetailReady;
        expect(state.locationFailure, LocationFailure.deniedForever);
        expect(state.isConfirming, isFalse);
      },
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'dismissing the prompt confirms nothing',
      build: build,
      seed: () => VisitDetailReady(detail(), pendingFix: faraway),
      act: (bloc) => bloc.add(const VisitOverrideDismissed()),
      verify: (bloc) {
        expect((bloc.state as VisitDetailReady).needsOverride, isFalse);
        verifyNever(() => repository.confirmPresence(
              any(),
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              overrideReason: any(named: 'overrideReason'),
            ));
      },
    );
  });
}
