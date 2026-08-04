import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

void main() {
  late MockAccountRepository repository;

  setUp(() => repository = MockAccountRepository());

  blocTest<ChangePasswordCubit, ChangePasswordState>(
    'emits [inProgress, success] when the change succeeds',
    setUp: () => when(() => repository.changePassword(
          currentPassword: any(named: 'currentPassword'),
          newPassword: any(named: 'newPassword'),
        )).thenAnswer((_) async {}),
    build: () => ChangePasswordCubit(repository: repository),
    act: (cubit) => cubit.submit(currentPassword: 'old', newPassword: 'new'),
    expect: () => const [ChangePasswordInProgress(), ChangePasswordSuccess()],
    verify: (_) => verify(() => repository.changePassword(
          currentPassword: 'old',
          newPassword: 'new',
        )).called(1),
  );

  blocTest<ChangePasswordCubit, ChangePasswordState>(
    'emits [inProgress, failure] when the change throws',
    setUp: () => when(() => repository.changePassword(
          currentPassword: any(named: 'currentPassword'),
          newPassword: any(named: 'newPassword'),
        )).thenThrow(Exception('bad')),
    build: () => ChangePasswordCubit(repository: repository),
    act: (cubit) => cubit.submit(currentPassword: 'old', newPassword: 'new'),
    expect: () => const [ChangePasswordInProgress(), ChangePasswordFailure()],
  );
}
