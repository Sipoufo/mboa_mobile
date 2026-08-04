import 'package:equatable/equatable.dart';

import 'subscription_tier.dart';

/// Why a feature is unavailable. Drives which treatment the UI applies —
/// blurred metric + upgrade CTA, a KYC prompt, or a "bientôt disponible" state.
enum AccessRestriction {
  /// KYC has never been submitted, or was rejected (CDC M01bis).
  kycRequired,

  /// KYC is submitted and awaiting review — the user need only wait.
  kycPending,

  /// The account's subscription tier is too low (RM-M14-02).
  tierRequired,

  /// Wrong account role (e.g. an agent reaching a prestataire surface).
  roleRequired,

  /// Specced but not built — no backend yet.
  comingSoon,
}

/// Outcome of an `AccessPolicy` check.
sealed class AccessDecision extends Equatable {
  const AccessDecision();

  bool get isGranted => this is AccessGranted;

  @override
  List<Object?> get props => [];
}

/// The feature is usable.
class AccessGranted extends AccessDecision {
  const AccessGranted();
}

/// The feature is blocked, for [restriction].
///
/// [requiredTier] is set only for [AccessRestriction.tierRequired], and names
/// the tier the upgrade CTA should point at.
class AccessDenied extends AccessDecision {
  const AccessDenied(this.restriction, {this.requiredTier});

  final AccessRestriction restriction;
  final SubscriptionTier? requiredTier;

  @override
  List<Object?> get props => [restriction, requiredTier];
}
