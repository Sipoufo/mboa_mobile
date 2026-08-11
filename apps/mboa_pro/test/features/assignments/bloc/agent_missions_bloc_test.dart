import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/assignments/bloc/agent_missions_bloc.dart';
import 'package:mboa_pro/features/assignments/data/agent_mission_repository.dart';
import 'package:mboa_pro/features/assignments/models/assignment.dart';
import 'package:mocktail/mocktail.dart';

class MockAgentMissionRepository extends Mock
    implements AgentMissionRepository {}

Assignment assignment({
  String id = 'as-1',
  AssignmentTarget? target,
  AssignmentStatus status = AssignmentStatus.pending,
  AssignmentInitiator initiatedBy = AssignmentInitiator.prestataire,
}) =>
    Assignment(
      id: id,
      target: target ?? const AnnonceTarget('a-1'),
      status: status,
      initiatedBy: initiatedBy,
      propertyTitle: 'Studio Bonapriso',
    );

/// The agent's side of M11.
void main() {
  late MockAgentMissionRepository repository;

  const opportunity = Opportunity(
    target: AnnonceTarget('a-9'),
    title: 'Villa Bonanjo',
    city: 'Douala',
  );

  setUpAll(() {
    registerFallbackValue(const AnnonceTarget('x'));
    registerFallbackValue(assignment());
  });

  setUp(() {
    repository = MockAgentMissionRepository();
    when(repository.assignments).thenAnswer((_) async => []);
    when(repository.opportunities).thenAnswer((_) async => []);
    when(repository.applications).thenAnswer((_) async => []);
  });

  AgentMissionsBloc build() => AgentMissionsBloc(repository: repository);

  blocTest<AgentMissionsBloc, AgentMissionsState>(
    'loads the three lists together',
    setUp: () {
      when(repository.assignments).thenAnswer((_) async => [assignment()]);
      when(repository.opportunities).thenAnswer((_) async => [opportunity]);
    },
    build: build,
    act: (bloc) => bloc.add(const MissionsLoadRequested()),
    verify: (bloc) {
      final state = bloc.state as MissionsReady;
      expect(state.offers, hasLength(1));
      expect(state.opportunities, [opportunity]);
      // Offers open first — work waiting on the agent is the urgent list.
      expect(state.filter, MissionFilter.offers);
    },
  );

  group('what belongs in which list', () {
    blocTest<AgentMissionsBloc, AgentMissionsState>(
      'an offer awaiting the agent is not confused with their own application',
      setUp: () {
        when(repository.assignments).thenAnswer(
          (_) async => [
            assignment(status: AssignmentStatus.pending),
            // The agent applied; the prestataire owes the answer.
            assignment(id: 'as-2', status: AssignmentStatus.applied),
          ],
        );
      },
      build: build,
      act: (bloc) => bloc.add(const MissionsLoadRequested()),
      verify: (bloc) {
        final state = bloc.state as MissionsReady;
        expect(state.offers, hasLength(1));
        expect(state.offers.single.id, 'as-1');
      },
    );

    blocTest<AgentMissionsBloc, AgentMissionsState>(
      'RM-M11-09 — mine is a filter on status, never on origin',
      setUp: () => when(repository.assignments).thenAnswer(
        (_) async => [
          // The prestataire offered and the agent accepted.
          assignment(
            status: AssignmentStatus.accepted,
            initiatedBy: AssignmentInitiator.prestataire,
          ),
          // The agent applied and the prestataire accepted.
          assignment(
            id: 'as-2',
            status: AssignmentStatus.accepted,
            initiatedBy: AssignmentInitiator.agent,
          ),
        ],
      ),
      build: build,
      act: (bloc) => bloc.add(const MissionsLoadRequested()),
      verify: (bloc) {
        // Afterwards they are the same thing: work this agent holds.
        expect((bloc.state as MissionsReady).mine, hasLength(2));
      },
    );

    blocTest<AgentMissionsBloc, AgentMissionsState>(
      'a declined or resigned assignment is in neither list',
      setUp: () => when(repository.assignments).thenAnswer(
        (_) async => [
          assignment(status: AssignmentStatus.declined),
          assignment(id: 'as-2', status: AssignmentStatus.resigned),
          assignment(id: 'as-3', status: AssignmentStatus.revoked),
        ],
      ),
      build: build,
      act: (bloc) => bloc.add(const MissionsLoadRequested()),
      verify: (bloc) {
        final state = bloc.state as MissionsReady;
        expect(state.offers, isEmpty);
        expect(state.mine, isEmpty);
      },
    );
  });

  group('acting on work', () {
    blocTest<AgentMissionsBloc, AgentMissionsState>(
      'accepting reloads, because the server moves work between lists',
      setUp: () =>
          when(() => repository.accept(any())).thenAnswer((_) async {}),
      build: build,
      seed: () => MissionsReady(assignments: [assignment()]),
      act: (bloc) => bloc.add(MissionAccepted(assignment())),
      verify: (bloc) {
        verify(repository.assignments).called(1);
        expect((bloc.state as MissionsReady).mutatingId, isNull);
      },
    );

    blocTest<AgentMissionsBloc, AgentMissionsState>(
      'applying to an opportunity keys the spinner on the property',
      setUp: () => when(() => repository.apply(any())).thenAnswer((_) async {}),
      build: build,
      seed: () => const MissionsReady(opportunities: [opportunity]),
      act: (bloc) => bloc.add(const OpportunityApplied(opportunity)),
      verify: (_) => verify(
        () => repository.apply(const AnnonceTarget('a-9')),
      ).called(1),
    );

    blocTest<AgentMissionsBloc, AgentMissionsState>(
      'a failed action stops spinning and says so',
      setUp: () => when(() => repository.resign(any())).thenThrow(Exception()),
      build: build,
      seed: () => MissionsReady(
        assignments: [assignment(status: AssignmentStatus.accepted)],
      ),
      act: (bloc) => bloc.add(
        MissionResigned(assignment(status: AssignmentStatus.accepted)),
      ),
      verify: (bloc) {
        final state = bloc.state as MissionsReady;
        expect(state.lastActionFailed, isTrue);
        expect(state.mutatingId, isNull);
        // The mission is still theirs — a failed resignation changes nothing.
        expect(state.mine, hasLength(1));
      },
    );

    blocTest<AgentMissionsBloc, AgentMissionsState>(
      'a residence action keys on the residence, a listing on the assignment',
      setUp: () {
        when(() => repository.accept(any())).thenAnswer((_) async {});
      },
      build: build,
      seed: () => const MissionsReady(),
      act: (bloc) => bloc
        ..add(MissionAccepted(assignment()))
        ..add(
          MissionAccepted(
            assignment(id: 'as-2', target: const ResidenceTarget('r-1')),
          ),
        ),
      verify: (_) {
        // The endpoints key differently; the repository picks, not the screen.
        verify(() => repository.accept(any())).called(2);
      },
    );
  });

  blocTest<AgentMissionsBloc, AgentMissionsState>(
    'changing segment touches nothing on the network',
    build: build,
    seed: () => const MissionsReady(),
    act: (bloc) => bloc.add(const MissionsFilterChanged(MissionFilter.mine)),
    verify: (bloc) {
      expect((bloc.state as MissionsReady).filter, MissionFilter.mine);
      verifyNever(repository.assignments);
    },
  );

  blocTest<AgentMissionsBloc, AgentMissionsState>(
    'a failed refresh keeps what is on screen',
    setUp: () => when(repository.assignments).thenThrow(Exception()),
    build: build,
    seed: () => MissionsReady(assignments: [assignment()]),
    act: (bloc) => bloc.add(const MissionsRefreshRequested()),
    verify: (bloc) => expect(
      (bloc.state as MissionsReady).offers,
      hasLength(1),
    ),
  );
}
