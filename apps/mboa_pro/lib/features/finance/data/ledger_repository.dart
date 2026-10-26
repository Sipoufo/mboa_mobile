import 'dart:convert';
import 'dart:typed_data';

import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/finance_refusal.dart';
import '../models/ledger.dart';

/// What the landlord writes in his register — the body of
/// `POST /finance/ledger`. Never a line kept from a confirmed payment: those
/// are the server's.
class LedgerDraft {
  const LedgerDraft({
    required this.direction,
    required this.category,
    required this.amount,
    required this.date,
    this.property = const UnassignedProperty(),
    this.note,
    this.attachmentKey,
  });

  final LedgerDirection direction;
  final LedgerCategory category;
  final int amount;
  final DateTime date;

  /// A listing, a residence, or « non affecté » (RM-M25-02).
  final LedgerProperty property;
  final String? note;

  /// A compressed `FINANCE_ATTACHMENT` upload — a receipt, a quote. On a
  /// correction (§34): null keeps the line's own, `""` removes it.
  final String? attachmentKey;
}

/// One page of lines.
class LedgerLines {
  const LedgerLines({required this.entries, required this.isLast});

  final List<LedgerEntry> entries;
  final bool isLast;
}

/// The landlord's register (CDC M25): his own, private (RM-M25-04). Every
/// movement is his word (RM-M25-01); confirmed rents and invoices write
/// their own lines, read only. Writing needs the add-on running; reading,
/// summing up and exporting, having held it once.
class LedgerRepository {
  LedgerRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  FinanceLedgerApi get _api => _dioClient.api.getFinanceLedgerApi();

  static const int _pageSize = 30;

  /// Newest first. The first page of each scope is kept for offline.
  Future<Cached<LedgerLines>> entries(LedgerScope scope, {int page = 0, DateTime? today}) async {
    final key = 'ledger:${scope.key}';
    final f = _filters(scope, today ?? DateTime.now());
    try {
      final data = (await _api.listLedgerEntries(
        pageable: Pageable((b) => b
          ..page = page
          ..size = _pageSize),
        from: f.from,
        to: f.to,
        annonceId: f.annonceId,
        residenceId: f.residenceId,
        unassigned: f.unassigned,
      ))
          .data;
      final entries = data?.content?.map(LedgerEntry.fromResponse).toList() ?? const <LedgerEntry>[];
      if (page == 0) await _cache.put(StorageKeys.financeBox, key, {'items': [for (final e in entries) e.toCache()]});
      return Cached(LedgerLines(entries: entries, isLast: data?.last ?? entries.length < _pageSize));
    } catch (error) {
      final raw = _cache.get(StorageKeys.financeBox, key)?['items'];
      if (page > 0 || raw is! List) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached(LedgerLines(entries: [for (final e in raw) ?LedgerEntry.fromCache(e)], isLast: true), fromCache: true);
    }
  }

  /// In, out, net and by category, over the same scope (RM-M25-03).
  Future<Cached<LedgerSummary>> summary(LedgerScope scope, {DateTime? today}) async {
    final key = 'ledger-summary:${scope.key}';
    final f = _filters(scope, today ?? DateTime.now());
    try {
      final data = (await _api.getLedgerSummary(
        from: f.from,
        to: f.to,
        annonceId: f.annonceId,
        residenceId: f.residenceId,
        unassigned: f.unassigned,
      ))
          .data;
      final summary = data == null ? const LedgerSummary() : LedgerSummary.fromResponse(data);
      await _cache.put(StorageKeys.financeBox, key, summary.toCache());
      return Cached(summary);
    } catch (error) {
      final cached = LedgerSummary.fromCache(_cache.get(StorageKeys.financeBox, key));
      if (cached == null) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached(cached, fromCache: true);
    }
  }

  /// The same lines as CSV, for any period (RM-M25-05) — as bytes, UTF-8.
  Future<Uint8List> exportCsv(LedgerScope scope, {DateTime? today}) async {
    final f = _filters(scope, today ?? DateTime.now());
    final csv = (await _api.exportLedger(
      from: f.from,
      to: f.to,
      annonceId: f.annonceId,
      residenceId: f.residenceId,
      unassigned: f.unassigned,
    ))
        .data;
    if (csv == null) throw StateError('empty ledger export');
    return Uint8List.fromList(utf8.encode(csv));
  }

  /// A short-lived link to a line's attachment.
  Future<String> attachmentUrl(String entryId) async {
    final url = (await _api.getLedgerAttachment(id: entryId)).data?.downloadUrl;
    if (url == null) throw StateError('no attachment link for $entryId');
    return url;
  }

  Future<LedgerEntry> create(LedgerDraft draft) =>
      guardFinance(() async => _read((await _api.createLedgerEntry(ledgerEntryRequest: _request(draft))).data));

  Future<LedgerEntry> update(String id, LedgerDraft draft) => guardFinance(
        () async => _read((await _api.updateLedgerEntry(id: id, ledgerEntryRequest: _request(draft))).data),
      );

  /// The line and its attachment go.
  Future<void> delete(String id) => guardFinance(() => _api.deleteLedgerEntry(id: id));

  LedgerEntryRequest _request(LedgerDraft draft) => LedgerEntryRequest(
        (b) => b
          ..direction = LedgerEntryRequestDirectionEnum.valueOf(draft.direction.wire)
          ..category = LedgerEntryRequestCategoryEnum.valueOf(draft.category.wire)
          ..amount = draft.amount
          ..date = draft.date.toDate()
          ..annonceId = switch (draft.property) {
            ListingProperty(:final id) => id,
            _ => null,
          }
          ..residenceId = switch (draft.property) {
            ResidenceProperty(:final id) => id,
            _ => null,
          }
          ..note = _blank(draft.note)
          ..attachmentKey = draft.attachmentKey,
      );

  LedgerEntry _read(LedgerEntryResponse? data) {
    if (data == null) throw StateError('empty ledger response');
    return LedgerEntry.fromResponse(data);
  }

  /// One scope, as every read sends it.
  static ({Date? from, Date? to, String? annonceId, String? residenceId, bool unassigned}) _filters(
    LedgerScope scope,
    DateTime today,
  ) {
    final range = scope.period.range(today);
    return (
      from: range?.$1.toDate(),
      to: range?.$2.toDate(),
      annonceId: switch (scope.property) {
        ListingProperty(:final id) => id,
        _ => null,
      },
      residenceId: switch (scope.property) {
        ResidenceProperty(:final id) => id,
        _ => null,
      },
      unassigned: scope.property is UnassignedProperty,
    );
  }

  static String? _blank(String? value) => (value == null || value.trim().isEmpty) ? null : value.trim();
}
