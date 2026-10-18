import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

ScoreSignal _signal(ScoreSignalCodeEnum code, int points, {int? max, int? count, bool available = true}) => ScoreSignal(
  (b) => b
    ..code = code
    ..points = points
    ..maxPoints = max
    ..count = count
    ..available = available,
);

/// Two upheld reports and nothing else: the score is held at 0 while the
/// breakdown shows −30 — the case that proves nothing is re-added here.
MboaScoreResponse _penalised() => MboaScoreResponse(
  (b) => b
    ..score = 0
    ..maxScore = 90
    ..signals = ListBuilder([
      _signal(ScoreSignalCodeEnum.PROFILE_COMPLETE, 0, max: 10),
      _signal(ScoreSignalCodeEnum.IDENTITY_VERIFIED, 0, max: 20),
      _signal(ScoreSignalCodeEnum.ACCOUNT_SENIORITY, 0, max: 10),
      _signal(ScoreSignalCodeEnum.SIGNED_CONTRACTS, 0, max: 30, count: 0),
      _signal(ScoreSignalCodeEnum.PROVIDER_RATING, 0, max: 20, available: false),
      _signal(ScoreSignalCodeEnum.VALIDATED_REPORTS, -30, max: 0, count: 2),
      _signal(ScoreSignalCodeEnum.ADMIN_ADJUSTMENT, 0, count: 0),
    ]),
);

DioException _refused(int status, String code) => DioException(
  requestOptions: RequestOptions(path: '/score'),
  response: Response(
    requestOptions: RequestOptions(path: '/score'),
    statusCode: status,
    data: {'error': code},
  ),
);

