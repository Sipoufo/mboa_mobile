import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/profile/data/profile_repository.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockCurrentUserApi extends Mock implements CurrentUserApi {}

class MockUserProfileApi extends Mock implements UserProfileApi {}

class MockPrestataireProfileApi extends Mock implements PrestataireProfileApi {}

class MockBaseProfileRepository extends Mock implements BaseProfileRepository {}

Response<T> ok<T>(T? data, {String path = '/api/v1/prestataires/me'}) =>
    Response<T>(
      data: data,
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
    );

/// Where a newly uploaded avatar key is written.
///
/// A prestataire's avatar is their business logo (`/prestataires/me`), which the
/// app loaded but never wrote — so the logo could not be set at all, and every
/// Pro screen rendered the personal photo instead.
void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockCurrentUserApi currentUserApi;
  late MockUserProfileApi userProfileApi;
  late MockPrestataireProfileApi prestataireApi;
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
    ..profileComplete = true);

  setUpAll(() => registerFallbackValue(UpdatePrestataireProfileRequest()));

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    currentUserApi = MockCurrentUserApi();
    userProfileApi = MockUserProfileApi();
    prestataireApi = MockPrestataireProfileApi();
    base = MockBaseProfileRepository();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getCurrentUserApi).thenReturn(currentUserApi);
    when(apiClient.getUserProfileApi).thenReturn(userProfileApi);
    when(apiClient.getPrestataireProfileApi).thenReturn(prestataireApi);

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
  });

  test('an agent has no business profile and keeps the personal photo', () async {
    when(() => currentUserApi.getMe()).thenAnswer(
      (_) async => ok(account(MeResponseRoleEnum.AGENT), path: '/api/v1/me'),
    );
    when(() => base.load()).thenAnswer(
      (_) async => const BaseProfile(role: AccountRole.agent),
    );

    await repository.updatePhoto('photo.jpg');

    verify(() => base.updatePhoto('photo.jpg')).called(1);
    verifyNever(
      () => prestataireApi.updateMyPrestataireProfile(
        updatePrestataireProfileRequest: any(
          named: 'updatePrestataireProfileRequest',
        ),
      ),
    );
  });
}
