import 'package:mboa_core/mboa_core.dart';

import '../models/assignment.dart';

/// The prestataire's side of M11: who is assigned to a property, who applied,
/// and who could be.
///
/// Every operation forks on [AssignmentTarget] because listings and residences
/// sit on different endpoints with different payloads — a residence offer
/// returns what it *did* (offered, skipped) rather than a single assignment.
/// Keeping the fork here means the blocs and screens never branch on it.
class AssignmentRepository {
  AssignmentRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  static const int _pageSize = 100;

  AssignationAgentApi get _annonces => _dioClient.api.getAssignationAgentApi();

  AssignationAgentRsidenceApi get _residences =>
      _dioClient.api.getAssignationAgentRsidenceApi();

  /// Agents the server considers eligible — active, and covering the property's
  /// zone (RM-M11-08). Sorted by surname for the alphabetical picker.
  Future<List<AgentCandidateView>> candidates(AssignmentTarget target) async {
    final response = switch (target) {
      AnnonceTarget() => await _annonces.listAgentCandidates(annonceId: target.id),
      ResidenceTarget() =>
        await _residences.listResidenceAgentCandidates(residenceId: target.id),
    };

    final candidates = (response.data ?? const <AgentCandidate>[])
        .map(AgentCandidateView.fromResponse)
        .toList()
      ..sort((a, b) => a.sortKey.compareTo(b.sortKey));
    return candidates;
  }

  /// Agents waiting on an answer (RM-M11-07).
  Future<List<AgentApplication>> applications(AssignmentTarget target) async {
    switch (target) {
      case AnnonceTarget():
        final response =
            await _annonces.listAnnonceApplications(annonceId: target.id);
        return (response.data ?? const <AssignmentResponse>[])
            .map(AgentApplication.fromAnnonce)
            .toList();
      case ResidenceTarget():
        final response =
            await _residences.listResidenceApplications(residenceId: target.id);
        return (response.data ?? const <ResidenceApplicationSummary>[])
            .map(AgentApplication.fromResidence)
            .toList();
    }
  }

  /// The assignments already on this property, in any state.
  Future<List<Assignment>> forTarget(AssignmentTarget target) async {
    switch (target) {
      case AnnonceTarget():
        // A listing has no dedicated read; the portfolio list carries it.
        final all = await myAssignments();
        return all.where((a) => a.target == target).toList();
      case ResidenceTarget():
        final response =
            await _residences.listResidenceAssignments(residenceId: target.id);
        return (response.data ?? const <AssignmentResponse>[])
            .map(Assignment.fromResponse)
            .toList();
    }
  }

  /// Offers the property to an agent. Returns what the offer did — for a
  /// residence that is a count plus the units it skipped (RM-M10bis-06).
  Future<ResidenceOfferOutcome> offer(
    AssignmentTarget target,
    String agentAccountId,
  ) async {
    final request =
        AssignAgentRequest((b) => b..agentAccountId = agentAccountId);

    switch (target) {
      case AnnonceTarget():
        await _annonces.assignAgent(
          annonceId: target.id,
          assignAgentRequest: request,
        );
        // One listing, one unit offered, nothing to skip.
        return const ResidenceOfferOutcome(offered: 1);
      case ResidenceTarget():
        final response = await _residences.assignAgentToResidence(
          residenceId: target.id,
          assignAgentRequest: request,
        );
        final data = response.data;
        return data == null
            ? const ResidenceOfferOutcome()
            : ResidenceOfferOutcome.fromResponse(data);
    }
  }

  /// RM-M11-06 — removes the property's agent. Visits already planned are
  /// cancelled server-side, so this is not a silent operation for the tenant
  /// either.
  ///
  /// **Names no agent**, because the endpoint takes none. With a pool of
  /// several (RM-M11-01) that is ambiguous, so `PropertyAgentReady.canWithdraw`
  /// keeps the action off the screen until there is only one — see
  /// `docs/backend-requests.md` §12.
  Future<void> withdraw(AssignmentTarget target) async {
    switch (target) {
      case AnnonceTarget():
        await _annonces.withdrawAgentAssignment(annonceId: target.id);
      case ResidenceTarget():
        await _residences.withdrawResidenceAgentAssignment(
          residenceId: target.id,
        );
    }
  }

  /// Accepting an application adds that agent to the property's pool.
  ///
  /// **It no longer refuses the others** (RM-M11-07, revised 2026-08-13): the
  /// prestataire may accept several, and the client picks their visitor at
  /// booking time. The screen reloads because the server is the authority on
  /// what the acceptance did.
  Future<ResidenceOfferOutcome> acceptApplication(
    AgentApplication application,
  ) async {
    switch (application.target) {
      case AnnonceTarget(:final id):
        await _annonces.acceptAnnonceApplication(
          annonceId: id,
          applicationId: application.id,
        );
        return const ResidenceOfferOutcome(offered: 1);
      case ResidenceTarget(:final id):
        final response = await _residences.acceptResidenceApplication(
          residenceId: id,
          agentAccountId: application.agentAccountId,
        );
        final data = response.data;
        return data == null
            ? const ResidenceOfferOutcome()
            : ResidenceOfferOutcome.fromResponse(data);
    }
  }

  Future<void> declineApplication(AgentApplication application) async {
    switch (application.target) {
      case AnnonceTarget(:final id):
        await _annonces.declineAnnonceApplication(
          annonceId: id,
          applicationId: application.id,
        );
      case ResidenceTarget(:final id):
        await _residences.declineResidenceApplication(
          residenceId: id,
          agentAccountId: application.agentAccountId,
        );
    }
  }

  /// What a prestataire may see about an agent — public, no contact details.
  ///
  /// Resolves for a suspended or pending agent too: they are named on visits
  /// they carried out, and 404-ing would dead-link that history. Only a deleted
  /// account is withheld.
  Future<AgentPublicProfileView> publicProfile(String accountId) async {
    final response =
        await _dioClient.api.getSearchApi().getAgentPublicProfile(id: accountId);
    final data = response.data;
    if (data == null) throw StateError('No agent profile for $accountId');
    return AgentPublicProfileView.fromResponse(data);
  }

  /// Every assignment across the portfolio, listings and residences alike.
  ///
  /// `AssignmentItem` is a discriminated union — one entry per *lot*, so a
  /// residence of 200 units is one row, not 200 (RM-M10bis-11).
  Future<List<Assignment>> myAssignments() async {
    final response = await _annonces.listMyAnnonceAssignments(
      pageable: Pageable((b) => b
        ..page = 0
        ..size = _pageSize),
    );

    return [
      for (final item in response.data?.content ?? const <AssignmentItem>[])
        if (item.assignment case final assignment?)
          Assignment.fromResponse(assignment)
        else if (item.residence case final residence?)
          Assignment.fromResidenceSummary(residence),
    ];
  }
}
