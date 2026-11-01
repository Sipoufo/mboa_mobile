import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/annonces/bloc/listing_tenancies_bloc.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockHomesRepository extends Mock implements HomesRepository {}

/// A listing's « Occupant » and « Historique » (RM-M31-09) — they said
/// « Aucune information » whatever the listing had lived through.
void main() {
  late MockHomesRepository repository;

  Home home(String id, HomeStage state, {DateTime? start, DateTime? end}) => Home(
    contractId: 'c-$id',
    annonceId: 'a-1',
    tenant: ContractParticipant(displayName: 'Locataire $id'),
    state: state,
    rent: 110000,
    startDate: start,
    endDate: end,
  );

  final running = home('now', HomeStage.active, start: DateTime(2026, 3, 1));
  final following = home('next', HomeStage.upcoming, start: DateTime(2027, 3, 1));
  final later = home('later', HomeStage.upcoming, start: DateTime(2027, 9, 1));
  final y2024 = home('2024', HomeStage.readOnly, start: DateTime(2024, 1, 1), end: DateTime(2024, 12, 31));
  final y2025 = home('2025', HomeStage.readOnly, start: DateTime(2025, 1, 1), end: DateTime(2026, 2, 28));
  final undated = home('undated', HomeStage.readOnly);

  setUp(() => repository = MockHomesRepository());

  ListingTenanciesBloc build() => ListingTenanciesBloc(repository: repository);

  void answer(List<Home> homes, {bool fromCache = false}) =>
      when(() => repository.tenantHomes(annonceId: 'a-1')).thenAnswer((_) async => Cached(homes, fromCache: fromCache));

  blocTest<ListingTenanciesBloc, ListingTenanciesState>(
    'the running tenancy is the occupant; one signed to follow is next; the ended ones, latest first, '
    'an undated one last',
    setUp: () => answer([undated, y2024, following, running, y2025]),
    build: build,
    act: (bloc) => bloc.add(const ListingTenanciesRequested('a-1')),
    expect: () => [
      ListingTenanciesReady(occupant: running, next: following, past: [y2025, y2024, undated]),
    ],
    verify: (_) => verify(() => repository.tenantHomes(annonceId: 'a-1')).called(1),
  );

  blocTest<ListingTenanciesBloc, ListingTenanciesState>(
    'nobody living there yet: the first to move in is the occupant',
    setUp: () => answer([later, following, y2025]),
    build: build,
    act: (bloc) => bloc.add(const ListingTenanciesRequested('a-1')),
    expect: () => [
      ListingTenanciesReady(occupant: following, past: [y2025]),
    ],
  );

  blocTest<ListingTenanciesBloc, ListingTenanciesState>(
    'never let: free, with no history',
    setUp: () => answer(const []),
    build: build,
    act: (bloc) => bloc.add(const ListingTenanciesRequested('a-1')),
    expect: () => [const ListingTenanciesReady()],
  );

  blocTest<ListingTenanciesBloc, ListingTenanciesState>(
    'offline: the last read, said to be one',
    setUp: () => answer([running], fromCache: true),
    build: build,
    act: (bloc) => bloc.add(const ListingTenanciesRequested('a-1')),
    expect: () => [ListingTenanciesReady(occupant: running, isOffline: true)],
  );

  blocTest<ListingTenanciesBloc, ListingTenanciesState>(
    'nothing read and nothing cached: a failure, to retry',
    setUp: () => when(() => repository.tenantHomes(annonceId: 'a-1')).thenThrow(Exception('offline')),
    build: build,
    act: (bloc) => bloc.add(const ListingTenanciesRequested('a-1')),
    expect: () => [const ListingTenanciesFailure()],
  );

  blocTest<ListingTenanciesBloc, ListingTenanciesState>(
    'a retry after a failure shows it is trying',
    setUp: () => answer([running]),
    build: build,
    seed: () => const ListingTenanciesFailure(),
    act: (bloc) => bloc.add(const ListingTenanciesRequested('a-1')),
    expect: () => [const ListingTenanciesLoading(), ListingTenanciesReady(occupant: running)],
  );

  blocTest<ListingTenanciesBloc, ListingTenanciesState>(
    'a refresh that fails keeps what was shown',
    setUp: () => when(() => repository.tenantHomes(annonceId: 'a-1')).thenThrow(Exception('offline')),
    build: build,
    seed: () => ListingTenanciesReady(occupant: running),
    act: (bloc) => bloc.add(const ListingTenanciesRequested('a-1')),
    expect: () => <ListingTenanciesState>[],
  );

  group('the history', () {
    final many = [
      for (var year = 2016; year < 2026; year++)
        home('$year', HomeStage.readOnly, start: DateTime(year), end: DateTime(year, 12, 31)),
    ];

    test('shows the three latest, then « Voir tout »', () {
      final ready = ListingTenanciesReady.of(many);

      expect(ready.visiblePast.map((h) => h.contractId), ['c-2025', 'c-2024', 'c-2023']);
      expect(ready.hasMorePast, isTrue);
    });

    blocTest<ListingTenanciesBloc, ListingTenanciesState>(
      '« Voir tout » shows every one — and a refresh does not fold it back',
      setUp: () => answer(many),
      build: build,
      act: (bloc) async {
        bloc.add(const ListingTenanciesRequested('a-1'));
        await Future<void>.delayed(Duration.zero);
        bloc
          ..add(const ListingTenanciesHistoryExpanded())
          ..add(const ListingTenanciesRequested('a-1'));
      },
      skip: 1,
      verify: (bloc) {
        final ready = bloc.state as ListingTenanciesReady;
        expect(ready.visiblePast, hasLength(10));
        expect(ready.hasMorePast, isFalse);
      },
    );
  });
}
