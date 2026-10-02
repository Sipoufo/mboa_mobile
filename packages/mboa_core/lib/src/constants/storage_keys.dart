/// Centralized keys for secure storage and Hive boxes.
///
/// Cache policy (per CLAUDE.md Offline Strategy):
///   viewedBox          — last 20 viewed listings   (24h)
///   searchBox          — last 20 search results     (1h)
///   favoritesBox       — favorites                  (permanent)
///   pendingMessagesBox — unsent messages            (until confirmed)
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

  static const List<String> allBoxes = [
    viewedBox,
    searchBox,
    favoritesBox,
    pendingMessagesBox,
    appSettingsBox,
    dashboardBox,
    subscriptionBox,
    visitsBox,
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
