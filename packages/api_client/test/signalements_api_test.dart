import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for SignalementsApi
void main() {
  final instance = ApiClient().getSignalementsApi();

  group(SignalementsApi, () {
    // Report a listing or a message
    //
    // The reporter is only told the report was received — the outcome is never disclosed to them (RM-M23-05).
    //
    //Future<SignalementResponse> createSignalement(CreateSignalementRequest createSignalementRequest) async
    test('test createSignalement', () async {
      // TODO
    });

  });
}
