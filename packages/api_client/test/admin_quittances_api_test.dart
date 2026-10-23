import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminQuittancesApi
void main() {
  final instance = ApiClient().getAdminQuittancesApi();

  group(AdminQuittancesApi, () {
    // Receipts still without their PDF after the three attempts, oldest first
    //
    //Future<PageResponseFailedReceipt> adminListFailedReceipts(Pageable pageable) async
    test('test adminListFailedReceipts', () async {
      // TODO
    });

    // Try again to produce a receipt's PDF (CE-M08-02)
    //
    // Gives the receipt three attempts again and makes the first one now. `ready: false` means it failed again; the sweep makes the next two. 409 PDF_ALREADY_GENERATED if it has its PDF.
    //
    //Future<ReceiptRegeneration> adminRegenerateReceiptPdf(String id) async
    test('test adminRegenerateReceiptPdf', () async {
      // TODO
    });

  });
}
