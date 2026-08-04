import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/register/bloc/register_bloc.dart';
import 'package:mboa_pro/features/register/models/professional_role.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

void main() {
  late MockRegisterRepository repository;

  const email = 'pro@example.com';
  const password = 'secret123';
  const phone = '+237690000000';
  const role = ProfessionalRole.prestataire;

  setUpAll(() => registerFallbackValue(ProfessionalRole.prestataire));
  setUp(() => repository = MockRegisterRepository());

  void stubRegisterOk() => when(
        () => repository.register(
          role: any(named: 'role'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          phone: any(named: 'phone'),
        ),
      ).thenAnswer((_) async {});

  RegisterBloc build() => RegisterBloc(repository: repository);

  const submit = RegisterSubmitted(role: role, email: email, password: password, phone: phone);

  group('RegisterSubmitted', () {
    blocTest<RegisterBloc, RegisterState>(
      'registers and moves to the phone OTP step on success',
      setUp: stubRegisterOk,
      build: build,
      act: (bloc) => bloc.add(submit),
      expect: () => const [
        RegisterEnterDetails(loading: true),
        RegisterEnterOtp(phone: phone),
      ],
      verify: (_) => verify(
        () => repository.register(role: role, email: email, password: password, phone: phone),
      ).called(1),
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits a details error when registration fails',
      setUp: () => when(
        () => repository.register(
          role: any(named: 'role'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          phone: any(named: 'phone'),
        ),
      ).thenThrow(Exception('conflict')),
      build: build,
      act: (bloc) => bloc.add(submit),
      expect: () => const [
        RegisterEnterDetails(loading: true),
        RegisterEnterDetails(error: RegisterError.registrationFailed),
      ],
    );
  });

  group('RegisterOtpSubmitted', () {
    blocTest<RegisterBloc, RegisterState>(
      'verifies the phone code and emits success',
      setUp: () {
        stubRegisterOk();
        when(() => repository.verifyOtp(phone: any(named: 'phone'), code: any(named: 'code')))
            .thenAnswer((_) async {});
      },
      build: build,
      act: (bloc) => bloc
        ..add(submit)
        ..add(const RegisterOtpSubmitted('123456')),
      expect: () => const [
        RegisterEnterDetails(loading: true),
        RegisterEnterOtp(phone: phone),
        RegisterEnterOtp(phone: phone, loading: true),
        RegisterSuccess(),
      ],
      verify: (_) => verify(() => repository.verifyOtp(phone: phone, code: '123456')).called(1),
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits an OTP error on an invalid code',
      setUp: () {
        stubRegisterOk();
        when(() => repository.verifyOtp(phone: any(named: 'phone'), code: any(named: 'code')))
            .thenThrow(Exception('invalid'));
      },
      build: build,
      act: (bloc) => bloc
        ..add(submit)
        ..add(const RegisterOtpSubmitted('000000')),
      expect: () => const [
        RegisterEnterDetails(loading: true),
        RegisterEnterOtp(phone: phone),
        RegisterEnterOtp(phone: phone, loading: true),
        RegisterEnterOtp(phone: phone, error: RegisterError.invalidCode),
      ],
    );
  });

  group('RegisterOtpResent', () {
    blocTest<RegisterBloc, RegisterState>(
      'requests a fresh OTP and flags a resend',
      setUp: () {
        stubRegisterOk();
        when(() => repository.resendOtp(any())).thenAnswer((_) async {});
      },
      build: build,
      act: (bloc) => bloc
        ..add(submit)
        ..add(const RegisterOtpResent()),
      expect: () => const [
        RegisterEnterDetails(loading: true),
        RegisterEnterOtp(phone: phone),
        RegisterEnterOtp(phone: phone, loading: true),
        RegisterEnterOtp(phone: phone, justResent: true),
      ],
      verify: (_) => verify(() => repository.resendOtp(phone)).called(1),
    );
  });
}
