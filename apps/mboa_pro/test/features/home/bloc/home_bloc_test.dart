import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/home/bloc/home_bloc.dart';
import 'package:mboa_pro/features/home/data/pro_dashboard_repository.dart';
import 'package:mboa_pro/features/home/models/dashboard_stats.dart';
import 'package:mocktail/mocktail.dart';

class MockProDashboardRepository extends Mock
    implements ProDashboardRepository {}

void main() {
  late MockProDashboardRepository repository;

  const fresh = DashboardStats(
    totalBiens: 17,
    byStatus: {AnnonceStatus.published: 12, AnnonceStatus.rented: 5},
  );
  const stale = DashboardStats(totalBiens: 9);

  setUp(() {
    repository = MockProDashboardRepository();
    when(() => repository.cached()).thenReturn(null);
  });

  HomeBloc build() => HomeBloc(repository: repository);

  group('HomeLoadRequested', () {
    blocTest<HomeBloc, HomeState>(
      'emits [loading, ready] when there is no cache',
      setUp: () => when(repository.fetch).thenAnswer((_) async => fresh),
      build: build,
      act: (bloc) => bloc.add(const HomeLoadRequested()),
      expect: () => const [HomeLoadInProgress(), HomeReady(fresh)],
    );

    blocTest<HomeBloc, HomeState>(
      'paints the cache first, then the network figures',
      setUp: () {
        when(() => repository.cached()).thenReturn(stale);
        when(repository.fetch).thenAnswer((_) async => fresh);
      },
      build: build,
      act: (bloc) => bloc.add(const HomeLoadRequested()),
      expect: () => const [
        HomeReady(stale, fromCache: true),
        HomeReady(fresh),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'keeps the cached figures when the fetch fails',
      setUp: () {
        when(() => repository.cached()).thenReturn(stale);
        when(repository.fetch).thenThrow(Exception('offline'));
      },
      build: build,
      act: (bloc) => bloc.add(const HomeLoadRequested()),
      // No HomeFailure — stale figures beat a blank screen.
      expect: () => const [HomeReady(stale, fromCache: true)],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [loading, failure] when the fetch fails with no cache',
      setUp: () => when(repository.fetch).thenThrow(Exception('boom')),
      build: build,
      act: (bloc) => bloc.add(const HomeLoadRequested()),
      expect: () => const [HomeLoadInProgress(), HomeFailure()],
    );
  });

  group('HomeRefreshRequested', () {
    blocTest<HomeBloc, HomeState>(
      'replaces the figures on success',
      setUp: () => when(repository.fetch).thenAnswer((_) async => fresh),
      build: build,
      seed: () => const HomeReady(stale, fromCache: true),
      act: (bloc) => bloc.add(const HomeRefreshRequested()),
      expect: () => const [HomeReady(fresh)],
    );

    blocTest<HomeBloc, HomeState>(
      'holds the current figures when the refresh fails',
      setUp: () => when(repository.fetch).thenThrow(Exception('offline')),
      build: build,
      seed: () => const HomeReady(fresh),
      act: (bloc) => bloc.add(const HomeRefreshRequested()),
      expect: () => const <HomeState>[],
    );

    blocTest<HomeBloc, HomeState>(
      'falls to failure when a refresh fails with nothing on screen',
      setUp: () => when(repository.fetch).thenThrow(Exception('offline')),
      build: build,
      act: (bloc) => bloc.add(const HomeRefreshRequested()),
      expect: () => const [HomeFailure()],
    );
  });
}
