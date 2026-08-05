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

/// Loads one residence in full.
///
/// The list payload carries the unit *counts* but not necessarily the `units`
/// array, so the detail screen must fetch its own — otherwise it shows a
/// residence with no units.
final class ResidenceDetailRequested extends ResidencesEvent {
  const ResidenceDetailRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// Bulk transition — applies to every unit in the residence.
final class ResidenceStatusChangeRequested extends ResidencesEvent {
  const ResidenceStatusChangeRequested(this.id, this.transition);

  final String id;
  final AnnonceTransition transition;

  @override
  List<Object?> get props => [id, transition];
}
