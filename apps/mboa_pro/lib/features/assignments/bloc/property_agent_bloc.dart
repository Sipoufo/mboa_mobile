import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/assignment_repository.dart';
import '../models/assignment.dart';

part 'property_agent_event.dart';
part 'property_agent_state.dart';

/// One property's agent situation (CDC M11): who is on it, who applied, and who
/// could be offered it.
///
/// Route-scoped — the assign screen and the Agent section on a property's detail
/// each own an instance for their own target.
class PropertyAgentBloc extends Bloc<PropertyAgentEvent, PropertyAgentState> {
  PropertyAgentBloc({required AssignmentRepository repository})
      : _repository = repository,
        super(const PropertyAgentInitial()) {
    on<PropertyAgentLoadRequested>(_onLoad);
    on<AgentOffered>(_onOffer);
    on<AssignmentWithdrawn>(_onWithdraw);
    on<ApplicationAccepted>(_onAccept);
    on<ApplicationDeclined>(_onDecline);
  }

  final AssignmentRepository _repository;

  Future<void> _onLoad(
    PropertyAgentLoadRequested event,
    Emitter<PropertyAgentState> emit,
  ) async {
    emit(const PropertyAgentLoadInProgress());
    await _reload(event.target, emit);
  }

  /// The three reads are independent, so they go out together — a picker that
  /// waits on three sequential round trips feels broken on a slow connection.
  Future<void> _reload(
    AssignmentTarget target,
    Emitter<PropertyAgentState> emit, {
    ResidenceOfferOutcome? outcome,
  }) async {
    try {
      final results = await Future.wait([
        _repository.forTarget(target),
        _repository.applications(target),
        _repository.candidates(target),
      ]);

      emit(
        PropertyAgentReady(
          target: target,
          assignments: results[0] as List<Assignment>,
          applications: results[1] as List<AgentApplication>,
          candidates: results[2] as List<AgentCandidateView>,
          lastOutcome: outcome,
        ),
      );
    } catch (_) {
      emit(const PropertyAgentFailure());
    }
  }

  Future<void> _onOffer(
    AgentOffered event,
    Emitter<PropertyAgentState> emit,
  ) async {
    final current = state;
    if (current is! PropertyAgentReady) return;

    emit(current.copyWith(mutatingId: event.agentAccountId));
    try {
      final outcome =
          await _repository.offer(current.target, event.agentAccountId);
      // Reload rather than patch: accepting or offering changes other rows too
      // (RM-M11-07 auto-declines the rest), and the server is the authority.
      await _reload(current.target, emit, outcome: outcome);
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }

  Future<void> _onWithdraw(
    AssignmentWithdrawn event,
    Emitter<PropertyAgentState> emit,
  ) async {
    final current = state;
    if (current is! PropertyAgentReady) return;

    emit(current.copyWith(mutatingId: event.assignment.agentAccountId));
    try {
      await _repository.withdraw(current.target);
      await _reload(current.target, emit);
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }

  Future<void> _onAccept(
    ApplicationAccepted event,
    Emitter<PropertyAgentState> emit,
  ) async {
    final current = state;
    if (current is! PropertyAgentReady) return;

    emit(current.copyWith(mutatingId: event.application.agentAccountId));
    try {
      final outcome = await _repository.acceptApplication(event.application);
      await _reload(current.target, emit, outcome: outcome);
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }

  Future<void> _onDecline(
    ApplicationDeclined event,
    Emitter<PropertyAgentState> emit,
  ) async {
    final current = state;
    if (current is! PropertyAgentReady) return;

    emit(current.copyWith(mutatingId: event.application.agentAccountId));
    try {
      await _repository.declineApplication(event.application);
      await _reload(current.target, emit);
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }
}
