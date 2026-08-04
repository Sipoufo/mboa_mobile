/// Every surface whose availability depends on the account rather than on the
/// route table. Resolved by `AccessPolicy`.
enum FeatureKey {
  /// Listing management (CDC M10).
  mesBiens,

  /// Wallet / transactions. No API and no CDC module yet — coming soon.
  portefeuille,

  /// Agent delegation (CDC M15/M16). No agent endpoints yet — coming soon.
  mesAgents,

  // Dashboard metrics (CDC M14, "Disponible dès" column).
  statsVues,
  statsContacts,
  statsConversion,
  statsVisites,
  statsContrats,
  statsPosition,
}
