import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/splash/logic/splash_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

void main() {
  late MockSessionRepository session;

  setUp(() => session = MockSessionRepository());

  blocTest<SplashCubit, SplashState>(
    'emits [Loading, Authenticated] when the session resolves as authenticated',
    setUp: () => when(session.resolve)
        .thenAnswer((_) async => const SessionAuthenticated()),
    build: () =>
        SplashCubit(sessionRepository: session, minimumDisplay: Duration.zero),
    act: (cubit) => cubit.initialize(),
    expect: () => const [SplashLoading(), SplashAuthenticated()],
  );

  blocTest<SplashCubit, SplashState>(
    'emits [Loading, Unauthenticated] when there is no session',
    setUp: () => when(session.resolve)
        .thenAnswer((_) async => const SessionUnauthenticated()),
    build: () =>
        SplashCubit(sessionRepository: session, minimumDisplay: Duration.zero),
    act: (cubit) => cubit.initialize(),
    expect: () => const [SplashLoading(), SplashUnauthenticated()],
  );

  blocTest<SplashCubit, SplashState>(
    'emits [Loading, Failure] on a check error',
    setUp: () => when(session.resolve)
        .thenAnswer((_) async => const SessionCheckError()),
    build: () =>
        SplashCubit(sessionRepository: session, minimumDisplay: Duration.zero),
    act: (cubit) => cubit.initialize(),
    expect: () => const [SplashLoading(), SplashFailure()],
  );
}
