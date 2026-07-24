import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';

void main() {
  group('AuthTokens', () {
    test('isValid is true only when both tokens are non-empty', () {
      expect(
        const AuthTokens(accessToken: 'a', refreshToken: 'r').isValid,
        isTrue,
      );
      expect(
        const AuthTokens(accessToken: '', refreshToken: 'r').isValid,
        isFalse,
      );
      expect(
        const AuthTokens(accessToken: 'a', refreshToken: '').isValid,
        isFalse,
      );
    });

    test('supports value equality', () {
      expect(
        const AuthTokens(accessToken: 'a', refreshToken: 'r'),
        equals(const AuthTokens(accessToken: 'a', refreshToken: 'r')),
      );
    });
  });

  group('Environment', () {
    test('defaults to dev and exposes a base URL', () {
      expect(Environment.current, MboaEnv.dev);
      expect(Environment.apiBaseUrl, contains('/api/v1'));
    });
  });
}
