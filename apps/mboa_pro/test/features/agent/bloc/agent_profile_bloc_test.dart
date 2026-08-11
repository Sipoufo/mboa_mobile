import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/agent/bloc/agent_profile_bloc.dart';
import 'package:mboa_pro/features/agent/data/agent_repository.dart';
import 'package:mboa_pro/features/agent/models/agent_profile.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockAgentRepository extends Mock implements AgentRepository {}

void main() {
  late MockAgentRepository repository;
  late MockMediaUploader uploader;

  const profile = AgentProfile(
    accountId: 'a-1',
    firstName: 'Awa',
    lastName: 'Nkeng',
    photoObjectKey: 'photo.jpg',
    zones: [AgentCityZone('c-1')],
    acceptingAssignments: true,
    completedVisitCount: 12,
    averageRating: 4.5,
    ratingCount: 8,
    status: AgentStatus.active,
    profileComplete: true,
  );

  setUpAll(() {
    registerFallbackValue(ImageSource.gallery);
    registerFallbackValue(CreateUploadRequestCategoryEnum.PROFILE_PHOTO);
  });

  setUp(() {
    repository = MockAgentRepository();
    uploader = MockMediaUploader();
  });

  AgentProfileBloc build() =>
      AgentProfileBloc(repository: repository, uploader: uploader);

  blocTest<AgentProfileBloc, AgentProfileState>(
    'loads the agent profile',
    setUp: () => when(repository.load).thenAnswer((_) async => profile),
    build: build,
    act: (bloc) => bloc.add(const AgentProfileLoadRequested()),
    expect: () => [
      const AgentProfileLoadInProgress(),
      const AgentProfileReady(profile),
    ],
  );

  blocTest<AgentProfileBloc, AgentProfileState>(
    'a failed load is a failure state, not an empty profile',
    setUp: () => when(repository.load).thenThrow(Exception('offline')),
    build: build,
    act: (bloc) => bloc.add(const AgentProfileLoadRequested()),
    expect: () => [
      const AgentProfileLoadInProgress(),
      const AgentProfileFailure(),
    ],
  );

  group('accepting assignments (RM-M15-05)', () {
    blocTest<AgentProfileBloc, AgentProfileState>(
      'flips immediately, then confirms with the server',
      setUp: () => when(() => repository.save(acceptingAssignments: false))
          .thenAnswer(
        (_) async => const AgentProfile(
          accountId: 'a-1',
          acceptingAssignments: false,
        ),
      ),
      build: build,
      seed: () => const AgentProfileReady(profile),
      act: (bloc) =>
          bloc.add(const AgentAcceptingAssignmentsToggled(false)),
      verify: (bloc) {
        final state = bloc.state as AgentProfileReady;
        expect(state.profile.acceptingAssignments, isFalse);
      },
    );

    blocTest<AgentProfileBloc, AgentProfileState>(
      'reverts when the server refuses',
      setUp: () => when(() => repository.save(acceptingAssignments: false))
          .thenThrow(Exception('500')),
      build: build,
      seed: () => const AgentProfileReady(profile),
      act: (bloc) => bloc.add(const AgentAcceptingAssignmentsToggled(false)),
      verify: (bloc) {
        final state = bloc.state as AgentProfileReady;
        // A switch left flipped on a failed call is a lie about whether the
        // agent is taking work.
        expect(state.profile.acceptingAssignments, isTrue);
        expect(state.lastActionFailed, isTrue);
      },
    );
  });

  group('photo', () {
    blocTest<AgentProfileBloc, AgentProfileState>(
      'writes the key to the agent record, never the base profile',
      setUp: () {
        when(() => uploader.captureAndUpload(
              source: any(named: 'source'),
              category: any(named: 'category'),
            )).thenAnswer((_) async => 'new.jpg');
        when(() => repository.save(photoObjectKey: 'new.jpg')).thenAnswer(
          (_) async => const AgentProfile(
            accountId: 'a-1',
            photoObjectKey: 'new.jpg',
          ),
        );
      },
      build: build,
      seed: () => const AgentProfileReady(profile),
      act: (bloc) => bloc.add(
        const AgentPhotoChangeRequested(ImageSource.gallery),
      ),
      verify: (bloc) {
        // profileComplete and the prestataire's candidate card both read the
        // agent record's photo — writing /users/me leaves the agent
        // unassignable with nothing on screen explaining why.
        verify(() => repository.save(photoObjectKey: 'new.jpg')).called(1);
        expect(
          (bloc.state as AgentProfileReady).profile.photoObjectKey,
          'new.jpg',
        );
      },
    );

    blocTest<AgentProfileBloc, AgentProfileState>(
      'a cancelled picker is not a failure',
      setUp: () => when(() => uploader.captureAndUpload(
            source: any(named: 'source'),
            category: any(named: 'category'),
          )).thenAnswer((_) async => null),
      build: build,
      seed: () => const AgentProfileReady(profile),
      act: (bloc) => bloc.add(
        const AgentPhotoChangeRequested(ImageSource.camera),
      ),
      verify: (bloc) {
        final state = bloc.state as AgentProfileReady;
        expect(state.lastActionFailed, isFalse);
        expect(state.isUploadingPhoto, isFalse);
        verifyNever(
          () => repository.save(
            photoObjectKey: any(named: 'photoObjectKey'),
          ),
        );
      },
    );
  });

  blocTest<AgentProfileBloc, AgentProfileState>(
    'saving zones sends both lists (RM-M15-04)',
    setUp: () => when(
      () => repository.saveZones(
        cityIds: ['c-1'],
        districtIds: ['d-1', 'd-2'],
      ),
    ).thenAnswer(
      (_) async => const AgentProfile(
        accountId: 'a-1',
        zones: [
          AgentCityZone('c-1'),
          AgentDistrictZone('d-1'),
          AgentDistrictZone('d-2'),
        ],
      ),
    ),
    build: build,
    seed: () => const AgentProfileReady(profile),
    act: (bloc) => bloc.add(
      const AgentZonesSaved(cityIds: ['c-1'], districtIds: ['d-1', 'd-2']),
    ),
    verify: (bloc) {
      final saved = (bloc.state as AgentProfileReady).profile;
      expect(saved.cityZoneIds, ['c-1']);
      expect(saved.districtZoneIds, ['d-1', 'd-2']);
    },
  );
}
