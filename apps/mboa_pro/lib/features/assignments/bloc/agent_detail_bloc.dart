import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/assignment_repository.dart';
import '../models/assignment.dart';

part 'agent_detail_event.dart';
part 'agent_detail_state.dart';

/// One agent, as a prestataire sees them (CDC M11).
///
/// Route-scoped. Holds only the *public profile* — who they are, how much work
/// they have carried out, where they cover. What they hold **for this
/// prestataire** comes from `MyAgentsBloc`, which the hub already loaded; there
/// is no endpoint for "this agent's assignments with me", and deriving it from
/// a list already in memory beats inventing one.
class AgentDetailBloc extends Bloc<AgentDetailEvent, AgentDetailState> {
  AgentDetailBloc({required AssignmentRepository repository})
      : _repository = repository,
        super(const AgentDetailInitial()) {
    on<AgentDetailRequested>(_onRequested);
  }

  final AssignmentRepository _repository;

  Future<void> _onRequested(
    AgentDetailRequested event,
    Emitter<AgentDetailState> emit,
  ) async {
    emit(const AgentDetailLoadInProgress());
    try {
      emit(AgentDetailReady(await _repository.publicProfile(event.accountId)));
    } catch (_) {
      // The properties still render from MyAgentsBloc, so a failure here costs
      // the header rather than the screen.
      emit(const AgentDetailFailure());
    }
  }
}
