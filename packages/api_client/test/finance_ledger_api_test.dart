import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for FinanceLedgerApi
void main() {
  final instance = ApiClient().getFinanceLedgerApi();

  group(FinanceLedgerApi, () {
    // Record an income or an expense; needs the add-on running
    //
    //Future<LedgerEntryResponse> createLedgerEntry(LedgerEntryRequest ledgerEntryRequest) async
    test('test createLedgerEntry', () async {
      // TODO
    });

    // Remove an entry and its attachment; needs the add-on running
    //
    //Future deleteLedgerEntry(String id) async
    test('test deleteLedgerEntry', () async {
      // TODO
    });

    // The same entries as CSV, for any period (RM-M25-05)
    //
    // `;`-separated with a UTF-8 BOM so Excel in French opens it as is.
    //
    //Future<String> exportLedger({ Date from, Date to, String annonceId, String residenceId, bool unassigned }) async
    test('test exportLedger', () async {
      // TODO
    });

    // A short-lived link to an entry's attachment
    //
    //Future<PresignedDownload> getLedgerAttachment(String id) async
    test('test getLedgerAttachment', () async {
      // TODO
    });

    // Totals in, out and net, and per category, over the same filters (RM-M25-03)
    //
    //Future<LedgerSummaryResponse> getLedgerSummary({ Date from, Date to, String annonceId, String residenceId, bool unassigned }) async
    test('test getLedgerSummary', () async {
      // TODO
    });

    // My ledger, newest first — filter by period and by one listing, one residence or the unassigned
    //
    //Future<PageResponseLedgerEntryResponse> listLedgerEntries(Pageable pageable, { Date from, Date to, String annonceId, String residenceId, bool unassigned }) async
    test('test listLedgerEntries', () async {
      // TODO
    });

    // Replace an entry; needs the add-on running
    //
    //Future<LedgerEntryResponse> updateLedgerEntry(String id, LedgerEntryRequest ledgerEntryRequest) async
    test('test updateLedgerEntry', () async {
      // TODO
    });

  });
}
