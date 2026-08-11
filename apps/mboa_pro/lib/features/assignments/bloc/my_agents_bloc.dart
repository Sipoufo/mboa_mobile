import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/assignment_repository.dart';
import '../models/assignment.dart';

part 'my_agents_event.dart';
part 'my_agents_state.dart';

/// "Mes agents" — the prestataire's agents across the whole portfolio.
///
/// The API returns one row per *assignment*; this screen lists **people**, so
/// the rows are grouped by agent. That is the same reasoning RM-M10bis-09 gives
/// for grouping applications: a prestataire picks an agent, they do not work
/// through fifteen identical lines.
class MyAgentsBloc extends Bloc<MyAgentsEvent, MyAgentsState> {
  MyAgentsBloc({required AssignmentRepository repository})
      : _repository = repository,
        super(const MyAgentsInitial()) {
    on<MyAgentsLoadRequested>(_onLoad);
    on<MyAgentsRefreshRequested>(_onRefresh);
  }

  final AssignmentRepository _repository;

  Future<void> _onLoad(
    MyAgentsLoadRequested event,
    Emitter<MyAgentsState> emit,
  ) async {
    emit(const MyAgentsLoadInProgress());
    await _load(emit);
  }

  Future<void> _onRefresh(
    MyAgentsRefreshRequested event,
    Emitter<MyAgentsState> emit,
  ) =>
      _load(emit);

  Future<void> _load(Emitter<MyAgentsState> emit) async {
    try {
      emit(MyAgentsReady(rows: _group(await _repository.myAssignments())));
    } catch (_) {
      if (state is! MyAgentsReady) emit(const MyAgentsFailure());
    }
  }

  /// One row per agent, newest first, closed assignments dropped — a revoked or
  /// declined assignment is history, not an agent the prestataire has.
  static List<AgentRow> _group(List<Assignment> assignments) {
    final byAgent = <String, List<Assignment>>{};
    for (final assignment in assignments) {
      if (assignment.status.isClosed) continue;
      final id = assignment.agentAccountId;
      if (id == null || id.isEmpty) continue;
      (byAgent[id] ??= []).add(assignment);
    }

    final rows = byAgent.entries
        .map(
          (entry) => AgentRow(
            agentAccountId: entry.key,
            agentName: entry.value.first.agentName,
            assignments: entry.value,
          ),
        )
        .toList();

    rows.sort((a, b) => (a.agentName ?? '').compareTo(b.agentName ?? ''));
    return rows;
  }
}
