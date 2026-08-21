part of 'annonces_bloc.dart';

sealed class AnnoncesEvent extends Equatable {
  const AnnoncesEvent();

  @override
  List<Object?> get props => [];
}

final class AnnoncesLoadRequested extends AnnoncesEvent {
  const AnnoncesLoadRequested();
}

/// Pull-to-refresh — keeps the current list on screen while it runs.
final class AnnoncesRefreshRequested extends AnnoncesEvent {
  const AnnoncesRefreshRequested();
}

/// Switches the Disponibles / Occupés tab. Purely local — no fetch.
final class AnnoncesFilterChanged extends AnnoncesEvent {
  const AnnoncesFilterChanged(this.filter);

  final AnnonceFilter filter;

  @override
  List<Object?> get props => [filter];
}

/// Loads one listing that may not be in the list — a residence *unit* is
/// excluded from "Biens Uniques" but still has a detail screen.
final class AnnonceDetailRequested extends AnnoncesEvent {
  const AnnonceDetailRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class AnnonceStatusChangeRequested extends AnnoncesEvent {
  const AnnonceStatusChangeRequested(this.id, this.transition);

  final String id;
  final AnnonceTransition transition;

  @override
  List<Object?> get props => [id, transition];
}

/// RM-M11-10 — the prestataire puts himself in this listing's pool of
/// bookable visitors, or takes himself out.
final class AnnonceOwnerVisitsToggled extends AnnoncesEvent {
  const AnnonceOwnerVisitsToggled(this.id, {required this.enabled});

  final String id;
  final bool enabled;

  @override
  List<Object?> get props => [id, enabled];
}

/// RM-M10-07 — the UI must confirm in two steps before dispatching this.
final class AnnonceDeleteRequested extends AnnoncesEvent {
  const AnnonceDeleteRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
