import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/annonces/bloc/listing_stats_bloc.dart';
import 'package:mboa_pro/features/home/data/pro_dashboard_repository.dart';
import 'package:mboa_pro/features/home/models/dashboard_stats.dart';
import 'package:mboa_pro/features/home/models/listing_figures.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockPrestataireDashboardApi extends Mock implements PrestataireDashboardApi {}

class MockProDashboardRepository extends Mock implements ProDashboardRepository {}

DashboardMetric _metric(num? value, {bool locked = false}) => DashboardMetric(
      (b) => b
        ..value = value
        ..locked = locked
        ..available = true,
    );

ListingStats _listing(String id, int views) => ListingStats(
      (b) => b
        ..annonceId = id
        ..figures.replace(DashboardFigures((f) => f
          ..views = _metric(views).toBuilder()
          ..viewsLast7Days = _metric(views ~/ 4).toBuilder()
          ..contacts = _metric(null, locked: true).toBuilder()))
        ..averagePosition = _metric(2.4).toBuilder(),
    );

/// CDC M14 — a listing's own figures, on its detail: standing alone, or a
/// unit inside its residence; locked as the server says.
void main() {
  late MockPrestataireDashboardApi api;
  late MockHiveCache cache;
  late Map<String, Map<String, dynamic>> stored;
  late ProDashboardRepository repository;

  setUpAll(() => registerFallbackValue(Pageable()));

  setUp(() {
    final dioClient = MockDioClient();
    final apiClient = MockApiClient();
    api = MockPrestataireDashboardApi();
    cache = MockHiveCache();
    stored = {};
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getPrestataireDashboardApi).thenReturn(api);
    when(() => cache.put(any(), any(), any())).thenAnswer((call) async {
      stored[call.positionalArguments[1] as String] = call.positionalArguments[2] as Map<String, dynamic>;
    });
    when(() => cache.get(any(), any(), ttl: any(named: 'ttl')))
        .thenAnswer((call) => stored[call.positionalArguments[1] as String]);
    repository = ProDashboardRepository(dioClient: dioClient, cache: cache);
    when(() => api.listMyDashboardEntries(pageable: any(named: 'pageable'))).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/x'),
        data: PageResponseDashboardItem(
          (b) => b
            ..content = ListBuilder([
              DashboardItem((i) => i
                ..type = DashboardItemTypeEnum.LISTING
                ..listing = _listing('a-1', 120).toBuilder()),
              DashboardItem((i) => i
                ..type = DashboardItemTypeEnum.RESIDENCE
                ..residence = ResidenceStats((r) => r
                  ..residenceId = 'r-1'
                  ..units = ListBuilder([_listing('u-3', 40)])).toBuilder()),
            ]),
        ),
      ),
    );
  });

  test('a listing standing alone', () async {
    final read = await repository.listingFigures('a-1');

    expect(read.fromCache, isFalse);
    expect(read.value?.views?.value, 120);
    expect(read.value?.viewsLast7Days?.value, 30);
    expect(read.value?.averagePosition?.value, 2.4);
    // Locked: no value was sent, none is made up.
    expect(read.value?.contacts, const DashboardFigure(locked: true));
  });

  test('a unit, found inside its residence', () async {
    expect((await repository.listingFigures('u-3')).value?.views?.value, 40);
  });

  test('not counted (a draft): nothing, rather than zeros', () async {
    expect((await repository.listingFigures('draft')).value, isNull);
  });

  test('offline, the last read', () async {
    await repository.listingFigures('a-1');
    when(() => api.listMyDashboardEntries(pageable: any(named: 'pageable')))
        .thenThrow(DioException(requestOptions: RequestOptions(path: '/x')));

    final read = await repository.listingFigures('a-1');
    expect(read.fromCache, isTrue);
    expect(read.value?.views?.value, 120);
    await expectLater(repository.listingFigures('a-2'), throwsA(isA<DioException>()));
  });

  group('ListingStatsBloc', () {
    late MockProDashboardRepository repo;
    const figures = ListingFigures(views: DashboardFigure(value: 12));

    setUp(() => repo = MockProDashboardRepository());

    blocTest<ListingStatsBloc, ListingStatsState>(
      'reads the figures',
      setUp: () => when(() => repo.listingFigures('a-1')).thenAnswer((_) async => const Cached(figures)),
      build: () => ListingStatsBloc(repository: repo),
      act: (bloc) => bloc.add(const ListingStatsRequested('a-1')),
      expect: () => const [ListingStatsReady(figures)],
    );

    blocTest<ListingStatsBloc, ListingStatsState>(
      'nothing at all is a failure',
      setUp: () => when(() => repo.listingFigures('a-1')).thenThrow(Exception('offline')),
      build: () => ListingStatsBloc(repository: repo),
      act: (bloc) => bloc.add(const ListingStatsRequested('a-1')),
      expect: () => const [ListingStatsFailure()],
    );
  });
}
