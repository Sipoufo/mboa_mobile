import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/visits_source.dart';
import '../models/visit.dart';

part 'visits_agenda_event.dart';
part 'visits_agenda_state.dart';

/// A week of visits, one day selected (CDC M16 for the agent, RM-M15-06 for a
/// prestataire showing his own property).
///
/// Loads **one week at a time** because that is exactly what the strip shows;
/// moving to another week is another request rather than a filter over
/// everything ever booked. The bloc never acts on a visit — confirming,
/// declining and cancelling belong to each persona's own bloc, since the rules
/// differ per role.
class VisitsAgendaBloc extends Bloc<VisitsAgendaEvent, VisitsAgendaState> {
  VisitsAgendaBloc({required VisitsSource source, DateTime? today})
      : _source = source,
        _today = today,
        super(const VisitsAgendaInitial()) {
    on<AgendaRequested>(_onRequested);
    on<AgendaDaySelected>(_onDaySelected);
    on<AgendaWeekChanged>(_onWeekChanged);
    on<AgendaRefreshed>(_onRefreshed);
  }

  final VisitsSource _source;

  /// Injected in tests so "today" is not the machine clock.
  final DateTime? _today;

  DateTime get _now => _today ?? DateTime.now();

  /// Monday 00:00 of [day]'s week. Weeks start on Monday here: Doc 10's
  /// availability grid does, and the two must line up.
  static DateTime weekStartOf(DateTime day) {
    final local = DateTime(day.year, day.month, day.day);
    return local.subtract(Duration(days: local.weekday - DateTime.monday));
  }

  static bool sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Future<void> _onRequested(
    AgendaRequested event,
    Emitter<VisitsAgendaState> emit,
  ) async {
    final day = event.day ?? _now;
    emit(const VisitsAgendaLoadInProgress());
    await _load(weekStartOf(day), day, emit);
  }

  void _onDaySelected(
    AgendaDaySelected event,
    Emitter<VisitsAgendaState> emit,
  ) {
    final current = state;
    if (current is! VisitsAgendaReady) return;

    // Selecting a day of another week is how the strip's arrows and a swipe
    // both end up here; the week follows the selection rather than the reverse.
    final week = weekStartOf(event.day);
    if (sameDay(week, current.weekStart)) {
      emit(current.copyWith(selectedDay: event.day));
      return;
    }
    add(AgendaWeekChanged(week, selectedDay: event.day));
  }

  Future<void> _onWeekChanged(
    AgendaWeekChanged event,
    Emitter<VisitsAgendaState> emit,
  ) async {
    final current = state;
    final week = weekStartOf(event.weekStart);
    // Keep the visits already on screen while the new week loads: blanking the
    // list on every arrow tap makes a week look empty before it has been read.
    if (current is VisitsAgendaReady) {
      emit(current.copyWith(isLoadingWeek: true));
    }
    await _load(week, event.selectedDay ?? week, emit);
  }

  Future<void> _onRefreshed(
    AgendaRefreshed event,
    Emitter<VisitsAgendaState> emit,
  ) async {
    final current = state;
    if (current is! VisitsAgendaReady) return;
    emit(current.copyWith(isLoadingWeek: true));
    await _load(current.weekStart, current.selectedDay, emit);
  }

  Future<void> _load(
    DateTime weekStart,
    DateTime selectedDay,
    Emitter<VisitsAgendaState> emit,
  ) async {
    try {
      final visits = await _source.range(
        from: weekStart,
        to: weekStart.add(const Duration(days: 7)),
      );
      emit(
        VisitsAgendaReady(
          weekStart: weekStart,
          selectedDay: DateTime(
            selectedDay.year,
            selectedDay.month,
            selectedDay.day,
          ),
          today: DateTime(_now.year, _now.month, _now.day),
          visits: visits,
        ),
      );
    } catch (_) {
      emit(const VisitsAgendaFailure());
    }
  }
}
