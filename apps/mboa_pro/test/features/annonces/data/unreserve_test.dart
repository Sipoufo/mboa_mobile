import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/annonces/data/annonce_repository.dart';
import 'package:mboa_pro/features/annonces/data/residence_repository.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockAnnoncesApi extends Mock implements AnnoncesApi {}

class MockResidencesApi extends Mock implements ResidencesApi {}

/// RM-M10-10 — lifting a reservation set by hand reaches its own endpoint.
void main() {
  late MockAnnoncesApi annonces;
  late MockResidencesApi residences;
  late MockDioClient dioClient;

  setUp(() {
    dioClient = MockDioClient();
    final apiClient = MockApiClient();
    annonces = MockAnnoncesApi();
    residences = MockResidencesApi();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getAnnoncesApi).thenReturn(annonces);
    when(apiClient.getResidencesApi).thenReturn(residences);
  });

  test('a listing', () async {
    when(() => annonces.unreserveAnnonce(id: 'a-1')).thenAnswer(
      (_) async => Response(
        data: AnnonceResponse((b) => b
          ..id = 'a-1'
          ..status = AnnonceResponseStatusEnum.PUBLISHED),
        requestOptions: RequestOptions(path: '/annonces/a-1/unreserve'),
      ),
    );

    final lifted = await AnnonceRepository(dioClient: dioClient).transition('a-1', AnnonceTransition.unreserve);

    expect(lifted.status, AnnonceStatus.published);
    verifyNever(() => annonces.reserveAnnonce(id: any(named: 'id')));
  });

  test('every unit of a residence set by hand', () async {
    when(() => residences.unreserveResidenceUnits(id: 'r-1')).thenAnswer(
      (_) async => Response(
        data: ResidenceResponse((b) => b..id = 'r-1'),
        requestOptions: RequestOptions(path: '/residences/r-1/unreserve'),
      ),
    );

    await ResidenceRepository(dioClient: dioClient).transition('r-1', AnnonceTransition.unreserve);

    verify(() => residences.unreserveResidenceUnits(id: 'r-1')).called(1);
  });
}
