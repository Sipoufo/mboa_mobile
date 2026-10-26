import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureTokenStorage extends Mock implements SecureTokenStorage {}

/// iOS keeps the Keychain when the app is deleted. Reinstalled, the app found
/// the last install's tokens: signed out on screen, signed in on the wire.
void main() {
  late Directory dir;
  late HiveCache cache;
  late MockSecureTokenStorage tokens;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('install_guard_test');
    await HiveCache.initAt(dir.path);
    cache = HiveCache();
    tokens = MockSecureTokenStorage();
    when(tokens.clear).thenAnswer((_) async {});
  });

  tearDown(() async {
    await HiveCache.close();
    await dir.delete(recursive: true);
  });

  test('the first start of an install forgets the tokens a previous one left', () async {
    await forgetTokensOfPreviousInstall(cache: cache, tokens: tokens);

    verify(tokens.clear).called(1);
  });

  test('once per install: the next starts keep the session', () async {
    await forgetTokensOfPreviousInstall(cache: cache, tokens: tokens);
    await forgetTokensOfPreviousInstall(cache: cache, tokens: tokens);

    verify(tokens.clear).called(1);
  });

  test('signing out does not reset it: the marker is the device\'s, not the account\'s', () async {
    await forgetTokensOfPreviousInstall(cache: cache, tokens: tokens);
    await cache.clearAccountScoped();
    await forgetTokensOfPreviousInstall(cache: cache, tokens: tokens);

    verify(tokens.clear).called(1);
  });
}
