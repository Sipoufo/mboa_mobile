part of 'visits_agenda_bloc.dart';

sealed class VisitsAgendaEvent extends Equatable {
  const VisitsAgendaEvent();

  @override
  List<Object?> get props => [];
}

/// Opens the agenda, on [day] or on today.
class AgendaRequested extends VisitsAgendaEvent {
  const AgendaRequested({this.day});

  final DateTime? day;

  @override
  List<Object?> get props => [day];
}

class AgendaDaySelected extends VisitsAgendaEvent {
  const AgendaDaySelected(this.day);

  final DateTime day;

  @override
  List<Object?> get props => [day];
}

/// Another week — the strip's arrows, or a day picked outside the current one.
class AgendaWeekChanged extends VisitsAgendaEvent {
  const AgendaWeekChanged(this.weekStart, {this.selectedDay});

  final DateTime weekStart;

  /// Defaults to the first day of the week when the move came from an arrow.
  final DateTime? selectedDay;

  @override
  List<Object?> get props => [weekStart, selectedDay];
}

/// Re-reads the week in place — after an action taken elsewhere on the screen.
class AgendaRefreshed extends VisitsAgendaEvent {
  const AgendaRefreshed();
}
