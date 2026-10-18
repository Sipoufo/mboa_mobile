import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for FinanceInvoicesOwnerApi
void main() {
  final instance = ApiClient().getFinanceInvoicesOwnerApi();

  group(FinanceInvoicesOwnerApi, () {
    // Cancel an open invoice
    //
    //Future<InvoiceResponse> cancelInvoice(String id) async
    test('test cancelInvoice', () async {
      // TODO
    });

    // Bill the tenant of a running Mboa contract — water, electricity or another charge (RM-M24-02)
    //
    //Future<InvoiceResponse> createInvoice(CreateInvoiceRequest createInvoiceRequest) async
    test('test createInvoice', () async {
      // TODO
    });

    // One of my invoices
    //
    //Future<InvoiceResponse> getOwnerInvoice(String id) async
    test('test getOwnerInvoice', () async {
      // TODO
    });

    // My invoices, latest due first, optionally on one contract
    //
    //Future<PageResponseInvoiceResponse> listOwnerInvoices(Pageable pageable, { String contractId }) async
    test('test listOwnerInvoices', () async {
      // TODO
    });

    // Declare an invoice paid — unchecked by Mboa, in force at once (RM-M24-05)
    //
    //Future<InvoiceResponse> markInvoicePaid(String id, { MarkInvoicePaidRequest markInvoicePaidRequest }) async
    test('test markInvoicePaid', () async {
      // TODO
    });

    // Withdraw a payment you declared by mistake
    //
    //Future<InvoiceResponse> reopenInvoice(String id) async
    test('test reopenInvoice', () async {
      // TODO
    });

    // Correct an open invoice; a new due date re-arms the reminders
    //
    //Future<InvoiceResponse> updateInvoice(String id, UpdateInvoiceRequest updateInvoiceRequest) async
    test('test updateInvoice', () async {
      // TODO
    });

  });
}
