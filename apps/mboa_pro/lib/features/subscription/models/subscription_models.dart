import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Maps the generated tier enums onto the shared [SubscriptionTier] that
/// `AccessPolicy` gates on. Kept here rather than in `mboa_shared` so the
/// policy stays free of generated types.
extension SubscriptionTierMapping on SubscriptionTier {
  static SubscriptionTier fromResponse(SubscriptionResponseTierEnum? value) =>
      switch (value) {
        SubscriptionResponseTierEnum.BASIC_PLUS => SubscriptionTier.basicPlus,
        SubscriptionResponseTierEnum.PRO => SubscriptionTier.pro,
        SubscriptionResponseTierEnum.PRO_PLUS => SubscriptionTier.proPlus,
        // FREE, null and anything unrecognised fall back to the safest tier.
        _ => SubscriptionTier.gratuit,
      };

  static SubscriptionTier fromTierInfo(TierInfoTierEnum? value) =>
      switch (value) {
        TierInfoTierEnum.BASIC_PLUS => SubscriptionTier.basicPlus,
        TierInfoTierEnum.PRO => SubscriptionTier.pro,
        TierInfoTierEnum.PRO_PLUS => SubscriptionTier.proPlus,
        _ => SubscriptionTier.gratuit,
      };

  SubscribeRequestTierEnum get asRequest => switch (this) {
        SubscriptionTier.gratuit => SubscribeRequestTierEnum.FREE,
        SubscriptionTier.basicPlus => SubscribeRequestTierEnum.BASIC_PLUS,
        SubscriptionTier.pro => SubscribeRequestTierEnum.PRO,
        SubscriptionTier.proPlus => SubscribeRequestTierEnum.PRO_PLUS,
      };
}

/// The prestataire's current plan (CDC M13).
class SubscriptionPlan extends Equatable {
  const SubscriptionPlan({
    required this.tier,
    this.periodEnd,
    this.activeListingLimit,
  });

  const SubscriptionPlan.free() : this(tier: SubscriptionTier.gratuit);

  final SubscriptionTier tier;

  /// When the current period lapses. Null on the free tier — it doesn't expire.
  final DateTime? periodEnd;

  /// Listings the prestataire may keep active. Drives M10's publish guard.
  final int? activeListingLimit;

  static SubscriptionPlan fromResponse(SubscriptionResponse response) =>
      SubscriptionPlan(
        tier: SubscriptionTierMapping.fromResponse(response.tier),
        periodEnd: response.periodEnd,
        activeListingLimit: response.activeListingLimit,
      );

  /// RM-M13-02: a lapsed period drops the account back to Gratuit at J+1. The
  /// backend does this at midnight; reading it locally too means the UI doesn't
  /// promise a tier that has already run out.
  bool get hasLapsed =>
      periodEnd != null && !periodEnd!.isAfter(DateTime.now());

  SubscriptionTier get effectiveTier =>
      hasLapsed ? SubscriptionTier.gratuit : tier;

  @override
  List<Object?> get props => [tier, periodEnd, activeListingLimit];
}

/// A purchasable plan from `GET /subscriptions/tiers`.
class TierOption extends Equatable {
  const TierOption({
    required this.tier,
    this.rank,
    this.monthlyPrice,
    this.activeListingLimit,
    this.residenceUnitAllowance,
  });

  final SubscriptionTier tier;
  final int? rank;

  /// FCFA per month. 0 on the free tier.
  final int? monthlyPrice;
  final int? activeListingLimit;
  final int? residenceUnitAllowance;

  static TierOption fromResponse(TierInfo info) => TierOption(
        tier: SubscriptionTierMapping.fromTierInfo(info.tier),
        rank: info.rank,
        monthlyPrice: info.monthlyPrice,
        activeListingLimit: info.activeListingLimit,
        residenceUnitAllowance: info.residenceUnitAllowance,
      );

  @override
  List<Object?> get props =>
      [tier, rank, monthlyPrice, activeListingLimit, residenceUnitAllowance];
}

/// Mobile Money providers (CDC M13 — MVP payment methods).
enum PaymentMethod {
  mtnMomo,
  orangeMoney;

  SubscribeRequestMethodEnum get asRequest => switch (this) {
        PaymentMethod.mtnMomo => SubscribeRequestMethodEnum.MTN_MOMO,
        PaymentMethod.orangeMoney => SubscribeRequestMethodEnum.ORANGE_MONEY,
      };
}

enum PaymentStatus { pending, confirmed, failed, cancelled }

/// One payment, from initiation or from the server's history.
class PaymentAttempt extends Equatable {
  const PaymentAttempt({
    required this.paymentId,
    required this.tier,
    this.providerRef,
    this.amount,
    this.status = PaymentStatus.pending,
    this.initiatedAt,
    this.method,
    this.hasReceipt = false,
  });

  final String paymentId;
  final SubscriptionTier tier;

  /// Provider-side reference, shown so support can trace a payment.
  final String? providerRef;
  final int? amount;
  final PaymentStatus status;
  final DateTime? initiatedAt;
  final PaymentMethod? method;

  /// Whether `GET /payments/{id}/receipt` will succeed — lets the UI show or
  /// hide the download without a probe call.
  final bool hasReceipt;

  static PaymentAttempt fromResponse(
    PaymentInitiatedResponse response, {
    required SubscriptionTier tier,
  }) =>
      PaymentAttempt(
        paymentId: response.paymentId ?? '',
        tier: tier,
        providerRef: response.providerRef,
        amount: response.amount,
        status: switch (response.status) {
          PaymentInitiatedResponseStatusEnum.CONFIRMED =>
            PaymentStatus.confirmed,
          PaymentInitiatedResponseStatusEnum.FAILED => PaymentStatus.failed,
          PaymentInitiatedResponseStatusEnum.CANCELLED =>
            PaymentStatus.cancelled,
          _ => PaymentStatus.pending,
        },
        initiatedAt: DateTime.now(),
      );

  /// From `GET /subscriptions/payments` — the server's own record, which
  /// replaced the device-local cache.
  static PaymentAttempt fromSummary(PaymentSummary summary) => PaymentAttempt(
        paymentId: summary.paymentId ?? '',
        tier: switch (summary.tier) {
          PaymentSummaryTierEnum.BASIC_PLUS => SubscriptionTier.basicPlus,
          PaymentSummaryTierEnum.PRO => SubscriptionTier.pro,
          PaymentSummaryTierEnum.PRO_PLUS => SubscriptionTier.proPlus,
          _ => SubscriptionTier.gratuit,
        },
        amount: summary.amount,
        status: switch (summary.status) {
          PaymentSummaryStatusEnum.CONFIRMED => PaymentStatus.confirmed,
          PaymentSummaryStatusEnum.FAILED => PaymentStatus.failed,
          PaymentSummaryStatusEnum.CANCELLED => PaymentStatus.cancelled,
          _ => PaymentStatus.pending,
        },
        method: switch (summary.method) {
          PaymentSummaryMethodEnum.ORANGE_MONEY => PaymentMethod.orangeMoney,
          _ => PaymentMethod.mtnMomo,
        },
        hasReceipt: summary.hasReceipt ?? false,
        initiatedAt: summary.paidAt ?? summary.createdAt,
      );

  @override
  List<Object?> get props =>
      [paymentId, tier, providerRef, amount, status, initiatedAt, hasReceipt];
}
