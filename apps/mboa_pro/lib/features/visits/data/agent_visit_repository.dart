import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/agent_visit.dart';

/// The agent's visits (CDC M16).
class AgentVisitRepository implements VisitsSource {
  AgentVisitRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  static const int _pageSize = 100;

  AgentVisitesApi get _api => _dioClient.api.getAgentVisitesApi();

  /// Presence lives on its own tag: the client confirms through the same pair
  /// of endpoints from the other app (RM-M07-05).
  VisitesPrsenceApi get _presenceApi => _dioClient.api.getVisitesPrsenceApi();

  /// Every visit assigned to this agent in `[from, to)`, in any state.
  ///
  /// One week per request, which is what the agenda shows. Cancelled visits
  /// come back too: a day that had one planned should not read as an empty day.
  @override
  Future<List<Visit>> range({
    required DateTime from,
    required DateTime to,
  }) async {
    final response = await _api.listMyAgentVisites(
      from: from,
      to: to,
      pageable: Pageable((b) => b
        ..page = 0
        ..size = _pageSize),
    );
    return (response.data?.content ?? const <VisiteResponse>[])
        .map(Visit.fromResponse)
        .toList();
  }

  Future<AgentVisitDetail> detail(String id) async {
    final response = await _api.getMyAgentVisite(id: id);
    final data = response.data;
    if (data == null) throw StateError('Visit $id not found');
    return AgentVisitDetail.fromResponse(data);
  }

  /// RM-M07-05 / RM-M16-02 — the agent confirms being at the property, and the
  /// coordinates go with it so the server decides.
  ///
  /// This is **half** of the start: the visit only completes once the client
  /// confirms too, from their own app. [overrideReason] is the written
  /// justification Doc 10 asks for beyond 500 m — not a way round the rule,
  /// the rule's own escape hatch, and it is recorded.
  Future<void> confirmPresence(
    String id, {
    required double latitude,
    required double longitude,
    String? overrideReason,
  }) =>
      _presenceApi.confirmVisitorPresence(
        id: id,
        startVisiteRequest: StartVisiteRequest((b) => b
          ..latitude = latitude
          ..longitude = longitude
          ..overrideReason = overrideReason),
      );

  /// RM-M16-04 — the server enforces the one-hour cutoff.
  Future<void> cancel(String id) => _api.cancelAgentVisite(id: id);
}
