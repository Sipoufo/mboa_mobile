import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../contracts/models/contract.dart';
import '../../listings/models/rental_period.dart';
import '../../profile/models/base_profile.dart';

/// "Mon Logement" (CDC M30) — one space per signed contract, read by both
/// parties. **No money moves through Mboa** (RM-M30-06): payments are made
/// outside it, *declared* by the tenant and *confirmed* or *contested* by the
/// landlord. Every status and total here is the server's — the apps never
/// work out a lateness or add up a list (RM-M30-02, RM-M30-08).

/// Where the space stands (RM-M30-01, RM-M30-16).
enum HomeStage {
  /// Signed, before the move-in day: "À venir".
  upcoming,
  active,

  /// The tenancy is over: read only (7 more days to declare a late rent).
  readOnly,
  unknown;

  static HomeStage fromWire(String? name) => switch (name) {
        'UPCOMING' => HomeStage.upcoming,
        'ACTIVE' => HomeStage.active,
        'READ_ONLY' => HomeStage.readOnly,
        _ => HomeStage.unknown,
      };
}

/// One échéance, from the server's verdicts (§29.2).
enum DueStatus {
  upcoming,

  /// RentDue, within its 5 days.
  due,

  /// Past its 5 days without being covered.
  late,

  /// A declaration waits for the landlord.
  declared,

  /// A declaration has waited 7 days or more — still answerable.
  unconfirmed,

  /// Covered by confirmed payments.
  confirmed,

  /// The last answer was a contest, and nothing else waits.
  contested,

  /// RentDue before rent tracking began on Mboa: never late, greyed out.
  untracked,
  unknown;

  static DueStatus fromWire(String? name) => switch (name) {
        'UPCOMING' => DueStatus.upcoming,
        'DUE' => DueStatus.due,
        'LATE' => DueStatus.late,
        'DECLARED' => DueStatus.declared,
        'UNCONFIRMED' => DueStatus.unconfirmed,
        'CONFIRMED' => DueStatus.confirmed,
        'CONTESTED' => DueStatus.contested,
        'UNTRACKED' => DueStatus.untracked,
        _ => DueStatus.unknown,
      };

  /// Still to be paid — what a tenant may declare for.
  bool get isOpen =>
      this == DueStatus.upcoming || this == DueStatus.due || this == DueStatus.late || this == DueStatus.contested;
}

class RentDue extends Equatable {
  const RentDue({
    required this.index,
    this.periodStart,
    this.periodEnd,
    this.dueDate,
    this.amount = 0,
    this.confirmedTotal = 0,
    this.status = DueStatus.unknown,
    this.late = false,
    this.declarationIds = const [],
  });

  /// Stable within the contract: 0 is the move-in day.
  final int index;
  final DateTime? periodStart;
  final DateTime? periodEnd;

  /// The first day of the period — rent is paid in advance.
  final DateTime? dueDate;
  final int amount;

  /// A partial payment shows here; the échéance stays open until covered.
  final int confirmedTotal;
  final DueStatus status;

  /// Five days past without being covered, **whatever the status** — declared
  /// is not paid.
  final bool late;
  final List<String> declarationIds;

  int get remaining => (amount - confirmedTotal).clamp(0, amount);

  bool get isPartlyPaid => confirmedTotal > 0 && confirmedTotal < amount;

  static RentDue fromResponse(Due response) => RentDue(
        index: response.index ?? 0,
        periodStart: response.periodStart?.toDateTime(),
        periodEnd: response.periodEnd?.toDateTime(),
        dueDate: response.dueDate?.toDateTime(),
        amount: response.amount ?? 0,
        confirmedTotal: response.confirmedTotal ?? 0,
        status: DueStatus.fromWire(response.status?.name),
        late: response.late_ ?? false,
        declarationIds: response.declarationIds?.toList() ?? const [],
      );

  Map<String, dynamic> toCache() => {
        'index': index,
        'periodStart': periodStart?.toIso8601String(),
        'periodEnd': periodEnd?.toIso8601String(),
        'dueDate': dueDate?.toIso8601String(),
        'amount': amount,
        'confirmedTotal': confirmedTotal,
        'status': status.name,
        'late': late,
        'declarationIds': declarationIds,
      };

