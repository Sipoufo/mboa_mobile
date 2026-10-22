import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for MonLogementApi
void main() {
  final instance = ApiClient().getMonLogementApi();

  group(MonLogementApi, () {
    // Acknowledge a sending of photo proofs, with a word — never contest by deleting (RM-M30-12)
    //
    //Future<EvidenceBatchResponse> acknowledgeEvidence(String contractId, String batchId, { AcknowledgeEvidenceRequest acknowledgeEvidenceRequest }) async
    test('test acknowledgeEvidence', () async {
      // TODO
    });

    // The tenant closes a request — for good
    //
    //Future<HomeRequestResponse> closeHomeRequest(String requestId, { HomeRequestNoteRequest homeRequestNoteRequest }) async
    test('test closeHomeRequest', () async {
      // TODO
    });

    // Confirm a declared payment: it now pays its échéances (RM-M30-04, RM-M30-08)
    //
    //Future<DeclarationResponse> confirmDeclaration(String declarationId) async
    test('test confirmDeclaration', () async {
      // TODO
    });

    // Contest a declared payment, with a reason the tenant sees (RM-M30-04, RM-M30-07)
    //
    //Future<DeclarationResponse> contestDeclaration(String declarationId, ContestDeclarationRequest contestDeclarationRequest) async
    test('test contestDeclaration', () async {
      // TODO
    });

    // Get one upload per photo proof, its SHA-256 signed in — storage refuses any other content (RM-M30-11)
    //
    //Future<BuiltList<EvidenceUpload>> createEvidenceUploads(String contractId, EvidenceUploadsRequest evidenceUploadsRequest) async
    test('test createEvidenceUploads', () async {
      // TODO
    });

    // Ask the landlord: a remark, a problem (with photos), a question — it lives in the property's thread (RM-M30-09)
    //
    //Future<HomeRequestResponse> createHomeRequest(String contractId, CreateHomeRequest createHomeRequest) async
    test('test createHomeRequest', () async {
      // TODO
    });

    // Add a useful contact, shared with my tenants or not, on all my properties or some (15 at most)
    //
    //Future<UsefulContactResponse> createUsefulContact(UsefulContactRequest usefulContactRequest) async
    test('test createUsefulContact', () async {
      // TODO
    });

    // Declare an invoice paid outside Mboa, proofs optional — confirmed, it settles the invoice (RM-M24-09)
    //
    //Future<DeclarationResponse> declareInvoicePayment(String invoiceId, DeclareInvoicePaymentRequest declareInvoicePaymentRequest) async
    test('test declareInvoicePayment', () async {
      // TODO
    });

    // Declare a payment made outside Mboa: rent (one or more échéances) or deposit, proofs optional (RM-M30-03)
    //
    //Future<DeclarationResponse> declarePayment(String contractId, DeclarePaymentRequest declarePaymentRequest) async
    test('test declarePayment', () async {
      // TODO
    });

    // Remove a useful contact
    //
    //Future deleteUsefulContact(String contactId) async
    test('test deleteUsefulContact', () async {
      // TODO
    });

    // Short-lived links to a declaration's proofs — the two parties only
    //
    //Future<BuiltList<PresignedDownload>> getDeclarationProofs(String contractId, String declarationId) async
    test('test getDeclarationProofs', () async {
      // TODO
    });

    // One sending of photo proofs, each with a short-lived link
    //
    //Future<EvidenceBatchResponse> getEvidenceBatch(String contractId, String batchId) async
    test('test getEvidenceBatch', () async {
      // TODO
    });

    // One home, tenant or landlord: the summary and its échéancier up to the next 12 (RM-M30-01/02)
    //
    //Future<HomeDetail> getHome(String contractId) async
    test('test getHome', () async {
      // TODO
    });

    // One declared payment of a home
    //
    //Future<DeclarationResponse> getHomeDeclaration(String contractId, String declarationId) async
    test('test getHomeDeclaration', () async {
      // TODO
    });

    // A home's totals — confirmed, waiting, contested; only confirmed counts as paid (RM-M30-08)
    //
    //Future<HomeFinanceSummary> getHomeFinanceSummary(String contractId) async
    test('test getHomeFinanceSummary', () async {
      // TODO
    });

    // One request with its photos and history — what N-38 opens; the landlord's first look marks it seen
    //
    //Future<HomeRequestResponse> getHomeRequest(String requestId) async
    test('test getHomeRequest', () async {
      // TODO
    });

    // A window of a home's échéancier, computed from the contract — at most the next 12, 100 per answer (RM-M30-02)
    //
    //Future<HomeSchedule> getHomeSchedule(String contractId, { Date from, Date to }) async
    test('test getHomeSchedule', () async {
      // TODO
    });

    // One declared payment on my homes — what N-35 opens
    //
    //Future<DeclarationResponse> getMyReceivedDeclaration(String declarationId) async
    test('test getMyReceivedDeclaration', () async {
      // TODO
    });

    // A home's photo proofs, by sending, newest first — the two parties only
    //
    //Future<PageResponseEvidenceBatchResponse> listEvidence(String contractId, Pageable pageable) async
    test('test listEvidence', () async {
      // TODO
    });

    // The contacts my landlord shares on my home: name, role, number (CA-M30-05)
    //
    //Future<BuiltList<UsefulContactResponse>> listHomeContacts(String contractId) async
    test('test listHomeContacts', () async {
      // TODO
    });

    // A home's declared payments, newest first
    //
    //Future<PageResponseDeclarationResponse> listHomeDeclarations(String contractId, Pageable pageable) async
    test('test listHomeDeclarations', () async {
      // TODO
    });

    // A home's receipts, newest first — one per confirmed declaration (RM-M30-05)
    //
    //Future<PageResponseHomeReceiptResponse> listHomeReceipts(String contractId, Pageable pageable) async
    test('test listHomeReceipts', () async {
      // TODO
    });

    // A home's requests, newest first
    //
    //Future<PageResponseHomeRequestResponse> listHomeRequests(String contractId, Pageable pageable, { BuiltList<String> status }) async
    test('test listHomeRequests', () async {
      // TODO
    });

    // An invoice's declared payments, newest first
    //
    //Future<PageResponseDeclarationResponse> listInvoiceDeclarations(String invoiceId, Pageable pageable) async
    test('test listInvoiceDeclarations', () async {
      // TODO
    });

    // My homes — one per signed contract, active first, then to come, then ended (RM-M30-01)
    //
    //Future<PageResponseHomeSummary> listMyHomes(Pageable pageable, { BuiltList<String> state }) async
    test('test listMyHomes', () async {
      // TODO
    });

    // Declared payments on my homes, oldest first — status=DECLARED,UNCONFIRMED is the inbox (RM-M30-04)
    //
    //Future<PageResponseDeclarationResponse> listMyReceivedDeclarations(Pageable pageable, { BuiltList<String> status, String contractId }) async
    test('test listMyReceivedDeclarations', () async {
      // TODO
    });

    // Requests on my homes, newest first — status=SENT,SEEN,IN_PROGRESS is the inbox (no add-on, RM-M30-15)
    //
    //Future<PageResponseHomeRequestResponse> listMyReceivedRequests(Pageable pageable, { BuiltList<String> status, String contractId }) async
    test('test listMyReceivedRequests', () async {
      // TODO
    });

    // The homes on my properties, one per signed contract, active first (RM-M30-14: mine only)
    //
    //Future<PageResponseHomeSummary> listMyTenantHomes(Pageable pageable, { String annonceId, BuiltList<String> state }) async
    test('test listMyTenantHomes', () async {
      // TODO
    });

    // My useful contacts — caretaker, cleaner, craftsmen (RM-M30-13)
    //
    //Future<BuiltList<UsefulContactResponse>> listMyUsefulContacts() async
    test('test listMyUsefulContacts', () async {
      // TODO
    });

    // The landlord takes a request in hand or resolves it, with a word
    //
    //Future<HomeRequestResponse> moveHomeRequest(String requestId, HomeRequestStatusRequest homeRequestStatusRequest) async
    test('test moveHomeRequest', () async {
      // TODO
    });

    // Record uploaded photo proofs: checked in storage, then timestamped by the server — never modified (RM-M30-11)
    //
    //Future<EvidenceBatchResponse> recordEvidence(String contractId, RecordEvidenceRequest recordEvidenceRequest) async
    test('test recordEvidence', () async {
      // TODO
    });

    // The tenant reopens a resolved request: the problem is still there
    //
    //Future<HomeRequestResponse> reopenHomeRequest(String requestId, { HomeRequestNoteRequest homeRequestNoteRequest }) async
    test('test reopenHomeRequest', () async {
      // TODO
    });

    // Replace a useful contact
    //
    //Future<UsefulContactResponse> updateUsefulContact(String contactId, UsefulContactRequest usefulContactRequest) async
    test('test updateUsefulContact', () async {
      // TODO
    });

  });
}
