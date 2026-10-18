import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../../api/api_error.dart';
import '../models/mboa_score.dart';

/// Why a score cannot be shown — the server's answer, not a failure.
enum ScoreRefusal {
  /// RM-M09-04 — the tenant has not contacted this prestataire yet
  /// (`403 SCORE_NOT_ACCESSIBLE`).
  notContacted,

  /// Only a USER account has a score (`404 SCORE_NOT_APPLICABLE`).
  noScore,
}

class ScoreUnavailable implements Exception {
  const ScoreUnavailable(this.reason);

  final ScoreRefusal reason;
}

/// The Mboa Score (CDC M09), read two ways and never cached: it is
/// recomputed live (RM-M09-02), and a copy on a prestataire's phone would be
/// someone else's private data kept for no reason.
class MboaScoreRepository {
  MboaScoreRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  MboaScoreApi get _api => _dioClient.api.getMboaScoreApi();

  /// RM-M09-03 — the user's own, with its breakdown.
  Future<MboaScore> mine() => _read(() => _api.getMyMboaScore());

  /// RM-M09-04 — a tenant's, for a prestataire they have contacted.
  ///
  /// Throws [ScoreUnavailable] when the server says it cannot be shown.
  Future<MboaScore> tenant(String userAccountId) => _read(() => _api.getTenantMboaScore(userId: userAccountId));

  Future<MboaScore> _read(Future<Response<MboaScoreResponse>> Function() call) async {
    try {
      final data = (await call()).data;
      if (data == null) throw Exception('empty score response');
      return MboaScore.fromResponse(data);
    } catch (error) {
      final api = ApiError.from(error);
      if (api.hasCode('SCORE_NOT_ACCESSIBLE')) throw const ScoreUnavailable(ScoreRefusal.notContacted);
      if (api.hasCode('SCORE_NOT_APPLICABLE')) throw const ScoreUnavailable(ScoreRefusal.noScore);
      rethrow;
    }
  }
}
