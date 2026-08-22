import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/profile/data/profile_repository.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockCurrentUserApi extends Mock implements CurrentUserApi {}

class MockUserProfileApi extends Mock implements UserProfileApi {}

class MockPrestataireProfileApi extends Mock implements PrestataireProfileApi {}

class MockAgentApi extends Mock implements AgentApi {}

class MockBaseProfileRepository extends Mock implements BaseProfileRepository {}

Response<T> ok<T>(T? data, {String path = '/api/v1/prestataires/me'}) =>
    Response<T>(
      data: data,
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
    );

/// Where a newly uploaded avatar key is written — one record per role.
///
/// A prestataire's avatar is their business logo (`/prestataires/me`). An
/// **agent's** is on `/agents/me`, a record created empty with nothing copied
/// from `/users/me`: the server's `profileComplete` and the prestataire-facing
/// `AgentCandidate` card both read it. Writing the base profile instead showed
/// the agent their new photo while leaving them unassignable, with nothing on
/// screen explaining why.
void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockCurrentUserApi currentUserApi;
  late MockUserProfileApi userProfileApi;
  late MockPrestataireProfileApi prestataireApi;
  late MockAgentApi agentApi;
  late MockBaseProfileRepository base;
  late ProProfileRepository repository;

  MeResponse account(MeResponseRoleEnum role) => MeResponse((b) => b
    ..id = 'a-1'
    ..role = role);

  final existing = PrestataireProfileResponse((b) => b
    ..id = 'p-1'
    ..displayName = 'Agence Deido'
    ..type = PrestataireProfileResponseTypeEnum.AGENCE
    ..mainCityId = 'c-1'
    ..registrationNumber = 'RC/DLA/2024/B/1234'
    ..profileComplete = true);

  final existingAgent = AgentProfileResponse((b) => b
    ..accountId = 'a-1'
    ..firstName = 'Awa'
    ..lastName = 'Nkeng'
    ..photoObjectKey = 'agent.jpg'
    ..profileComplete = true);

  setUpAll(() {
    registerFallbackValue(UpdatePrestataireProfileRequest());
    registerFallbackValue(UpdateAgentProfileRequest());
    registerFallbackValue(const BaseProfileEdit(firstName: '', lastName: ''));
  });

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    currentUserApi = MockCurrentUserApi();
    userProfileApi = MockUserProfileApi();
    prestataireApi = MockPrestataireProfileApi();
    agentApi = MockAgentApi();
    base = MockBaseProfileRepository();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getCurrentUserApi).thenReturn(currentUserApi);
    when(apiClient.getUserProfileApi).thenReturn(userProfileApi);
    when(apiClient.getPrestataireProfileApi).thenReturn(prestataireApi);
    when(apiClient.getAgentApi).thenReturn(agentApi);

    when(() => agentApi.getMyAgentProfile())
        .thenAnswer((_) async => ok(existingAgent));
    when(
      () => agentApi.updateMyAgentProfile(
        updateAgentProfileRequest: any(named: 'updateAgentProfileRequest'),
      ),
    ).thenAnswer((_) async => ok(existingAgent));

    when(() => prestataireApi.getMyPrestataireProfile())
        .thenAnswer((_) async => ok(existing));
    when(
      () => prestataireApi.updateMyPrestataireProfile(
        updatePrestataireProfileRequest: any(
          named: 'updatePrestataireProfileRequest',
        ),
      ),
    ).thenAnswer((_) async => ok(existing));
    when(() => base.updatePhoto(any()))
        .thenAnswer((_) async => const BaseProfile());
    when(() => base.save(any()))
        .thenAnswer((_) async => const BaseProfile());
    when(() => base.load()).thenAnswer((_) async => const BaseProfile());

    repository = ProProfileRepository(dioClient: dioClient, base: base);
  });

  test('a prestataire writes the key to logoObjectKey', () async {
    when(() => currentUserApi.getMe()).thenAnswer(
      (_) async => ok(account(MeResponseRoleEnum.PRESTATAIRE), path: '/api/v1/me'),
    );
    when(() => base.load()).thenAnswer(
      (_) async => const BaseProfile(role: AccountRole.prestataire),
    );

    await repository.updatePhoto('logo.jpg');

    final sent = verify(
      () => prestataireApi.updateMyPrestataireProfile(
        updatePrestataireProfileRequest: captureAny(
          named: 'updatePrestataireProfileRequest',
        ),
      ),
    ).captured.single as UpdatePrestataireProfileRequest;

    expect(sent.logoObjectKey, 'logo.jpg');
    // The personal photo is left alone.
    verifyNever(() => base.updatePhoto(any()));
  });

  test('the other business fields are re-sent, not dropped', () async {
    when(() => currentUserApi.getMe()).thenAnswer(
      (_) async => ok(account(MeResponseRoleEnum.PRESTATAIRE), path: '/api/v1/me'),
    );
    when(() => base.load()).thenAnswer(
      (_) async => const BaseProfile(role: AccountRole.prestataire),
    );

    await repository.updatePhoto('logo.jpg');

    final sent = verify(
      () => prestataireApi.updateMyPrestataireProfile(
        updatePrestataireProfileRequest: captureAny(
          named: 'updatePrestataireProfileRequest',
        ),
      ),
    ).captured.single as UpdatePrestataireProfileRequest;

    // Partial-update semantics are an assumption; omitting these would wipe the
    // business profile to set an avatar.
    expect(sent.displayName, 'Agence Deido');
    expect(sent.mainCityId, 'c-1');
    expect(sent.type, UpdatePrestataireProfileRequestTypeEnum.AGENCE);
    // Added 2026-08-20 with the field itself: the Contrat Mboa prints it
    // (M08), and losing it to an avatar change would only surface when a
    // contract is drawn up.
    expect(sent.registrationNumber, 'RC/DLA/2024/B/1234');
  });

  group('agent', () {
    setUp(() {
      when(() => currentUserApi.getMe()).thenAnswer(
        (_) async => ok(account(MeResponseRoleEnum.AGENT), path: '/api/v1/me'),
      );
      when(() => base.load()).thenAnswer(
        (_) async => const BaseProfile(role: AccountRole.agent),
      );
    });

    test('writes the photo to the agent record, not the base profile', () async {
      await repository.updatePhoto('new.jpg');

      final sent = verify(
        () => agentApi.updateMyAgentProfile(
          updateAgentProfileRequest: captureAny(
            named: 'updateAgentProfileRequest',
          ),
        ),
      ).captured.first as UpdateAgentProfileRequest;

      expect(sent.photoObjectKey, 'new.jpg');
      // /users/me is unrelated for an agent: the record is created empty and
      // nothing is copied across, so writing it changes nothing that is read.
      verifyNever(() => base.updatePhoto(any()));
    });

    test('writes the name to the agent record as well as the account', () async {
      await repository.save(
        const ProfileEdit(
          firstName: 'Awa',
          lastName: 'Nkeng',
          isPrestataire: false,
          isAgent: true,
        ),
      );

      final sent = verify(
        () => agentApi.updateMyAgentProfile(
          updateAgentProfileRequest: captureAny(
            named: 'updateAgentProfileRequest',
          ),
        ),
      ).captured.first as UpdateAgentProfileRequest;

      // It is the name a prestataire sees when choosing a candidate.
      expect(sent.firstName, 'Awa');
      expect(sent.lastName, 'Nkeng');
    });

    test('reads back the agent record\'s own name and photo', () async {
      final profile = await repository.load();

      expect(profile.firstName, 'Awa');
      expect(profile.photoObjectKey, 'agent.jpg');
      // The agent record's completeness, not a prestataire's.
      expect(profile.profileComplete, isTrue);
    });

    test('never touches the prestataire profile', () async {
      await repository.updatePhoto('new.jpg');

      verifyNever(
        () => prestataireApi.updateMyPrestataireProfile(
          updatePrestataireProfileRequest: any(
            named: 'updatePrestataireProfileRequest',
          ),
        ),
      );
    });
  });

  test('a plain user still writes the base profile', () async {
    when(() => currentUserApi.getMe()).thenAnswer(
      (_) async => ok(account(MeResponseRoleEnum.USER), path: '/api/v1/me'),
    );
    when(() => base.load())
        .thenAnswer((_) async => const BaseProfile(role: AccountRole.user));

    await repository.updatePhoto('photo.jpg');

    verify(() => base.updatePhoto('photo.jpg')).called(1);
    verifyNever(
      () => agentApi.updateMyAgentProfile(
        updateAgentProfileRequest: any(named: 'updateAgentProfileRequest'),
      ),
    );
  });
}
