import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/visits_repository.dart';

part 'my_visits_event.dart';
part 'my_visits_state.dart';

/// The tenant's own visits (CDC M07).
///
/// Separate from [VisitBookingBloc] because booking and keeping track are two
/// screens with two lifetimes — the sheet dies when it closes, this outlives
/// it. They do not talk: after a booking this reloads on its own event, which
/// is also what a pull-to-refresh does.
class MyVisitsBloc extends Bloc<MyVisitsEvent, MyVisitsState> {
  MyVisitsBloc({required VisitsRepository repository, DateTime Function()? now})
      : _repository = repository,
        _now = now ?? DateTime.now,
        super(const MyVisitsInitial()) {
    on<MyVisitsRequested>(_onRequested);
    on<VisitPresenceConfirmed>(_onPresenceConfirmed);
    on<VisitCancelled>(_onCancelled);
    on<VisitorRated>(_onRated);
  }

  final VisitsRepository _repository;
  final DateTime Function() _now;

  Future<void> _onRequested(
    MyVisitsRequested event,
    Emitter<MyVisitsState> emit,
  ) async {
    if (state is! MyVisitsReady) emit(const MyVisitsLoadInProgress());
    try {
      emit(_ready(await _repository.mine()));
    } catch (_) {
      // Offline-first: the times and places of what is coming, which is what
      // someone checks on the way there.
      final cached = _repository.cachedUpcoming();
      if (cached.isNotEmpty) {
        emit(_ready(cached, isOffline: true));
        return;
      }
      if (state is MyVisitsReady) return;
      emit(const MyVisitsFailure());
    }
  }

  Future<void> _onPresenceConfirmed(
    VisitPresenceConfirmed event,
    Emitter<MyVisitsState> emit,
  ) async {
    if (state case final MyVisitsReady ready) {
      emit(ready.copyWith(busyVisitId: event.visitId));
      try {
        await _repository.confirmPresence(event.visitId);
        // RM-M07-05 — the server decides whether both halves are in, so the
        // whole list is re-read rather than patched from the response.
        add(const MyVisitsRequested());
      } catch (_) {
        emit(ready.copyWith(failed: true));
      }
    }
  }

  Future<void> _onCancelled(
    VisitCancelled event,
    Emitter<MyVisitsState> emit,
  ) async {
    if (state case final MyVisitsReady ready) {
      emit(ready.copyWith(busyVisitId: event.visitId));
      try {
        await _repository.cancel(event.visitId);
        add(const MyVisitsRequested());
      } catch (_) {
        emit(ready.copyWith(failed: true));
      }
    }
  }

  Future<void> _onRated(VisitorRated event, Emitter<MyVisitsState> emit) async {
    if (state case final MyVisitsReady ready) {
      emit(ready.copyWith(busyVisitId: event.visitId));
      try {
        await _repository.rateVisitor(
          visitId: event.visitId,
          rating: event.rating,
        );
        emit(ready.copyWith(ratedVisitIds: {...ready.ratedVisitIds, event.visitId}));
      } catch (_) {
        emit(ready.copyWith(failed: true));
      }
    }
  }

  MyVisitsReady _ready(List<Visit> visits, {bool isOffline = false}) {
    final now = _now();
    final upcoming = <Visit>[];
    final past = <Visit>[];
    for (final visit in visits) {
      final at = visit.scheduledAt;
      // An open visit whose slot has passed is still "upcoming" business: the
      // tenant may still have to confirm being there (RM-M07-05), and burying
      // it under history is where it would be missed.
      if (visit.status.isOpen && (at == null || at.isAfter(_dayStart(now)))) {
        upcoming.add(visit);
      } else {
        past.add(visit);
      }
    }
    // Soonest first for what is coming; most recent first for what is done.
    upcoming.sort((a, b) => _at(a).compareTo(_at(b)));

    return MyVisitsReady(
      upcoming: upcoming,
      past: past,
      isOffline: isOffline,
      // Kept across a reload: the endpoint takes a rating once, and nothing in
      // the response says one was given.
      ratedVisitIds:
          state is MyVisitsReady ? (state as MyVisitsReady).ratedVisitIds : const {},
    );
  }

  static DateTime _dayStart(DateTime day) =>
      DateTime(day.year, day.month, day.day);

  static DateTime _at(Visit visit) =>
      visit.scheduledAt ?? DateTime.fromMillisecondsSinceEpoch(0);
}
