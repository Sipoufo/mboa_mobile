import 'package:hive_ce_flutter/hive_flutter.dart';

import '../constants/storage_keys.dart';

/// A tiny wrapper over Hive implementing the offline-first cache policy.
///
/// Entries are stored as `{ 'ts': <epochMs>, 'data': <json> }` so a TTL can be
/// enforced on read. Callers check the cache first, fire the network request in
/// the background, then update the cache — never a blank screen when offline.
class HiveCache {
  /// Opens every box declared in [StorageKeys.allBoxes]. Call once at startup
  /// after `Hive.initFlutter()`.
  static Future<void> init() async {
    await Hive.initFlutter();
    for (final name in StorageKeys.allBoxes) {
      if (!Hive.isBoxOpen(name)) {
        await Hive.openBox<Map<dynamic, dynamic>>(name);
      }
    }
  }

  Box<Map<dynamic, dynamic>> _box(String name) =>
      Hive.box<Map<dynamic, dynamic>>(name);

  Future<void> put(String boxName, String key, Map<String, dynamic> data) {
    return _box(boxName).put(key, {
      'ts': DateTime.now().millisecondsSinceEpoch,
      'data': data,
    });
  }

  /// Returns the cached payload, or `null` when absent or older than [ttl].
  Map<String, dynamic>? get(String boxName, String key, {Duration? ttl}) {
    final entry = _box(boxName).get(key);
    if (entry == null) return null;

    if (ttl != null) {
      final ts = entry['ts'] as int? ?? 0;
      final age = DateTime.now().millisecondsSinceEpoch - ts;
      if (age > ttl.inMilliseconds) return null;
    }
    final data = entry['data'];
    return data == null ? null : Map<String, dynamic>.from(data as Map);
  }

  Future<void> delete(String boxName, String key) => _box(boxName).delete(key);

  Future<void> clearBox(String boxName) => _box(boxName).clear();
}
