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
    test('defaults to dev and exposes an origin-only base URL', () {
      expect(Environment.current, MboaEnv.dev);
      // Origin only — the generated client paths already carry `/api/v1`.
      expect(Environment.apiBaseUrl, 'http://localhost:8080');
      expect(Environment.apiBaseUrl, isNot(contains('/api/v1')));
    });
  });
}
