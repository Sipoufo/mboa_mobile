import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/profile/models/prestataire_type.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

void main() {
  late MockProProfileRepository repository;

  const loaded = ProfileData(
    email: 'pro@example.com',
    role: AccountRole.prestataire,
    firstName: 'Ydille',
    lastName: 'Fynem',
    searchCity: 'Deido',
    displayName: 'Ydille Immo',
    mainCity: 'Douala',
    type: PrestataireType.agence,
  );

  const edit = ProfileEdit(
    firstName: 'Ydille',
    lastName: 'Fynem',
    isPrestataire: true,
    displayName: 'Ydille Immo',
    type: PrestataireType.agence,
  );

  setUpAll(() => registerFallbackValue(edit));
  setUp(() => repository = MockProProfileRepository());

  group('ProfileLoadRequested', () {
    blocTest<ProProfileBloc, ProfileState>(
      'emits [loading, ready] on success',
      setUp: () => when(repository.load).thenAnswer((_) async => loaded),
      build: () => ProProfileBloc(repository: repository),
      act: (bloc) => bloc.add(const ProfileLoadRequested()),
      expect: () => const [ProfileLoadInProgress(), ProProfileReady(loaded)],
    );

    blocTest<ProProfileBloc, ProfileState>(
      'emits [loading, failure] when the load throws',
      setUp: () => when(repository.load).thenThrow(Exception('boom')),
      build: () => ProProfileBloc(repository: repository),
      act: (bloc) => bloc.add(const ProfileLoadRequested()),
      expect: () => const [ProfileLoadInProgress(), ProfileLoadFailure()],
    );
  });

  group('ProfileSaveRequested', () {
    blocTest<ProProfileBloc, ProfileState>(
      'emits [saving, saved] on success',
      setUp: () => when(() => repository.save(any())).thenAnswer((_) async => loaded),
      build: () => ProProfileBloc(repository: repository),
      seed: () => const ProProfileReady(loaded),
      act: (bloc) => bloc.add(const ProfileSaveRequested(edit)),
      expect: () => const [
        ProProfileReady(loaded, saving: true),
        ProProfileReady(loaded, justSaved: true),
      ],
      verify: (_) => verify(() => repository.save(edit)).called(1),
    );

    blocTest<ProProfileBloc, ProfileState>(
      'emits [saving, saveFailed] when the save throws',
      setUp: () => when(() => repository.save(any())).thenThrow(Exception('boom')),
      build: () => ProProfileBloc(repository: repository),
      seed: () => const ProProfileReady(loaded),
      act: (bloc) => bloc.add(const ProfileSaveRequested(edit)),
      expect: () => const [
        ProProfileReady(loaded, saving: true),
        ProProfileReady(loaded, saveFailed: true),
      ],
    );
  });
}
