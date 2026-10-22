import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../../api/api_error.dart';
import '../models/home.dart';

/// Why the server turned a declaration or an answer down — the cases the
/// screens word (§29, slice C).
enum DeclarationRefusal {
  amountInvalid,
  dateInvalid,

  /// Not consecutive, or beyond the next 12 échéances.
  duesInvalid,
  dueAlreadyConfirmed,
  noDeposit,
  depositAlreadyConfirmed,
  proofLimit,
  invalidAttachment,

  /// The tenancy ended more than 7 days ago.
  readOnly,

  /// Answered meanwhile.
  answered,
  contestReasonRequired,

  /// The invoice was paid or cancelled meanwhile (slice E).
  invoiceSettled,
}

/// The receipt is still being made — usually a few seconds after the
/// confirmation (CA-M30-02); the server retries on its own.
class ReceiptNotReady implements Exception {
  const ReceiptNotReady();
}

class DeclarationRefused implements Exception {
  const DeclarationRefused(this.reason);

  final DeclarationRefusal reason;
}

/// What a tenant declares — the body of `POST /homes/{id}/declarations`.
class DeclarationDraft {
  const DeclarationDraft({
    required this.kind,
    required this.amount,
    required this.paidOn,
    required this.method,
    this.dueIndexes = const [],
    this.reference,
    this.note,
    this.proofKeys = const [],
  });

  final DeclarationKind kind;
  final List<int> dueIndexes;
  final int amount;
  final DateTime paidOn;
  final RentPaymentMethod method;
  final String? reference;
  final String? note;
  final List<String> proofKeys;
}

/// A read, and whether it came from the device's copy.
class Cached<T> {
  const Cached(this.value, {this.fromCache = false});

  final T value;
  final bool fromCache;
}

/// One space as a screen shows it: the home, a window of its schedule, its
/// declarations, its totals and its receipts.
class HomeBundle {
  const HomeBundle({
    required this.home,
    required this.schedule,
    this.declarations = const [],
    this.totals,
    this.receipts = const [],
  });

  final Home home;
  final RentSchedule schedule;
  final List<Declaration> declarations;
  final HomeTotals? totals;

  /// Newest first (slice D).
  final List<HomeReceipt> receipts;
}

/// "Mon Logement" (CDC M30) — `/homes` for both parties, and the landlord's
/// `/prestataires/me/…` routes. **No money moves through Mboa** (RM-M30-06):
/// nothing here takes or sends an amount; a declaration only says one was paid.
///
/// Offline, the last reads of an account's spaces are kept (an account's own,
/// emptied at sign-out); nothing is declared or answered without the network.
class HomesRepository {
  HomesRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  MonLogementApi get _api => _dioClient.api.getMonLogementApi();
  QuittancesApi get _receipts => _dioClient.api.getQuittancesApi();
  InvoicesTenantApi get _invoices => _dioClient.api.getInvoicesTenantApi();

  // --- The tenant's spaces --------------------------------------------------

  /// Active first, then upcoming, then ended (the server's order).
  Future<Cached<List<Home>>> myHomes() => _cachedList(
        'mine',
        () async => (await _api.listMyHomes(pageable: Pageable((b) => b..size = 20))).data?.content,
      );

  // --- One space, either side ----------------------------------------------

