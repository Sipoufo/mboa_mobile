import 'package:mboa_core/mboa_core.dart';

import '../models/assignment.dart';

/// The agent's side of M11: work offered to them, work they asked for, and the
/// properties they could ask for.
///
/// The listing endpoints key on the **assignment id**, the residence ones on
/// the **residence id** — so the actions take an [Assignment] rather than a
/// target, and pick the right key themselves.
class AgentMissionRepository {
  AgentMissionRepository({required DioClient dioClient})
      : _dioClient = dioClient;

  final DioClient _dioClient;

  static const int _pageSize = 100;

  AgentAssignationsApi get _assignments =>
      _dioClient.api.getAgentAssignationsApi();

  AgentCandidaturesApi get _applications =>
      _dioClient.api.getAgentCandidaturesApi();

  /// Offers and accepted work alike — one entry per lot (RM-M10bis-11).
  Future<List<Assignment>> assignments() async {
    final response = await _assignments.listMyAgentAssignments(
      pageable: Pageable((b) => b
        ..page = 0
        ..size = _pageSize),
    );
    return _flatten(response.data?.content);
  }

  /// What this agent has applied for and not yet heard back on.
  Future<List<Assignment>> applications() async {
    final response = await _applications.listMyAgentApplications(
      pageable: Pageable((b) => b
        ..page = 0
        ..size = _pageSize),
    );
    return _flatten(response.data?.content);
  }

  /// Published properties in the agent's zones with no agent yet — the server
  /// applies RM-M11-08, so what comes back is what may be applied for.
  Future<List<Opportunity>> opportunities() async {
    final response = await _assignments.listAgentOpportunities();
    return (response.data ?? const <OpportunityItem>[])
        .map(Opportunity.fromItem)
        .nonNulls
        .toList();
  }

  Future<void> apply(AssignmentTarget target) async {
    switch (target) {
      case AnnonceTarget():
        await _assignments.applyToAnnonce(annonceId: target.id);
      case ResidenceTarget():
        await _assignments.applyToResidence(residenceId: target.id);
    }
  }

  Future<void> accept(Assignment assignment) async {
    switch (assignment.target) {
      case AnnonceTarget():
        await _assignments.acceptAgentAssignment(id: assignment.id);
      case ResidenceTarget(:final id):
        await _assignments.acceptResidenceAssignment(residenceId: id);
    }
  }

  Future<void> decline(Assignment assignment) async {
    switch (assignment.target) {
      case AnnonceTarget():
        await _assignments.declineAgentAssignment(id: assignment.id);
      case ResidenceTarget(:final id):
        await _assignments.declineResidenceAssignment(residenceId: id);
    }
  }

  /// RM-M11-06 — the agent steps down. Visits already planned are cancelled,
  /// so this is not reversible for the tenants who booked them.
  Future<void> resign(Assignment assignment) async {
    switch (assignment.target) {
      case AnnonceTarget():
        await _assignments.resignAgentAssignment(id: assignment.id);
      case ResidenceTarget(:final id):
        await _assignments.resignResidenceAssignment(residenceId: id);
    }
  }

  /// Takes back an application the prestataire has not answered.
  Future<void> withdrawApplication(Assignment assignment) async {
    switch (assignment.target) {
      case AnnonceTarget():
        await _applications.withdrawMyAgentApplication(id: assignment.id);
      case ResidenceTarget(:final id):
        await _applications.withdrawResidenceApplication(residenceId: id);
    }
  }

  static List<Assignment> _flatten(Iterable<AssignmentItem>? items) => [
        for (final item in items ?? const <AssignmentItem>[])
          if (item.assignment case final assignment?)
            Assignment.fromResponse(assignment)
          else if (item.residence case final residence?)
            Assignment.fromResidenceSummary(residence),
      ];
}