  static RentDue? fromCache(Object? raw) {
    if (raw is! Map) return null;
    final json = Map<String, dynamic>.from(raw);
    final index = json['index'];
    if (index is! int) return null;
    return RentDue(
      index: index,
      periodStart: _date(json['periodStart']),
      periodEnd: _date(json['periodEnd']),
      dueDate: _date(json['dueDate']),
      amount: json['amount'] as int? ?? 0,
      confirmedTotal: json['confirmedTotal'] as int? ?? 0,
      status: DueStatus.values.where((s) => s.name == json['status']).firstOrNull ?? DueStatus.unknown,
      late: json['late'] as bool? ?? false,
      declarationIds: [for (final id in (json['declarationIds'] as List? ?? const [])) '$id'],
    );
  }

  @override
  List<Object?> get props =>
      [index, periodStart, periodEnd, dueDate, amount, confirmedTotal, status, late, declarationIds];
}

/// The caution's declared state — in the MVP (§29.1): declared, confirmed,
/// and then a "reçu de dépôt de garantie", not a quittance.
enum DepositStatus {
  none,
  declared,
  unconfirmed,
  confirmed,
  contested,
  unknown;

  static DepositStatus fromWire(String? name) => switch (name) {
        'NONE' => DepositStatus.none,
        'DECLARED' => DepositStatus.declared,
        'UNCONFIRMED' => DepositStatus.unconfirmed,
        'CONFIRMED' => DepositStatus.confirmed,
        'CONTESTED' => DepositStatus.contested,
        _ => DepositStatus.unknown,
      };

  /// What a tenant may still declare.
  bool get isOpen => this == DepositStatus.none || this == DepositStatus.contested;
}

class RentDeposit extends Equatable {
  const RentDeposit({this.amount = 0, this.confirmedTotal = 0, this.status = DepositStatus.none});

  final int amount;
  final int confirmedTotal;
  final DepositStatus status;

  static RentDeposit fromResponse(HomeDeposit response) => RentDeposit(
        amount: response.amount ?? 0,
        confirmedTotal: response.confirmedTotal ?? 0,
        status: DepositStatus.fromWire(response.status?.name),
      );

  @override
  List<Object?> get props => [amount, confirmedTotal, status];
}

/// One space — a signed contract, from either side (both parties named).
class Home extends Equatable {
  const Home({
    required this.contractId,
    this.annonceId,
    this.annonceTitle,
    this.city,
    this.district,
    this.exactAddress,
    this.coverPhotoKey,
    this.prestataire,
    this.tenant,
    this.state = HomeStage.unknown,
    this.rent = 0,
    this.rentalPeriod = RentalPeriod.fallback,
    this.chargesIncluded,
    this.deposit = const RentDeposit(),
    this.startDate,
    this.endDate,
    this.tacitRenewal = false,
    this.nextDue,
    this.overdueCount = 0,
    this.overdueAmount = 0,
  });

  /// The space's id is the contract's.
  final String contractId;
  final String? annonceId;
  final String? annonceTitle;
  final String? city;
  final String? district;

  /// Signed, so the address is shown (CA-M08-02).
  final String? exactAddress;
  final String? coverPhotoKey;
  final ContractParticipant? prestataire;
  final ContractParticipant? tenant;
  final HomeStage state;
  final int rent;
  final RentalPeriod rentalPeriod;
  final bool? chargesIncluded;
  final RentDeposit deposit;
  final DateTime? startDate;

  /// Absent while the lease renews itself.
  final DateTime? endDate;
  final bool tacitRenewal;

  /// The oldest échéance not covered — possibly a late one.
  final RentDue? nextDue;
  final int overdueCount;
  final int overdueAmount;

  String? get coverUrl => BaseProfile.mediaUrl(coverPhotoKey);

  bool get isOverdue => overdueCount > 0;

  /// The tenant may still declare (the server refuses otherwise:
  /// `HOME_READ_ONLY`, beyond 7 days after the end).
  bool get isWritable => state == HomeStage.active || state == HomeStage.upcoming;

