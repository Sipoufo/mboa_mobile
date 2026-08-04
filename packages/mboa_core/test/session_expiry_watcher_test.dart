import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mocktail/mocktail.dart';

class MockDioClient extends Mock implements DioClient {}

class MockSecureTokenStorage extends Mock implements SecureTokenStorage {}

AuthTokens tokens({
  Duration? accessIn,
  Duration? refreshIn = const Duration(days: 7),
  String access = 'access',
}) {
  final now = DateTime.now();
  return AuthTokens(
    accessToken: access,
    refreshToken: 'refresh',
    accessTokenExpiresAt: accessIn == null ? null : now.add(accessIn),
    refreshTokenExpiresAt: refreshIn == null ? null : now.add(refreshIn),
  );
}

void main() {
  late MockDioClient dioClient;
  late MockSecureTokenStorage storage;
  late int expiredCalls;

  setUpAll(() => registerFallbackValue(tokens()));

  setUp(() {
    dioClient = MockDioClient();
    storage = MockSecureTokenStorage();
    expiredCalls = 0;
    when(() => storage.save(any())).thenAnswer((_) async {});
    when(() => storage.clear()).thenAnswer((_) async {});
  });

  SessionExpiryWatcher build({
    Duration leeway = const Duration(minutes: 2),
  }) =>
      SessionExpiryWatcher(
        dioClient: dioClient,
        tokenStorage: storage,
        onSessionExpired: () async => expiredCalls++,
        refreshLeeway: leeway,
      );

  test('does nothing when there are no stored tokens', () async {
    when(() => storage.readTokens()).thenAnswer((_) async => null);

    await build().start();

    expect(expiredCalls, 0);
    verifyNever(() => dioClient.refreshSession(any()));
  });

  test('expires the session when the refresh token has already lapsed', () async {
    when(() => storage.readTokens()).thenAnswer(
      (_) async => tokens(refreshIn: const Duration(seconds: -1)),
    );

    await build().start();

    expect(expiredCalls, 1);
    verify(() => storage.clear()).called(1);
    // A dead refresh token can't be redeemed — don't waste the round-trip.
    verifyNever(() => dioClient.refreshSession(any()));
  });

  test('refreshes immediately when the access token is inside the leeway', () async {
    when(() => storage.readTokens()).thenAnswer(
      (_) async => tokens(accessIn: const Duration(seconds: 30)),
    );
    // Second read (the re-arm after a successful refresh) has no expiry, so the
    // watcher settles instead of looping.
    when(() => dioClient.refreshSession('refresh')).thenAnswer((_) async {
      when(() => storage.readTokens()).thenAnswer((_) async => tokens());
      return tokens(access: 'fresh');
    });

    await build().start();

    verify(() => dioClient.refreshSession('refresh')).called(1);
    final saved = verify(() => storage.save(captureAny())).captured.single;
    expect((saved as AuthTokens).accessToken, 'fresh');
    expect(expiredCalls, 0);
  });

  test('expires the session when the proactive refresh is rejected', () async {
    when(() => storage.readTokens()).thenAnswer(
      (_) async => tokens(accessIn: const Duration(seconds: 30)),
    );
    when(() => dioClient.refreshSession(any())).thenAnswer((_) async => null);

    await build().start();

    expect(expiredCalls, 1);
    verify(() => storage.clear()).called(1);
    verifyNever(() => storage.save(any()));
  });

  test('schedules instead of refreshing when expiry is comfortably ahead', () async {
    when(() => storage.readTokens()).thenAnswer(
      (_) async => tokens(accessIn: const Duration(minutes: 30)),
    );

    final watcher = build();
    await watcher.start();

    verifyNever(() => dioClient.refreshSession(any()));
    expect(expiredCalls, 0);
    watcher.stop();
  });

  test('leaves the 401 path as the safety net when expiry is unknown', () async {
    when(() => storage.readTokens()).thenAnswer((_) async => tokens());

    await build().start();

    verifyNever(() => dioClient.refreshSession(any()));
    expect(expiredCalls, 0);
  });
}
