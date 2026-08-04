import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

void main() {
  late MockAccountRepository repository;
  const phone = '+237690000000';

  setUp(() => repository = MockAccountRepository());

  void stubRequestOk() =>
      when(() => repository.requestPhoneChange(any())).thenAnswer((_) async {});

  group('ChangePhoneRequested', () {
    blocTest<ChangePhoneBloc, ChangePhoneState>(
      'moves to the codes step on success',
      setUp: stubRequestOk,
      build: () => ChangePhoneBloc(repository: repository),
      act: (bloc) => bloc.add(const ChangePhoneRequested(phone)),
      expect: () => const [
        ChangePhoneEnterPhone(loading: true),
        ChangePhoneEnterCodes(newPhoneNumber: phone),
      ],
      verify: (_) => verify(() => repository.requestPhoneChange(phone)).called(1),
    );

    blocTest<ChangePhoneBloc, ChangePhoneState>(
      'surfaces a request error',
      setUp: () => when(() => repository.requestPhoneChange(any())).thenThrow(Exception('x')),
      build: () => ChangePhoneBloc(repository: repository),
      act: (bloc) => bloc.add(const ChangePhoneRequested(phone)),
      expect: () => const [
        ChangePhoneEnterPhone(loading: true),
        ChangePhoneEnterPhone(error: ChangePhoneError.requestFailed),
      ],
    );
  });

  group('ChangePhoneConfirmed', () {
    blocTest<ChangePhoneBloc, ChangePhoneState>(
      'confirms with both codes and emits success',
      setUp: () {
        stubRequestOk();
        when(() => repository.confirmPhoneChange(
              newPhoneNumber: any(named: 'newPhoneNumber'),
              oldCode: any(named: 'oldCode'),
              newCode: any(named: 'newCode'),
            )).thenAnswer((_) async {});
      },
      build: () => ChangePhoneBloc(repository: repository),
      act: (bloc) => bloc
        ..add(const ChangePhoneRequested(phone))
        ..add(const ChangePhoneConfirmed(oldCode: '111111', newCode: '222222')),
      expect: () => const [
        ChangePhoneEnterPhone(loading: true),
        ChangePhoneEnterCodes(newPhoneNumber: phone),
        ChangePhoneEnterCodes(newPhoneNumber: phone, loading: true),
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
        when(() => repository.confirmPhoneChange(
              newPhoneNumber: any(named: 'newPhoneNumber'),
              oldCode: any(named: 'oldCode'),
              newCode: any(named: 'newCode'),
            )).thenThrow(Exception('bad'));
      },
      build: () => ChangePhoneBloc(repository: repository),
      act: (bloc) => bloc
        ..add(const ChangePhoneRequested(phone))
        ..add(const ChangePhoneConfirmed(oldCode: '000000', newCode: '000000')),
      expect: () => const [
        ChangePhoneEnterPhone(loading: true),
        ChangePhoneEnterCodes(newPhoneNumber: phone),
        ChangePhoneEnterCodes(newPhoneNumber: phone, loading: true),
        ChangePhoneEnterCodes(newPhoneNumber: phone, error: ChangePhoneError.invalidCode),
      ],
    );
  });
}
