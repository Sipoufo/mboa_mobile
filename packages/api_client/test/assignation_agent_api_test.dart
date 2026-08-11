import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AssignationAgentApi
void main() {
  final instance = ApiClient().getAssignationAgentApi();

  group(AssignationAgentApi, () {
    // Accept an application; the other applicants are declined automatically
    //
    //Future<AssignmentResponse> acceptAnnonceApplication(String annonceId, String applicationId) async
    test('test acceptAnnonceApplication', () async {
      // TODO
    });

    // Offer the listing to an agent (RM-M11-04)
    //
    //Future<AssignmentResponse> assignAgent(String annonceId, AssignAgentRequest assignAgentRequest) async
    test('test assignAgent', () async {
      // TODO
    });

    // Turn an application down
    //
    //Future<AssignmentResponse> declineAnnonceApplication(String annonceId, String applicationId) async
    test('test declineAnnonceApplication', () async {
      // TODO
    });

    // Agents who cover this listing's area; query matches a name or phone (RM-M11-03)
    //
    //Future<BuiltList<AgentCandidate>> listAgentCandidates(String annonceId, { String query }) async
    test('test listAgentCandidates', () async {
      // TODO
    });

    // Agents who applied to this listing, oldest first
    //
    //Future<BuiltList<AssignmentResponse>> listAnnonceApplications(String annonceId) async
    test('test listAnnonceApplications', () async {
      // TODO
    });

    // Every assignment across the prestataire's listings, newest first
    //
    //Future<PageResponseAssignmentItem> listMyAnnonceAssignments(Pageable pageable, { BuiltList<String> status }) async
    test('test listMyAnnonceAssignments', () async {
      // TODO
    });

    // Remove the listing's agent; visits already planned are cancelled (RM-M11-06)
    //
    //Future withdrawAgentAssignment(String annonceId) async
    test('test withdrawAgentAssignment', () async {
      // TODO
    });

  });
}
