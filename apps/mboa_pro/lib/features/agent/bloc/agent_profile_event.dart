part of 'agent_profile_bloc.dart';

sealed class AgentProfileEvent extends Equatable {
  const AgentProfileEvent();

  @override
  List<Object?> get props => [];
}

class AgentProfileLoadRequested extends AgentProfileEvent {
  const AgentProfileLoadRequested();
}

/// Identity only — the photo and the zones have their own events, because each
/// hits a different endpoint.
class AgentProfileSaved extends AgentProfileEvent {
  const AgentProfileSaved({required this.firstName, required this.lastName});

  final String firstName;
  final String lastName;

  @override
  List<Object?> get props => [firstName, lastName];
}

/// RM-M15-05 — "Inactif": stop receiving new assignments.
class AgentAcceptingAssignmentsToggled extends AgentProfileEvent {
  const AgentAcceptingAssignmentsToggled(this.accepting);

  final bool accepting;

  @override
  List<Object?> get props => [accepting];
}

/// RM-M15-04. Replaces the whole set — the endpoint is a PUT.
class AgentZonesSaved extends AgentProfileEvent {
  const AgentZonesSaved({required this.cityIds, required this.districtIds});

  final List<String> cityIds;
  final List<String> districtIds;

  @override
  List<Object?> get props => [cityIds, districtIds];
}

class AgentPhotoChangeRequested extends AgentProfileEvent {
  const AgentPhotoChangeRequested(this.source);

  final ImageSource source;

  @override
  List<Object?> get props => [source];
}
