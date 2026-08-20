import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/assignments/bloc/my_agents_bloc.dart';
import 'package:mboa_pro/features/assignments/bloc/property_agent_bloc.dart';
import 'package:mboa_pro/features/annonces/data/annonce_repository.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/assignments/data/assignment_repository.dart';
import 'package:mboa_pro/features/assignments/models/assignment.dart';
import 'package:mocktail/mocktail.dart';

class MockAssignmentRepository extends Mock implements AssignmentRepository {}

class MockAnnonceRepository extends Mock implements AnnonceRepository {}

Annonce listing({bool ownerVisitsEnabled = false}) => Annonce(
      id: 'a-1',
      title: 'Studio Bonapriso',
      status: AnnonceStatus.published,
      propertyType: PropertyType.studio,
      ownerVisitsEnabled: ownerVisitsEnabled,
    );

Assignment assignment({
  String id = 'as-1',
  AssignmentTarget? target,
  AssignmentStatus status = AssignmentStatus.accepted,
  AssignmentInitiator initiatedBy = AssignmentInitiator.prestataire,
  String agentId = 'ag-1',
  String? agentName = 'Emmanuel NDJOKO',
  String? propertyTitle = 'Studio Bonapriso',
}) =>
    Assignment(
      id: id,
      target: target ?? const AnnonceTarget('a-1'),
      status: status,
      initiatedBy: initiatedBy,
      agentAccountId: agentId,
      agentName: agentName,
      propertyTitle: propertyTitle,
    );

