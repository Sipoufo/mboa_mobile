part of 'agent_availability_bloc.dart';

sealed class AgentAvailabilityState extends Equatable {
  const AgentAvailabilityState();

  @override
  List<Object?> get props => [];
}

class AvailabilityInitial extends AgentAvailabilityState {
  const AvailabilityInitial();
}

class AvailabilityLoadInProgress extends AgentAvailabilityState {
  const AvailabilityLoadInProgress();
}

class AvailabilityReady extends AgentAvailabilityState {
  const AvailabilityReady({
    required this.saved,
    required this.draft,
    this.isSaving = false,
    this.justSaved = false,
    this.lastActionFailed = false,
    this.rejected = false,
  });

  /// What the server holds.
  final Availability saved;

  /// What the agent is editing. Days off are applied to both at once — they are
  /// saved the moment they are tapped.
  final Availability draft;

  final bool isSaving;
  final bool justSaved;
  final bool lastActionFailed;

  /// Set for one emission when a rule was refused (overlapping or backwards),
  /// so the screen can say why instead of silently ignoring the tap.
  final bool rejected;

  bool get isDirty =>
      draft.rules != saved.rules ||
      draft.visitDurationMinutes != saved.visitDurationMinutes;

  AvailabilityReady copyWith({
    Availability? saved,
    Availability? draft,
    bool? isSaving,
    bool justSaved = false,
    bool lastActionFailed = false,
    bool rejected = false,
  }) =>
      AvailabilityReady(
        saved: saved ?? this.saved,
        draft: draft ?? this.draft,
        isSaving: isSaving ?? this.isSaving,
        justSaved: justSaved,
        lastActionFailed: lastActionFailed,
        rejected: rejected,
      );

  @override
  List<Object?> get props =>
      [saved, draft, isSaving, justSaved, lastActionFailed, rejected];
}

class AvailabilityFailure extends AgentAvailabilityState {
  const AvailabilityFailure();
}
