import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/login/bloc/credential_login_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

void main() {
  late MockCredentialAuthRepository repository;

  const email = 'pro@example.com';
  const password = 'secret123';

  setUp(() => repository = MockCredentialAuthRepository());

  void stubLoginOk() => when(
        () => repository.login(email: any(named: 'email'), password: any(named: 'password')),
      ).thenAnswer((_) async {});

  group('CredentialLoginSubmitted', () {
    blocTest<CredentialLoginBloc, CredentialLoginState>(
      'emits [loading credentials, EnterOtp] when the login call succeeds',
      setUp: stubLoginOk,
      build: () => CredentialLoginBloc(repository: repository),
      act: (bloc) => bloc.add(const CredentialLoginSubmitted(email: email, password: password)),
      expect: () => const [
        CredentialLoginEnterCredentials(loading: true),
        CredentialLoginEnterOtp(email: email),
      ],
      verify: (_) => verify(() => repository.login(email: email, password: password)).called(1),
    );

    blocTest<CredentialLoginBloc, CredentialLoginState>(
      'emits [loading credentials, credentials error] when the login call fails',
      setUp: () => when(
        () => repository.login(email: any(named: 'email'), password: any(named: 'password')),
      ).thenThrow(Exception('bad creds')),
      build: () => CredentialLoginBloc(repository: repository),
      act: (bloc) => bloc.add(const CredentialLoginSubmitted(email: email, password: password)),
      expect: () => const [
        CredentialLoginEnterCredentials(loading: true),
        CredentialLoginEnterCredentials(error: CredentialLoginError.invalidCredentials),
      ],
    );
  });

  group('CredentialLoginOtpSubmitted', () {
    blocTest<CredentialLoginBloc, CredentialLoginState>(
      'verifies the emailed code and emits success',
      setUp: () {
        stubLoginOk();
        when(() => repository.verifyOtp(email: any(named: 'email'), code: any(named: 'code')))
            .thenAnswer((_) async {});
      },
      build: () => CredentialLoginBloc(repository: repository),
      act: (bloc) => bloc
        ..add(const CredentialLoginSubmitted(email: email, password: password))
        ..add(const CredentialLoginOtpSubmitted('123456')),
      expect: () => const [
        CredentialLoginEnterCredentials(loading: true),
        CredentialLoginEnterOtp(email: email),
        CredentialLoginEnterOtp(email: email, loading: true),
        CredentialLoginSuccess(),
      ],
      verify: (_) => verify(() => repository.verifyOtp(email: email, code: '123456')).called(1),
    );

    blocTest<CredentialLoginBloc, CredentialLoginState>(
      'emits an OTP error on an invalid code',
      setUp: () {
        stubLoginOk();
        when(() => repository.verifyOtp(email: any(named: 'email'), code: any(named: 'code')))
            .thenThrow(Exception('invalid'));
      },
      build: () => CredentialLoginBloc(repository: repository),
      act: (bloc) => bloc
        ..add(const CredentialLoginSubmitted(email: email, password: password))
        ..add(const CredentialLoginOtpSubmitted('000000')),
      expect: () => const [
        CredentialLoginEnterCredentials(loading: true),
        CredentialLoginEnterOtp(email: email),
        CredentialLoginEnterOtp(email: email, loading: true),
        CredentialLoginEnterOtp(email: email, error: CredentialLoginError.invalidCode),
      ],
    );
  });

  group('CredentialLoginOtpResent', () {
    blocTest<CredentialLoginBloc, CredentialLoginState>(
      'replays login with the retained credentials and flags a resend',
      setUp: stubLoginOk,
      build: () => CredentialLoginBloc(repository: repository),
      act: (bloc) => bloc
        ..add(const CredentialLoginSubmitted(email: email, password: password))
        ..add(const CredentialLoginOtpResent()),
      expect: () => const [
        CredentialLoginEnterCredentials(loading: true),
        CredentialLoginEnterOtp(email: email),
        CredentialLoginEnterOtp(email: email, loading: true),
        CredentialLoginEnterOtp(email: email, justResent: true),
      ],
      verify: (_) => verify(() => repository.login(email: email, password: password)).called(2),
    );
  });
}
