import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Native permission declarations, pinned.
///
/// A plugin that needs a runtime permission fails **only on device**, with a
/// crash the analyzer, the bloc tests and the widget tests cannot see —
/// geolocator shipped without `NSLocationWhenInUseUsageDescription`, and the
/// Android manifest had no `uses-permission` entries at all.
///
/// So: when you add a plugin that touches camera, photos, location,
/// notifications or the background, add its declaration **and** a line here.
void main() {
  String read(String path) => File(path).readAsStringSync();

  group('iOS Info.plist', () {
    late String plist;

    setUp(() => plist = read('ios/Runner/Info.plist'));

    test('declares the camera and photo usage strings (KYC, M01bis)', () {
      expect(plist, contains('NSCameraUsageDescription'));
      expect(plist, contains('NSPhotoLibraryUsageDescription'));
    });

    test('declares the location usage string (listing capture, M10)', () {
      // geolocator throws at runtime without this.
      expect(plist, contains('NSLocationWhenInUseUsageDescription'));
    });

    test('declares the remote-notification background mode (M03)', () {
      // Without it, data-only pushes never wake the background handler.
      expect(plist, contains('UIBackgroundModes'));
      expect(plist, contains('remote-notification'));
    });

    test('every usage key has a non-empty description', () {
      // An empty string is an App Store rejection, and reads as a bug to users.
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

  group('AndroidManifest', () {
    late String manifest;

    setUp(() => manifest = read('android/app/src/main/AndroidManifest.xml'));

    test('declares location for the listing capture (M10)', () {
      expect(manifest, contains('android.permission.ACCESS_FINE_LOCATION'));
      // Declared alongside fine, so an approximate-only grant still works.
      expect(manifest, contains('android.permission.ACCESS_COARSE_LOCATION'));
    });

    test('declares POST_NOTIFICATIONS for Android 13+ push (M03)', () {
      expect(manifest, contains('android.permission.POST_NOTIFICATIONS'));
    });
  });
}
