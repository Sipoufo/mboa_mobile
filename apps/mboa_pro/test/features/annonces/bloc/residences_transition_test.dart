import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/annonces/bloc/residences_bloc.dart';
import 'package:mboa_pro/features/annonces/data/residence_repository.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/models/residence.dart';
import 'package:mocktail/mocktail.dart';

class MockResidenceRepository extends Mock implements ResidenceRepository {}

/// Bulk lifecycle transitions on a residence.
///
/// Two bugs met here. Un-archiving threw client-side and reported the generic
/// *"Action impossible pour le moment."*; and because a bulk transition answers
/// with the aggregate shape — `units` empty by design — writing that response
/// straight into the list emptied the detail screen's unit list.
void main() {
  late MockResidenceRepository repository;

  const archived = Residence(
    id: 'r1',
    name: 'Résidence Deido',
    status: AnnonceStatus.archived,
    unitCount: 2,
    units: [
      ResidenceUnit(
        id: 'u1',
        title: 'Chambre 1',
        status: AnnonceStatus.archived,
        propertyType: PropertyType.room,
      ),
      ResidenceUnit(
        id: 'u2',
        title: 'Chambre 2',
        status: AnnonceStatus.archived,
        propertyType: PropertyType.room,
      ),
    ],
  );

  /// What a bulk transition answers with: counts, no units.
  const draftAggregate = Residence(
    id: 'r1',
    name: 'Résidence Deido',
    status: AnnonceStatus.draft,
    unitCount: 2,
    draftUnitCount: 2,
  );

  /// What `getOne` answers with after the same transition.
  const draftWithUnits = Residence(
    id: 'r1',
    name: 'Résidence Deido',
    status: AnnonceStatus.draft,
    unitCount: 2,
    draftUnitCount: 2,
    units: [
      ResidenceUnit(
        id: 'u1',
        title: 'Chambre 1',
        status: AnnonceStatus.draft,
        propertyType: PropertyType.room,
      ),
      ResidenceUnit(
        id: 'u2',
        title: 'Chambre 2',
        status: AnnonceStatus.draft,
        propertyType: PropertyType.room,
      ),
    ],
  );

  setUp(() => repository = MockResidenceRepository());

  ResidencesBloc build() => ResidencesBloc(repository: repository);

  blocTest<ResidencesBloc, ResidencesState>(
    'un-archiving a residence succeeds instead of reporting a failed action',
    setUp: () {
      when(() => repository.transition('r1', AnnonceTransition.unarchive))
          .thenAnswer((_) async => draftAggregate);
      when(() => repository.getOne('r1'))
          .thenAnswer((_) async => draftWithUnits);
    },
    build: build,
    seed: () => const ResidencesReady(items: [archived]),
    act: (bloc) => bloc.add(
      const ResidenceStatusChangeRequested('r1', AnnonceTransition.unarchive),
    ),
    expect: () => [
      const ResidencesReady(items: [archived], mutatingId: 'r1'),
      const ResidencesReady(items: [draftWithUnits]),
    ],
    verify: (bloc) {
      final state = bloc.state as ResidencesReady;
      expect(state.lastActionFailed, isFalse);
      expect(state.items.single.status, AnnonceStatus.draft);
    },
  );

  blocTest<ResidencesBloc, ResidencesState>(
    'a bulk transition does not empty the units it was holding',
    setUp: () {
      when(() => repository.transition('r1', AnnonceTransition.unarchive))
          .thenAnswer((_) async => draftAggregate);
      when(() => repository.getOne('r1'))
          .thenAnswer((_) async => draftWithUnits);
    },
    build: build,
    seed: () => const ResidencesReady(items: [archived]),
    act: (bloc) => bloc.add(
      const ResidenceStatusChangeRequested('r1', AnnonceTransition.unarchive),
    ),
    verify: (bloc) {
      final units = (bloc.state as ResidencesReady).items.single.units;
      expect(units, hasLength(2));
      // Refetched, not carried forward: the transition changed each unit too.
      expect(units.every((u) => u.status == AnnonceStatus.draft), isTrue);
      verify(() => repository.getOne('r1')).called(1);
    },
  );

  blocTest<ResidencesBloc, ResidencesState>(
    'no refetch when the list never held units for that residence',
    setUp: () => when(
      () => repository.transition('r1', AnnonceTransition.archive),
    ).thenAnswer((_) async => draftAggregate),
    build: build,
    // The list payload carries counts only — nothing to preserve.
    seed: () => const ResidencesReady(
      items: [
        Residence(id: 'r1', name: 'Résidence Deido', status: AnnonceStatus.published, unitCount: 2),
      ],
    ),
    act: (bloc) => bloc.add(
      const ResidenceStatusChangeRequested('r1', AnnonceTransition.archive),
    ),
    verify: (_) => verifyNever(() => repository.getOne(any())),
  );

  blocTest<ResidencesBloc, ResidencesState>(
    'a failed refetch keeps the successful transition rather than reporting an error',
    setUp: () {
      when(() => repository.transition('r1', AnnonceTransition.unarchive))
          .thenAnswer((_) async => draftAggregate);
      when(() => repository.getOne('r1')).thenThrow(Exception('offline'));
    },
    build: build,
    seed: () => const ResidencesReady(items: [archived]),
    act: (bloc) => bloc.add(
      const ResidenceStatusChangeRequested('r1', AnnonceTransition.unarchive),
    ),
    verify: (bloc) {
      final state = bloc.state as ResidencesReady;
      expect(state.lastActionFailed, isFalse);
      expect(state.items.single.status, AnnonceStatus.draft);
    },
  );

  blocTest<ResidencesBloc, ResidencesState>(
    'a failed transition still flags the action as failed',
    setUp: () => when(
      () => repository.transition('r1', AnnonceTransition.unarchive),
    ).thenThrow(Exception('409')),
    build: build,
    seed: () => const ResidencesReady(items: [archived]),
    act: (bloc) => bloc.add(
      const ResidenceStatusChangeRequested('r1', AnnonceTransition.unarchive),
    ),
    verify: (bloc) => expect(
      (bloc.state as ResidencesReady).lastActionFailed,
      isTrue,
    ),
  );
}
