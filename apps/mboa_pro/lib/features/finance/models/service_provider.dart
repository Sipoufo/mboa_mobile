import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import 'ledger.dart';

/// What an intervenant does (CDC M26).
enum ProviderKind {
  cleaning,
  plumbing,
  electrical,
  other;

  String get wire => switch (this) {
        ProviderKind.cleaning => 'CLEANING',
        ProviderKind.plumbing => 'PLUMBING',
        ProviderKind.electrical => 'ELECTRICAL',
        ProviderKind.other => 'OTHER',
      };

  static ProviderKind fromWire(String? name) =>
      ProviderKind.values.where((k) => k.wire == name).firstOrNull ?? ProviderKind.other;
}

/// Someone the landlord pays for his properties (CDC M26) — a Mboa account
/// he has a thread with, its name kept up to date and never its phone
/// (RM-M26-01, CA-M12-02), or a name he typed. With payments, archived
/// rather than deleted: the history stays.
class ServiceProvider extends Equatable {
  const ServiceProvider({
    required this.id,
    required this.name,
    this.kind = ProviderKind.other,
    this.kindLabel,
    this.note,
    this.linkedAccountId,
    this.archived = false,
    this.totalPaid = 0,
    this.paymentCount = 0,
    this.lastPaidOn,
  });

  final String id;
  final String name;
  final ProviderKind kind;

  /// The landlord's word for [ProviderKind.other]: « Gardien ».
  final String? kindLabel;
  final String? note;
  final String? linkedAccountId;
  final bool archived;

  /// The server's sums of the declared payments.
  final int totalPaid;
  final int paymentCount;
  final DateTime? lastPaidOn;

  bool get isLinked => linkedAccountId != null;

  /// Deleted only without payments; otherwise archived.
  bool get canDelete => paymentCount == 0;

  static ServiceProvider fromResponse(ServiceProviderResponse r) => ServiceProvider(
        id: r.id ?? '',
        name: r.name ?? '',
        kind: ProviderKind.fromWire(r.kind?.name),
        kindLabel: r.kindLabel,
        note: r.note,
        linkedAccountId: r.linkedAccountId,
        archived: r.archived ?? false,
        totalPaid: r.totalPaid ?? 0,
        paymentCount: r.paymentCount ?? 0,
        lastPaidOn: r.lastPaidOn?.toDateTime(),
      );

  Map<String, dynamic> toCache() => {
        'id': id,
        'name': name,
        'kind': kind.name,
        'kindLabel': kindLabel,
        'note': note,
        'linked': linkedAccountId,
        'archived': archived,
        'total': totalPaid,
        'count': paymentCount,
        'last': lastPaidOn?.toIso8601String(),
      };

  static ServiceProvider? fromCache(Object? raw) {
    if (raw is! Map || raw['id'] is! String) return null;
    return ServiceProvider(
      id: raw['id'] as String,
      name: raw['name'] as String? ?? '',
      kind: ProviderKind.values.where((k) => k.name == raw['kind']).firstOrNull ?? ProviderKind.other,
      kindLabel: raw['kindLabel'] as String?,
      note: raw['note'] as String?,
      linkedAccountId: raw['linked'] as String?,
      archived: raw['archived'] as bool? ?? false,
      totalPaid: raw['total'] as int? ?? 0,
      paymentCount: raw['count'] as int? ?? 0,
      lastPaidOn: raw['last'] is String ? DateTime.tryParse(raw['last'] as String) : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, kind, kindLabel, note, linkedAccountId, archived, totalPaid, paymentCount, lastPaidOn];
}

/// A payment declared to an intervenant (RM-M26-02) — his word, never
/// moved by Mboa — and its line in the register (« Sortie · Intervenants »,
/// RM-M26-04).
class ProviderPayment extends Equatable {
  const ProviderPayment({
    required this.id,
    required this.amount,
    this.paidOn,
    this.note,
    this.annonceId,
    this.residenceId,
    this.propertyLabel,
    this.inLedger = false,
  });

  final String id;
  final int amount;
  final DateTime? paidOn;
  final String? note;
  final String? annonceId;
  final String? residenceId;
  final String? propertyLabel;
  final bool inLedger;

  LedgerProperty get property => switch ((annonceId, residenceId)) {
        (final id?, _) => ListingProperty(id, propertyLabel ?? ''),
        (_, final id?) => ResidenceProperty(id, propertyLabel ?? ''),
        _ => const UnassignedProperty(),
      };

  static ProviderPayment fromResponse(ServiceProviderPaymentResponse r) => ProviderPayment(
        id: r.id ?? '',
        amount: r.amount ?? 0,
        paidOn: r.paidOn?.toDateTime(),
        note: r.note,
        annonceId: r.annonceId,
        residenceId: r.residenceId,
        propertyLabel: r.propertyLabel,
        inLedger: r.inLedger ?? false,
      );

  Map<String, dynamic> toCache() => {
        'id': id,
        'amount': amount,
        'paidOn': paidOn?.toIso8601String(),
        'note': note,
        'annonceId': annonceId,
        'residenceId': residenceId,
        'property': propertyLabel,
        'inLedger': inLedger,
      };

  static ProviderPayment? fromCache(Object? raw) {
    if (raw is! Map || raw['id'] is! String) return null;
    return ProviderPayment(
      id: raw['id'] as String,
      amount: raw['amount'] as int? ?? 0,
      paidOn: raw['paidOn'] is String ? DateTime.tryParse(raw['paidOn'] as String) : null,
      note: raw['note'] as String?,
      annonceId: raw['annonceId'] as String?,
      residenceId: raw['residenceId'] as String?,
      propertyLabel: raw['property'] as String?,
      inLedger: raw['inLedger'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [id, amount, paidOn, note, annonceId, residenceId, propertyLabel, inLedger];
}

/// Someone the landlord has a thread with — the only Mboa accounts an
/// intervenant can be linked to.
class ProviderContact extends Equatable {
  const ProviderContact({required this.accountId, required this.name});

  final String accountId;
  final String name;

  @override
  List<Object?> get props => [accountId, name];
}
