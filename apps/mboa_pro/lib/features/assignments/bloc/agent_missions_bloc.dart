import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/agent_mission_repository.dart';
import '../models/assignment.dart';

part 'agent_missions_event.dart';
part 'agent_missions_state.dart';

/// The agent's Missions tab (CDC M11, agent side).
///
/// One bloc for the three segments because they are one screen and one refresh,
/// and because every action moves work between them — accepting an offer turns
/// a proposition into a mission, applying turns an opportunity into a pending
/// application. Splitting them would mean three blocs refreshing each other.
class AgentMissionsBloc extends Bloc<AgentMissionsEvent, AgentMissionsState> {
  AgentMissionsBloc({required AgentMissionRepository repository})
      : _repository = repository,
        super(const MissionsInitial()) {
    on<MissionsLoadRequested>(_onLoad);
    on<MissionsRefreshRequested>(_onRefresh);
    on<MissionsFilterChanged>(_onFilter);
    on<OpportunityApplied>(_onApply);
    on<MissionAccepted>(_onAccept);
    on<MissionDeclined>(_onDecline);
    on<MissionResigned>(_onResign);
    on<ApplicationWithdrawn>(_onWithdraw);
  }

  final AgentMissionRepository _repository;

  Future<void> _onLoad(
    MissionsLoadRequested event,
    Emitter<AgentMissionsState> emit,
  ) async {
    emit(const MissionsLoadInProgress());
    await _load(emit);
  }

  Future<void> _onRefresh(
    MissionsRefreshRequested event,
    Emitter<AgentMissionsState> emit,
  ) =>
      _load(emit);

  Future<void> _load(
    Emitter<AgentMissionsState> emit, {
    MissionFilter? filter,
  }) async {
    final current = state;
    try {
      final results = await Future.wait([
        _repository.assignments(),
        _repository.opportunities(),
        _repository.applications(),
      ]);

      emit(
        MissionsReady(
          assignments: results[0] as List<Assignment>,
          opportunities: results[1] as List<Opportunity>,
          applications: results[2] as List<Assignment>,
          filter: filter ??
              (current is MissionsReady ? current.filter : MissionFilter.offers),
        ),
      );
    } catch (_) {
      // A failed refresh keeps what is on screen; only a cold load fails.
      if (current is! MissionsReady) emit(const MissionsFailure());
    }
  }

  void _onFilter(
    MissionsFilterChanged event,
    Emitter<AgentMissionsState> emit,
  ) {
    final current = state;
    if (current is! MissionsReady) return;
    emit(current.copyWith(filter: event.filter));
  }

  Future<void> _act(
    Emitter<AgentMissionsState> emit,
    String mutatingId,
    Future<void> Function() action,
  ) async {
    final current = state;
    if (current is! MissionsReady) return;

    emit(current.copyWith(mutatingId: mutatingId));
    try {
      await action();
      // Reload rather than patch: the server moves work between the three
      // lists, and an accepted residence offer may not have covered every unit.
      await _load(emit);
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }

  Future<void> _onApply(
    OpportunityApplied event,
    Emitter<AgentMissionsState> emit,
  ) =>
      _act(
        emit,
        event.opportunity.target.id,
        () => _repository.apply(event.opportunity.target),
      );

  Future<void> _onAccept(
    MissionAccepted event,
    Emitter<AgentMissionsState> emit,
  ) =>
      _act(emit, event.assignment.id, () => _repository.accept(event.assignment));

  Future<void> _onDecline(
    MissionDeclined event,
    Emitter<AgentMissionsState> emit,
  ) =>
      _act(
        emit,
        event.assignment.id,
        () => _repository.decline(event.assignment),
      );

  Future<void> _onResign(
    MissionResigned event,
    Emitter<AgentMissionsState> emit,
  ) =>
      _act(emit, event.assignment.id, () => _repository.resign(event.assignment));

  Future<void> _onWithdraw(
    ApplicationWithdrawn event,
    Emitter<AgentMissionsState> emit,
  ) =>
      _act(
        emit,
        event.assignment.id,
        () => _repository.withdrawApplication(event.assignment),
      );
}
