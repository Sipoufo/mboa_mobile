import 'package:mboa_core/mboa_core.dart';

import '../models/agent_visit.dart';
import '../models/visit_report.dart';

/// The agent's visits (CDC M16).
class AgentVisitRepository {
  AgentVisitRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  static const int _pageSize = 100;

  AgentVisitesApi get _api => _dioClient.api.getAgentVisitesApi();

  /// Every visit assigned to this agent, in any state.
  ///
  /// Unfiltered on purpose: the screen splits them into today / upcoming /
  /// past itself, and one page covers any realistic workload. Filtering
  /// server-side would mean three requests to fill three tabs.
  Future<List<AgentVisit>> list() async {
    final response = await _api.listMyAgentVisites(
      pageable: Pageable((b) => b
        ..page = 0
        ..size = _pageSize),
    );
    return (response.data?.content ?? const <VisiteResponse>[])
        .map(AgentVisit.fromResponse)
        .toList();
  }

  Future<AgentVisitDetail> detail(String id) async {
    final response = await _api.getMyAgentVisite(id: id);
    final data = response.data;
    if (data == null) throw StateError('Visit $id not found');
    return AgentVisitDetail.fromResponse(data);
  }

  /// RM-M16-02 — the coordinates go with it, and the server decides.
  ///
  /// [overrideReason] is the written justification Doc 10 asks for when the
  /// agent is beyond 500 m. It is not a way round the rule; it is the rule's
  /// own escape hatch, and it is recorded.
  Future<void> start(
    String id, {
    required double latitude,
    required double longitude,
    String? overrideReason,
  }) =>
      _api.startMyAgentVisite(
        id: id,
        startVisiteRequest: StartVisiteRequest((b) => b
          ..latitude = latitude
          ..longitude = longitude
          ..overrideReason = overrideReason),
      );

  /// RM-M16-03 — locked once filed.
  Future<void> submitReport(String id, VisitReportDraft draft) =>
      _api.submitVisiteReport(
        id: id,
        submitVisiteReportRequest: draft.toRequest(),
      );

  /// RM-M16-04 — the server enforces the one-hour cutoff.
  Future<void> cancel(String id) => _api.cancelAgentVisite(id: id);
}
