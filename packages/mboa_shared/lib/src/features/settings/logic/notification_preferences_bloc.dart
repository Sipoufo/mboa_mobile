import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../api/api_error.dart';
import '../data/app_settings_repository.dart';
import '../models/notification_preference.dart';

part 'notification_preferences_event.dart';
part 'notification_preferences_state.dart';

/// The notification switches in Paramètres (RM-M03-01).
///
/// A switch moves the moment it is tapped and is put back if the server says
/// no — waiting a round-trip to see a switch move feels broken. One save at a
/// time: the opt-out set replaces the stored one, so two saves racing could
/// land in the wrong order and quietly undo each other.
class NotificationPreferencesBloc extends Bloc<NotificationPreferencesEvent, NotificationPreferencesState> {
  NotificationPreferencesBloc({
    required AppSettingsRepository repository,
    required NotificationAudience audience,
  })  : _repository = repository,
        _audience = audience,
        super(const NotificationPreferencesLoading()) {
    on<NotificationPreferencesRequested>(_onRequested);
    on<NotificationPreferenceToggled>(_onToggled);
  }

  final AppSettingsRepository _repository;
  final NotificationAudience _audience;

  Future<void> _onRequested(
    NotificationPreferencesRequested event,
    Emitter<NotificationPreferencesState> emit,
  ) async {
    emit(const NotificationPreferencesLoading());
    try {
      emit(_ready(await _repository.fetchNotifications()));
    } catch (_) {
      emit(const NotificationPreferencesFailure());
    }
  }

  Future<void> _onToggled(
    NotificationPreferenceToggled event,
    Emitter<NotificationPreferencesState> emit,
  ) async {
    final current = state;
    if (current is! NotificationPreferencesReady || current.savingCode != null) return;

    final toggled = [
      for (final p in current.all)
        p.code == event.code ? p.copyWith(enabled: event.enabled) : p,
    ];
    emit(_ready(toggled, savingCode: event.code));

    try {
      // Every opt-out, shown here or not: the set replaces the stored one.
      final disabled = {
        for (final p in toggled)
          if (!p.enabled && !p.mandatory) p.code,
      };
      emit(_ready(await _repository.saveDisabledNotifications(disabled)));
    } catch (error) {
      emit(
        _ready(
          current.all,
          error: ApiError.from(error).hasCode('NOTIFICATION_MANDATORY')
              ? NotificationPreferencesError.mandatory
              : NotificationPreferencesError.saveFailed,
        ),
      );
    }
  }

  NotificationPreferencesReady _ready(
    List<NotificationPreference> all, {
    String? savingCode,
    NotificationPreferencesError? error,
  }) =>
      NotificationPreferencesReady(
        all: all,
        visible: NotificationPreference.visibleTo(_audience, all),
        savingCode: savingCode,
        error: error,
      );
}
