import 'package:api_client/api_client.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/visits/data/agent_visit_repository.dart';
import 'package:mboa_pro/features/visits/data/prestataire_visit_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockAgentVisitesApi extends Mock implements AgentVisitesApi {}

class MockPrestataireVisitesApi extends Mock
    implements PrestataireVisitesApi {}

Response<PageResponseVisiteResponse> emptyPage() =>
    Response<PageResponseVisiteResponse>(
      data: PageResponseVisiteResponse(
        (b) => b
          ..page = 0
          ..size = 100
          ..totalElements = 0
          ..totalPages = 0
          ..last = true,
      ),
      requestOptions: RequestOptions(path: '/api/v1/agents/me/visites'),
      statusCode: 200,
    );

/// **The agenda's week goes out in UTC.**
///
/// built_value's `DateTime` serializer throws *"Must be in utc for
/// serialization"* on a local one, from inside the generated client — so the
/// week never left the phone and the agenda rendered its failure state: an
/// empty calendar with a Réessayer button that could not succeed, reported from
/// a device. The boundaries are local days by nature (Monday 00:00 where the
/// agent stands), so the conversion has to happen in the repository.
void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockAgentVisitesApi agentApi;
  late MockPrestataireVisitesApi prestataireApi;

  // A local Monday. In any zone east of Greenwich its UTC instant falls on the
  // Sunday, which is exactly the conversion being asserted.
  final from = DateTime(2026, 8, 17);
  final to = DateTime(2026, 8, 24);

  setUpAll(() {
    registerFallbackValue(Pageable((b) => b
      ..page = 0
      ..size = 1));
  });

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    agentApi = MockAgentVisitesApi();
    prestataireApi = MockPrestataireVisitesApi();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getAgentVisitesApi).thenReturn(agentApi);
    when(apiClient.getPrestataireVisitesApi).thenReturn(prestataireApi);
  });

  /// What the generated client does with the value it is handed. Asserting the
  /// repository's argument alone would pass on the very value that crashed.
  void expectSerialisable(DateTime value) {
    expect(
      () => standardSerializers.serialize(
        value,
        specifiedType: const FullType(DateTime),
      ),
      returnsNormally,
    );
  }

  test('the agent agenda sends instants the client can serialize', () async {
    when(
      () => agentApi.listMyAgentVisites(
        pageable: any(named: 'pageable'),
        from: any(named: 'from'),
        to: any(named: 'to'),
      ),
    ).thenAnswer((_) async => emptyPage());

    await AgentVisitRepository(dioClient: dioClient).range(from: from, to: to);

    final call = verify(
      () => agentApi.listMyAgentVisites(
        pageable: any(named: 'pageable'),
        from: captureAny(named: 'from'),
        to: captureAny(named: 'to'),
      ),
    ).captured;

    expect((call[0] as DateTime).isUtc, isTrue);
    expect((call[1] as DateTime).isUtc, isTrue);
    expectSerialisable(call[0] as DateTime);
    // The same moment, not a relabelled wall clock.
    expect(call[0], from.toUtc());
    expect(call[1], to.toUtc());
  });

  test('the prestataire agenda does the same', () async {
    when(
      () => prestataireApi.listMyOwnerVisites(
        pageable: any(named: 'pageable'),
        from: any(named: 'from'),
        to: any(named: 'to'),
      ),
    ).thenAnswer((_) async => emptyPage());

    await PrestataireVisitRepository(dioClient: dioClient)
        .range(from: from, to: to);

    final call = verify(
      () => prestataireApi.listMyOwnerVisites(
        pageable: any(named: 'pageable'),
        from: captureAny(named: 'from'),
        to: captureAny(named: 'to'),
      ),
    ).captured;

    expect((call[0] as DateTime).isUtc, isTrue);
    expectSerialisable(call[1] as DateTime);
  });
}
