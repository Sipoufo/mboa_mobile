import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminModrationApi
void main() {
  final instance = ApiClient().getAdminModrationApi();

  group(AdminModrationApi, () {
    // A tenancy dispute's file: the home, the disputed piece with its proofs, and the home's record
    //
    // For a report with reason DISPUTE (target CONTRACT, DECLARATION or EVIDENCE). The disputed declaration's proofs and the disputed sending's photos come with short-lived links; the other sendings are described without. Mboa keeps the pieces and does not rule on the amount (RM-M30-07). 404 DISPUTE_NOT_FOUND for another kind of report.
    //
    //Future<DisputeDossier> getDisputeDossier(String id) async
    test('test getDisputeDossier', () async {
      // TODO
    });

    // The moderation queue, oldest first; optionally filtered by status
    //
    //Future<PageResponseSignalementResponse> listSignalements(Pageable pageable, { String status }) async
    test('test listSignalements', () async {
      // TODO
    });

    // Dismiss a report as a false positive
    //
    //Future<SignalementResponse> rejectSignalement(String id, { ReviewSignalementRequest reviewSignalementRequest }) async
    test('test rejectSignalement', () async {
      // TODO
    });

    // Restore a suspended listing (false positive — RM-M19-04)
    //
    //Future<AnnonceResponse> restoreAnnonce(String id) async
    test('test restoreAnnonce', () async {
      // TODO
    });

    // Uphold a report; the 3rd upheld one on a listing suspends it automatically
    //
    //Future<SignalementResponse> validateSignalement(String id, { ReviewSignalementRequest reviewSignalementRequest }) async
    test('test validateSignalement', () async {
      // TODO
    });

  });
}
