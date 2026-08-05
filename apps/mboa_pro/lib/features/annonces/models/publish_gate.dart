import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Why publishing is blocked.
enum PublishBlocker {
  /// RM-M10-01 — the prestataire profile needs a photo, a type and a city.
  incompleteProfile,

  /// CE-M10-03 — fewer than the three required photos.
  notEnoughPhotos,

  /// RM-M10-02 / CE-M10-02 — the tier's active-listing limit is reached.
  listingLimitReached,
}

class PublishDecision extends Equatable {
  const PublishDecision.allowed()
      : blocker = null,
        limit = null;

  const PublishDecision.blocked(this.blocker, {this.limit});

  final PublishBlocker? blocker;

  /// The limit that was hit, for the CE-M10-02 copy.
  final int? limit;

  bool get isAllowed => blocker == null;

  @override
  List<Object?> get props => [blocker, limit];
}

/// Decides whether a listing may be published.
///
/// A pure function of facts the caller already has, so the rule is testable in
/// isolation and no bloc has to reach into another. The UI assembles the inputs
/// from `ProProfileBloc`, `SubscriptionBloc` and `AnnoncesBloc`.
class PublishGate {
  const PublishGate();

  PublishDecision check({
    required bool profileComplete,
    required int photoCount,
    required int activeCount,
    required int? activeListingLimit,
    int minPhotos = 3,
  }) {
    if (!profileComplete) {
      return const PublishDecision.blocked(PublishBlocker.incompleteProfile);
    }
    if (photoCount < minPhotos) {
      return const PublishDecision.blocked(PublishBlocker.notEnoughPhotos);
    }
    // A null limit means unlimited (Pro+).
    if (activeListingLimit != null && activeCount >= activeListingLimit) {
      return PublishDecision.blocked(
        PublishBlocker.listingLimitReached,
        limit: activeListingLimit,
      );
    }
    return const PublishDecision.allowed();
  }

  /// The tier to upsell to when the limit is hit — the next one up.
  SubscriptionTier? nextTier(SubscriptionTier current) => switch (current) {
        SubscriptionTier.gratuit => SubscriptionTier.basicPlus,
        SubscriptionTier.basicPlus => SubscriptionTier.pro,
        SubscriptionTier.pro => SubscriptionTier.proPlus,
        SubscriptionTier.proPlus => null,
      };
}
