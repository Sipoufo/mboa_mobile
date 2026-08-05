import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Native permission declarations, pinned. See the Pro app's copy for why —
/// these failures only surface on device.
///
/// App Mboa has no geolocator today, so no location keys are asserted; add them
/// here when it does.
void main() {
  String read(String path) => File(path).readAsStringSync();

  group('iOS Info.plist', () {
    late String plist;

    setUp(() => plist = read('ios/Runner/Info.plist'));

    test('declares the camera and photo usage strings (profile photo)', () {
      expect(plist, contains('NSCameraUsageDescription'));
      expect(plist, contains('NSPhotoLibraryUsageDescription'));
    });

    test('declares the remote-notification background mode (M03)', () {
      expect(plist, contains('UIBackgroundModes'));
      expect(plist, contains('remote-notification'));
    });

    test('every usage key has a non-empty description', () {
      final pattern = RegExp(
        r'<key>(NS\w*UsageDescription)</key>\s*<string>(.*?)</string>',
        dotAll: true,
      );
      final matches = pattern.allMatches(plist).toList();

      expect(matches, isNotEmpty);
      for (final match in matches) {
        expect(
          match.group(2)!.trim(),
          isNotEmpty,
          reason: '${match.group(1)} has an empty description',
        );
      }
    });
  });

  test('AndroidManifest declares POST_NOTIFICATIONS for Android 13+ (M03)', () {
    expect(
      read('android/app/src/main/AndroidManifest.xml'),
      contains('android.permission.POST_NOTIFICATIONS'),
    );
  });
}
