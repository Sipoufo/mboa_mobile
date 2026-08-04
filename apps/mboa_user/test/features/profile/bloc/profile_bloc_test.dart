import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/profile/profile_types.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

void main() {
  late MockBaseProfileRepository repository;

  const loaded = BaseProfile(
    email: 'user@example.com',
    firstName: 'Ydille',
    lastName: 'Fynem',
    searchCity: 'Deido',
  );

  const edit = BaseProfileEdit(firstName: 'Ydille', lastName: 'Fynem');

  setUpAll(() => registerFallbackValue(edit));
  setUp(() => repository = MockBaseProfileRepository());

  group('ProfileLoadRequested', () {
    blocTest<UserProfileBloc, ProfileState>(
      'emits [loading, ready] on success',
      setUp: () => when(repository.load).thenAnswer((_) async => loaded),
      build: () => UserProfileBloc(repository: repository),
      act: (bloc) => bloc.add(const ProfileLoadRequested()),
      expect: () => const [ProfileLoadInProgress(), UserProfileReady(loaded)],
    );

    blocTest<UserProfileBloc, ProfileState>(
      'emits [loading, failure] when the load throws',
      setUp: () => when(repository.load).thenThrow(Exception('boom')),
      build: () => UserProfileBloc(repository: repository),
      act: (bloc) => bloc.add(const ProfileLoadRequested()),
      expect: () => const [ProfileLoadInProgress(), ProfileLoadFailure()],
    );
  });

  group('ProfileSaveRequested', () {
    const updated = BaseProfile(
      email: 'user@example.com',
      firstName: 'Ydille',
      lastName: 'Fynem',
      searchCity: 'Akwa',
    );

    blocTest<UserProfileBloc, ProfileState>(
      'emits [saving, saved] on success',
      setUp: () => when(() => repository.save(any())).thenAnswer((_) async => updated),
      build: () => UserProfileBloc(repository: repository),
      seed: () => const UserProfileReady(loaded),
      act: (bloc) => bloc.add(const ProfileSaveRequested(edit)),
      expect: () => const [
        UserProfileReady(loaded, saving: true),
        UserProfileReady(updated, justSaved: true),
      ],
      verify: (_) => verify(() => repository.save(edit)).called(1),
    );

    blocTest<UserProfileBloc, ProfileState>(
      'emits [saving, saveFailed] when the save throws',
      setUp: () => when(() => repository.save(any())).thenThrow(Exception('boom')),
      build: () => UserProfileBloc(repository: repository),
      seed: () => const UserProfileReady(loaded),
      act: (bloc) => bloc.add(const ProfileSaveRequested(edit)),
      expect: () => const [
        UserProfileReady(loaded, saving: true),
        UserProfileReady(loaded, saveFailed: true),
      ],
    );
  });
}