  /// The home, the default window of its schedule, its declarations and its
  /// totals — read together, kept together for offline.
  Future<Cached<HomeBundle>> bundle(String contractId) async {
    final key = 'home:$contractId';
    try {
      final (detail, declarations, totals, receipts) = await (
        _api.getHome(contractId: contractId),
        _api.listHomeDeclarations(contractId: contractId, pageable: Pageable((b) => b..size = 50)),
        _api.getHomeFinanceSummary(contractId: contractId),
        _receiptsOrNull(contractId),
      ).wait;
      final data = detail.data;
      final summary = data?.home;
      if (summary == null) throw StateError('home $contractId came back empty');
      final bundle = HomeBundle(
        home: Home.fromResponse(summary),
        schedule: data?.schedule == null ? const RentSchedule() : RentSchedule.fromResponse(data!.schedule!),
        declarations: declarations.data?.content?.map(Declaration.fromResponse).toList() ?? const [],
        totals: totals.data == null ? null : HomeTotals.fromResponse(totals.data!),
        // A list that did not come keeps the last one read, not an empty one.
        receipts: receipts ??
            [for (final r in (_cache.get(StorageKeys.homesBox, key)?['receipts'] as List? ?? const [])) ?HomeReceipt.fromCache(r)],
      );
      await _cache.put(StorageKeys.homesBox, key, {
        'home': bundle.home.toCache(),
        'schedule': bundle.schedule.toCache(),
        'declarations': [for (final d in bundle.declarations) d.toCache()],
        'totals': bundle.totals?.toCache(),
        'receipts': [for (final r in bundle.receipts) r.toCache()],
      });
      return Cached(bundle);
    } catch (error) {
      final raw = _cache.get(StorageKeys.homesBox, key);
      final home = Home.fromCache(raw?['home']);
      if (raw == null || home == null) {
        Error.throwWithStackTrace(error, StackTrace.current);
      }
      return Cached(
        HomeBundle(
          home: home,
          schedule: RentSchedule.fromCache(raw['schedule']) ?? const RentSchedule(),
          declarations: [for (final d in (raw['declarations'] as List? ?? const [])) ?Declaration.fromCache(d)],
          totals: HomeTotals.fromCache(raw['totals']),
          receipts: [for (final r in (raw['receipts'] as List? ?? const [])) ?HomeReceipt.fromCache(r)],
        ),
        fromCache: true,
      );
    }
  }

  /// The space's receipts — best-effort: the space stands without them.
  Future<List<HomeReceipt>?> _receiptsOrNull(String contractId) async {
    try {
      final response = await _api.listHomeReceipts(contractId: contractId, pageable: Pageable((b) => b..size = 50));
      return response.data?.content?.map(HomeReceipt.fromResponse).toList() ?? const [];
    } catch (_) {
      return null;
    }
  }

  /// Échéances due before [before] — paging back through an old lease.
  Future<RentSchedule> scheduleBefore(String contractId, DateTime before) async {
    final last = before.subtract(const Duration(days: 1));
    final response = await _api.getHomeSchedule(contractId: contractId, to: last.toDate());
    final data = response.data;
    return data == null ? const RentSchedule() : RentSchedule.fromResponse(data);
  }

  Future<Declaration> declaration(String contractId, String declarationId) async =>
      _declaration((await _api.getHomeDeclaration(contractId: contractId, declarationId: declarationId)).data);

  /// Short-lived links to the proofs — never public (RM-M30-12).
  Future<List<String>> proofUrls(String contractId, String declarationId) async {
    final response = await _api.getDeclarationProofs(contractId: contractId, declarationId: declarationId);
    return [for (final link in response.data ?? BuiltList<PresignedDownload>()) ?link.downloadUrl];
  }

  // --- The tenant declares (RM-M30-03) ---------------------------------------

  Future<Declaration> declare(String contractId, DeclarationDraft draft) => _guard(
        () async => _declaration(
          (await _api.declarePayment(
            contractId: contractId,
            declarePaymentRequest: DeclarePaymentRequest(
              (b) => b
                ..kind = DeclarePaymentRequestKindEnum.valueOf(draft.kind.wire)
                ..dueIndexes = draft.kind == DeclarationKind.rent ? ListBuilder<int>(draft.dueIndexes) : null
                ..amount = draft.amount
                ..paidOn = draft.paidOn.toDate()
                ..method = DeclarePaymentRequestMethodEnum.valueOf(draft.method.wire)
                ..reference = _blank(draft.reference)
                ..note = _blank(draft.note)
                ..proofKeys = draft.proofKeys.isEmpty ? null : ListBuilder<String>(draft.proofKeys),
            ),
          ))
              .data,
        ),
      );

  // --- Receipts (slice D), either party ---------------------------------------

