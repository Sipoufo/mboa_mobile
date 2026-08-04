import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';

void main() {
  const policy = AccessPolicy();

  AccessContext prestataire({
    bool approved = true,
    bool pending = false,
    SubscriptionTier tier = SubscriptionTier.gratuit,
  }) =>
      AccessContext(
        role: AccountRole.prestataire,
        isKycApproved: approved,
        isKycPending: pending,
        tier: tier,
      );

  group('coming-soon surfaces', () {
    test('portefeuille and mes agents are denied on every tier', () {
      final context = prestataire(tier: SubscriptionTier.proPlus);

      expect(
        policy.check(FeatureKey.portefeuille, context),
        const AccessDenied(AccessRestriction.comingSoon),
      );
      expect(
        policy.check(FeatureKey.mesAgents, context),
        const AccessDenied(AccessRestriction.comingSoon),
      );
    });
  });

  group('mesBiens', () {
    test('granted for a KYC-approved prestataire', () {
      expect(policy.check(FeatureKey.mesBiens, prestataire()).isGranted, isTrue);
    });

    test('denied with kycRequired when KYC was never submitted', () {
      expect(
        policy.check(FeatureKey.mesBiens, prestataire(approved: false)),
        const AccessDenied(AccessRestriction.kycRequired),
      );
    });

    test('denied with kycPending while KYC is under review', () {
      expect(
        policy.check(
          FeatureKey.mesBiens,
          prestataire(approved: false, pending: true),
        ),
        const AccessDenied(AccessRestriction.kycPending),
      );
    });

    test('denied with roleRequired for a non-prestataire, KYC notwithstanding', () {
      const agent = AccessContext(
        role: AccountRole.agent,
        isKycApproved: true,
      );

      expect(
        policy.check(FeatureKey.mesBiens, agent),
        const AccessDenied(AccessRestriction.roleRequired),
      );
    });

    test('denied for an unknown (not yet loaded) context', () {
      expect(
        policy.check(FeatureKey.mesBiens, const AccessContext.unknown()).isGranted,
        isFalse,
      );
    });
  });

  group('M14 metrics — "Disponible dès"', () {
    test('vues, contacts and contrats are free on Gratuit', () {
      final free = prestataire(tier: SubscriptionTier.gratuit);

      expect(policy.isAllowed(FeatureKey.statsVues, free), isTrue);
      expect(policy.isAllowed(FeatureKey.statsContacts, free), isTrue);
      expect(policy.isAllowed(FeatureKey.statsContrats, free), isTrue);
    });

    test('conversion and visites need Basic+', () {
      final gratuit = prestataire(tier: SubscriptionTier.gratuit);
      final basic = prestataire(tier: SubscriptionTier.basicPlus);

      expect(
        policy.check(FeatureKey.statsConversion, gratuit),
        const AccessDenied(
          AccessRestriction.tierRequired,
          requiredTier: SubscriptionTier.basicPlus,
        ),
      );
      expect(policy.isAllowed(FeatureKey.statsConversion, basic), isTrue);
      expect(policy.isAllowed(FeatureKey.statsVisites, basic), isTrue);
    });

    test('position moyenne needs Pro+ — Pro is not enough', () {
      expect(
        policy.check(
          FeatureKey.statsPosition,
          prestataire(tier: SubscriptionTier.pro),
        ),
        const AccessDenied(
          AccessRestriction.tierRequired,
          requiredTier: SubscriptionTier.proPlus,
        ),
      );
      expect(
        policy.isAllowed(
          FeatureKey.statsPosition,
          prestataire(tier: SubscriptionTier.proPlus),
        ),
        isTrue,
      );
    });

    test('a higher tier keeps access to lower-tier metrics', () {
      final proPlus = prestataire(tier: SubscriptionTier.proPlus);

      for (final metric in [
        FeatureKey.statsVues,
        FeatureKey.statsContacts,
        FeatureKey.statsContrats,
        FeatureKey.statsConversion,
        FeatureKey.statsVisites,
        FeatureKey.statsPosition,
      ]) {
        expect(policy.isAllowed(metric, proPlus), isTrue, reason: '$metric');
      }
    });
  });

  test('SubscriptionTier.isAtLeast ranks tiers in CDC order', () {
    expect(SubscriptionTier.proPlus.isAtLeast(SubscriptionTier.gratuit), isTrue);
    expect(SubscriptionTier.gratuit.isAtLeast(SubscriptionTier.basicPlus), isFalse);
    expect(SubscriptionTier.pro.isAtLeast(SubscriptionTier.pro), isTrue);
  });
}
