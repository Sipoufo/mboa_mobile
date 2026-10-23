import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/finance_refusal.dart';

/// What the landlord bills — the body of `POST /finance/invoices`. Settled by
/// hand or by the tenant's declarations: paying in the app is shut until the
/// COBAC opinion (DL-04), so no settlement is chosen.
class InvoiceDraft {
  const InvoiceDraft({
    required this.contractId,
    required this.kind,
    required this.amount,
    required this.dueDate,
    this.label,
  });

  final String contractId;
  final InvoiceKind kind;
  final int amount;
  final DateTime dueDate;

  /// Required for [InvoiceKind.other].
  final String? label;
}

/// The landlord's invoices (CDC M24): bill the tenant of a running Mboa
/// contract, follow what is paid, correct or cancel what is not. Writing
/// needs the add-on running; reading, having held it once.
class OwnerInvoicesRepository {
  OwnerInvoicesRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  FinanceInvoicesOwnerApi get _api => _dioClient.api.getFinanceInvoicesOwnerApi();

  static const String _listKey = 'invoices';
  static String _key(String id) => 'invoice:$id';

  /// Latest due first. Offline, the last list.
  Future<Cached<List<HomeInvoice>>> list() async {
    try {
      final page = (await _api.listOwnerInvoices(pageable: Pageable((b) => b..size = 100))).data;
      final items = page?.content?.map(HomeInvoice.fromResponse).toList() ?? const <HomeInvoice>[];
      await _cache.put(StorageKeys.financeBox, _listKey, {'items': [for (final i in items) i.toCache()]});
      return Cached(items);
    } catch (error) {
      final raw = _cache.get(StorageKeys.financeBox, _listKey)?['items'];
      if (raw is! List) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached([for (final i in raw) ?HomeInvoice.fromCache(i)], fromCache: true);
    }
  }

  /// One invoice. Offline, the last read.
  Future<Cached<HomeInvoice>> invoice(String id) async {
    try {
      final invoice = _read((await _api.getOwnerInvoice(id: id)).data);
      await _cache.put(StorageKeys.financeBox, _key(id), invoice.toCache());
      return Cached(invoice);
    } catch (error) {
      final cached = HomeInvoice.fromCache(_cache.get(StorageKeys.financeBox, _key(id)));
      if (cached == null) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached(cached, fromCache: true);
    }
  }

  Future<HomeInvoice> create(InvoiceDraft draft) => guardFinance(
        () async => _read(
          (await _api.createInvoice(
            createInvoiceRequest: CreateInvoiceRequest(
              (b) => b
                ..contractId = draft.contractId
                ..kind = CreateInvoiceRequestKindEnum.valueOf(_kindWire(draft.kind))
                ..label = _blank(draft.label)
                ..amount = draft.amount
                ..dueDate = draft.dueDate.toDate()
                ..settlement = CreateInvoiceRequestSettlementEnum.MANUAL,
            ),
          ))
              .data,
        ),
      );

  /// What is not paid can be corrected; a new due date re-arms the reminders.
  Future<HomeInvoice> update(String id, {String? label, int? amount, DateTime? dueDate}) => guardFinance(
        () async => _read(
          (await _api.updateInvoice(
            id: id,
            updateInvoiceRequest: UpdateInvoiceRequest(
              (b) => b
                ..label = _blank(label)
                ..amount = amount
                ..dueDate = dueDate?.toDate(),
            ),
          ))
              .data,
        ),
      );

  /// Paid outside Mboa, as the landlord says (RM-M24-05) — in force at once.
  Future<HomeInvoice> markPaid(String id, {required DateTime paidOn}) => guardFinance(
        () async => _read(
          (await _api.markInvoicePaid(
            id: id,
            markInvoicePaidRequest: MarkInvoicePaidRequest((b) => b..paidOn = paidOn.toDate()),
          ))
              .data,
        ),
      );

  /// Never deleted, for the trace.
  Future<HomeInvoice> cancel(String id) => guardFinance(() async => _read((await _api.cancelInvoice(id: id)).data));

  /// Withdraws a payment the landlord declared by mistake.
  Future<HomeInvoice> reopen(String id) => guardFinance(() async => _read((await _api.reopenInvoice(id: id)).data));

  HomeInvoice _read(InvoiceResponse? data) {
    if (data == null) throw StateError('empty invoice response');
    return HomeInvoice.fromResponse(data);
  }

  static String _kindWire(InvoiceKind kind) => switch (kind) {
        InvoiceKind.water => 'WATER',
        InvoiceKind.electricity => 'ELECTRICITY',
        InvoiceKind.other => 'OTHER',
      };

  static String? _blank(String? value) => (value == null || value.trim().isEmpty) ? null : value.trim();
}