  /// A short-lived link to a receipt's PDF; [ReceiptNotReady] while it is
  /// made.
  Future<String> receiptPdfUrl(String receiptId) async {
    try {
      final url = (await _receipts.getReceiptPdf(receiptId: receiptId)).data?.downloadUrl;
      if (url == null || url.isEmpty) throw StateError('receipt $receiptId came back without a link');
      return url;
    } on DioException catch (error) {
      if (ApiError.from(error).hasCode('RECEIPT_NOT_READY')) throw const ReceiptNotReady();
      rethrow;
    }
  }

  // --- Invoices declared paid (slice E), the tenant ---------------------------

  /// The tenant's invoices, latest due first — one tenancy's with
  /// [contractId] (the API lists them all; they are few). Offline, the last
  /// list read.
  Future<Cached<List<HomeInvoice>>> invoices({String? contractId}) async {
    const key = 'invoices';
    List<HomeInvoice> mine(List<HomeInvoice> all) =>
        contractId == null ? all : [for (final i in all) if (i.contractId == contractId) i];
    try {
      final response = await _invoices.listMyInvoices(pageable: Pageable((b) => b..size = 100));
      final items = response.data?.content?.map(HomeInvoice.fromResponse).toList() ?? const <HomeInvoice>[];
      await _cache.put(StorageKeys.homesBox, key, {'items': [for (final i in items) i.toCache()]});
      return Cached(mine(items));
    } catch (error) {
      final raw = _cache.get(StorageKeys.homesBox, key)?['items'];
      if (raw is! List) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached(mine([for (final i in raw) ?HomeInvoice.fromCache(i)]), fromCache: true);
    }
  }

  /// One invoice — what N-36 opens for an invoice. Offline, the copy kept
  /// with the list, if it has it.
  Future<Cached<HomeInvoice>> invoice(String invoiceId) async {
    try {
      final data = (await _invoices.getMyInvoice(id: invoiceId)).data;
      if (data == null) throw StateError('invoice $invoiceId came back empty');
      return Cached(HomeInvoice.fromResponse(data));
    } catch (error) {
      final raw = _cache.get(StorageKeys.homesBox, 'invoices')?['items'];
      final kept = raw is List ? [for (final i in raw) ?HomeInvoice.fromCache(i)].where((i) => i.id == invoiceId) : null;
      if (kept == null || kept.isEmpty) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached(kept.first, fromCache: true);
    }
  }

  /// The invoice's declarations, newest first.
  Future<List<Declaration>> invoiceDeclarations(String invoiceId) async {
    final response = await _api.listInvoiceDeclarations(invoiceId: invoiceId, pageable: Pageable((b) => b..size = 50));
    return response.data?.content?.map(Declaration.fromResponse).toList() ?? const [];
  }

  /// Declares an invoice paid — open invoices only (`INVOICE_SETTLED`).
  Future<Declaration> declareInvoice(String invoiceId, DeclarationDraft draft) => _guard(
        () async => _declaration(
          (await _api.declareInvoicePayment(
            invoiceId: invoiceId,
            declareInvoicePaymentRequest: DeclareInvoicePaymentRequest(
              (b) => b
                ..amount = draft.amount
                ..paidOn = draft.paidOn.toDate()
                ..method = DeclareInvoicePaymentRequestMethodEnum.valueOf(draft.method.wire)
                ..reference = _blank(draft.reference)
                ..note = _blank(draft.note)
                ..proofKeys = draft.proofKeys.isEmpty ? null : ListBuilder<String>(draft.proofKeys),
            ),
          ))
              .data,
        ),
      );

  // --- The landlord (no add-on, RM-M30-15) ------------------------------------

  /// His tenants' spaces, one listing's with [annonceId].
  Future<Cached<List<Home>>> tenantHomes({String? annonceId}) => _cachedList(
        'tenants:${annonceId ?? 'all'}',
        () async => (await _api.listMyTenantHomes(pageable: Pageable((b) => b..size = 50), annonceId: annonceId))
            .data
            ?.content,
      );

