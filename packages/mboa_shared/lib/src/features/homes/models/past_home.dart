import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../listings/models/listing_detail.dart';
import 'home.dart';

/// One payment of an ended tenancy, as the expenses list it (CDC M31).
class PastExpense extends Equatable {
  const PastExpense({
    required this.declarationId,
    this.kind = DeclarationKind.rent,
    this.label,
    this.amount = 0,
    this.paidOn,
    this.status = DeclarationStatus.unknown,
    this.receiptId,
    this.receiptReady = false,
  });

  final String declarationId;
  final DeclarationKind kind;

  /// Ready to show: « Loyer du 18 octobre 2026 au 17 novembre 2026 ».
  final String? label;
  final int amount;
  final DateTime? paidOn;
  final DeclarationStatus status;
  final String? receiptId;
  final bool receiptReady;

  static PastExpense fromResponse(PastPayment response) => PastExpense(
        declarationId: response.declarationId ?? '',
        kind: DeclarationKind.fromWire(response.kind?.name),
        label: response.label,
        amount: response.amount ?? 0,
        paidOn: response.paidOn?.toDateTime(),
        status: DeclarationStatus.fromWire(response.status?.name),
        receiptId: response.receiptId,
        receiptReady: response.receiptReady ?? false,
      );

  Map<String, dynamic> toCache() => {
        'id': declarationId,
        'kind': kind.name,
        'label': label,
        'amount': amount,
        'paidOn': paidOn?.toIso8601String(),
        'status': status.name,
        'receiptId': receiptId,
      };

  static PastExpense? fromCache(Object? raw) {
    if (raw is! Map || raw['id'] is! String) return null;
    return PastExpense(
      declarationId: raw['id'] as String,
      kind: DeclarationKind.values.where((k) => k.name == raw['kind']).firstOrNull ?? DeclarationKind.rent,
      label: raw['label'] as String?,
      amount: raw['amount'] as int? ?? 0,
      paidOn: raw['paidOn'] is String ? DateTime.tryParse(raw['paidOn'] as String) : null,
      status: DeclarationStatus.values.where((s) => s.name == raw['status']).firstOrNull ?? DeclarationStatus.unknown,
      receiptId: raw['receiptId'] as String?,
    );
  }

  @override
  List<Object?> get props => [declarationId, kind, label, amount, paidOn, status, receiptId, receiptReady];
}

/// The tenant's own review of an ended tenancy (M27), as this page can act
/// on it: write one, change it until [editableUntil], or read it.
class MyPastReview extends Equatable {
  const MyPastReview({this.reviewId, this.rating, this.canWrite = false, this.canEdit = false, this.editableUntil});

  final String? reviewId;
  final int? rating;
  final bool canWrite;
  final bool canEdit;
  final DateTime? editableUntil;

  @override
  List<Object?> get props => [reviewId, rating, canWrite, canEdit, editableUntil];
}

/// « Mes anciens logements » (CDC M31): an ended tenancy as the tenant keeps
/// it — the lease as signed (RM-M31-02), what was paid (confirmed only in
/// the total, RM-M31-03), the property's rating today (RM-M31-04), the
/// tenant's review (RM-M31-05), the requests and the photos (RM-M31-06).
/// Nothing new is stored: M08, M27 and M30, read together.
class PastHome extends Equatable {
  const PastHome({
    required this.home,
    this.listingOnline = false,
    this.verificationCode,
    this.confirmedTotal = 0,
    this.byYear = const [],
    this.confirmed = const [],
    this.notConfirmed = const [],
    this.requestCount = 0,
    this.openRequestCount = 0,
    this.rating = const PropertyRatingSummary(),
    this.myReview = const MyPastReview(),
  });

  final Home home;

  /// The listing's page is still up: « Voir l'annonce ».
  final bool listingOnline;

  /// The contract's code, to check it.
  final String? verificationCode;

  /// The sum of the confirmed payments — the server's (CA-M31-02).
  final int confirmedTotal;

