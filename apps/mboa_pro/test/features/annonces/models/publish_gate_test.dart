import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/annonces/models/publish_gate.dart';
import 'package:mboa_shared/mboa_shared.dart';

void main() {
  const gate = PublishGate();

  PublishDecision check({
    bool profileComplete = true,
    int photoCount = 3,
    int activeCount = 0,
    int? activeListingLimit = 1,
  }) =>
      gate.check(
        profileComplete: profileComplete,
        photoCount: photoCount,
        activeCount: activeCount,
        activeListingLimit: activeListingLimit,
      );

  test('allows a complete listing within the limit', () {
    expect(check().isAllowed, isTrue);
  });

  test('RM-M10-01 — an incomplete profile blocks publishing', () {
    expect(
      check(profileComplete: false),
      const PublishDecision.blocked(PublishBlocker.incompleteProfile),
    );
  });

  test('CE-M10-03 — fewer than three photos blocks publishing', () {
    expect(
      check(photoCount: 2),
      const PublishDecision.blocked(PublishBlocker.notEnoughPhotos),
    );
    expect(check(photoCount: 3).isAllowed, isTrue);
  });

  group('RM-M10-02 / CE-M10-02 — the active-listing limit', () {
    test('blocks a Gratuit second listing and reports the limit', () {
      expect(
        check(activeCount: 1, activeListingLimit: 1),
        const PublishDecision.blocked(
          PublishBlocker.listingLimitReached,
          limit: 1,
        ),
      );
    });

    test('allows up to the limit', () {
      expect(check(activeCount: 2, activeListingLimit: 3).isAllowed, isTrue);
    });

    test('treats a null limit as unlimited (Pro+)', () {
      expect(
        check(activeCount: 99, activeListingLimit: null).isAllowed,
        isTrue,
      );
    });
  });

  test('reports the profile blocker first — it is the one they can fix', () {
    // Everything is wrong at once; the message must not be arbitrary.
    expect(
      check(profileComplete: false, photoCount: 0, activeCount: 5),
      const PublishDecision.blocked(PublishBlocker.incompleteProfile),
    );
  });

  group('nextTier', () {
    test('points one tier up for the upsell', () {
      expect(gate.nextTier(SubscriptionTier.gratuit), SubscriptionTier.basicPlus);
      expect(gate.nextTier(SubscriptionTier.basicPlus), SubscriptionTier.pro);
      expect(gate.nextTier(SubscriptionTier.pro), SubscriptionTier.proPlus);
    });

    test('has nothing to sell above Pro+', () {
      expect(gate.nextTier(SubscriptionTier.proPlus), isNull);
    });
  });
}