  /// Declarations waiting for his answer, oldest first.
  Future<Cached<List<Declaration>>> waitingDeclarations() async {
    const key = 'received:waiting';
    try {
      final response = await _api.listMyReceivedDeclarations(
        pageable: Pageable((b) => b..size = 50),
        status: BuiltList(const ['DECLARED', 'UNCONFIRMED']),
      );
      final items = response.data?.content?.map(Declaration.fromResponse).toList() ?? const <Declaration>[];
      await _cache.put(StorageKeys.homesBox, key, {'items': [for (final d in items) d.toCache()]});
      return Cached(items);
    } catch (error) {
      final raw = _cache.get(StorageKeys.homesBox, key)?['items'];
      if (raw is! List) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached([for (final d in raw) ?Declaration.fromCache(d)], fromCache: true);
    }
  }

  /// The home's counter — the server's total, not a page.
  Future<int> waitingCount() async {
    final response = await _api.listMyReceivedDeclarations(
      pageable: Pageable((b) => b..size = 1),
      status: BuiltList(const ['DECLARED', 'UNCONFIRMED']),
    );
    return response.data?.totalElements ?? 0;
  }

  /// What N-35 opens.
  Future<Declaration> receivedDeclaration(String declarationId) async =>
      _declaration((await _api.getMyReceivedDeclaration(declarationId: declarationId)).data);

  Future<Declaration> confirm(String declarationId) =>
      _guard(() async => _declaration((await _api.confirmDeclaration(declarationId: declarationId)).data));

  /// With a reason the tenant sees (RM-M30-04, RM-M30-07).
  Future<Declaration> contest(String declarationId, {required String reason}) => _guard(
        () async => _declaration(
          (await _api.contestDeclaration(
            declarationId: declarationId,
            contestDeclarationRequest: ContestDeclarationRequest((b) => b..reason = reason.trim()),
          ))
              .data,
        ),
      );

  // --- Helpers ----------------------------------------------------------------

  Future<Cached<List<Home>>> _cachedList(String key, Future<BuiltList<HomeSummary>?> Function() read) async {
    try {
      final items = (await read())?.map(Home.fromResponse).toList() ?? const <Home>[];
      await _cache.put(StorageKeys.homesBox, key, {'items': [for (final h in items) h.toCache()]});
      return Cached(items);
    } catch (error) {
      final raw = _cache.get(StorageKeys.homesBox, key)?['items'];
      if (raw is! List) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached([for (final h in raw) ?Home.fromCache(h)], fromCache: true);
    }
  }

  Future<Declaration> _guard(Future<Declaration> Function() call) async {
    try {
      return await call();
    } on DioException catch (error) {
      final api = ApiError.from(error);
      for (final (code, reason) in const [
        ('DECLARATION_AMOUNT_INVALID', DeclarationRefusal.amountInvalid),
        ('DECLARATION_DATE_INVALID', DeclarationRefusal.dateInvalid),
        ('DUE_INDEXES_INVALID', DeclarationRefusal.duesInvalid),
        ('DUE_ALREADY_CONFIRMED', DeclarationRefusal.dueAlreadyConfirmed),
        ('NO_DEPOSIT', DeclarationRefusal.noDeposit),
        ('DEPOSIT_ALREADY_CONFIRMED', DeclarationRefusal.depositAlreadyConfirmed),
        ('PROOF_LIMIT', DeclarationRefusal.proofLimit),
        ('INVALID_ATTACHMENT', DeclarationRefusal.invalidAttachment),
        ('HOME_READ_ONLY', DeclarationRefusal.readOnly),
        ('DECLARATION_ANSWERED', DeclarationRefusal.answered),
        ('CONTEST_REASON_REQUIRED', DeclarationRefusal.contestReasonRequired),
        ('INVOICE_SETTLED', DeclarationRefusal.invoiceSettled),
      ]) {
        if (api.hasCode(code)) throw DeclarationRefused(reason);
      }
      rethrow;
    }
  }

  Declaration _declaration(DeclarationResponse? data) {
    if (data == null) throw StateError('empty declaration response');
    return Declaration.fromResponse(data);
  }

  static String? _blank(String? value) => (value == null || value.trim().isEmpty) ? null : value.trim();
}
