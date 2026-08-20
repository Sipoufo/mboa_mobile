import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../annonces/data/location_capture.dart';
import '../data/prestataire_visit_repository.dart';

part 'prestataire_visits_event.dart';
part 'prestataire_visits_state.dart';

/// What a prestataire *does* with his own visits (RM-M15-06 / RM-M07-05).
///
/// The list itself belongs to `PrestataireAgendaBloc`; this one only acts, and
/// says which visit is mid-action. Splitting them is what lets the agenda be
/// shared with the agent, whose rules for the same three buttons are not the
/// same — he cancels, he never confirms a request.
class PrestataireVisitsBloc
    extends Bloc<PrestataireVisitsEvent, PrestataireVisitsState> {
  PrestataireVisitsBloc({
    required PrestataireVisitRepository repository,
    required LocationCapture location,
  })  : _repository = repository,
        _location = location,
        super(const PrestataireVisitsIdle()) {
    on<VisitRequestConfirmed>(_onConfirm);
    on<VisitRequestDeclined>(_onDecline);
    on<OwnerPresenceConfirmed>(_onPresence);
  }

  final PrestataireVisitRepository _repository;
  final LocationCapture _location;

  Future<void> _onConfirm(
    VisitRequestConfirmed event,
    Emitter<PrestataireVisitsState> emit,
  ) =>
      _run(event.id, emit, () => _repository.confirm(event.id));

  Future<void> _onDecline(
    VisitRequestDeclined event,
    Emitter<PrestataireVisitsState> emit,
  ) =>
      _run(event.id, emit, () => _repository.decline(event.id));

  /// RM-M07-05 — his half of the mutual confirmation.
  ///
  /// Needs a position because the endpoint does; without one there is nothing
  /// to send, so the failure names the missing permission rather than reading
  /// as a refusal.
  Future<void> _onPresence(
    OwnerPresenceConfirmed event,
    Emitter<PrestataireVisitsState> emit,
  ) async {
    emit(PrestataireVisitsBusy(event.id));

    final LocationFix fix;
    try {
      fix = await _location.current();
    } on LocationCaptureException catch (e) {
      emit(PrestataireVisitsLocationFailed(e.failure));
      return;
    } catch (_) {
      emit(const PrestataireVisitsLocationFailed(LocationFailure.unavailable));
      return;
    }

    try {
      await _repository.confirmPresence(
        event.id,
        latitude: fix.latitude,
        longitude: fix.longitude,
      );
      emit(const PrestataireVisitsDone());
    } catch (_) {
      emit(const PrestataireVisitsFailed());
    }
  }

  Future<void> _run(
    String id,
    Emitter<PrestataireVisitsState> emit,
    Future<void> Function() action,
  ) async {
    emit(PrestataireVisitsBusy(id));
    try {
      await action();
      // Done, and nothing patched locally: the screen asks the agenda to
      // re-read, because the server owns what the answer did to the visit.
      emit(const PrestataireVisitsDone());
    } catch (_) {
      emit(const PrestataireVisitsFailed());
    }
  }
}
