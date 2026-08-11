import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../annonces/data/location_capture.dart';
import '../data/agent_visit_repository.dart';
import '../models/agent_visit.dart';

part 'visit_detail_event.dart';
part 'visit_detail_state.dart';

/// One visit, and starting it (CDC M16 / RM-M16-02).
///
/// The geofence is checked here for the *prompt* only. The coordinates go to
/// the server either way and it decides; the app asking first is what turns a
/// silent rejection into a question the agent can answer.
class VisitDetailBloc extends Bloc<VisitDetailEvent, VisitDetailState> {
  VisitDetailBloc({
    required AgentVisitRepository repository,
    required LocationCapture location,
  })  : _repository = repository,
        _location = location,
        super(const VisitDetailInitial()) {
    on<VisitDetailRequested>(_onRequested);
    on<VisitStartRequested>(_onStart);
    on<VisitStartOverridden>(_onOverride);
    on<VisitOverrideDismissed>(_onDismiss);
    on<VisitCancelRequested>(_onCancel);
  }

  final AgentVisitRepository _repository;
  final LocationCapture _location;

  Future<void> _onRequested(
    VisitDetailRequested event,
    Emitter<VisitDetailState> emit,
  ) async {
    emit(const VisitDetailLoadInProgress());
    try {
      emit(VisitDetailReady(await _repository.detail(event.id)));
    } catch (_) {
      emit(const VisitDetailFailure());
    }
  }

  Future<void> _onStart(
    VisitStartRequested event,
    Emitter<VisitDetailState> emit,
  ) async {
    final current = state;
    if (current is! VisitDetailReady) return;

    emit(current.copyWith(isStarting: true));

    final LocationFix fix;
    try {
      fix = await _location.current();
    } on LocationCaptureException catch (e) {
      // RM-M16-02 needs a position; without one there is nothing to send and
      // nothing to justify, so say which permission is missing.
      emit(current.copyWith(isStarting: false, locationFailure: e.failure));
      return;
    } catch (_) {
      emit(
        current.copyWith(
          isStarting: false,
          locationFailure: LocationFailure.unavailable,
        ),
      );
      return;
    }

    final distance = VisitGeofence.distanceTo(
      current.visit,
      latitude: fix.latitude,
      longitude: fix.longitude,
    );

    if (VisitGeofence.needsOverride(distance)) {
      // Ask rather than refuse: a GPS fix can be wrong, and an agent at the
      // gate should not be stranded by it (Doc 10 asks for a justification).
      emit(
        current.copyWith(
          isStarting: false,
          pendingFix: fix,
          distanceMetres: distance,
        ),
      );
      return;
    }

    await _send(current, emit, fix: fix, distance: distance);
  }

  Future<void> _onOverride(
    VisitStartOverridden event,
    Emitter<VisitDetailState> emit,
  ) async {
    final current = state;
    if (current is! VisitDetailReady) return;
    final fix = current.pendingFix;
    if (fix == null) return;

    emit(current.copyWith(isStarting: true, clearPendingFix: true));
    await _send(
      current,
      emit,
      fix: fix,
      distance: current.distanceMetres,
      reason: event.reason,
    );
  }

  void _onDismiss(
    VisitOverrideDismissed event,
    Emitter<VisitDetailState> emit,
  ) {
    final current = state;
    if (current is! VisitDetailReady) return;
    emit(current.copyWith(clearPendingFix: true));
  }

  /// RM-M16-04 — the server owns the one-hour cutoff, so a refusal comes back
  /// as a failure rather than being pre-empted here.
  Future<void> _onCancel(
    VisitCancelRequested event,
    Emitter<VisitDetailState> emit,
  ) async {
    final current = state;
    if (current is! VisitDetailReady) return;

    emit(current.copyWith(isCancelling: true));
    try {
      await _repository.cancel(current.visit.id);
      emit(const VisitWasCancelled());
    } catch (_) {
      emit(current.copyWith(isCancelling: false, lastActionFailed: true));
    }
  }

  Future<void> _send(
    VisitDetailReady current,
    Emitter<VisitDetailState> emit, {
    required LocationFix fix,
    double? distance,
    String? reason,
  }) async {
    try {
      await _repository.start(
        current.visit.id,
        latitude: fix.latitude,
        longitude: fix.longitude,
        overrideReason: reason,
      );
      // Re-read: `canStart`, `startedAt` and the report lock are all the
      // server's to report.
      emit(VisitDetailReady(await _repository.detail(current.visit.id)));
    } catch (_) {
      emit(current.copyWith(isStarting: false, lastActionFailed: true));
    }
  }
}