/// CDC M09 — the Mboa Score, shown as the server computed it.
void main() {
  group('MboaScore.fromResponse', () {
    test('the score is the server\'s, never the sum of the lines', () {
      final score = MboaScore.fromResponse(_penalised());

      expect(score.score, 0);
      expect(score.maxScore, 90);
      final reports = score.signals.firstWhere((s) => s.kind == ScoreSignalKind.validatedReports);
      expect(reports.points, -30);
      expect(reports.isPenalty, isTrue);
      expect(reports.count, 2);
    });

    test('the lines keep the server\'s order, and a zero adjustment is dropped', () {
      final kinds = MboaScore.fromResponse(_penalised()).signals.map((s) => s.kind);

      expect(kinds, [
        ScoreSignalKind.profileComplete,
        ScoreSignalKind.identityVerified,
        ScoreSignalKind.accountSeniority,
        ScoreSignalKind.signedContracts,
        ScoreSignalKind.providerRating,
        ScoreSignalKind.validatedReports,
      ]);
    });

    test('an adjustment that moved the score is shown', () {
      final response = _penalised().rebuild(
        (b) => b.signals[6] = _signal(ScoreSignalCodeEnum.ADMIN_ADJUSTMENT, 20, count: 1),
      );

      expect(MboaScore.fromResponse(response).signals.last.kind, ScoreSignalKind.adminAdjustment);
    });

    test('a signal not computed yet is "bientôt", with nothing left to earn', () {
      final rating = MboaScore.fromResponse(_penalised()).signals.firstWhere(
        (s) => s.kind == ScoreSignalKind.providerRating,
      );

      expect(rating.available, isFalse);
      expect(rating.remaining, 0);
    });

    test('what is still within reach on a line', () {
      const contracts = MboaScoreSignal(kind: ScoreSignalKind.signedContracts, points: 10, maxPoints: 30, count: 1);
      const reports = MboaScoreSignal(kind: ScoreSignalKind.validatedReports, points: -15, maxPoints: 0, count: 1);

      expect(contracts.remaining, 20);
      expect(reports.remaining, 0);
    });
  });

  group('MboaScoreRepository', () {
    late MockDioClient dioClient;
    late MockApiClient apiClient;
    late MockMboaScoreApi api;
    late MboaScoreRepository repository;

    setUp(() {
      dioClient = MockDioClient();
      apiClient = MockApiClient();
      api = MockMboaScoreApi();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getMboaScoreApi).thenReturn(api);
      repository = MboaScoreRepository(dioClient: dioClient);
    });

    test('a tenant\'s score is asked for by their account id', () async {
      when(() => api.getTenantMboaScore(userId: 'u-1')).thenAnswer(
        (_) async => Response(
          data: _penalised(),
          requestOptions: RequestOptions(path: '/score'),
        ),
      );

      expect((await repository.tenant('u-1')).score, 0);
    });

    test('RM-M09-04 — no contact yet is a refusal, not a failure', () {
      when(() => api.getTenantMboaScore(userId: any(named: 'userId'))).thenThrow(_refused(403, 'SCORE_NOT_ACCESSIBLE'));

      expect(
        () => repository.tenant('u-1'),
        throwsA(isA<ScoreUnavailable>().having((e) => e.reason, 'reason', ScoreRefusal.notContacted)),
      );
    });

    test('an account with no score says so', () {
      when(() => api.getMyMboaScore()).thenThrow(_refused(404, 'SCORE_NOT_APPLICABLE'));

      expect(
        repository.mine,
        throwsA(isA<ScoreUnavailable>().having((e) => e.reason, 'reason', ScoreRefusal.noScore)),
      );
    });
  });

  group('MboaScoreBloc', () {
    late MockMboaScoreRepository repository;
    final score = MboaScore.fromResponse(_penalised());

    setUp(() => repository = MockMboaScoreRepository());

    blocTest<MboaScoreBloc, MboaScoreState>(
      'reads the tenant\'s own score',
      setUp: () => when(() => repository.mine()).thenAnswer((_) async => score),
      build: () => MboaScoreBloc(repository: repository, source: const OwnScore()),
      act: (bloc) => bloc.add(const MboaScoreRequested()),
      expect: () => [const MboaScoreLoading(), MboaScoreReady(score)],
      verify: (_) => verifyNever(() => repository.tenant(any())),
    );

    blocTest<MboaScoreBloc, MboaScoreState>(
      'reads a tenant\'s, for a prestataire',
      setUp: () => when(() => repository.tenant('u-1')).thenAnswer((_) async => score),
      build: () => MboaScoreBloc(repository: repository, source: const TenantScore('u-1')),
      act: (bloc) => bloc.add(const MboaScoreRequested()),
      expect: () => [const MboaScoreLoading(), MboaScoreReady(score)],
    );

    blocTest<MboaScoreBloc, MboaScoreState>(
      'a refusal is told apart from a failure — it is not worth a retry',
      setUp: () => when(() => repository.tenant('u-1')).thenThrow(const ScoreUnavailable(ScoreRefusal.notContacted)),
      build: () => MboaScoreBloc(repository: repository, source: const TenantScore('u-1')),
      act: (bloc) => bloc.add(const MboaScoreRequested()),
      expect: () => [const MboaScoreLoading(), const MboaScoreUnavailable(ScoreRefusal.notContacted)],
    );

    blocTest<MboaScoreBloc, MboaScoreState>(
      '"Réessayer" after a failure reads it again',
      setUp: () {
        var calls = 0;
        when(() => repository.mine()).thenAnswer((_) async {
          if (calls++ == 0) throw Exception('offline');
          return score;
        });
      },
      build: () => MboaScoreBloc(repository: repository, source: const OwnScore()),
      act: (bloc) async {
        bloc.add(const MboaScoreRequested());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const MboaScoreRequested());
      },
      expect: () => [
        const MboaScoreLoading(),
        const MboaScoreFailure(),
        const MboaScoreLoading(),
        MboaScoreReady(score),
      ],
    );

    blocTest<MboaScoreBloc, MboaScoreState>(
      'offline, a failure with a retry — nothing cached to fall back on',
      setUp: () => when(() => repository.mine()).thenThrow(Exception('offline')),
      build: () => MboaScoreBloc(repository: repository, source: const OwnScore()),
      act: (bloc) => bloc.add(const MboaScoreRequested()),
      expect: () => [const MboaScoreLoading(), const MboaScoreFailure()],
    );
  });
}
