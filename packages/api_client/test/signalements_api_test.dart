import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for SignalementsApi
void main() {
  final instance = ApiClient().getSignalementsApi();

  group(SignalementsApi, () {
    // Report a listing, a message or a review, or dispute a home; the reason must fit the target
    //
    // ANNONCE: FRAUDULENT_LISTING, ABNORMAL_PRICE, INAPPROPRIATE_CONTENT, ASKED_FOR_MONEY. MESSAGE: INAPPROPRIATE_CONTENT, HARASSMENT, ASKED_FOR_MONEY. REVIEW: INAPPROPRIATE_CONTENT, HARASSMENT. CONTRACT, DECLARATION, EVIDENCE (a sending of photo proofs): DISPUTE only, by a party to the home (404 otherwise) — escalated to the admin, against nobody, and while pending it keeps the tenant's proofs and requests past their account (RM-M30-07, RM-M31-07). Anything else is 400 REASON_NOT_APPLICABLE. One upheld report removes a review; a listing takes three. The reporter is only told the report was received — the outcome is never disclosed to them (RM-M23-05).
    //
    //Future<SignalementResponse> createSignalement(CreateSignalementRequest createSignalementRequest) async
    test('test createSignalement', () async {
      // TODO
    });

  });
}
