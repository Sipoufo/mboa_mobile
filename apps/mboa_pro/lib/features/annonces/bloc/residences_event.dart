part of 'residences_bloc.dart';

sealed class ResidencesEvent extends Equatable {
  const ResidencesEvent();

  @override
  List<Object?> get props => [];
}

final class ResidencesLoadRequested extends ResidencesEvent {
  const ResidencesLoadRequested();
}

final class ResidencesRefreshRequested extends ResidencesEvent {
  const ResidencesRefreshRequested();
}

/// Bulk transition — applies to every unit in the residence.
final class ResidenceStatusChangeRequested extends ResidencesEvent {
  const ResidenceStatusChangeRequested(this.id, this.transition);

  final String id;
  final AnnonceTransition transition;

  @override
  List<Object?> get props => [id, transition];
}
