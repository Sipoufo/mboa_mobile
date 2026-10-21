import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for QuittancesApi
void main() {
  final instance = ApiClient().getQuittancesApi();

  group(QuittancesApi, () {
    // A short-lived link to a receipt's PDF — 409 RECEIPT_NOT_READY while it is prepared (CA-M30-02)
    //
    //Future<ReceiptPdfResponse> getReceiptPdf(String receiptId) async
    test('test getReceiptPdf', () async {
      // TODO
    });

    // Public: check a receipt with its number and code — amount and period, no names (RM-M30-05)
    //
    //Future<ReceiptVerification> verifyReceipt(String receiptId, String code) async
    test('test verifyReceipt', () async {
      // TODO
    });

  });
}
