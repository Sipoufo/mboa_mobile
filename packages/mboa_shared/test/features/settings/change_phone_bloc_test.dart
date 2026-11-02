import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

/// RM-M02-02 — the current number is typed before the new one, and the server
/// checks it (§40 B: `currentPhoneNumber` is required — without it every
/// change was refused once the backend shipped).
void main() {
  late MockAccountRepository repository;
  const current = '+237690000014';
  const phone = '+237690000000';

  setUp(() => repository = MockAccountRepository());

  void stubRequest(Future<void> Function() answer) => when(() => repository.requestPhoneChange(
        currentPhoneNumber: any(named: 'currentPhoneNumber'),
        newPhoneNumber: any(named: 'newPhoneNumber'),
      )).thenAnswer((_) => answer());

  void stubRequestOk() => stubRequest(() async {});

  DioException refused(String code, {int status = 400}) => DioException(
        requestOptions: RequestOptions(path: '/account/phone/change'),
        response: Response(
          requestOptions: RequestOptions(path: '/account/phone/change'),
          statusCode: status,
          data: {'error': code},
        ),
      );

  const request = ChangePhoneRequested(currentPhoneNumber: current, newPhoneNumber: phone);
  const codes = ChangePhoneEnterCodes(currentPhoneNumber: current, newPhoneNumber: phone);

  group('ChangePhoneRequested', () {
    blocTest<ChangePhoneBloc, ChangePhoneState>(
      'sends both numbers, then the codes step names both',
      setUp: stubRequestOk,
      build: () => ChangePhoneBloc(repository: repository),
      act: (bloc) => bloc.add(request),
      expect: () => const [ChangePhoneEnterPhone(loading: true), codes],
      verify: (_) => verify(
        () => repository.requestPhoneChange(currentPhoneNumber: current, newPhoneNumber: phone),
      ).called(1),
    );

    for (final (code, status, error) in [
      ('CURRENT_PHONE_MISMATCH', 400, ChangePhoneError.currentMismatch),
      ('PHONE_UNCHANGED', 400, ChangePhoneError.unchanged),
      ('PHONE_ALREADY_USED', 409, ChangePhoneError.alreadyUsed),
    ]) {
      blocTest<ChangePhoneBloc, ChangePhoneState>(
        '$code: said under the number it is about',
        setUp: () => stubRequest(() async => throw refused(code, status: status)),
        build: () => ChangePhoneBloc(repository: repository),
        act: (bloc) => bloc.add(request),
        expect: () => [const ChangePhoneEnterPhone(loading: true), ChangePhoneEnterPhone(error: error)],
      );
    }

    blocTest<ChangePhoneBloc, ChangePhoneState>(
      'anything else: a failure to retry',
      setUp: () => stubRequest(() async => throw Exception('x')),
      build: () => ChangePhoneBloc(repository: repository),
      act: (bloc) => bloc.add(request),
      expect: () => const [
        ChangePhoneEnterPhone(loading: true),
        ChangePhoneEnterPhone(error: ChangePhoneError.requestFailed),
      ],
    );
  });

  blocTest<ChangePhoneBloc, ChangePhoneState>(
    'a resend sends both numbers again',
    setUp: stubRequestOk,
    build: () => ChangePhoneBloc(repository: repository),
    act: (bloc) => bloc
      ..add(request)
      ..add(const ChangePhoneResent()),
    skip: 2,
    expect: () => const [
      ChangePhoneEnterCodes(currentPhoneNumber: current, newPhoneNumber: phone, loading: true),
      ChangePhoneEnterCodes(currentPhoneNumber: current, newPhoneNumber: phone, justResent: true),
    ],
    verify: (_) => verify(
      () => repository.requestPhoneChange(currentPhoneNumber: current, newPhoneNumber: phone),
    ).called(2),
  );

  group('ChangePhoneConfirmed', () {
    void stubConfirm(Future<void> Function() answer) => when(() => repository.confirmPhoneChange(
          newPhoneNumber: any(named: 'newPhoneNumber'),
          oldCode: any(named: 'oldCode'),
          newCode: any(named: 'newCode'),
        )).thenAnswer((_) => answer());

    blocTest<ChangePhoneBloc, ChangePhoneState>(
      'confirms with both codes and emits success',
      setUp: () {
        stubRequestOk();
        stubConfirm(() async {});
      },
      build: () => ChangePhoneBloc(repository: repository),
      act: (bloc) => bloc
        ..add(request)
        ..add(const ChangePhoneConfirmed(oldCode: '111111', newCode: '222222')),
      expect: () => const [
        ChangePhoneEnterPhone(loading: true),
        codes,
        ChangePhoneEnterCodes(currentPhoneNumber: current, newPhoneNumber: phone, loading: true),
        ChangePhoneSuccess(),
      ],
      verify: (_) => verify(() => repository.confirmPhoneChange(
            newPhoneNumber: phone,
            oldCode: '111111',
            newCode: '222222',
          )).called(1),
    );

    blocTest<ChangePhoneBloc, ChangePhoneState>(
      'emits an invalid-code error on a bad code',
      setUp: () {
        stubRequestOk();
        stubConfirm(() async => throw Exception('bad'));
      },
      build: () => ChangePhoneBloc(repository: repository),
      act: (bloc) => bloc
        ..add(request)
        ..add(const ChangePhoneConfirmed(oldCode: '000000', newCode: '000000')),
      skip: 3,
      expect: () => const [
        ChangePhoneEnterCodes(currentPhoneNumber: current, newPhoneNumber: phone, error: ChangePhoneError.invalidCode),
      ],
    );

    blocTest<ChangePhoneBloc, ChangePhoneState>(
      'dead codes (three tries, or expired) ask for new ones',
      setUp: () {
        stubRequestOk();
        stubConfirm(() async => throw const OtpCodeBurnt());
      },
      build: () => ChangePhoneBloc(repository: repository),
      act: (bloc) => bloc
        ..add(request)
        ..add(const ChangePhoneConfirmed(oldCode: '000000', newCode: '000000')),
      skip: 3,
      expect: () => const [
        ChangePhoneEnterCodes(currentPhoneNumber: current, newPhoneNumber: phone, error: ChangePhoneError.codeBurnt),
      ],
    );
  });
}
