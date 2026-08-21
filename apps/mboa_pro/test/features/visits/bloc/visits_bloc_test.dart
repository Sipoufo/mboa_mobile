import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/annonces/data/location_capture.dart';
import 'package:mboa_pro/features/visits/bloc/visit_detail_bloc.dart';
import 'package:mboa_pro/features/visits/data/agent_visit_repository.dart';
import 'package:mboa_pro/features/visits/models/agent_visit.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockAgentVisitRepository extends Mock implements AgentVisitRepository {}

class MockLocationCapture extends Mock implements LocationCapture {}

/// The agent's visit detail (CDC M16).
///
/// The list moved to `VisitsAgendaBloc` in mboa_shared — the agent and the
/// prestataire read the same weeks — so what is left here is the half that is
/// the agent's alone.
void main() {
  late MockAgentVisitRepository repository;
  late MockLocationCapture location;

  setUp(() {
    repository = MockAgentVisitRepository();
    location = MockLocationCapture();
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

    VisitDetailBloc build() => VisitDetailBloc(repository: repository, location: location);

    blocTest<VisitDetailBloc, VisitDetailState>(
      'inside the radius confirms without asking anything',
      setUp: () {
        when(location.current).thenAnswer((_) async => nearby);
        when(
          () => repository.confirmPresence(
            'v-1',
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            overrideReason: any(named: 'overrideReason'),
          ),
        ).thenAnswer((_) async {});
        when(() => repository.detail('v-1')).thenAnswer((_) async => detail());
      },
      build: build,
      seed: () => VisitDetailReady(detail()),
      act: (bloc) => bloc.add(const VisitPresenceConfirmed()),
      verify: (bloc) {
        expect((bloc.state as VisitDetailReady).needsOverride, isFalse);
        verify(
          () => repository.confirmPresence(
            'v-1',
            latitude: nearby.latitude,
            longitude: nearby.longitude,
            overrideReason: null,
          ),
        ).called(1);
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
        verifyNever(
          () => repository.confirmPresence(
            any(),
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            overrideReason: any(named: 'overrideReason'),
          ),
        );
      },
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'the justification is sent with the fix that triggered it',
      setUp: () {
        when(
          () => repository.confirmPresence(
            'v-1',
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            overrideReason: any(named: 'overrideReason'),
          ),
        ).thenAnswer((_) async {});
        when(() => repository.detail('v-1')).thenAnswer((_) async => detail());
      },
      build: build,
      seed: () => VisitDetailReady(
        detail(),
        pendingFix: faraway,
        distanceMetres: 1100,
      ),
      act: (bloc) => bloc.add(const VisitPresenceOverridden('GPS imprécis, je suis au portail')),
      verify: (_) => verify(
        () => repository.confirmPresence(
          'v-1',
          latitude: faraway.latitude,
          longitude: faraway.longitude,
          overrideReason: 'GPS imprécis, je suis au portail',
        ),
      ).called(1),
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'a property with no coordinates never demands a justification',
      setUp: () {
        when(location.current).thenAnswer((_) async => faraway);
        when(
          () => repository.confirmPresence(
            'v-1',
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            overrideReason: any(named: 'overrideReason'),
          ),
        ).thenAnswer((_) async {});
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
        verify(
          () => repository.confirmPresence(
            'v-1',
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            overrideReason: null,
          ),
        ).called(1);
      },
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'confirming is only half — the visit waits on the client (RM-M07-05)',
      setUp: () {
        when(location.current).thenAnswer((_) async => nearby);
        when(
          () => repository.confirmPresence(
            'v-1',
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            overrideReason: any(named: 'overrideReason'),
          ),
        ).thenAnswer((_) async {});
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
        verifyNever(
          () => repository.confirmPresence(
            any(),
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            overrideReason: any(named: 'overrideReason'),
          ),
        );
      },
    );
  });
}
