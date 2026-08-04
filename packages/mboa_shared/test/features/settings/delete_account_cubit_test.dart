import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

void main() {
  late MockAccountRepository repository;

  setUp(() => repository = MockAccountRepository());

  blocTest<DeleteAccountCubit, DeleteAccountState>(
    'emits [inProgress, success] when deletion succeeds',
    setUp: () => when(repository.deleteAccount).thenAnswer((_) async {}),
    build: () => DeleteAccountCubit(repository: repository),
    act: (cubit) => cubit.delete(),
    expect: () => const [DeleteAccountInProgress(), DeleteAccountSuccess()],
    verify: (_) => verify(repository.deleteAccount).called(1),
  );

  blocTest<DeleteAccountCubit, DeleteAccountState>(
    'emits [inProgress, failure] when deletion throws',
    setUp: () => when(repository.deleteAccount).thenThrow(Exception('boom')),
    build: () => DeleteAccountCubit(repository: repository),
    act: (cubit) => cubit.delete(),
    expect: () => const [DeleteAccountInProgress(), DeleteAccountFailure()],
  );
}
