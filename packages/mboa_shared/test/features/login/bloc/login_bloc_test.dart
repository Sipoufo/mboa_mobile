import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
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
      setUp: () => when(() => repository.requestOtp(
            phoneNumber: any(named: 'phoneNumber'),
            email: any(named: 'email'),
          )).thenAnswer((_) async => session),
      build: () => LoginBloc(repository: repository),
      act: (bloc) => bloc.add(const LoginOtpRequested(phoneNumber: '+237690000000')),
      expect: () => [const LoginInProgress(), LoginOtpSent(session)],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginInProgress, LoginFailure] when the request throws',
      setUp: () => when(() => repository.requestOtp(
            phoneNumber: any(named: 'phoneNumber'),
            email: any(named: 'email'),
          )).thenThrow(Exception('boom')),
      build: () => LoginBloc(repository: repository),
      act: (bloc) => bloc.add(const LoginOtpRequested(phoneNumber: '+237690000000')),
      expect: () => [const LoginInProgress(), isA<LoginFailure>()],
    );
  });

  group('LoginOtpResendRequested', () {
    blocTest<LoginBloc, LoginState>(
      'emits [LoginInProgress, LoginOtpResent] when the resend succeeds',
      setUp: () => when(() => repository.resendOtp(any())).thenAnswer((call) async => call.positionalArguments.first as OtpSession),
      build: () => LoginBloc(repository: repository),
      act: (bloc) => bloc.add(LoginOtpResendRequested(buildOtpSession())),
      expect: () => const [LoginInProgress(), LoginOtpResent()],
      verify: (_) => verify(() => repository.resendOtp(buildOtpSession())).called(1),
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginInProgress, LoginFailure] when the resend throws',
      setUp: () => when(() => repository.resendOtp(any())).thenThrow(Exception('boom')),
      build: () => LoginBloc(repository: repository),
      act: (bloc) => bloc.add(LoginOtpResendRequested(buildOtpSession())),
      expect: () => const [LoginInProgress(), LoginFailure(LoginError.otpRequestFailed)],
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

    blocTest<LoginBloc, LoginState>(
      'a dead code (three tries, or expired) asks for a new one',
      setUp: () => when(
        () => repository.verifyOtp(
          session: any(named: 'session'),
          code: any(named: 'code'),
        ),
      ).thenThrow(const OtpCodeBurnt()),
      build: () => LoginBloc(repository: repository),
      act: (bloc) => bloc.add(LoginCodeSubmitted(session: session, code: '000000')),
      expect: () => [const LoginInProgress(), LoginFailure(LoginError.codeBurnt, session: session)],
    );
  });

  // §40 A — an email, and the two refusals the screen says in words.
  group('§40 A', () {
    DioException refused(String code, int status) => DioException(
          requestOptions: RequestOptions(),
          response: Response(requestOptions: RequestOptions(), statusCode: status, data: {'error': code}),
        );

    blocTest<LoginBloc, LoginState>(
      'an email asks for a code by email',
      setUp: () => when(() => repository.requestOtp(
            phoneNumber: any(named: 'phoneNumber'),
            email: any(named: 'email'),
          )).thenAnswer((_) async => buildOtpSession(email: 'awa@example.cm', channel: OtpChannel.email)),
      build: () => LoginBloc(repository: repository),
      act: (bloc) => bloc.add(const LoginOtpRequested(email: 'awa@example.cm')),
      expect: () => [
        const LoginInProgress(),
        LoginOtpSent(buildOtpSession(email: 'awa@example.cm', channel: OtpChannel.email)),
      ],
      verify: (_) => verify(() => repository.requestOtp(email: 'awa@example.cm')).called(1),
    );

    for (final (code, status, error) in [
      ('WHATSAPP_UNAVAILABLE', 409, LoginError.whatsappUnavailable),
      ('USE_PASSWORD_LOGIN', 403, LoginError.usePasswordLogin),
    ]) {
      blocTest<LoginBloc, LoginState>(
        '$code is said as such',
        setUp: () => when(() => repository.requestOtp(
              phoneNumber: any(named: 'phoneNumber'),
              email: any(named: 'email'),
            )).thenAnswer((_) async => throw refused(code, status)),
        build: () => LoginBloc(repository: repository),
        act: (bloc) => bloc.add(const LoginOtpRequested(phoneNumber: '+237690000000')),
        expect: () => [const LoginInProgress(), LoginFailure(error)],
      );
    }
  });
}
