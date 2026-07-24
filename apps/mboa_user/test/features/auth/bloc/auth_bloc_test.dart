import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_user/features/auth/bloc/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

void main() {
  late MockAuthRepository repository;

  setUp(() => repository = MockAuthRepository());

  group('AuthStarted', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthAuthenticated] when a session already exists',
      setUp: () => when(repository.hasSession).thenAnswer((_) async => true),
      build: () => AuthBloc(repository: repository),
      act: (bloc) => bloc.add(const AuthStarted()),
      expect: () => const [AuthAuthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthUnauthenticated] when there is no session',
      setUp: () => when(repository.hasSession).thenAnswer((_) async => false),
      build: () => AuthBloc(repository: repository),
      act: (bloc) => bloc.add(const AuthStarted()),
      expect: () => const [AuthUnauthenticated()],
    );
  });

  blocTest<AuthBloc, AuthState>(
    'AuthSessionEstablished emits [AuthAuthenticated]',
    build: () => AuthBloc(repository: repository),
    act: (bloc) => bloc.add(const AuthSessionEstablished()),
    expect: () => const [AuthAuthenticated()],
  );

  blocTest<AuthBloc, AuthState>(
    'AuthLogoutRequested clears the session and emits [AuthUnauthenticated]',
    setUp: () => when(repository.logout).thenAnswer((_) async {}),
    build: () => AuthBloc(repository: repository),
    act: (bloc) => bloc.add(const AuthLogoutRequested()),
    expect: () => const [AuthUnauthenticated()],
    verify: (_) => verify(repository.logout).called(1),
  );
}
