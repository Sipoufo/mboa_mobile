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
}
