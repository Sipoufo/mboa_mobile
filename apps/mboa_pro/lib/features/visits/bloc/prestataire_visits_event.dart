part of 'prestataire_visits_bloc.dart';

sealed class PrestataireVisitsEvent extends Equatable {
  const PrestataireVisitsEvent();

  @override
  List<Object?> get props => [];
}

/// RM-M15-06 — the proposed time suits him.
class VisitRequestConfirmed extends PrestataireVisitsEvent {
  const VisitRequestConfirmed(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// Turns the proposed time down; the client may propose another.
class VisitRequestDeclined extends PrestataireVisitsEvent {
  const VisitRequestDeclined(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// RM-M07-05 — he is at the property.
class OwnerPresenceConfirmed extends PrestataireVisitsEvent {
  const OwnerPresenceConfirmed(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