  static Home fromResponse(HomeSummary response) => Home(
        contractId: response.contractId ?? '',
        annonceId: response.annonceId,
        annonceTitle: response.annonceTitle,
        city: response.city,
        district: response.district,
        exactAddress: response.exactAddress,
        coverPhotoKey: response.coverPhotoKey,
        prestataire: response.prestataire == null ? null : ContractParticipant.fromResponse(response.prestataire!),
        tenant: response.tenant == null ? null : ContractParticipant.fromResponse(response.tenant!),
        state: HomeStage.fromWire(response.state?.name),
        rent: response.rent ?? 0,
        rentalPeriod: RentalPeriod.fromWire(response.rentalPeriod?.name),
        chargesIncluded: response.chargesIncluded,
        deposit: response.deposit == null
            ? RentDeposit(amount: response.depositAmount ?? 0)
            : RentDeposit.fromResponse(response.deposit!),
        startDate: response.startDate?.toDateTime(),
        endDate: response.endDate?.toDateTime(),
        tacitRenewal: response.tacitRenewal ?? false,
        nextDue: response.nextDue == null ? null : RentDue.fromResponse(response.nextDue!),
        overdueCount: response.overdueCount ?? 0,
        overdueAmount: response.overdueAmount ?? 0,
      );

  Map<String, dynamic> toCache() => {
        'contractId': contractId,
        'annonceId': annonceId,
        'annonceTitle': annonceTitle,
        'city': city,
        'district': district,
        'exactAddress': exactAddress,
        'coverPhotoKey': coverPhotoKey,
        'prestataire': prestataire?.displayName,
        'tenant': tenant?.displayName,
        'state': state.name,
        'rent': rent,
        'rentalPeriod': rentalPeriod.name,
        'chargesIncluded': chargesIncluded,
        'depositAmount': deposit.amount,
        'depositConfirmed': deposit.confirmedTotal,
        'depositStatus': deposit.status.name,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'tacitRenewal': tacitRenewal,
        'nextDue': nextDue?.toCache(),
        'overdueCount': overdueCount,
        'overdueAmount': overdueAmount,
      };

