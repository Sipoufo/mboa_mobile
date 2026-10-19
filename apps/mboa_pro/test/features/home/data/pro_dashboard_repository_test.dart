import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/home/data/pro_dashboard_repository.dart';
import 'package:mboa_pro/features/home/models/dashboard_stats.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockAnnoncesApi extends Mock implements AnnoncesApi {}

class MockPrestataireDashboardApi extends Mock implements PrestataireDashboardApi {}

DashboardMetric metric({
  num? value,
  bool locked = false,
  DashboardMetricRequiredTierEnum? tier,
  bool available = true,
}) => DashboardMetric(
  (b) => b
    ..value = value
    ..locked = locked
    ..requiredTier = tier
    ..available = available,
);

AnnonceResponse annonce(AnnonceResponseStatusEnum status) => AnnonceResponse(
  (b) => b
    ..id = 'a-${status.name}'
    ..status = status,
);

void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockAnnoncesApi annoncesApi;
  late MockPrestataireDashboardApi dashboardApi;
  late MockHiveCache cache;
  late ProDashboardRepository repository;

  void stubDashboard(DashboardSummaryResponse summary) => when(() => dashboardApi.getMyDashboard()).thenAnswer(
    (_) async => Response(
      data: summary,
      requestOptions: RequestOptions(path: '/api/v1/prestataires/me/dashboard'),
      statusCode: 200,
    ),
  );

  setUpAll(() => registerFallbackValue(Pageable()));

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    annoncesApi = MockAnnoncesApi();
    dashboardApi = MockPrestataireDashboardApi();
    cache = MockHiveCache();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getAnnoncesApi).thenReturn(annoncesApi);
    when(apiClient.getPrestataireDashboardApi).thenReturn(dashboardApi);
    stubDashboard(DashboardSummaryResponse());
    when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});

    repository = ProDashboardRepository(dioClient: dioClient, cache: cache);
  });

  void stubPage({
    required List<AnnonceResponse> content,
    int? totalElements,
  }) {
    final page = PageResponseAnnonceResponse(
      (b) => b
        ..content = ListBuilder(content)
        ..totalElements = totalElements ?? content.length,
    );

    when(() => annoncesApi.listMyAnnonces(pageable: any(named: 'pageable'))).thenAnswer(
      (_) async => Response(
        data: page,
        requestOptions: RequestOptions(path: '/api/v1/annonces'),
        statusCode: 200,
      ),
    );
  }

  group('fetch', () {
    test('counts listings per status and takes the total from the page', () async {
      stubPage(
        content: [
          annonce(AnnonceResponseStatusEnum.PUBLISHED),
          annonce(AnnonceResponseStatusEnum.PUBLISHED),
          annonce(AnnonceResponseStatusEnum.RENTED),
          annonce(AnnonceResponseStatusEnum.DRAFT),
        ],
        // Bigger than the page content — the server total must win.
        totalElements: 17,
      );

      final stats = await repository.fetch();

      expect(stats.totalBiens, 17);
      expect(stats.countOf(AnnonceStatus.published), 2);
      expect(stats.countOf(AnnonceStatus.rented), 1);
      expect(stats.countOf(AnnonceStatus.draft), 1);
      expect(stats.countOf(AnnonceStatus.reserved), 0);
    });

    test('the six figures are the dashboard endpoint\'s, as it sent them', () async {
      stubPage(content: [annonce(AnnonceResponseStatusEnum.PUBLISHED)]);
      stubDashboard(
        DashboardSummaryResponse(
          (b) => b
            ..totals.views.replace(metric(value: 42))
            ..totals.contacts.replace(metric(value: 3))
            // Unlocked, nothing to measure yet: no value, and not a zero.
            ..totals.conversionRate.replace(metric(tier: DashboardMetricRequiredTierEnum.BASIC_PLUS))
            ..totals.agentVisits.replace(metric(locked: true, tier: DashboardMetricRequiredTierEnum.BASIC_PLUS))
            ..totals.signedContracts.replace(metric(value: 1))
            ..averagePosition.replace(
              metric(locked: true, tier: DashboardMetricRequiredTierEnum.PRO_PLUS, available: false),
            ),
        ),
      );

      final stats = await repository.fetch();

      expect(stats.views, const DashboardFigure(value: 42));
      expect(stats.contacts?.value, 3);
      expect(stats.conversionRate, const DashboardFigure(requiredTier: SubscriptionTier.basicPlus));
      expect(
        stats.agentVisits,
        const DashboardFigure(locked: true, requiredTier: SubscriptionTier.basicPlus),
      );
      expect(stats.signedContracts?.value, 1);
      expect(
        stats.averagePosition,
        const DashboardFigure(locked: true, requiredTier: SubscriptionTier.proPlus, available: false),
      );
    });

    test('views are the server\'s count, not a sum of the listings\' viewCount', () async {
      stubPage(
        content: [
          AnnonceResponse(
            (b) => b
              ..id = 'a'
              ..status = AnnonceResponseStatusEnum.PUBLISHED
              ..viewCount = 999,
          ),
        ],
      );
      stubDashboard(DashboardSummaryResponse((b) => b..totals.views.replace(metric(value: 42))));

      expect((await repository.fetch()).views?.value, 42);
    });

    test('a dashboard failure fails the load, so the bloc falls back to the cache', () async {
      stubPage(content: const []);
      when(() => dashboardApi.getMyDashboard()).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/api/v1/prestataires/me/dashboard')),
      );

      expect(repository.fetch, throwsA(isA<DioException>()));
    });

    test('maps an unrecognised status defensively', () async {
      stubPage(
        content: [annonce(AnnonceResponseStatusEnum.unknownDefaultOpenApi)],
      );

      final stats = await repository.fetch();

      expect(stats.countOf(AnnonceStatus.unknown), 1);
    });

    test('handles an empty portfolio', () async {
      stubPage(content: const []);

      final stats = await repository.fetch();

      expect(stats.totalBiens, 0);
      expect(stats.byStatus, isEmpty);
    });

    test('writes the result to the dashboard cache', () async {
      stubPage(
        content: [annonce(AnnonceResponseStatusEnum.PUBLISHED)],
        totalElements: 3,
      );

      await repository.fetch();

      final captured =
          verify(
                () => cache.put(StorageKeys.dashboardBox, 'stats', captureAny()),
              ).captured.single
              as Map<String, dynamic>;
      expect(captured['totalBiens'], 3);
    });

    test('propagates a network failure so the bloc can fall back', () async {
      when(() => annoncesApi.listMyAnnonces(pageable: any(named: 'pageable'))).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/api/v1/annonces')),
      );

      expect(repository.fetch, throwsA(isA<DioException>()));
    });
  });

  group('cached', () {
    test('returns null when the cache is empty or stale', () {
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn(null);

      expect(repository.cached(), isNull);
    });

    test('reads through the dashboard TTL and rebuilds the stats', () {
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn({
        'totalBiens': 17,
        'byStatus': {'published': 12, 'rented': 5},
      });

      final stats = repository.cached();

      expect(stats?.totalBiens, 17);
      expect(stats?.countOf(AnnonceStatus.published), 12);
      expect(stats?.countOf(AnnonceStatus.rented), 5);
      verify(
        () => cache.get(
          StorageKeys.dashboardBox,
          'stats',
          ttl: CacheTtl.dashboard,
        ),
      ).called(1);
    });

    test('survives a cache entry written by an older build', () {
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn({
        'totalBiens': 4,
        'byStatus': {'retired': 2},
      });

      final stats = repository.cached();

      expect(stats?.totalBiens, 4);
      expect(stats?.countOf(AnnonceStatus.unknown), 2);
    });
  });

  test('figures survive the cache round trip, a missing one stays missing', () {
    const stats = DashboardStats(
      totalBiens: 3,
      views: DashboardFigure(value: 42),
      averagePosition: DashboardFigure(locked: true, requiredTier: SubscriptionTier.proPlus),
    );

    final back = DashboardStats.fromCache(stats.toCache());

    expect(back, stats);
    expect(back.contacts, isNull);
  });
}