void main() {
  late MockAssignmentRepository repository;
  late MockAnnonceRepository annonces;

  const target = AnnonceTarget('a-1');
  const residence = ResidenceTarget('r-1');

  const candidate = AgentCandidateView(
    accountId: 'ag-2',
    firstName: 'Steve',
    lastName: 'Borelle',
    completedVisitCount: 7,
  );

  const application = AgentApplication(
    id: 'app-1',
    agentAccountId: 'ag-3',
    target: target,
    agentName: 'Jeanette Evelyne',
  );

  setUpAll(() {
    registerFallbackValue(const AnnonceTarget('x'));
    registerFallbackValue(
      const AgentApplication(
        id: 'x',
        agentAccountId: 'x',
        target: AnnonceTarget('x'),
      ),
    );
  });

  setUp(() {
    repository = MockAssignmentRepository();
    annonces = MockAnnonceRepository();
    when(() => annonces.getOne(any())).thenAnswer((_) async => listing());
    when(() => repository.forTarget(any())).thenAnswer((_) async => []);
    when(() => repository.applications(any())).thenAnswer((_) async => []);
    when(() => repository.candidates(any())).thenAnswer((_) async => []);
  });

  PropertyAgentBloc buildProperty() =>
      PropertyAgentBloc(repository: repository, annonces: annonces);

  group('a property\'s agent', () {
    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'loads the three lists together',
      setUp: () {
        when(() => repository.candidates(target))
            .thenAnswer((_) async => [candidate]);
        when(() => repository.applications(target))
            .thenAnswer((_) async => [application]);
      },
      build: buildProperty,
      act: (bloc) => bloc.add(const PropertyAgentLoadRequested(target)),
      verify: (bloc) {
        final state = bloc.state as PropertyAgentReady;
        expect(state.candidates, [candidate]);
        expect(state.applications, [application]);
        expect(state.offerableCandidates, [candidate]);
      },
    );

    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'RM-M11-01 — a property carries several agents at once',
      setUp: () {
        when(() => repository.forTarget(target)).thenAnswer(
          (_) async => [
            assignment(),
            assignment(id: 'as-2', agentId: 'ag-9', agentName: 'Awa Nkeng'),
          ],
        );
        when(() => repository.candidates(target))
            .thenAnswer((_) async => [candidate]);
      },
      build: buildProperty,
      act: (bloc) => bloc.add(const PropertyAgentLoadRequested(target)),
      verify: (bloc) {
        final state = bloc.state as PropertyAgentReady;
        // The exclusivity this screen used to enforce was repealed on
        // 2026-08-13: the client picks a visitor from the pool at booking time.
        expect(state.liveAgents, hasLength(2));
        expect(state.offerableCandidates, [candidate]);
      },
    );

    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'an agent already in the pool is not offered again',
      setUp: () {
        when(() => repository.forTarget(target))
            .thenAnswer((_) async => [assignment(agentId: candidate.accountId)]);
        when(() => repository.candidates(target))
            .thenAnswer((_) async => [candidate]);
      },
      build: buildProperty,
      act: (bloc) => bloc.add(const PropertyAgentLoadRequested(target)),
      // Offering the same agent twice is a 409; a picker that lists somebody it
      // cannot offer is a picker that lies.
      verify: (bloc) => expect(
        (bloc.state as PropertyAgentReady).offerableCandidates,
        isEmpty,
      ),
    );

    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'an offer awaiting an answer still counts in the pool',
      setUp: () => when(() => repository.forTarget(target)).thenAnswer(
        (_) async => [assignment(status: AssignmentStatus.pending)],
      ),
      build: buildProperty,
      act: (bloc) => bloc.add(const PropertyAgentLoadRequested(target)),
      verify: (bloc) {
        final state = bloc.state as PropertyAgentReady;
        // RM-M11-04 — the agent has not answered; they are on the property's
        // list all the same, so the prestataire is not asked twice.
        expect(state.awaitingAgents, hasLength(1));
        expect(state.pool, hasLength(1));
      },
    );

    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'RM-M11-06 — removal is offered only while it is unambiguous',
      setUp: () => when(() => repository.forTarget(target)).thenAnswer(
        (_) async => [
          assignment(),
          assignment(id: 'as-2', agentId: 'ag-9', agentName: 'Awa Nkeng'),
        ],
      ),
      build: buildProperty,
      act: (bloc) => bloc.add(const PropertyAgentLoadRequested(target)),
      // DELETE /annonces/{id}/agent names no agent, so with two in the pool
      // the app cannot say which one would go.
      verify: (bloc) =>
          expect((bloc.state as PropertyAgentReady).canWithdraw, isFalse),
    );

    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'a residence lists one row per agent, not one per unit',
      setUp: () => when(() => repository.forTarget(residence)).thenAnswer(
        (_) async => [
          for (var i = 0; i < 12; i++)
            assignment(id: 'as-$i', target: residence),
        ],
      ),
      build: buildProperty,
      act: (bloc) => bloc.add(const PropertyAgentLoadRequested(residence)),
      verify: (bloc) {
        final state = bloc.state as PropertyAgentReady;
        // `GET /residences/{id}/agent` answers unit by unit — showing that raw
        // would print the same person twelve times and make `canWithdraw`
        // false for a pool of one.
        expect(state.pool, hasLength(1));
        expect(state.unitsCoveredBy(state.pool.single), 12);
        expect(state.canWithdraw, isTrue);
      },
    );

    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'RM-M11-10 — the owner puts himself in the pool',
      setUp: () {
        when(() => annonces.setOwnerVisits('a-1', enabled: true))
            .thenAnswer((_) async => listing(ownerVisitsEnabled: true));
      },
      build: buildProperty,
      seed: () => const PropertyAgentReady(
        target: target,
        ownerVisitsEnabled: false,
      ),
      act: (bloc) => bloc.add(const OwnerVisitsToggled(enabled: true)),
      verify: (bloc) {
        final state = bloc.state as PropertyAgentReady;
        expect(state.ownerVisitsEnabled, isTrue);
        expect(state.isSavingOwnerVisits, isFalse);
      },
    );

    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'a residence has no owner-visits flag to show',
      build: buildProperty,
      act: (bloc) => bloc.add(const PropertyAgentLoadRequested(residence)),
      verify: (bloc) {
        // RM-M11-10 is a field on an annonce; reading it for a residence would
        // mean electing one unit to speak for the rest.
        expect((bloc.state as PropertyAgentReady).ownerVisitsEnabled, isNull);
        verifyNever(() => annonces.getOne(any()));
      },
    );

    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'a closed assignment leaves the pool empty',
      setUp: () => when(() => repository.forTarget(target)).thenAnswer(
        (_) async => [
          assignment(status: AssignmentStatus.declined),
          assignment(id: 'as-2', status: AssignmentStatus.revoked),
          assignment(id: 'as-3', status: AssignmentStatus.resigned),
        ],
      ),
      build: buildProperty,
      act: (bloc) => bloc.add(const PropertyAgentLoadRequested(target)),
      verify: (bloc) => expect(
        (bloc.state as PropertyAgentReady).pool,
        isEmpty,
      ),
    );

    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'offering reloads rather than patching',
      setUp: () => when(() => repository.offer(target, 'ag-2'))
          .thenAnswer((_) async => const ResidenceOfferOutcome(offered: 1)),
      build: buildProperty,
      seed: () => const PropertyAgentReady(target: target),
      act: (bloc) => bloc.add(const AgentOffered('ag-2')),
      verify: (bloc) {
        // RM-M11-07 lets the server change rows this screen did not touch, so
        // the server stays the authority on what the lists now hold.
        verify(() => repository.forTarget(target)).called(1);
        expect((bloc.state as PropertyAgentReady).mutatingId, isNull);
      },
    );

    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'a failed offer flags the failure and stops spinning',
      setUp: () =>
          when(() => repository.offer(target, 'ag-2')).thenThrow(Exception()),
      build: buildProperty,
      seed: () => const PropertyAgentReady(target: target),
      act: (bloc) => bloc.add(const AgentOffered('ag-2')),
      verify: (bloc) {
        final state = bloc.state as PropertyAgentReady;
        expect(state.lastActionFailed, isTrue);
        expect(state.mutatingId, isNull);
      },
    );

    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'RM-M10bis-06 — a residence offer reports the units it skipped',
      setUp: () => when(() => repository.offer(residence, 'ag-2')).thenAnswer(
        (_) async => const ResidenceOfferOutcome(
          offered: 8,
          skipped: [
            SkippedUnitView(title: 'Chambre 3', reason: 'ALREADY_ASSIGNED'),
          ],
        ),
      ),
      build: buildProperty,
      seed: () => const PropertyAgentReady(target: residence),
      act: (bloc) => bloc.add(const AgentOffered('ag-2')),
      verify: (bloc) {
        final outcome = (bloc.state as PropertyAgentReady).lastOutcome!;
        // Swallowing this would tell the prestataire the whole residence was
        // offered when one unit was not.
        expect(outcome.offered, 8);
        expect(outcome.hasSkipped, isTrue);
        expect(outcome.skipped.single.title, 'Chambre 3');
      },
    );

    blocTest<PropertyAgentBloc, PropertyAgentState>(
      'accepting an application reloads the whole picture',
      setUp: () => when(() => repository.acceptApplication(application))
          .thenAnswer((_) async => const ResidenceOfferOutcome(offered: 1)),
      build: buildProperty,
      seed: () => const PropertyAgentReady(
        target: target,
        applications: [application],
      ),
      act: (bloc) => bloc.add(const ApplicationAccepted(application)),
      verify: (bloc) {
        // Accepting one refuses the others server-side (RM-M11-07); only a
        // reload shows that.
        verify(() => repository.applications(target)).called(1);
      },
    );
  });

  group('Mes agents', () {
    MyAgentsBloc buildAgents() => MyAgentsBloc(repository: repository);

    blocTest<MyAgentsBloc, MyAgentsState>(
      'lists people, not assignments',
      setUp: () => when(repository.myAssignments).thenAnswer(
        (_) async => [
          assignment(id: 'as-1', propertyTitle: 'Studio Bonapriso'),
          assignment(
            id: 'as-2',
            target: const AnnonceTarget('a-2'),
            propertyTitle: 'Villa Bonanjo',
          ),
          assignment(
            id: 'as-3',
            target: const AnnonceTarget('a-3'),
            agentId: 'ag-9',
            agentName: 'Steve Borelle',
          ),
        ],
      ),
      build: buildAgents,
      act: (bloc) => bloc.add(const MyAgentsLoadRequested()),
      verify: (bloc) {
        final rows = (bloc.state as MyAgentsReady).rows;
        // Three assignments, two agents.
        expect(rows, hasLength(2));
        final emmanuel =
            rows.firstWhere((r) => r.agentAccountId == 'ag-1');
        expect(emmanuel.propertyCount, 2);
        expect(emmanuel.soleProperty, isNull);
      },
    );

    blocTest<MyAgentsBloc, MyAgentsState>(
      'names the property when an agent has exactly one',
      setUp: () => when(repository.myAssignments)
          .thenAnswer((_) async => [assignment()]),
      build: buildAgents,
      act: (bloc) => bloc.add(const MyAgentsLoadRequested()),
      verify: (bloc) => expect(
        (bloc.state as MyAgentsReady).rows.single.soleProperty,
        'Studio Bonapriso',
      ),
    );

    blocTest<MyAgentsBloc, MyAgentsState>(
      'drops agents whose assignments are all over',
      setUp: () => when(repository.myAssignments).thenAnswer(
        (_) async => [
          assignment(status: AssignmentStatus.revoked),
          assignment(id: 'as-2', agentId: 'ag-9', status: AssignmentStatus.accepted),
        ],
      ),
      build: buildAgents,
      act: (bloc) => bloc.add(const MyAgentsLoadRequested()),
      verify: (bloc) {
        // A revoked assignment is history, not an agent the prestataire has.
        final rows = (bloc.state as MyAgentsReady).rows;
        expect(rows, hasLength(1));
        expect(rows.single.agentAccountId, 'ag-9');
      },
    );

    blocTest<MyAgentsBloc, MyAgentsState>(
      'RM-M11-09 — origin does not decide which list the work appears in',
      setUp: () => when(repository.myAssignments).thenAnswer(
        (_) async => [
          assignment(initiatedBy: AssignmentInitiator.agent),
          assignment(
            id: 'as-2',
            agentId: 'ag-9',
            initiatedBy: AssignmentInitiator.prestataire,
          ),
        ],
      ),
      build: buildAgents,
      act: (bloc) => bloc.add(const MyAgentsLoadRequested()),
      verify: (bloc) {
        // One was the agent's application, the other the prestataire's offer.
        // Both are accepted, so both are simply agents they have.
        expect((bloc.state as MyAgentsReady).rows, hasLength(2));
      },
    );

    blocTest<MyAgentsBloc, MyAgentsState>(
      'a refresh failure keeps the list already on screen',
      setUp: () => when(repository.myAssignments).thenThrow(Exception()),
      build: buildAgents,
      seed: () => MyAgentsReady(
        rows: [
          AgentRow(agentAccountId: 'ag-1', assignments: [assignment()]),
        ],
      ),
      act: (bloc) => bloc.add(const MyAgentsRefreshRequested()),
      verify: (bloc) => expect(
        (bloc.state as MyAgentsReady).rows,
        hasLength(1),
      ),
    );
  });
}
