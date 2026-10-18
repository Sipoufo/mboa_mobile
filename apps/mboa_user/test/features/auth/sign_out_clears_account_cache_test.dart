import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/auth/bloc/auth_bloc.dart';
import 'package:mboa_user/features/auth/data/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

/// **The last account's visits outlived its sign-out.**
///
/// `VisitsRepository` kept the upcoming visits in `visitsBox` and only dropped
/// them after a booking, a cancellation or a confirmation — nothing did on
/// sign-out, which reset the blocs and left the disk alone. The next person to
/// sign in on the same phone, offline, was shown someone else's visits. The
/// queue of unsent messages had the same hole.
///
/// This runs the real sign-out — `AuthBloc` → `AuthRepository` → `HiveCache` on
/// disk — and reads every box back. A session that expires goes the same way:
/// the interceptor and the expiry watcher both end in `AuthLogoutRequested`.
void main() {
  late Directory dir;
  late HiveCache cache;
  late MockSecureTokenStorage tokens;
  late AuthRepository repository;

  /// Real disk I/O outlasts `blocTest`'s wait, so the state is awaited here.
  Future<AuthState> dispatch(AuthEvent event) async {
    final bloc = AuthBloc(repository: repository);
    final next = bloc.stream.first;
    bloc.add(event);
    final state = await next;
    await bloc.close();
    return state;
  }

  Future<void> seedEveryBox() async {
    for (final box in StorageKeys.allBoxes) {
      await cache.put(box, 'seed', {'box': box});
    }
  }

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('mboa_user_sign_out');
    await HiveCache.initAt(dir.path);
    cache = HiveCache();

    tokens = MockSecureTokenStorage();
    when(tokens.readRefreshToken).thenAnswer((_) async => null);
    when(tokens.clear).thenAnswer((_) async {});

    repository = AuthRepository(
      dioClient: MockDioClient(),
      tokenStorage: tokens,
      cache: cache,
    );
  });

  tearDown(() async {
    await HiveCache.close();
    await dir.delete(recursive: true);
  });

  test('signing out empties the account\'s boxes and keeps the device\'s', () async {
    await seedEveryBox();

    expect(await dispatch(const AuthLogoutRequested()), const AuthUnauthenticated());

    for (final box in StorageKeys.accountScopedBoxes) {
      expect(cache.get(box, 'seed'), isNull, reason: '$box belongs to the account');
    }
    for (final box in StorageKeys.deviceScopedBoxes) {
      expect(cache.get(box, 'seed'), {'box': box}, reason: '$box belongs to the device');
    }
  });

  test('the visits, and the messages that never left, go with the account', () async {
    await cache.put(StorageKeys.visitsBox, 'upcoming', {'items': <Object>[]});
    await MessagingRepository(dioClient: MockDioClient(), cache: cache).enqueue(
      QueuedMessage(
        localId: 'local-1',
        conversationId: 'conv-1',
        body: 'Je passe à 17h',
        queuedAt: DateTime(2026, 10, 18),
      ),
    );
    await cache.put(StorageKeys.searchBox, 'lastQuery', {'cityId': 'douala'});
    await cache.put(StorageKeys.appSettingsBox, 'locale', {'value': 'en'});

    await dispatch(const AuthLogoutRequested());

    expect(cache.get(StorageKeys.visitsBox, 'upcoming'), isNull);
    expect(
      MessagingRepository(dioClient: MockDioClient(), cache: cache).queued('conv-1'),
      isEmpty,
    );
    // RM-M04-02 restores the last search for a visitor too, and the
    // language is the phone's.
    expect(cache.get(StorageKeys.searchBox, 'lastQuery'), {'cityId': 'douala'});
    expect(cache.get(StorageKeys.appSettingsBox, 'locale'), {'value': 'en'});
  });

  test('signing in clears what landed after the last sign-out', () async {
    // A visits fetch still in flight when the tokens went writes on return.
    await seedEveryBox();

    expect(await dispatch(const AuthSessionEstablished()), const AuthAuthenticated());

    for (final box in StorageKeys.accountScopedBoxes) {
      expect(cache.get(box, 'seed'), isNull, reason: box);
    }
    for (final box in StorageKeys.deviceScopedBoxes) {
      expect(cache.get(box, 'seed'), {'box': box}, reason: box);
    }
  });
}
