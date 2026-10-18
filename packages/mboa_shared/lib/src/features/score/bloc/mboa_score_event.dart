part of 'mboa_score_bloc.dart';

sealed class MboaScoreEvent extends Equatable {
  const MboaScoreEvent();

  @override
  List<Object?> get props => [];
}

/// Read the score — on opening, and on "Réessayer".
final class MboaScoreRequested extends MboaScoreEvent {
  const MboaScoreRequested();
}
