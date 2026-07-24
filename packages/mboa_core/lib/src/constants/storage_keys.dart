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

  // Hive box names.
  static const String viewedBox = 'viewedBox';
  static const String searchBox = 'searchBox';
  static const String favoritesBox = 'favoritesBox';
  static const String pendingMessagesBox = 'pendingMessagesBox';

  static const List<String> allBoxes = [
    viewedBox,
    searchBox,
    favoritesBox,
    pendingMessagesBox,
  ];
}

/// Cache freshness windows for the offline-first strategy.
class CacheTtl {
  const CacheTtl._();

  static const Duration viewed = Duration(hours: 24);
  static const Duration search = Duration(hours: 1);
}
