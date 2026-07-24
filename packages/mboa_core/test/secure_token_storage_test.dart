import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late Map<String, String> store;
  late MockFlutterSecureStorage backing;
  late SecureTokenStorage storage;

  // Fixed date so the epoch-millis round-trip is exact.
  final refreshExpiry = DateTime.fromMillisecondsSinceEpoch(1893456000000);
  final accessExpiry = DateTime.fromMillisecondsSinceEpoch(1800000000000);

  setUp(() {
    store = {};
    backing = MockFlutterSecureStorage();

    when(() => backing.write(key: any(named: 'key'), value: any(named: 'value')))
        .thenAnswer((inv) async {
      final key = inv.namedArguments[#key] as String;
      final value = inv.namedArguments[#value] as String?;
      if (value == null) {
        store.remove(key);
      } else {
        store[key] = value;
      }
    });
    when(() => backing.read(key: any(named: 'key')))
        .thenAnswer((inv) async => store[inv.namedArguments[#key] as String]);
    when(() => backing.delete(key: any(named: 'key')))
        .thenAnswer((inv) async => store.remove(inv.namedArguments[#key] as String));

    storage = SecureTokenStorage(storage: backing);
  });

  test('save then readTokens round-trips tokens and expiries', () async {
    await storage.save(
      AuthTokens(
        accessToken: 'access_1',
        refreshToken: 'refresh_1',
        accessTokenExpiresAt: accessExpiry,
        refreshTokenExpiresAt: refreshExpiry,
      ),
    );

    final read = await storage.readTokens();

    expect(read, isNotNull);
    expect(read!.accessToken, 'access_1');
    expect(read.refreshToken, 'refresh_1');
    expect(read.accessTokenExpiresAt, accessExpiry);
    expect(read.refreshTokenExpiresAt, refreshExpiry);
  });

  test('a null expiry is not persisted and reads back as null', () async {
    await storage.save(
      const AuthTokens(accessToken: 'a', refreshToken: 'r'),
    );

    final read = await storage.readTokens();

    expect(read!.refreshTokenExpiresAt, isNull);
    expect(read.accessTokenExpiresAt, isNull);
  });

  test('clear removes tokens and expiries', () async {
    await storage.save(
      AuthTokens(
        accessToken: 'a',
        refreshToken: 'r',
        refreshTokenExpiresAt: refreshExpiry,
      ),
    );

    await storage.clear();

    expect(await storage.hasTokens(), isFalse);
    expect(await storage.readTokens(), isNull);
    expect(store, isEmpty);
  });
}
