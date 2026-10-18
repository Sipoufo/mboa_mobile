import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';

void main() {
  late Directory dir;
  late HiveCache cache;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('hive_cache_test');
    await HiveCache.initAt(dir.path);
    cache = HiveCache();
  });

  tearDown(() async {
    await HiveCache.close();
    await dir.delete(recursive: true);
  });

  test('every box is either the device\'s or the account\'s, never both', () {
    final device = StorageKeys.deviceScopedBoxes.toSet();
    final account = StorageKeys.accountScopedBoxes.toSet();

    expect(device.intersection(account), isEmpty);
    expect(StorageKeys.allBoxes.toSet(), device.union(account));
    expect(StorageKeys.allBoxes, hasLength(StorageKeys.allBoxes.toSet().length));
  });

  test('clearAccountScoped empties the account\'s boxes and keeps the device\'s', () async {
    for (final box in StorageKeys.allBoxes) {
      await cache.put(box, 'k', {'v': box});
    }

    await cache.clearAccountScoped();

    for (final box in StorageKeys.accountScopedBoxes) {
      expect(cache.get(box, 'k'), isNull, reason: box);
    }
    for (final box in StorageKeys.deviceScopedBoxes) {
      expect(cache.get(box, 'k'), {'v': box}, reason: box);
    }
  });
}
