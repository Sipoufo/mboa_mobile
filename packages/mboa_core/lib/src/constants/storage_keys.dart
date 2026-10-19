/// Centralized keys for secure storage and Hive boxes.
///
/// Cache policy (per CLAUDE.md Offline Strategy):
///   viewedBox          — last 20 viewed listings   (24h)
///   searchBox          — last 20 search results     (1h)
///   favoritesBox       — favorites                  (permanent)
///   pendingMessagesBox — unsent messages            (until confirmed)
///
/// Every box is either [deviceScopedBoxes] or [accountScopedBoxes] — a new
/// box is only opened once it is in one of the two, so where it stands on
/// sign-out is decided when it is added, not after it has leaked.
class StorageKeys {
  const StorageKeys._();

  // flutter_secure_storage keys — the ONLY place JWT tokens ever live.
  static const String accessToken = 'mboa.access_token';
  static const String refreshToken = 'mboa.refresh_token';
  // Token expiries (epoch millis), persisted so the session check can reject a
  // definitively-expired refresh token locally before any network call.
  static const String accessTokenExpiresAt = 'mboa.access_token_expires_at';
  static const String refreshTokenExpiresAt = 'mboa.refresh_token_expires_at';

  // Hive box names.
  static const String viewedBox = 'viewedBox';
  static const String searchBox = 'searchBox';
  static const String favoritesBox = 'favoritesBox';
  static const String pendingMessagesBox = 'pendingMessagesBox';
  // App preferences (permanent): selected language, etc.
  static const String appSettingsBox = 'appSettings';
  // Subscription payment handles (M13). `paymentId` is returned once by
  // `POST /subscriptions` and is the only key to the receipt, so it is kept
  // locally until a payments-list endpoint exists.
  static const String subscriptionBox = 'subscriptionBox';
  // Upcoming visits (M07). A tenant checking the time of a visit from a taxi
  // with no line is the case this exists for.
  static const String visitsBox = 'visitsBox';
  // Prestataire dashboard counters (M14) — cheap to refetch, cached so the Pro
  // home renders instantly and works offline.
  static const String dashboardBox = 'dashboardBox';
  // Saved searches (M04, RM-M04-07) — at most three, replaced on every load.
  // Read-only offline: they belong to an account, so they are cleared at
  // sign-out, and nothing is changed while the network is gone.
  static const String savedSearchesBox = 'savedSearchesBox';
  // The tenant's reservation requests (M29) — read-only offline, an
  // account's own, so emptied at sign-out.
  static const String reservationsBox = 'reservationsBox';

  /// Boxes that belong to the **device**, kept across a sign-out on purpose.
  ///
  /// All three are written for a visitor too, and none holds anything an
  /// account owns: the last search is restored at launch signed in or not
  /// (RM-M04-02), a viewed fiche is public text with the server's verdicts
  /// (`canContact`, `canPlanVisit`) stripped before it is stored, and the
  /// settings are the language and the install id.
  static const List<String> deviceScopedBoxes = [
    viewedBox,
    searchBox,
    appSettingsBox,
  ];

  /// Boxes that belong to the **signed-in account**, emptied when a session
  /// ends and again when the next one begins (`HiveCache.clearAccountScoped`).
  ///
  /// Without that, the next person to sign in on the device reads the last
  /// one's visits offline. `favoritesBox` and `subscriptionBox` have no writer
  /// today (favourites are server-side, payment handles moved to the API), but
  /// an older build may have left data in them, and whatever lands there next
  /// is an account's.
  ///
  /// **Unsent messages are dropped with the account.** They are its private
  /// text and can only go out under its tokens, which are gone. Kept, they
  /// would wait for the next account to sign in, be refused by the server
  /// (not a participant), and — because `flushQueue` stops at the first
  /// failure to keep messages in order — jam that account's own queue behind
  /// them. Signing out with no line therefore loses what was typed offline.
  static const List<String> accountScopedBoxes = [
    favoritesBox,
    pendingMessagesBox,
    dashboardBox,
    subscriptionBox,
    visitsBox,
    savedSearchesBox,
    reservationsBox,
  ];

  static const List<String> allBoxes = [
    ...deviceScopedBoxes,
    ...accountScopedBoxes,
  ];
}

/// Cache freshness windows for the offline-first strategy.
class CacheTtl {
  const CacheTtl._();

  static const Duration viewed = Duration(hours: 24);
  static const Duration search = Duration(hours: 1);
  /// RM-M14-01 wants near-real-time stats, so keep this short — the cache is
  /// for instant first paint and offline, not for avoiding the fetch.
  static const Duration dashboard = Duration(minutes: 5);

  /// M07 — a booked visit barely changes, but a cancellation by the visitor
  /// (CE-M07-02) must not linger on screen for long.
  static const Duration visits = Duration(hours: 1);
}
