part of 'agent_profile_bloc.dart';

sealed class AgentProfileState extends Equatable {
  const AgentProfileState();

  @override
  List<Object?> get props => [];
}

class AgentProfileInitial extends AgentProfileState {
  const AgentProfileInitial();
}

class AgentProfileLoadInProgress extends AgentProfileState {
  const AgentProfileLoadInProgress();
}

class AgentProfileReady extends AgentProfileState {
  const AgentProfileReady(
    this.profile, {
    this.isSaving = false,
    this.isUploadingPhoto = false,
    this.justSaved = false,
    this.lastActionFailed = false,
  });

  final AgentProfile profile;
  final bool isSaving;
  final bool isUploadingPhoto;

  /// Set for one emission after a successful save, for a confirmation toast.
  final bool justSaved;

  /// Set for one emission after a failure, for an error toast.
  final bool lastActionFailed;

  AgentProfileReady copyWith({
    AgentProfile? profile,
    bool? isSaving,
    bool? isUploadingPhoto,
    bool justSaved = false,
    bool lastActionFailed = false,
  }) =>
      AgentProfileReady(
        profile ?? this.profile,
        isSaving: isSaving ?? this.isSaving,
        isUploadingPhoto: isUploadingPhoto ?? this.isUploadingPhoto,
        justSaved: justSaved,
        lastActionFailed: lastActionFailed,
      );

  @override
  List<Object?> get props =>
      [profile, isSaving, isUploadingPhoto, justSaved, lastActionFailed];
}

class AgentProfileFailure extends AgentProfileState {
  const AgentProfileFailure();
}
