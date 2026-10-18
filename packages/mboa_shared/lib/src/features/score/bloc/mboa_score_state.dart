part of 'mboa_score_bloc.dart';

sealed class MboaScoreState extends Equatable {
  const MboaScoreState();

  @override
  List<Object?> get props => [];
}

final class MboaScoreLoading extends MboaScoreState {
  const MboaScoreLoading();
}

final class MboaScoreReady extends MboaScoreState {
  const MboaScoreReady(this.score);

  final MboaScore score;

  @override
  List<Object?> get props => [score];
}

/// The server's answer is that there is nothing to show — not an error, and
/// not worth a retry.
final class MboaScoreUnavailable extends MboaScoreState {
  const MboaScoreUnavailable(this.reason);

  final ScoreRefusal reason;

  @override
  List<Object?> get props => [reason];
}

/// Offline, or the server failed: the screen offers a retry.
final class MboaScoreFailure extends MboaScoreState {
  const MboaScoreFailure();
}
