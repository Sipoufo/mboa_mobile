import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for SignalementsApi
void main() {
  final instance = ApiClient().getSignalementsApi();

  group(SignalementsApi, () {
    // Report a listing, a message or a review; the reason must fit the target
    //
    // ANNONCE: FRAUDULENT_LISTING, ABNORMAL_PRICE, INAPPROPRIATE_CONTENT. MESSAGE and REVIEW: INAPPROPRIATE_CONTENT, HARASSMENT. Anything else is 400 REASON_NOT_APPLICABLE. One upheld report removes a review; a listing takes three. The reporter is only told the report was received — the outcome is never disclosed to them (RM-M23-05).
    //
    //Future<SignalementResponse> createSignalement(CreateSignalementRequest createSignalementRequest) async
    test('test createSignalement', () async {
      // TODO
    });

  });
}