  /// Newest year first, as the server lists them.
  final List<(int year, int total)> byYear;

  /// Newest first, each with its receipt.
  final List<PastExpense> confirmed;

  /// Declared, unanswered or contested — never in the total.
  final List<PastExpense> notConfirmed;
  final int requestCount;
  final int openRequestCount;
  final PropertyRatingSummary rating;
  final MyPastReview myReview;

  static PastHome fromResponse(PastHomeResponse response) {
    final expenses = response.expenses;
    final review = response.myReview;
    return PastHome(
      home: Home.fromResponse(response.home ?? HomeSummary()),
      listingOnline: response.listingOnline ?? false,
      verificationCode: response.verificationCode,
      confirmedTotal: expenses?.confirmedTotal ?? 0,
      byYear: [for (final y in expenses?.byYear?.toList() ?? const <YearTotal>[]) (y.year ?? 0, y.total ?? 0)],
      confirmed: [for (final p in expenses?.confirmed?.toList() ?? const <PastPayment>[]) PastExpense.fromResponse(p)],
      notConfirmed: [
        for (final p in expenses?.notConfirmed?.toList() ?? const <PastPayment>[]) PastExpense.fromResponse(p),
      ],
      requestCount: response.requestCount ?? 0,
      openRequestCount: response.openRequestCount ?? 0,
      rating: response.rating == null
          ? const PropertyRatingSummary()
          : PropertyRatingSummary.fromResponse(response.rating!),
      myReview: MyPastReview(
        reviewId: review?.reviewId,
        rating: review?.rating,
        canWrite: review?.canWrite ?? false,
        canEdit: review?.canEdit ?? false,
        editableUntil: review?.editableUntil?.toLocal(),
      ),
    );
  }

  /// For the offline copy: what the sheet reads, without what must be asked
  /// again (whether a receipt is ready, what may be done to the review).
  Map<String, dynamic> toCache() => {
        'home': home.toCache(),
        'listingOnline': listingOnline,
        'code': verificationCode,
        'total': confirmedTotal,
        'byYear': [for (final (year, total) in byYear) [year, total]],
        'confirmed': [for (final p in confirmed) p.toCache()],
        'notConfirmed': [for (final p in notConfirmed) p.toCache()],
        'requests': requestCount,
        'openRequests': openRequestCount,
        'rating': [rating.average, rating.reviewCount],
        'myRating': myReview.rating,
      };

  static PastHome? fromCache(Object? raw) {
    if (raw is! Map) return null;
    final home = Home.fromCache(raw['home']);
    if (home == null) return null;
    final rating = raw['rating'];
    return PastHome(
      home: home,
      listingOnline: raw['listingOnline'] as bool? ?? false,
      verificationCode: raw['code'] as String?,
      confirmedTotal: raw['total'] as int? ?? 0,
      byYear: [
        for (final y in (raw['byYear'] as List? ?? const []))
          if (y is List && y.length == 2 && y[0] is int && y[1] is int) (y[0] as int, y[1] as int),
      ],
      confirmed: [for (final p in (raw['confirmed'] as List? ?? const [])) ?PastExpense.fromCache(p)],
      notConfirmed: [for (final p in (raw['notConfirmed'] as List? ?? const [])) ?PastExpense.fromCache(p)],
      requestCount: raw['requests'] as int? ?? 0,
      openRequestCount: raw['openRequests'] as int? ?? 0,
      rating: rating is List && rating.length == 2
          ? PropertyRatingSummary(average: (rating[0] as num?)?.toDouble(), reviewCount: rating[1] as int? ?? 0)
          : const PropertyRatingSummary(),
      myReview: MyPastReview(rating: raw['myRating'] as int?),
    );
  }

  @override
  List<Object?> get props => [
        home,
        listingOnline,
        verificationCode,
        confirmedTotal,
        byYear,
        confirmed,
        notConfirmed,
        requestCount,
        openRequestCount,
        rating,
        myReview,
      ];
}
