part of 'profile_bloc.dart';

/// Events for the shared profile feature.
sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Load (or refresh) the profile.
final class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested();
}

/// Persist the edited profile ([E] being the app's edit type).
final class ProfileSaveRequested<E> extends ProfileEvent {
  const ProfileSaveRequested(this.edit);

  final E edit;

  @override
  List<Object?> get props => [edit];
}

/// Capture a photo from [source], upload it, and set it as the profile photo.
final class ProfilePhotoChangeRequested extends ProfileEvent {
  const ProfilePhotoChangeRequested(this.source);

  final ImageSource source;

  @override
  List<Object?> get props => [source];
}
