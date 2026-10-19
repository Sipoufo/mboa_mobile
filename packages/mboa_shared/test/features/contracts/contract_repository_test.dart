import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

class MockContratsApi extends Mock implements ContratsApi {}

class _FakeCreate extends Fake implements CreateContractRequest {}

/// `POST /contracts` — what goes on the wire.
void main() {
  late MockContratsApi api;
  late ContractRepository repository;

  setUpAll(() => registerFallbackValue(_FakeCreate()));

  setUp(() {
    final dioClient = MockDioClient();
    final apiClient = MockApiClient();
    api = MockContratsApi();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getContratsApi).thenReturn(api);
    when(() => api.createContract(createContractRequest: any(named: 'createContractRequest'))).thenAnswer(
      (_) async => Response(
        data: ContractResponse((b) => b..id = 'c-1'),
        requestOptions: RequestOptions(path: '/contracts'),
      ),
    );
    repository = ContractRepository(dioClient: dioClient);
  });

  CreateContractRequest sent() =>
      verify(() => api.createContract(createContractRequest: captureAny(named: 'createContractRequest')))
          .captured
          .single as CreateContractRequest;

  test('RM-M08-10 — from a reservation: the request, and no tenant named', () async {
    await repository.create(
      ContractTerms(
        annonceId: 'a-1',
        reservationRequestId: 'r-1',
        // Left over from a form: must not reach the server (TENANT_FROM_RESERVATION).
        tenantPhone: '+237690000000',
        price: 110000,
        depositAmount: 220000,
        startDate: DateTime(2026, 11, 1),
        durationUnits: 6,
      ),
    );

    final body = sent();
    expect(body.reservationRequestId, 'r-1');
    expect(body.tenantPhone, isNull);
    expect(body.tenantAccountId, isNull);
  });

  test('otherwise the tenant is the one typed', () async {
    await repository.create(
      ContractTerms(
        annonceId: 'a-1',
        tenantPhone: '+237690000000',
        price: 110000,
        depositAmount: 220000,
        startDate: DateTime(2026, 11, 1),
        durationUnits: 6,
      ),
    );

    final body = sent();
    expect(body.reservationRequestId, isNull);
    expect(body.tenantPhone, '+237690000000');
  });
}
