import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

/// One line of the breakdown (Doc 10 M09).
enum ScoreSignalKind {
  profileComplete,
  identityVerified,
  accountSeniority,
  signedContracts,
  providerRating,
  validatedReports,
  adminAdjustment,

  /// A signal newer than this build — kept, so the breakdown still shows
  /// what the server counted, and drawn without a label of its own.
  unknown;

  static ScoreSignalKind fromResponse(ScoreSignalCodeEnum? code) => switch (code) {
        ScoreSignalCodeEnum.PROFILE_COMPLETE => ScoreSignalKind.profileComplete,
        ScoreSignalCodeEnum.IDENTITY_VERIFIED => ScoreSignalKind.identityVerified,
        ScoreSignalCodeEnum.ACCOUNT_SENIORITY => ScoreSignalKind.accountSeniority,
        ScoreSignalCodeEnum.SIGNED_CONTRACTS => ScoreSignalKind.signedContracts,
        ScoreSignalCodeEnum.PROVIDER_RATING => ScoreSignalKind.providerRating,
        ScoreSignalCodeEnum.VALIDATED_REPORTS => ScoreSignalKind.validatedReports,
        ScoreSignalCodeEnum.ADMIN_ADJUSTMENT => ScoreSignalKind.adminAdjustment,
        _ => ScoreSignalKind.unknown,
      };
}

class MboaScoreSignal extends Equatable {
  const MboaScoreSignal({
    required this.kind,
    required this.points,
    this.maxPoints,
    this.count,
    this.available = true,
  });

  final ScoreSignalKind kind;

  /// As the server counted them — negative for upheld reports (−15 each).
  final int points;

  /// What the signal can bring at most. Null for the admin adjustment, which
  /// has no ceiling; 0 for upheld reports, which can only take away.
  final int? maxPoints;

  /// For countable signals (contracts, reports, adjustments) only.
  final int? count;

  /// False for a signal the platform cannot compute yet (`PROVIDER_RATING`):
  /// "bientôt", not a zero the tenant failed to earn.
  final bool available;

  /// RM-M09-06 — what lowered the score, shown as such.
  bool get isPenalty => points < 0;

  /// Points still within reach on this line — Doc 10's "marge d'amélioration".
  int get remaining {
    final max = maxPoints;
    // A line capped at 0 (upheld reports) only ever takes away: losing less
    // is not something to earn.
    if (!available || max == null || max <= 0 || max <= points) return 0;
    return max - points;
  }

  static MboaScoreSignal fromResponse(ScoreSignal response) => MboaScoreSignal(
        kind: ScoreSignalKind.fromResponse(response.code),
        points: response.points ?? 0,
        maxPoints: response.maxPoints,
        count: response.count,
        available: response.available ?? true,
      );

  @override
  List<Object?> get props => [kind, points, maxPoints, count, available];
}

/// A tenant's reliability score (CDC M09) — computed by the server, never here.
///
/// [score] is already held between 0 and [maxScore]; the [signals] are not,
/// and must not be re-added: two upheld reports and nothing else score 0
/// while the breakdown shows −30.
class MboaScore extends Equatable {
  const MboaScore({required this.score, this.maxScore = 90, this.signals = const []});

  final int score;

  /// 90 — "le point parfait n'existe pas".
  final int maxScore;

  /// In the server's order. The admin adjustment at 0 is dropped: it is 0
  /// for almost everyone and would read as a missing achievement.
  final List<MboaScoreSignal> signals;

  static MboaScore fromResponse(MboaScoreResponse response) => MboaScore(
        score: response.score ?? 0,
        maxScore: response.maxScore ?? 90,
        signals: [
          for (final s in response.signals ?? const <ScoreSignal>[])
            if (MboaScoreSignal.fromResponse(s) case final signal
                when !(signal.kind == ScoreSignalKind.adminAdjustment && signal.points == 0))
              signal,
        ],
      );

  @override
  List<Object?> get props => [score, maxScore, signals];
}
