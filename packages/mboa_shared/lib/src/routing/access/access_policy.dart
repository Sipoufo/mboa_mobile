import 'access_context.dart';
import 'access_decision.dart';
import 'feature_key.dart';
import 'subscription_tier.dart';

/// Single source of truth for "can this account use this feature?".
///
/// Pure function of ([FeatureKey], [AccessContext]) — no I/O, no singletons —
/// so the whole matrix is unit-testable. The UI turns an [AccessDenied] into
/// the right treatment: a blurred metric + upgrade CTA (RM-M14-02), a KYC
/// prompt, or a "bientôt disponible" state.
class AccessPolicy {
  const AccessPolicy();

  /// Minimum tier per M14 metric ("Disponible dès" column). Absent = available
  /// on every tier.
  static const _minimumTier = <FeatureKey, SubscriptionTier>{
    FeatureKey.statsConversion: SubscriptionTier.basicPlus,
    FeatureKey.statsVisites: SubscriptionTier.basicPlus,
    FeatureKey.statsPosition: SubscriptionTier.proPlus,
  };

  AccessDecision check(FeatureKey feature, AccessContext context) {
    switch (feature) {
      // Not built: no backend endpoints exist for either surface yet.
      case FeatureKey.portefeuille:
      case FeatureKey.mesAgents:
        return const AccessDenied(AccessRestriction.comingSoon);

      // Publishing and managing listings is a verified-prestataire surface.
      case FeatureKey.mesBiens:
        if (!context.role.isPrestataire) {
          return const AccessDenied(AccessRestriction.roleRequired);
        }
        return _requireApprovedKyc(context);

      // Metrics: free on every tier.
      case FeatureKey.statsVues:
      case FeatureKey.statsContacts:
      case FeatureKey.statsContrats:
        return const AccessGranted();

      // Metrics gated behind a tier.
      case FeatureKey.statsConversion:
      case FeatureKey.statsVisites:
      case FeatureKey.statsPosition:
        return _requireTier(feature, context);
    }
  }

  /// Convenience for widgets that only need the boolean.
  bool isAllowed(FeatureKey feature, AccessContext context) =>
      check(feature, context).isGranted;

  AccessDecision _requireApprovedKyc(AccessContext context) {
    if (context.isKycApproved) return const AccessGranted();
    if (context.isKycPending) {
      return const AccessDenied(AccessRestriction.kycPending);
    }
    return const AccessDenied(AccessRestriction.kycRequired);
  }

  AccessDecision _requireTier(FeatureKey feature, AccessContext context) {
    final required = _minimumTier[feature];
    if (required == null || context.tier.isAtLeast(required)) {
      return const AccessGranted();
    }
    return AccessDenied(
      AccessRestriction.tierRequired,
      requiredTier: required,
    );
  }
}
