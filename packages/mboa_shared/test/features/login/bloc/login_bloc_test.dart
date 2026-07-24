import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/builders/login_builders.dart';
import '../../../_helpers/mocks/mocks.dart';

void main() {
  late MockLoginRepository repository;

  setUpAll(() => registerFallbackValue(buildOtpSession()));
  setUp(() => repository = MockLoginRepository());

  group('LoginOtpRequested', () {
    final session = buildOtpSession();

    blocTest<LoginBloc, LoginState>(
      'emits [LoginInProgress, LoginOtpSent] on success',
      setUp: () => when(() => repository.requestOtp(any()))
          .thenAnswer((_) async => session),
      build: () => LoginBloc(repository: repository),
      act: (bloc) => bloc.add(const LoginOtpRequested('+237690000000')),
      expect: () => [const LoginInProgress(), LoginOtpSent(session)],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginInProgress, LoginFailure] when the request throws',
      setUp: () =>
          when(() => repository.requestOtp(any())).thenThrow(Exception('boom')),
      build: () => LoginBloc(repository: repository),
      act: (bloc) => bloc.add(const LoginOtpRequested('+237690000000')),
      expect: () => [const LoginInProgress(), isA<LoginFailure>()],
    );
  });

  group('LoginCodeSubmitted', () {
    final session = buildOtpSession();

    blocTest<LoginBloc, LoginState>(
      'emits [LoginInProgress, LoginSuccess] on a valid code',
      setUp: () => when(
        () => repository.verifyOtp(
          session: any(named: 'session'),
          code: any(named: 'code'),
        ),
      ).thenAnswer((_) async {}),
      build: () => LoginBloc(repository: repository),
      act: (bloc) =>
          bloc.add(LoginCodeSubmitted(session: session, code: '123456')),
      expect: () => [const LoginInProgress(), const LoginSuccess()],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginInProgress, LoginFailure(session)] on an invalid code',
      setUp: () => when(
        () => repository.verifyOtp(
          session: any(named: 'session'),
          code: any(named: 'code'),
        ),
      ).thenThrow(Exception('invalid')),
      build: () => LoginBloc(repository: repository),
      act: (bloc) =>
          bloc.add(LoginCodeSubmitted(session: session, code: '000000')),
      expect: () => [
        const LoginInProgress(),
        isA<LoginFailure>().having((f) => f.session, 'session', session),
      ],
    );
  });
}
