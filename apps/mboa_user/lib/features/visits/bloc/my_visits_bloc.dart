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
  MyVisitsBloc({
    required VisitsRepository repository,
    required VisitReviewRepository reviews,
    DateTime Function()? now,
  })  : _repository = repository,
        _reviews = reviews,
        _now = now ?? DateTime.now,
        super(const MyVisitsInitial()) {
    on<MyVisitsRequested>(_onRequested);
    on<VisitPresenceConfirmed>(_onPresenceConfirmed);
    on<VisitCancelled>(_onCancelled);
    on<VisitorRated>(_onRated);
  }

  final VisitsRepository _repository;

  /// Which completed visits already carry a report (M07bis).
  ///
  /// `VisiteResponse` does not say — there is no flag on it — so the only way
  /// to know is to ask, once per completed visit. Few visits are ever
  /// completed, the calls run together, and a failure is not fatal: an unknown
  /// visit keeps offering to write, and the server refuses a second report
  /// with a 409 the screen already handles.
  final VisitReviewRepository _reviews;
  final DateTime Function() _now;

  /// Visits rated in this session. The endpoint takes a rating once
  /// (RM-M07-07) and nothing in `VisiteResponse` says one was given, so the
  /// bloc remembers rather than the state carrying it across reloads.
  final _rated = <String>{};

  Future<void> _onRequested(
    MyVisitsRequested event,
    Emitter<MyVisitsState> emit,
  ) async {
    if (state is! MyVisitsReady) emit(const MyVisitsLoadInProgress());
    try {
      final visits = await _repository.mine();
      emit(_ready(visits, reviewed: await _reviewedAmong(visits)));
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

  /// The three actions share a shape: mark the row busy **if** there is a list
  /// on screen, do the work, then let the server be the one to say what
  /// changed.
  ///
  /// They no longer require a `MyVisitsReady` to run. A reload now also asks
  /// which visits carry a report, so it takes long enough that a tap landing
  /// mid-refresh would have been dropped on the floor — the action still has
  /// its visit id, and that is all it needs.
  Future<void> _act(
    String visitId,
    Emitter<MyVisitsState> emit,
    Future<void> Function() work, {
    bool reloadAfter = true,
  }) async {
    final ready = _previous;
    if (ready != null) emit(ready.copyWith(busyVisitId: visitId));
    try {
      await work();
      if (reloadAfter) add(const MyVisitsRequested());
    } catch (_) {
      final current = _previous;
      if (current != null) emit(current.copyWith(failed: true));
    }
  }

  Future<void> _onPresenceConfirmed(
    VisitPresenceConfirmed event,
    Emitter<MyVisitsState> emit,
  ) =>
      // RM-M07-05 — whether that completed the visit is the server's call, so
      // the whole list is re-read rather than patched from the response.
      _act(event.visitId, emit, () => _repository.confirmPresence(event.visitId));

  Future<void> _onCancelled(
    VisitCancelled event,
    Emitter<MyVisitsState> emit,
  ) =>
      _act(event.visitId, emit, () => _repository.cancel(event.visitId));

  Future<void> _onRated(VisitorRated event, Emitter<MyVisitsState> emit) =>
      _act(
        event.visitId,
        emit,
        () async {
          await _repository.rateVisitor(
            visitId: event.visitId,
            rating: event.rating,
          );
          _rated.add(event.visitId);
          final current = _previous;
          if (current != null) {
            emit(current.copyWith(ratedVisitIds: {..._rated}));
          }
        },
        // Nothing on the visit changes server-side that the list would show.
        reloadAfter: false,
      );

  /// Asks, for every completed visit, whether a report exists.
  Future<Set<String>> _reviewedAmong(List<Visit> visits) async {
    final completed =
        visits.where((visit) => visit.status == VisitStatus.completed);
    if (completed.isEmpty) return const {};

    final found = await Future.wait(
      completed.map((visit) async {
        try {
          return await _reviews.fetch(visit.id) == null ? null : visit.id;
        } catch (_) {
          // Not knowing is not the same as knowing there is none: the button
          // stays, and the 409 path catches the rest.
          return null;
        }
      }),
    );
    return found.nonNulls.toSet();
  }

  MyVisitsReady _ready(
    List<Visit> visits, {
    bool isOffline = false,
    Set<String>? reviewed,
  }) {
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
      // Offline there is nothing to ask, so what was known stays known.
      reviewedVisitIds: reviewed ?? _previous?.reviewedVisitIds ?? const {},
      // Kept across a reload: the endpoint takes a rating once, and nothing in
      // the response says one was given.
      ratedVisitIds: {..._rated},
    );
  }

  MyVisitsReady? get _previous =>
      state is MyVisitsReady ? state as MyVisitsReady : null;

  static DateTime _dayStart(DateTime day) =>
      DateTime(day.year, day.month, day.day);

  static DateTime _at(Visit visit) =>
      visit.scheduledAt ?? DateTime.fromMillisecondsSinceEpoch(0);
}
