import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AgentAssignationsApi
void main() {
  final instance = ApiClient().getAgentAssignationsApi();

  group(AgentAssignationsApi, () {
    // Accept an offer; the listing can then offer visits (RM-M05-07)
    //
    //Future<AssignmentResponse> acceptAgentAssignment(String id) async
    test('test acceptAgentAssignment', () async {
      // TODO
    });

    // Accept a whole residence batch; answering unit by unit is the same tedium in reverse
    //
    //Future<BatchResult> acceptResidenceAssignment(String residenceId) async
    test('test acceptResidenceAssignment', () async {
      // TODO
    });

    // Apply to a listing; the prestataire still decides (RM-M11-04)
    //
    //Future<AssignmentResponse> applyToAnnonce(String annonceId) async
    test('test applyToAnnonce', () async {
      // TODO
    });

    // Apply to every open unit of a residence in one act (M11)
    //
    //Future<ResidenceAssignmentResult> applyToResidence(String residenceId) async
    test('test applyToResidence', () async {
      // TODO
    });

    // Decline an offer; the prestataire is told so they can ask someone else
    //
    //Future<AssignmentResponse> declineAgentAssignment(String id) async
    test('test declineAgentAssignment', () async {
      // TODO
    });

    // Decline a whole residence batch
    //
    //Future<BatchResult> declineResidenceAssignment(String residenceId) async
    test('test declineResidenceAssignment', () async {
      // TODO
    });

    // What the agent may apply to: standalone listings and whole residences, in their zones
    //
    //Future<BuiltList<OpportunityItem>> listAgentOpportunities() async
    test('test listAgentOpportunities', () async {
      // TODO
    });

    // Everything the agent holds, newest first — offers and accepted applications alike
    //
    //Future<PageResponseAssignmentItem> listMyAgentAssignments(Pageable pageable, { BuiltList<String> status, BuiltList<String> initiatedBy }) async
    test('test listMyAgentAssignments', () async {
      // TODO
    });

    // Step down from an assignment already accepted; booked visits are cancelled
    //
    //Future<AssignmentResponse> resignAgentAssignment(String id) async
    test('test resignAgentAssignment', () async {
      // TODO
    });

    // Step down from a whole residence at once (RM-M10bis-10)
    //
    //Future<BatchResult> resignResidenceAssignment(String residenceId) async
    test('test resignResidenceAssignment', () async {
      // TODO
    });

    // Withdraw an unanswered application (superseded by DELETE /agents/me/applications/{id})
    //
    //Future withdrawAgentApplication(String id) async
    test('test withdrawAgentApplication', () async {
      // TODO
    });

  });
}
