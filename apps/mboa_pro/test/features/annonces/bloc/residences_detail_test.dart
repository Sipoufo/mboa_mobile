import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/annonces/bloc/residences_bloc.dart';
import 'package:mboa_pro/features/annonces/data/residence_repository.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/models/residence.dart';
import 'package:mocktail/mocktail.dart';

class MockResidenceRepository extends Mock implements ResidenceRepository {}

/// The residence detail showed no units for three separate reasons, in order:
/// it read the list state (which omits `units`), then it fetched but
/// `Residence.props` left `units` out — so the fetched residence compared
/// **equal** to the unit-less one, bloc dropped the emission as a no-op, and
/// the screen never rebuilt.
///
/// Equatable props must cover every field a screen renders.
void main() {
  late MockResidenceRepository repository;

  /// What the *list* returns: counts, no units.
  const fromList = Residence(
    id: 'r1',
    name: 'Résidence Deido',
    status: AnnonceStatus.published,
    unitCount: 2,
    publishedUnitCount: 1,
  );

  /// What `getOne` returns: identical, plus the units.
  const withUnits = Residence(
    id: 'r1',
    name: 'Résidence Deido',
    status: AnnonceStatus.published,
    unitCount: 2,
    publishedUnitCount: 1,
    units: [
      ResidenceUnit(
        id: 'u1',
        title: 'Chambre 1',
        status: AnnonceStatus.published,
        propertyType: PropertyType.room,
        price: 45000,
      ),
      ResidenceUnit(
        id: 'u2',
        title: 'Chambre 2',
        status: AnnonceStatus.draft,
        propertyType: PropertyType.room,
        price: 45000,
      ),
    ],
  );

  setUp(() => repository = MockResidenceRepository());

  ResidencesBloc build() => ResidencesBloc(repository: repository);

  test('a residence differing only by its units is not equal', () {
    // The whole bug in one line: if these compare equal, bloc emits nothing.
    expect(fromList, isNot(withUnits));
  });

  blocTest<ResidencesBloc, ResidencesState>(
    'fetching the detail replaces the unit-less residence from the list',
    setUp: () =>
        when(() => repository.getOne('r1')).thenAnswer((_) async => withUnits),
    build: build,
    seed: () => const ResidencesReady(items: [fromList]),
    act: (bloc) => bloc.add(const ResidenceDetailRequested('r1')),
    expect: () => const [ResidencesReady(items: [withUnits])],
    verify: (bloc) {
      final state = bloc.state as ResidencesReady;
      expect(state.items.single.units, hasLength(2));
      expect(state.items.single.units.first.title, 'Chambre 1');
    },
  );

  blocTest<ResidencesBloc, ResidencesState>(
    'a deep link works when the list was never loaded',
    setUp: () =>
        when(() => repository.getOne('r1')).thenAnswer((_) async => withUnits),
    build: build,
    act: (bloc) => bloc.add(const ResidenceDetailRequested('r1')),
    expect: () => const [ResidencesReady(items: [withUnits])],
  );

  blocTest<ResidencesBloc, ResidencesState>(
    'keeps the other residences when fetching one',
    setUp: () =>
        when(() => repository.getOne('r1')).thenAnswer((_) async => withUnits),
    build: build,
    seed: () => const ResidencesReady(
      items: [
        fromList,
        Residence(id: 'r2', name: 'Autre', status: AnnonceStatus.draft),
      ],
    ),
    act: (bloc) => bloc.add(const ResidenceDetailRequested('r1')),
    verify: (bloc) {
      final state = bloc.state as ResidencesReady;
      expect(state.items.map((r) => r.id), ['r1', 'r2']);
    },
  );

  blocTest<ResidencesBloc, ResidencesState>(
    'a failed fetch leaves an existing list alone',
    setUp: () => when(() => repository.getOne(any())).thenThrow(Exception('x')),
    build: build,
    seed: () => const ResidencesReady(items: [fromList]),
    act: (bloc) => bloc.add(const ResidenceDetailRequested('r1')),
    expect: () => const <ResidencesState>[],
  );
}
