import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureTokenStorage extends Mock implements SecureTokenStorage {}

/// The server, as far as the session goes: `/auth/token/refresh` rotates the pair
/// (a spent refresh token is `REFRESH_TOKEN_REUSED`), `/me` wants the current
/// access token.
class FakeServer implements HttpClientAdapter {
  FakeServer({this.refreshToken = 'r1', this.accessToken = 'a1'});

  String refreshToken;
  String accessToken;
  int refreshes = 0;
  final List<String> spent = [];

  /// Held open to let two callers meet over one refresh.
  Completer<void>? gate;

  /// No answer at all to a refresh.
  bool unreachable = false;

  /// What `/me` answers once authorised.
  int meStatus = 200;

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    if (options.path.endsWith('/auth/token/refresh')) {
      if (unreachable) {
        throw DioException(requestOptions: options, type: DioExceptionType.connectionError);
      }
      await gate?.future;
      refreshes++;
      final body = jsonDecode(utf8.decode(await requestStream!.expand((c) => c).toList())) as Map;
      final presented = body['refreshToken'];
      if (presented != refreshToken) {
        if (spent.contains(presented)) return _json({'error': 'REFRESH_TOKEN_REUSED'}, 401);
        return _json({'error': 'INVALID_TOKEN'}, 401);
      }
      spent.add(refreshToken);
      refreshToken = 'r${refreshes + 1}';
      accessToken = 'a${refreshes + 1}';
      return _json({
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'accessTokenExpiresAt': DateTime.now().add(const Duration(minutes: 15)).toUtc().toIso8601String(),
        'refreshTokenExpiresAt': DateTime.now().add(const Duration(days: 7)).toUtc().toIso8601String(),
      }, 200);
    }
    if (options.headers['Authorization'] != 'Bearer $accessToken') return _json({'error': 'UNAUTHORIZED'}, 401);
    return _json({'path': options.path}, meStatus);
  }

  ResponseBody _json(Object body, int status) => ResponseBody.fromString(
        jsonEncode(body),
        status,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );

  @override
  void close({bool force = false}) {}
}

/// The session's refresh token is single-use (`REFRESH_TOKEN_REUSED` signs
/// the account out everywhere): one refresh at a time, from the token stored
/// when it starts, saved before anyone replays.
void main() {
  late FakeServer server;
  late MockSecureTokenStorage storage;
  late AuthTokens? stored;
  late int expired;
  late DioClient client;

  setUpAll(() => registerFallbackValue(const AuthTokens(accessToken: 'x', refreshToken: 'y')));

  setUp(() {
    server = FakeServer();
    storage = MockSecureTokenStorage();
    stored = const AuthTokens(accessToken: 'a1', refreshToken: 'r1');
    expired = 0;
    when(storage.readAccessToken).thenAnswer((_) async => stored?.accessToken);
    when(storage.readRefreshToken).thenAnswer((_) async => stored?.refreshToken);
    when(storage.readTokens).thenAnswer((_) async => stored);
    when(() => storage.save(any())).thenAnswer((call) async => stored = call.positionalArguments.single as AuthTokens);
    when(storage.clear).thenAnswer((_) async => stored = null);
    client = DioClient(
      storage: storage,
      onSessionExpired: () async => expired++,
      dio: Dio()..httpClientAdapter = server,
      retryClient: Dio()..httpClientAdapter = server,
    );
  });

  test('two callers at once share one refresh', () async {
    server.gate = Completer();
    final first = client.rotateSession();
    final second = client.rotateSession();
    server.gate!.complete();

    final results = await Future.wait([first, second]);
    expect(server.refreshes, 1);
    expect(results.map((t) => t?.accessToken), ['a2', 'a2']);
    expect(stored?.refreshToken, 'r2');
  });

  test('…and the next one reads the token stored by the last, never a spent one', () async {
    await client.rotateSession();
    await client.rotateSession();

    expect(server.refreshes, 2);
    expect(stored?.refreshToken, 'r3');
    expect(expired, 0);
  });

  test('a refused refresh is the end of the session; no answer is not', () async {
    server.unreachable = true;
    await expectLater(client.rotateSession(), throwsA(isA<DioException>()));

    server
      ..unreachable = false
      ..refreshToken = 'elsewhere';
    expect(await client.rotateSession(), isNull);
  });

  group('the interceptor', () {
    test('a 401 refreshes once, then replays', () async {
      server.accessToken = 'expired-elsewhere';
      server.refreshToken = 'r1';

      final response = await client.dio.get<dynamic>('/me');

      expect(response.statusCode, 200);
      expect(server.refreshes, 1);
      expect(stored?.accessToken, 'a2');
    });

    test('a request that left with an old token is replayed, not refreshed again', () async {
      // Rotated meanwhile — by another 401, or by the watcher.
      await client.rotateSession();
      final dio = Dio()..httpClientAdapter = server;
      final interceptor = client.dio.interceptors.whereType<AuthInterceptor>().single;
      dio.interceptors.add(interceptor);

      final response = await dio.get<dynamic>('/me', options: Options(headers: {'Authorization': 'Bearer a1'}));

      expect(response.statusCode, 200);
      expect(server.refreshes, 1);
      expect(expired, 0);
    });

    test('three 401s together: one refresh, no reuse, no sign-out', () async {
      server
        ..accessToken = 'expired-elsewhere'
        ..gate = Completer();
      final calls = [for (var i = 0; i < 3; i++) client.dio.get<dynamic>('/me/$i')];
      await Future<void>.delayed(Duration.zero);
      server.gate!.complete();

      final responses = await Future.wait(calls);
      expect(responses.map((r) => r.statusCode), [200, 200, 200]);
      expect(server.refreshes, 1);
      expect(expired, 0);
    });

    test('a reused refresh token signs out, cleanly', () async {
      server
        ..accessToken = 'expired-elsewhere'
        ..refreshToken = 'r9'
        ..spent.add('r1');

      await expectLater(client.dio.get<dynamic>('/me'), throwsA(isA<DioException>()));
      expect(expired, 1);
      expect(stored, isNull);
    });

    test('offline at refresh time: the request fails, the session stays', () async {
      server
        ..accessToken = 'expired-elsewhere'
        ..unreachable = true;

      await expectLater(client.dio.get<dynamic>('/me'), throwsA(isA<DioException>()));
      expect(expired, 0);
      expect(stored?.refreshToken, 'r1');
    });

    test('a replay that fails is the request\'s failure, not the session\'s', () async {
      server
        ..accessToken = 'expired-elsewhere'
        ..meStatus = 500;

      final error = await client.dio.get<dynamic>('/me').then<DioException?>((_) => null, onError: (Object e) => e as DioException);
      expect(error?.response?.statusCode, 500);
      expect(expired, 0);
      expect(stored?.accessToken, 'a2');
    });
  });
}
