import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminModrationApi
void main() {
  final instance = ApiClient().getAdminModrationApi();

  group(AdminModrationApi, () {
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
