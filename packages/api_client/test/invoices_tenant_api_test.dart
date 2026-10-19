import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for InvoicesTenantApi
void main() {
  final instance = ApiClient().getInvoicesTenantApi();

  group(InvoicesTenantApi, () {
    // One of my invoices
    //
    //Future<InvoiceResponse> getMyInvoice(String id) async
    test('test getMyInvoice', () async {
      // TODO
    });

    // My invoices, current and past, latest due first (RM-M24-06)
    //
    //Future<PageResponseInvoiceResponse> listMyInvoices(Pageable pageable) async
    test('test listMyInvoices', () async {
      // TODO
    });

    // Pay an invoice in the app (RM-M24-04) — 409 INVOICE_IN_APP_DISABLED while that is shut, as at the MVP
    //
    //Future<PaymentInitiatedResponse> payInvoice(String id, PayInvoiceRequest payInvoiceRequest, { String idempotencyKey }) async
    test('test payInvoice', () async {
      // TODO
    });

  });
}
