/// Prestataire subscription tiers (CDC M13). Declared in ascending order so
/// [isAtLeast] can compare by rank.
enum SubscriptionTier {
  gratuit,
  basicPlus,
  pro,
  proPlus;

  /// Whether this tier is [other] or better.
  bool isAtLeast(SubscriptionTier other) => index >= other.index;

  /// Display label used by the upgrade CTA (CA-M14-02).
  String get label => switch (this) {
        SubscriptionTier.gratuit => 'Gratuit',
        SubscriptionTier.basicPlus => 'Basic+',
        SubscriptionTier.pro => 'Pro',
        SubscriptionTier.proPlus => 'Pro+',
      };
}
