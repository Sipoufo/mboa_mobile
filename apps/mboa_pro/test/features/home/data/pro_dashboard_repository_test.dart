import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/home/data/pro_dashboard_repository.dart';
import 'package:mboa_pro/features/home/models/dashboard_stats.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockHiveCache extends Mock implements HiveCache {}

class MockAnnoncesApi extends Mock implements AnnoncesApi {}

AnnonceResponse annonce(AnnonceResponseStatusEnum status) =>
    AnnonceResponse((b) => b
      ..id = 'a-${status.name}'
      ..status = status);

void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockAnnoncesApi annoncesApi;
  late MockHiveCache cache;
  late ProDashboardRepository repository;

  setUpAll(() => registerFallbackValue(Pageable()));

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    annoncesApi = MockAnnoncesApi();
    cache = MockHiveCache();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getAnnoncesApi).thenReturn(annoncesApi);
    when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});

    repository = ProDashboardRepository(dioClient: dioClient, cache: cache);
  });

  void stubPage({
    required List<AnnonceResponse> content,
    int? totalElements,
  }) {
    final page = PageResponseAnnonceResponse((b) => b
      ..content = ListBuilder(content)
      ..totalElements = totalElements ?? content.length);

    when(() => annoncesApi.listMyAnnonces(pageable: any(named: 'pageable')))
        .thenAnswer(
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

    test('leaves the metrics with no endpoint null, not zero', () async {
      stubPage(content: [annonce(AnnonceResponseStatusEnum.PUBLISHED)]);

      final stats = await repository.fetch();

      expect(stats.views, isNull);
      expect(stats.contacts, isNull);
      expect(stats.conversionRate, isNull);
      expect(stats.agentVisits, isNull);
      expect(stats.signedContracts, isNull);
      expect(stats.averageRank, isNull);
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

      final captured = verify(
        () => cache.put(StorageKeys.dashboardBox, 'stats', captureAny()),
      ).captured.single as Map<String, dynamic>;
      expect(captured['totalBiens'], 3);
    });

    test('propagates a network failure so the bloc can fall back', () async {
      when(() => annoncesApi.listMyAnnonces(pageable: any(named: 'pageable')))
          .thenThrow(
        DioException(requestOptions: RequestOptions(path: '/api/v1/annonces')),
      );

      expect(repository.fetch, throwsA(isA<DioException>()));
    });
  });

  group('cached', () {
    test('returns null when the cache is empty or stale', () {
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl')))
          .thenReturn(null);

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
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl')))
          .thenReturn({'totalBiens': 4, 'byStatus': {'retired': 2}});

      final stats = repository.cached();

      expect(stats?.totalBiens, 4);
      expect(stats?.countOf(AnnonceStatus.unknown), 2);
    });
  });

  group('views (M14)', () {
    AnnonceResponse viewed(String id, int? count) => AnnonceResponse((b) => b
      ..id = id
      ..status = AnnonceResponseStatusEnum.PUBLISHED
      ..viewCount = count);

    test('sums viewCount across the listings', () async {
      // The 2026-08-11 spec put viewCount on AnnonceResponse, so the first of
      // M14's six missing metrics finally has a source.
      stubPage(content: [viewed('a', 12), viewed('b', 30), viewed('c', 0)]);

      final stats = await repository.fetch();

      expect(stats.views, 42);
    });

    test('stays null when no listing carries the field', () async {
      // An older backend must keep reading as "unknown" so the dashboard shows
      // "Bientôt" — claiming zero views would be a lie the prestataire acts on.
      stubPage(content: [viewed('a', null), viewed('b', null)]);

      final stats = await repository.fetch();

      expect(stats.views, isNull);
    });

    test('counts the listings that do report, ignoring those that do not',
        () async {
      stubPage(content: [viewed('a', 7), viewed('b', null)]);

      final stats = await repository.fetch();

      expect(stats.views, 7);
    });

    test('survives the cache round trip', () {
      const stats = DashboardStats(totalBiens: 3, views: 42);

      expect(DashboardStats.fromCache(stats.toCache()).views, 42);
      // Null must not come back as zero.
      expect(
        DashboardStats.fromCache(const DashboardStats(totalBiens: 3).toCache())
            .views,
        isNull,
      );
    });
  });

}
