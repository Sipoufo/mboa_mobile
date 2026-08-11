import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/annonces/data/annonce_repository.dart';
import 'package:mboa_pro/features/annonces/data/residence_repository.dart';
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart';
import 'package:mboa_pro/features/annonces/models/rental_period.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockAnnoncesApi extends Mock implements AnnoncesApi {}

class MockResidencesApi extends Mock implements ResidencesApi {}

Response<T> ok<T>(T data) => Response<T>(
      data: data,
      requestOptions: RequestOptions(path: '/api/v1/annonces'),
      statusCode: 200,
    );

/// What the app puts on the wire for a rent (RM-M10-09).
///
/// `price` + `rentalPeriod` are the input; `monthlyRent` is the equivalent the
/// server derives to compare listings. Sending `monthlyRent` instead still
/// compiles — the field exists — it just silently records a figure nobody pays
/// and leaves the real price null. Hence this test.
void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockAnnoncesApi annoncesApi;
  late MockResidencesApi residencesApi;

  const location = ListingLocation(
    districtId: 'd-1',
    districtName: 'Deido',
    latitude: 4.05,
    longitude: 9.7,
    exactAddress: 'Rue 1.234',
  );
  final availableFrom = DateTime.utc(2026, 9, 1);

  setUpAll(() {
    // built_value rejects a partial instance, so the fallbacks carry the
    // fields the schema marks required.
    registerFallbackValue(CreateAnnonceRequest((b) => b
      ..propertyType = CreateAnnonceRequestPropertyTypeEnum.STUDIO
      ..title = 't'
      ..districtId = 'd-1'
      ..exactAddress = 'x'
      ..latitude = 0
      ..longitude = 0
      ..availableFrom = Date(2026, 1, 1)));
    registerFallbackValue(UpdateAnnonceRequest());
    registerFallbackValue(CreateResidenceRequest((b) => b
      ..name = 'r'
      ..districtId = 'd-1'
      ..exactAddress = 'x'
      ..latitude = 0
      ..longitude = 0
      ..availableFrom = Date(2026, 1, 1)));
  });

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    annoncesApi = MockAnnoncesApi();
    residencesApi = MockResidencesApi();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getAnnoncesApi).thenReturn(annoncesApi);
    when(apiClient.getResidencesApi).thenReturn(residencesApi);

    when(() => annoncesApi.createAnnonce(
          createAnnonceRequest: any(named: 'createAnnonceRequest'),
        )).thenAnswer((_) async => ok(AnnonceResponse((b) => b..id = 'a1')));
    when(() => annoncesApi.updateAnnonce(
          id: any(named: 'id'),
          updateAnnonceRequest: any(named: 'updateAnnonceRequest'),
        )).thenAnswer((_) async => ok(AnnonceResponse((b) => b..id = 'a1')));
    when(() => residencesApi.createResidence(
          createResidenceRequest: any(named: 'createResidenceRequest'),
        )).thenAnswer((_) async => ok(ResidenceResponse((b) => b..id = 'r1')));
  });

  test('creating a listing sends price and period, never monthlyRent', () async {
    await AnnonceRepository(dioClient: dioClient).create(
      AnnonceDraft(
        kind: AnnonceKind.single,
        title: 'Villa Bonapriso',
        price: 900000,
        rentalPeriod: RentalPeriod.year,
        location: location,
        availableFrom: availableFrom,
      ),
    );

    final sent = verify(() => annoncesApi.createAnnonce(
              createAnnonceRequest: captureAny(named: 'createAnnonceRequest'),
            )).captured.single as CreateAnnonceRequest;

    expect(sent.price, 900000);
    expect(sent.rentalPeriod, CreateAnnonceRequestRentalPeriodEnum.YEAR);
    // The derived figure is the server's to compute.
    expect(sent.monthlyRent, isNull);
  });

  test('editing a listing sends price and period', () async {
    await AnnonceRepository(dioClient: dioClient).update(
      AnnonceDraft(
        kind: AnnonceKind.single,
        id: 'a1',
        title: 'Villa Bonapriso',
        price: 250000,
        rentalPeriod: RentalPeriod.quarter,
        location: location,
        availableFrom: availableFrom,
      ),
    );

    final sent = verify(() => annoncesApi.updateAnnonce(
              id: 'a1',
              updateAnnonceRequest: captureAny(named: 'updateAnnonceRequest'),
            )).captured.single as UpdateAnnonceRequest;

    expect(sent.price, 250000);
    expect(sent.rentalPeriod, UpdateAnnonceRequestRentalPeriodEnum.QUARTER);
    expect(sent.monthlyRent, isNull);
  });

  test('a residence unit group carries its own price and period', () async {
    await ResidenceRepository(dioClient: dioClient).create(
      AnnonceDraft(
        kind: AnnonceKind.residence,
        title: 'Résidence Deido',
        location: location,
        availableFrom: availableFrom,
        units: const [
          UnitGroupDraft(
            count: 10,
            namePrefix: 'Chambre',
            price: 45000,
            rentalPeriod: RentalPeriod.month,
          ),
          UnitGroupDraft(
            count: 2,
            namePrefix: 'Local',
            price: 1200000,
            rentalPeriod: RentalPeriod.year,
          ),
        ],
      ),
    );

    final sent = verify(() => residencesApi.createResidence(
              createResidenceRequest:
                  captureAny(named: 'createResidenceRequest'),
            )).captured.single as CreateResidenceRequest;

    final groups = sent.units.toList();
    expect(groups[0].price, 45000);
    expect(groups[0].rentalPeriod, UnitGroupRentalPeriodEnum.MONTH);
    // Groups differ: a shop in the building can be let yearly.
    expect(groups[1].price, 1200000);
    expect(groups[1].rentalPeriod, UnitGroupRentalPeriodEnum.YEAR);
    expect(groups.every((g) => g.monthlyRent == null), isTrue);
  });
}