  static Home? fromCache(Object? raw) {
    if (raw is! Map) return null;
    final json = Map<String, dynamic>.from(raw);
    final id = json['contractId'];
    if (id is! String) return null;
    ContractParticipant? party(Object? name) => name is String ? ContractParticipant(displayName: name) : null;
    return Home(
      contractId: id,
      annonceId: json['annonceId'] as String?,
      annonceTitle: json['annonceTitle'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      exactAddress: json['exactAddress'] as String?,
      coverPhotoKey: json['coverPhotoKey'] as String?,
      prestataire: party(json['prestataire']),
      tenant: party(json['tenant']),
      state: HomeStage.values.where((s) => s.name == json['state']).firstOrNull ?? HomeStage.unknown,
      rent: json['rent'] as int? ?? 0,
      rentalPeriod: RentalPeriod.values.where((p) => p.name == json['rentalPeriod']).firstOrNull ?? RentalPeriod.fallback,
      chargesIncluded: json['chargesIncluded'] as bool?,
      deposit: RentDeposit(
        amount: json['depositAmount'] as int? ?? 0,
        confirmedTotal: json['depositConfirmed'] as int? ?? 0,
        status: DepositStatus.values.where((s) => s.name == json['depositStatus']).firstOrNull ?? DepositStatus.none,
      ),
      startDate: _date(json['startDate']),
      endDate: _date(json['endDate']),
      tacitRenewal: json['tacitRenewal'] as bool? ?? false,
      nextDue: RentDue.fromCache(json['nextDue']),
      overdueCount: json['overdueCount'] as int? ?? 0,
      overdueAmount: json['overdueAmount'] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        contractId,
        annonceId,
        annonceTitle,
        city,
        district,
        exactAddress,
        coverPhotoKey,
        prestataire,
        tenant,
        state,
        rent,
        rentalPeriod,
        chargesIncluded,
        deposit,
        startDate,
        endDate,
        tacitRenewal,
        nextDue,
        overdueCount,
        overdueAmount,
      ];
}

/// A window of the schedule — computed by the server at each read.
class RentSchedule extends Equatable {
  const RentSchedule({this.dues = const [], this.moreBefore = false, this.moreAfter = false});

  final List<RentDue> dues;

  /// Older échéances exist: ask again before the first one.
  final bool moreBefore;
  final bool moreAfter;

  static RentSchedule fromResponse(HomeSchedule response) => RentSchedule(
        dues: response.dues?.map(RentDue.fromResponse).toList() ?? const [],
        moreBefore: response.moreBefore ?? false,
        moreAfter: response.moreAfter ?? false,
      );

  /// [older] put in front of this window (paging back in time).
  RentSchedule prepend(RentSchedule older) => RentSchedule(
        dues: [
          ...older.dues.where((d) => !dues.any((mine) => mine.index == d.index)),
          ...dues,
        ],
        moreBefore: older.moreBefore,
        moreAfter: moreAfter,
      );

  Map<String, dynamic> toCache() => {
        'dues': [for (final d in dues) d.toCache()],
        'moreBefore': moreBefore,
        'moreAfter': moreAfter,
      };

  static RentSchedule? fromCache(Object? raw) {
    if (raw is! Map) return null;
    final json = Map<String, dynamic>.from(raw);
    return RentSchedule(
      dues: [for (final d in (json['dues'] as List? ?? const [])) ?RentDue.fromCache(d)],
      moreBefore: json['moreBefore'] as bool? ?? false,
      moreAfter: json['moreAfter'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [dues, moreBefore, moreAfter];
}

enum DeclarationKind {
  rent,
  deposit,

  /// An invoice declared paid (slice E, RM-M24-09) — declared on the invoice,
  /// never on the home's route.
  invoice;

  String get wire => switch (this) {
        DeclarationKind.rent => 'RENT',
        DeclarationKind.deposit => 'DEPOSIT',
        DeclarationKind.invoice => 'INVOICE',
      };

  static DeclarationKind fromWire(String? name) => switch (name) {
        'DEPOSIT' => DeclarationKind.deposit,
        'INVOICE' => DeclarationKind.invoice,
        _ => DeclarationKind.rent,
      };
}

/// How the tenant paid — outside Mboa, always (RM-M30-03).
enum RentPaymentMethod {
  mobileMoney,
  orangeMoney,
  cash,
  transfer,
  other;

  static RentPaymentMethod fromWire(String? name) => switch (name) {
        'MOBILE_MONEY' => RentPaymentMethod.mobileMoney,
        'ORANGE_MONEY' => RentPaymentMethod.orangeMoney,
        'CASH' => RentPaymentMethod.cash,
        'TRANSFER' => RentPaymentMethod.transfer,
        _ => RentPaymentMethod.other,
      };

  String get wire => switch (this) {
        RentPaymentMethod.mobileMoney => 'MOBILE_MONEY',
        RentPaymentMethod.orangeMoney => 'ORANGE_MONEY',
        RentPaymentMethod.cash => 'CASH',
        RentPaymentMethod.transfer => 'TRANSFER',
        RentPaymentMethod.other => 'OTHER',
      };

  /// The mockup's two tabs: mobile money, and the rest.
  bool get isMobile => this == RentPaymentMethod.mobileMoney || this == RentPaymentMethod.orangeMoney;
}

enum DeclarationStatus {
  declared,

  /// Waiting 7 days or more — computed by the server, still answerable.
  unconfirmed,
  confirmed,
  contested,
  unknown;

  static DeclarationStatus fromWire(String? name) => switch (name) {
        'DECLARED' => DeclarationStatus.declared,
        'UNCONFIRMED' => DeclarationStatus.unconfirmed,
        'CONFIRMED' => DeclarationStatus.confirmed,
        'CONTESTED' => DeclarationStatus.contested,
        _ => DeclarationStatus.unknown,
      };

  bool get isWaiting => this == DeclarationStatus.declared || this == DeclarationStatus.unconfirmed;
}

/// A payment the tenant declares — one or several consecutive échéances, or
/// the deposit (§29.1).
class Declaration extends Equatable {
  const Declaration({
    required this.id,
    this.contractId,
    this.annonceId,
    this.annonceTitle,
    this.tenant,
    this.kind = DeclarationKind.rent,
    this.dueIndexes = const [],
    this.amount = 0,
    this.paidOn,
    this.method = RentPaymentMethod.other,
    this.reference,
    this.note,
    this.proofKeys = const [],
    this.hasProof = false,
    this.status = DeclarationStatus.unknown,
    this.contestReason,
    this.declaredAt,
    this.answeredAt,
    this.canConfirm = false,
    this.canContest = false,
    this.invoiceId,
    this.receiptId,
    this.receiptReady = false,
  });

  final String id;
  final String? contractId;
  final String? annonceId;
  final String? annonceTitle;
  final ContractParticipant? tenant;
  final DeclarationKind kind;
  final List<int> dueIndexes;
  final int amount;
  final DateTime? paidOn;
  final RentPaymentMethod method;
  final String? reference;
  final String? note;
  final List<String> proofKeys;

  /// False is RM-M30-03's « déclaré sans justificatif ».
  final bool hasProof;
  final DeclarationStatus status;
  final String? contestReason;
  final DateTime? declaredAt;
  final DateTime? answeredAt;

  /// The landlord's, server-computed: while it waits and the space is writable.
  final bool canConfirm;
  final bool canContest;

  /// Set when [kind] is [DeclarationKind.invoice].
  final String? invoiceId;

  /// The receipt a confirmation produces (slice D) — named at once, its PDF
  /// [receiptReady] a few seconds later (CA-M30-02).
  final String? receiptId;
  final bool receiptReady;

  static Declaration fromResponse(DeclarationResponse response) => Declaration(
        id: response.id ?? '',
        contractId: response.contractId,
        annonceId: response.annonceId,
        annonceTitle: response.annonceTitle,
        tenant: response.tenant == null ? null : ContractParticipant.fromResponse(response.tenant!),
        kind: DeclarationKind.fromWire(response.kind?.name),
        dueIndexes: response.dueIndexes?.toList() ?? const [],
        amount: response.amount ?? 0,
        paidOn: response.paidOn?.toDateTime(),
        method: RentPaymentMethod.fromWire(response.method?.name),
        reference: _blank(response.reference),
        note: _blank(response.note),
        proofKeys: response.proofKeys?.toList() ?? const [],
        hasProof: response.hasProof ?? false,
        status: DeclarationStatus.fromWire(response.status?.name),
        contestReason: _blank(response.contestReason),
        declaredAt: response.declaredAt?.toLocal(),
        answeredAt: response.answeredAt?.toLocal(),
        canConfirm: response.canConfirm ?? false,
        canContest: response.canContest ?? false,
        invoiceId: response.invoiceId,
        receiptId: response.receiptId,
        receiptReady: response.receiptReady ?? false,
      );

  Map<String, dynamic> toCache() => {
        'id': id,
        'contractId': contractId,
        'annonceTitle': annonceTitle,
        'tenant': tenant?.displayName,
        'kind': kind.name,
        'dueIndexes': dueIndexes,
        'amount': amount,
        'paidOn': paidOn?.toIso8601String(),
        'method': method.name,
        'reference': reference,
        'hasProof': hasProof,
        'status': status.name,
        'contestReason': contestReason,
        'declaredAt': declaredAt?.toIso8601String(),
        'invoiceId': invoiceId,
        'receiptId': receiptId,
      };

  static Declaration? fromCache(Object? raw) {
    if (raw is! Map) return null;
    final json = Map<String, dynamic>.from(raw);
    final id = json['id'];
    if (id is! String) return null;
    return Declaration(
      id: id,
      contractId: json['contractId'] as String?,
      annonceTitle: json['annonceTitle'] as String?,
      tenant: json['tenant'] is String ? ContractParticipant(displayName: json['tenant'] as String) : null,
      kind: DeclarationKind.values.where((k) => k.name == json['kind']).firstOrNull ?? DeclarationKind.rent,
      dueIndexes: [for (final i in (json['dueIndexes'] as List? ?? const [])) if (i is int) i],
      amount: json['amount'] as int? ?? 0,
      paidOn: _date(json['paidOn']),
      method: RentPaymentMethod.values.where((m) => m.name == json['method']).firstOrNull ?? RentPaymentMethod.other,
      reference: json['reference'] as String?,
      hasProof: json['hasProof'] as bool? ?? false,
      status: DeclarationStatus.values.where((s) => s.name == json['status']).firstOrNull ?? DeclarationStatus.unknown,
      contestReason: json['contestReason'] as String?,
      declaredAt: _date(json['declaredAt']),
      invoiceId: json['invoiceId'] as String?,
      // Whether its PDF is ready is not kept: it is asked again online.
      receiptId: json['receiptId'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        contractId,
        annonceId,
        annonceTitle,
        tenant,
        kind,
        dueIndexes,
        amount,
        paidOn,
        method,
        reference,
        note,
        proofKeys,
        hasProof,
        status,
        contestReason,
        declaredAt,
        answeredAt,
        canConfirm,
        canContest,
        invoiceId,
        receiptId,
        receiptReady,
      ];
}

/// The space's totals — the server's sums, never the app's (RM-M30-08).
class HomeTotals extends Equatable {
  const HomeTotals({this.confirmedTotal = 0, this.declaredTotal = 0, this.contestedTotal = 0, this.lastConfirmedAt});

  final int confirmedTotal;

  /// What still waits for an answer.
  final int declaredTotal;
  final int contestedTotal;
  final DateTime? lastConfirmedAt;

  static HomeTotals fromResponse(HomeFinanceSummary response) => HomeTotals(
        confirmedTotal: response.confirmedTotal ?? 0,
        declaredTotal: response.declaredTotal ?? 0,
        contestedTotal: response.contestedTotal ?? 0,
        lastConfirmedAt: response.lastConfirmedAt?.toLocal(),
      );

  Map<String, dynamic> toCache() => {
        'confirmed': confirmedTotal,
        'declared': declaredTotal,
        'contested': contestedTotal,
        'lastConfirmedAt': lastConfirmedAt?.toIso8601String(),
      };

  static HomeTotals? fromCache(Object? raw) {
    if (raw is! Map) return null;
    final json = Map<String, dynamic>.from(raw);
    return HomeTotals(
      confirmedTotal: json['confirmed'] as int? ?? 0,
      declaredTotal: json['declared'] as int? ?? 0,
      contestedTotal: json['contested'] as int? ?? 0,
      lastConfirmedAt: _date(json['lastConfirmedAt']),
    );
  }

  @override
  List<Object?> get props => [confirmedTotal, declaredTotal, contestedTotal, lastConfirmedAt];
}

enum InvoiceKind { water, electricity, other }

/// Where an invoice stands — the server's word, lateness included.
enum InvoiceStatus {
  toPay,
  overdue,
  paid,
  cancelled,
  unknown;

  static InvoiceStatus fromWire(String? name) => switch (name) {
        'TO_PAY' => InvoiceStatus.toPay,
        'OVERDUE' => InvoiceStatus.overdue,
        'PAID' => InvoiceStatus.paid,
        'CANCELLED' => InvoiceStatus.cancelled,
        _ => InvoiceStatus.unknown,
      };

  /// Still to settle: it can be declared paid.
  bool get isOpen => this == InvoiceStatus.toPay || this == InvoiceStatus.overdue;
}

/// An invoice the landlord issued on a tenancy (CDC M24) — water, electricity,
/// or other. It outlives the tenancy: open, it can be declared paid even
/// once the space is read only (slice E). The tenant's read; issuing one is
/// the landlord's, behind the finance add-on.
class HomeInvoice extends Equatable {
  const HomeInvoice({
    required this.id,
    this.contractId,
    this.annonceTitle,
    this.kind = InvoiceKind.other,
    this.label,
    this.amount = 0,
    this.dueDate,
    this.status = InvoiceStatus.unknown,
    this.paidAt,
    this.paidViaDeclaration = false,
    this.confirmedTotal = 0,
    this.remaining = 0,
  });

  final String id;
  final String? contractId;
  final String? annonceTitle;
  final InvoiceKind kind;

  /// The landlord's own words: « Électricité — septembre ».
  final String? label;
  final int amount;
  final DateTime? dueDate;
  final InvoiceStatus status;
  final DateTime? paidAt;

  /// Settled by confirmed declarations (`paidVia: DECLARED`).
  final bool paidViaDeclaration;

  /// What the confirmed declarations cover, and what is left — the
  /// server's (§31.2); left is 0 once paid or cancelled.
  final int confirmedTotal;
  final int remaining;

  static HomeInvoice fromResponse(InvoiceResponse response) => HomeInvoice(
        id: response.id ?? '',
        contractId: response.contractId,
        annonceTitle: response.annonceTitle,
        kind: switch (response.kind?.name) {
          'WATER' => InvoiceKind.water,
          'ELECTRICITY' => InvoiceKind.electricity,
          _ => InvoiceKind.other,
        },
        label: _blank(response.label),
        amount: response.amount ?? 0,
        dueDate: response.dueDate?.toDateTime(),
        status: InvoiceStatus.fromWire(response.status?.name),
        paidAt: response.paidAt?.toLocal(),
        paidViaDeclaration: response.paidVia?.name == 'DECLARED',
        confirmedTotal: response.confirmedTotal ?? 0,
        remaining: response.remaining ?? 0,
      );

  Map<String, dynamic> toCache() => {
        'id': id,
        'contractId': contractId,
        'annonceTitle': annonceTitle,
        'kind': kind.name,
        'label': label,
        'amount': amount,
        'dueDate': dueDate?.toIso8601String(),
        'status': status.name,
        'paidAt': paidAt?.toIso8601String(),
        'declared': paidViaDeclaration,
        'confirmed': confirmedTotal,
        'remaining': remaining,
      };

  static HomeInvoice? fromCache(Object? raw) {
    if (raw is! Map) return null;
    final json = Map<String, dynamic>.from(raw);
    final id = json['id'];
    if (id is! String) return null;
    return HomeInvoice(
      id: id,
      contractId: json['contractId'] as String?,
      annonceTitle: json['annonceTitle'] as String?,
      kind: InvoiceKind.values.where((k) => k.name == json['kind']).firstOrNull ?? InvoiceKind.other,
      label: json['label'] as String?,
      amount: json['amount'] as int? ?? 0,
      dueDate: _date(json['dueDate']),
      status: InvoiceStatus.values.where((s) => s.name == json['status']).firstOrNull ?? InvoiceStatus.unknown,
      paidAt: _date(json['paidAt']),
      paidViaDeclaration: json['declared'] as bool? ?? false,
      confirmedTotal: json['confirmed'] as int? ?? 0,
      remaining: json['remaining'] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props =>
      [id, contractId, annonceTitle, kind, label, amount, dueDate, status, paidAt, paidViaDeclaration, confirmedTotal, remaining];
}

/// What a receipt is — its title on the PDF (§29.5): a full rent's
/// « Quittance de loyer », a partial one's receipt, the deposit's, an
/// invoice's.
enum ReceiptKind {
  rent,
  rentPartial,
  deposit,
  invoice,
  unknown;

  static ReceiptKind fromWire(String? name) => switch (name) {
        'RENT' => ReceiptKind.rent,
        'RENT_PARTIAL' => ReceiptKind.rentPartial,
        'DEPOSIT' => ReceiptKind.deposit,
        'INVOICE' => ReceiptKind.invoice,
        _ => ReceiptKind.unknown,
      };
}

/// One receipt of a space (slice D) — one per confirmed declaration, its
/// period and amount fixed at the confirmation. Its PDF is fetched from
/// the declaration it belongs to.
class HomeReceipt extends Equatable {
  const HomeReceipt({
    required this.id,
    required this.declarationId,
    this.contractId,
    this.kind = ReceiptKind.unknown,
    this.periodStart,
    this.periodEnd,
    this.amount = 0,
    this.issuedAt,
    this.ready = false,
  });

  final String id;
  final String declarationId;
  final String? contractId;
  final ReceiptKind kind;

  /// None for the deposit and an invoice.
  final DateTime? periodStart;
  final DateTime? periodEnd;
  final int amount;
  final DateTime? issuedAt;

  /// Its PDF is made.
  final bool ready;

  static HomeReceipt fromResponse(HomeReceiptResponse response) => HomeReceipt(
        id: response.id ?? '',
        declarationId: response.declarationId ?? '',
        contractId: response.contractId,
        kind: ReceiptKind.fromWire(response.kind?.name),
        periodStart: response.periodStart?.toDateTime(),
        periodEnd: response.periodEnd?.toDateTime(),
        amount: response.amount ?? 0,
        issuedAt: response.issuedAt?.toLocal(),
        ready: response.ready ?? false,
      );

  Map<String, dynamic> toCache() => {
        'id': id,
        'declarationId': declarationId,
        'contractId': contractId,
        'kind': kind.name,
        'from': periodStart?.toIso8601String(),
        'to': periodEnd?.toIso8601String(),
        'amount': amount,
        'issuedAt': issuedAt?.toIso8601String(),
        'ready': ready,
      };

  static HomeReceipt? fromCache(Object? raw) {
    if (raw is! Map) return null;
    final json = Map<String, dynamic>.from(raw);
    final id = json['id'];
    final declarationId = json['declarationId'];
    if (id is! String || declarationId is! String) return null;
    return HomeReceipt(
      id: id,
      declarationId: declarationId,
      contractId: json['contractId'] as String?,
      kind: ReceiptKind.values.where((k) => k.name == json['kind']).firstOrNull ?? ReceiptKind.unknown,
      periodStart: _date(json['from']),
      periodEnd: _date(json['to']),
      amount: json['amount'] as int? ?? 0,
      issuedAt: _date(json['issuedAt']),
      ready: json['ready'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [id, declarationId, contractId, kind, periodStart, periodEnd, amount, issuedAt, ready];
}

DateTime? _date(Object? raw) => raw is String ? DateTime.tryParse(raw) : null;

String? _blank(String? value) => (value == null || value.trim().isEmpty) ? null : value.trim();
