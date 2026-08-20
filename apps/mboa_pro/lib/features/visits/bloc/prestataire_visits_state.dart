part of 'prestataire_visits_bloc.dart';

sealed class PrestataireVisitsState extends Equatable {
  const PrestataireVisitsState();

  @override
  List<Object?> get props => [];
}

class PrestataireVisitsIdle extends PrestataireVisitsState {
  const PrestataireVisitsIdle();
}

/// One visit is mid-action, so its row spins instead of the whole week.
class PrestataireVisitsBusy extends PrestataireVisitsState {
  const PrestataireVisitsBusy(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// The action went through — the screen reloads the agenda on this.
class PrestataireVisitsDone extends PrestataireVisitsState {
  const PrestataireVisitsDone();
}

class PrestataireVisitsFailed extends PrestataireVisitsState {
  const PrestataireVisitsFailed();
}

/// No position, no presence confirmation — and the reason matters, because it
/// is a permission the prestataire can grant.
class PrestataireVisitsLocationFailed extends PrestataireVisitsState {
  const PrestataireVisitsLocationFailed(this.failure);

  final LocationFailure failure;

  @override
  List<Object?> get props => [failure];
}
