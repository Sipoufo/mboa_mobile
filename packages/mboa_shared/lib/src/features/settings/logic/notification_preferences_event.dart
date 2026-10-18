part of 'notification_preferences_bloc.dart';

sealed class NotificationPreferencesEvent extends Equatable {
  const NotificationPreferencesEvent();

  @override
  List<Object?> get props => [];
}

/// Load the settings — on opening the screen, and on "Réessayer".
final class NotificationPreferencesRequested extends NotificationPreferencesEvent {
  const NotificationPreferencesRequested();
}

/// A switch was flipped.
final class NotificationPreferenceToggled extends NotificationPreferencesEvent {
  const NotificationPreferenceToggled(this.code, {required this.enabled});

  final String code;
  final bool enabled;

  @override
  List<Object?> get props => [code, enabled];
}
