import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/annonces/data/residence_repository.dart';
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockResidencesApi extends Mock implements ResidencesApi {}

class _FakeRequest extends Fake implements CreateResidenceRequest {}

/// RM-M10bis-13 — a group's photos go up once, with the group.
void main() {
  late MockResidencesApi api;
  late ResidenceRepository repository;

  setUpAll(() => registerFallbackValue(_FakeRequest()));

  setUp(() {
    final dioClient = MockDioClient();
    final apiClient = MockApiClient();
    api = MockResidencesApi();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getResidencesApi).thenReturn(api);
    when(() => api.createResidence(createResidenceRequest: any(named: 'createResidenceRequest'))).thenAnswer(
      (_) async => Response(
        data: ResidenceResponse((b) => b
          ..id = 'r1'
          ..name = 'Cité blanche'
          ..status = ResidenceResponseStatusEnum.DRAFT),
        requestOptions: RequestOptions(path: '/api/v1/residences'),
        statusCode: 200,
      ),
    );
    repository = ResidenceRepository(dioClient: dioClient);
  });

  test('each group carries its own photos; a group without sends none', () async {
    await repository.create(
      AnnonceDraft(
        kind: AnnonceKind.residence,
        title: 'Cité blanche',
        availableFrom: DateTime(2026, 11, 1),
        location: const ListingLocation(districtId: 'd-1', districtName: 'Bonamoussadi', latitude: 4.09, longitude: 9.74),
        photoKeys: const ['shared-1'],
        units: const [
          UnitGroupDraft(count: 12, namePrefix: 'Chambre', price: 35000, photoKeys: ['room-1', 'room-2', 'room-3']),
          UnitGroupDraft(count: 2, namePrefix: 'Studio', price: 90000),
        ],
      ),
    );

    final request = verify(() => api.createResidence(createResidenceRequest: captureAny(named: 'createResidenceRequest')))
        .captured
        .single as CreateResidenceRequest;
    expect(request.photoKeys?.toList(), ['shared-1']);
    expect(request.units.first.photoKeys?.toList(), ['room-1', 'room-2', 'room-3']);
    // Absent, not empty: the units show the residence's photos.
    expect(request.units.last.photoKeys, isNull);
  });
}
