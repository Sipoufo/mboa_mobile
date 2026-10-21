/// Every surface whose availability depends on the account rather than on the
/// route table. Resolved by `AccessPolicy`.
enum FeatureKey {
  /// Listing management (CDC M10).
  mesBiens,

  /// The landlord's rents (CDC M30): his tenants' spaces and the payments
  /// they declare. No money moves through Mboa (RM-M30-06).
  loyers,

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
