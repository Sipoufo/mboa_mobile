part of 'visits_agenda_bloc.dart';

sealed class VisitsAgendaState extends Equatable {
  const VisitsAgendaState();

  @override
  List<Object?> get props => [];
}

class VisitsAgendaInitial extends VisitsAgendaState {
  const VisitsAgendaInitial();
}

class VisitsAgendaLoadInProgress extends VisitsAgendaState {
  const VisitsAgendaLoadInProgress();
}

class VisitsAgendaReady extends VisitsAgendaState {
  const VisitsAgendaReady({
    required this.weekStart,
    required this.selectedDay,
    required this.today,
    this.visits = const [],
    this.isLoadingWeek = false,
  });

  /// Monday of the week on screen.
  final DateTime weekStart;
  final DateTime selectedDay;

  /// Carried rather than read from the clock, so a widget test can sit on a
  /// fixed date and the strip still knows which cell is today.
  final DateTime today;

  final List<Visit> visits;

  /// A week is being read while the previous one stays on screen.
  final bool isLoadingWeek;

  List<DateTime> get days =>
      [for (var i = 0; i < 7; i++) weekStart.add(Duration(days: i))];

  List<Visit> visitsOn(DateTime day) => (visits
      .where((v) =>
          v.scheduledAt != null &&
          VisitsAgendaBloc.sameDay(v.scheduledAt!, day))
      .toList())
    ..sort((a, b) => a.scheduledAt!.compareTo(b.scheduledAt!));

  List<Visit> get selectedVisits => visitsOn(selectedDay);

  /// Only what still stands counts on the strip: a cancelled visit stays in the
  /// day's list, but a dot for it would send someone to an empty afternoon.
  int countOn(DateTime day) =>
      visitsOn(day).where((v) => v.status.isOpen).length;

  bool get isOnToday => VisitsAgendaBloc.sameDay(selectedDay, today);

  /// Slots proposed to a prestataire who confirms by hand (RM-M15-06), across
  /// the whole week — they are answered wherever they fall, not day by day.
  List<Visit> get awaitingAnswer =>
      visits.where((v) => v.status == VisitStatus.requested).toList();

  VisitsAgendaReady copyWith({
    DateTime? weekStart,
    DateTime? selectedDay,
    List<Visit>? visits,
    bool? isLoadingWeek,
  }) =>
      VisitsAgendaReady(
        weekStart: weekStart ?? this.weekStart,
        selectedDay: selectedDay ?? this.selectedDay,
        today: today,
        visits: visits ?? this.visits,
        isLoadingWeek: isLoadingWeek ?? this.isLoadingWeek,
      );

  @override
  List<Object?> get props =>
      [weekStart, selectedDay, today, visits, isLoadingWeek];
}

class VisitsAgendaFailure extends VisitsAgendaState {
  const VisitsAgendaFailure();
}
