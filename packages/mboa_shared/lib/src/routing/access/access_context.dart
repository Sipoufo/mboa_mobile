import 'package:equatable/equatable.dart';

import '../../features/profile/models/account_role.dart';
import 'subscription_tier.dart';

/// The account facts `AccessPolicy` decides from.
///
/// Deliberately expressed as plain flags rather than depending on the apps'
/// KYC/profile types — that keeps the policy a pure, trivially testable
/// function and leaves each app free to assemble the context from whatever
/// cubit already holds the data.
class AccessContext extends Equatable {
  const AccessContext({
    required this.role,
    this.isKycApproved = false,
    this.isKycPending = false,
    this.tier = SubscriptionTier.gratuit,
  });

  /// Context for a session whose profile/KYC state has not loaded yet.
  /// Everything gated is denied until we know better.
  const AccessContext.unknown()
      : role = AccountRole.user,
        isKycApproved = false,
        isKycPending = false,
        tier = SubscriptionTier.gratuit;

  final AccountRole role;
  final bool isKycApproved;
  final bool isKycPending;
  final SubscriptionTier tier;

  @override
  List<Object?> get props => [role, isKycApproved, isKycPending, tier];
}
