import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/annonces/data/residence_repository.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockResidencesApi extends Mock implements ResidencesApi {}

Response<ResidenceResponse> ok(ResidenceResponse data) =>
    Response<ResidenceResponse>(
      data: data,
      requestOptions: RequestOptions(path: '/api/v1/residences'),
      statusCode: 200,
    );

/// Every bulk transition must reach its own endpoint.
///
/// `unarchive` used to throw `UnsupportedError` client-side — written when
/// `ResidencesApi` really had only the four — so un-archiving a residence never
/// left the device and surfaced as *"Action impossible pour le moment."*
/// `POST /residences/{id}/unarchive` (RM-M10-08) has shipped since.
void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockResidencesApi api;
  late ResidenceRepository repository;

  ResidenceResponse residence(ResidenceResponseStatusEnum status) =>
      ResidenceResponse((b) => b
        ..id = 'r1'
        ..name = 'Résidence Deido'
        ..status = status);

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    api = MockResidencesApi();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getResidencesApi).thenReturn(api);
    repository = ResidenceRepository(dioClient: dioClient);
  });

  test('unarchive calls unarchiveResidenceUnits and returns the residence as a draft',
      () async {
    when(() => api.unarchiveResidenceUnits(id: 'r1')).thenAnswer(
      (_) async => ok(residence(ResidenceResponseStatusEnum.DRAFT)),
    );

    final updated =
        await repository.transition('r1', AnnonceTransition.unarchive);

    expect(updated.status, AnnonceStatus.draft);
    verify(() => api.unarchiveResidenceUnits(id: 'r1')).called(1);
    // Publishing an archived residence is a 409 — un-archiving is its own step.
    verifyNever(() => api.publishResidenceUnits(id: any(named: 'id')));
  });

  test('each of the other transitions reaches its own endpoint', () async {
    when(() => api.publishResidenceUnits(id: 'r1')).thenAnswer(
      (_) async => ok(residence(ResidenceResponseStatusEnum.PUBLISHED)),
    );
    when(() => api.reserveResidenceUnits(id: 'r1')).thenAnswer(
      (_) async => ok(residence(ResidenceResponseStatusEnum.RESERVED)),
    );
    when(() => api.rentResidenceUnits(id: 'r1')).thenAnswer(
      (_) async => ok(residence(ResidenceResponseStatusEnum.RENTED)),
    );
    when(() => api.archiveResidenceUnits(id: 'r1')).thenAnswer(
      (_) async => ok(residence(ResidenceResponseStatusEnum.ARCHIVED)),
    );

    expect(
      (await repository.transition('r1', AnnonceTransition.publish)).status,
      AnnonceStatus.published,
    );
    expect(
      (await repository.transition('r1', AnnonceTransition.reserve)).status,
      AnnonceStatus.reserved,
    );
    expect(
      (await repository.transition('r1', AnnonceTransition.markRented)).status,
      AnnonceStatus.rented,
    );
    expect(
      (await repository.transition('r1', AnnonceTransition.archive)).status,
      AnnonceStatus.archived,
    );
  });
}
