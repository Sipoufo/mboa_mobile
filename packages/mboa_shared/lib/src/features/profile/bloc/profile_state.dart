part of 'profile_bloc.dart';

/// Observable states of the shared profile feature.
sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

/// Nothing loaded yet.
final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// First load in flight (no data to show yet).
final class ProfileLoadInProgress extends ProfileState {
  const ProfileLoadInProgress();
}

/// The initial load failed and there is nothing to show.
final class ProfileLoadFailure extends ProfileState {
  const ProfileLoadFailure();
}

/// Profile data ([D]) is available. [saving] guards the edit screen and the
/// photo action. The one-shot signals are split so the edit screen (save) and
/// the hub (photo) each react only to their own outcome: [justSaved]/[saveFailed]
/// for a profile save, [photoJustUpdated]/[photoFailed] for a photo change.
final class ProfileReady<D> extends ProfileState {
  const ProfileReady(
    this.data, {
    this.saving = false,
    this.justSaved = false,
    this.saveFailed = false,
    this.photoJustUpdated = false,
    this.photoFailed = false,
  });

  final D data;
  final bool saving;
  final bool justSaved;
  final bool saveFailed;
  final bool photoJustUpdated;
  final bool photoFailed;

  @override
  List<Object?> get props => [data, saving, justSaved, saveFailed, photoJustUpdated, photoFailed];
}
