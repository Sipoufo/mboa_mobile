part of 'notification_preferences_bloc.dart';

/// Why a switch was put back.
enum NotificationPreferencesError { saveFailed, mandatory }

sealed class NotificationPreferencesState extends Equatable {
  const NotificationPreferencesState();

  @override
  List<Object?> get props => [];
}

final class NotificationPreferencesLoading extends NotificationPreferencesState {
  const NotificationPreferencesLoading();
}

/// Not loaded — offline, or the server failed. The screen offers a retry,
/// never an empty list that would read as "no notifications".
final class NotificationPreferencesFailure extends NotificationPreferencesState {
  const NotificationPreferencesFailure();
}

final class NotificationPreferencesReady extends NotificationPreferencesState {
  const NotificationPreferencesReady({
    required this.all,
    required this.visible,
    this.savingCode,
    this.error,
  });

  /// The whole catalogue as the server holds it — what a save is built from.
  final List<NotificationPreference> all;

  /// The switches this audience is offered.
  final List<NotificationPreference> visible;

  /// The switch being saved; every switch waits until it lands.
  final String? savingCode;

  /// Set on the state that puts a switch back, for the listener to explain.
  final NotificationPreferencesError? error;

  @override
  List<Object?> get props => [all, visible, savingCode, error];
}
