import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for MonLogementApi
void main() {
  final instance = ApiClient().getMonLogementApi();

  group(MonLogementApi, () {
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

    // Declare a payment made outside Mboa: rent (one or more échéances) or deposit, proofs optional (RM-M30-03)
    //
    //Future<DeclarationResponse> declarePayment(String contractId, DeclarePaymentRequest declarePaymentRequest) async
    test('test declarePayment', () async {
      // TODO
    });

    // Short-lived links to a declaration's proofs — the two parties only
    //
    //Future<BuiltList<PresignedDownload>> getDeclarationProofs(String contractId, String declarationId) async
    test('test getDeclarationProofs', () async {
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

    // A home's declared payments, newest first
    //
    //Future<PageResponseDeclarationResponse> listHomeDeclarations(String contractId, Pageable pageable) async
    test('test listHomeDeclarations', () async {
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

    // The homes on my properties, one per signed contract, active first (RM-M30-14: mine only)
    //
    //Future<PageResponseHomeSummary> listMyTenantHomes(Pageable pageable, { String annonceId, BuiltList<String> state }) async
    test('test listMyTenantHomes', () async {
      // TODO
    });

  });
}
