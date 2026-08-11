import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/agent_visit_repository.dart';
import '../models/agent_visit.dart';

part 'agent_visits_event.dart';
part 'agent_visits_state.dart';

/// The agent's visits list (CDC M16), split into today / upcoming / past.
class AgentVisitsBloc extends Bloc<AgentVisitsEvent, AgentVisitsState> {
  AgentVisitsBloc({required AgentVisitRepository repository})
      : _repository = repository,
        super(const VisitsInitial()) {
    on<VisitsLoadRequested>(_onLoad);
    on<VisitsRefreshRequested>(_onRefresh);
    on<VisitsFilterChanged>(_onFilter);
    on<VisitCancelled>(_onCancel);
  }

  final AgentVisitRepository _repository;

  Future<void> _onLoad(
    VisitsLoadRequested event,
    Emitter<AgentVisitsState> emit,
  ) async {
    emit(const VisitsLoadInProgress());
    await _load(emit);
  }

  Future<void> _onRefresh(
    VisitsRefreshRequested event,
    Emitter<AgentVisitsState> emit,
  ) =>
      _load(emit);

  Future<void> _load(Emitter<AgentVisitsState> emit) async {
    final current = state;
    try {
      emit(
        VisitsReady(
          visits: await _repository.list(),
          filter: current is VisitsReady ? current.filter : VisitFilter.today,
        ),
      );
    } catch (_) {
      if (current is! VisitsReady) emit(const VisitsFailure());
    }
  }

  void _onFilter(VisitsFilterChanged event, Emitter<AgentVisitsState> emit) {
    final current = state;
    if (current is! VisitsReady) return;
    emit(current.copyWith(filter: event.filter));
  }

  Future<void> _onCancel(
    VisitCancelled event,
    Emitter<AgentVisitsState> emit,
  ) async {
    final current = state;
    if (current is! VisitsReady) return;

    emit(current.copyWith(mutatingId: event.visit.id));
    try {
      await _repository.cancel(event.visit.id);
      // Reload: the server owns the one-hour cutoff (RM-M16-04), so it decides
      // whether the cancellation actually happened.
      await _load(emit);
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }
}
