import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/reservations/data/incoming_reservations_repository.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockReservationsPrestataireApi extends Mock implements RservationsPrestataireApi {}

class _FakeDecision extends Fake implements OwnerDecisionRequest {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/reservations'));

DioException _refused(String code) => DioException(
      requestOptions: RequestOptions(path: '/reservations'),
      response: Response(requestOptions: RequestOptions(path: '/reservations'), statusCode: 409, data: {'error': code}),
    );

DioException get _offline =>
    DioException(requestOptions: RequestOptions(path: '/reservations'), type: DioExceptionType.connectionError);

ReservationResponse _response(String id, {ReservationResponseStatusEnum? status}) => ReservationResponse(
      (b) => b
        ..id = id
        ..annonceId = 'a-1'
        ..annonceTitle = 'Studio Bonapriso'
        ..status = status ?? ReservationResponseStatusEnum.PENDING
        ..client.displayName = 'Hector Gunther'
        ..createdAt = DateTime.utc(2026, 10, 19, 9, 10),
    );

PageResponseReservationResponse _page(List<ReservationResponse> items, {int? total}) =>
    PageResponseReservationResponse((b) => b
      ..content = ListBuilder(items)
      ..totalElements = total ?? items.length);

/// CDC M29 — the requests on the prestataire's listings, on the wire.
void main() {
  late MockReservationsPrestataireApi api;
  late MockHiveCache cache;
  late IncomingReservationsRepository repository;

  setUpAll(() {
    registerFallbackValue(Pageable());
    registerFallbackValue(_FakeDecision());
  });

  setUp(() {
    final dioClient = MockDioClient();
    final apiClient = MockApiClient();
    api = MockReservationsPrestataireApi();
    cache = MockHiveCache();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getRservationsPrestataireApi).thenReturn(api);
    when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});
    when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn(null);
    repository = IncomingReservationsRepository(dioClient: dioClient, cache: cache);
  });

  group('list', () {
    test('one listing\'s requests, kept per scope for offline', () async {
      when(() => api.listIncomingReservations(pageable: any(named: 'pageable'), annonceId: 'a-1'))
          .thenAnswer((_) async => _ok(_page([_response('r-1')])));

      final page = await repository.list(annonceId: 'a-1');

      expect(page.items.single.client?.name, 'Hector Gunther');
      verify(() => cache.put(StorageKeys.reservationsBox, 'incoming:a-1', any())).called(1);
    });

    test('§30 — a residence\'s, narrowed by the server; the unit names its residence, offline too', () async {
      final unit = _response('r-2').rebuild((b) => b
        ..annonceTitle = 'Chambre 3'
        ..residenceId = 'res-1'
        ..residenceName = 'Résidence Deido');
      when(() => api.listIncomingReservations(pageable: any(named: 'pageable'), residenceId: 'res-1'))
          .thenAnswer((_) async => _ok(_page([unit])));

      final page = await repository.list(residenceId: 'res-1');

      final r = page.items.single;
      expect(r.residenceId, 'res-1');
      expect(r.placeTitle, 'Chambre 3 · Résidence Deido');
      final cached = verify(() => cache.put(StorageKeys.reservationsBox, 'incoming:all:residence:res-1', captureAny()))
          .captured
          .single as Map<String, dynamic>;
      final copy = Reservation.fromCache(Map<String, dynamic>.from((cached['items'] as List).single as Map));
      expect(copy?.placeTitle, 'Chambre 3 · Résidence Deido');
    });

    test('a standalone listing is named by its title alone', () async {
      when(() => api.listIncomingReservations(pageable: any(named: 'pageable'), annonceId: 'a-1'))
          .thenAnswer((_) async => _ok(_page([_response('r-1')])));

      expect((await repository.list(annonceId: 'a-1')).items.single.placeTitle, 'Studio Bonapriso');
    });

    test('offline, the copy — with who asked and when', () async {
      when(() => api.listIncomingReservations(pageable: any(named: 'pageable'))).thenThrow(_offline);
      when(() => cache.get(StorageKeys.reservationsBox, 'incoming:all', ttl: any(named: 'ttl'))).thenReturn({
        'items': [Reservation.fromResponse(_response('r-1')).toCache()],
      });

      final page = await repository.list();

      expect(page.fromCache, isTrue);
      expect(page.items.single.client?.name, 'Hector Gunther');
      expect(page.items.single.createdAt, isNotNull);
    });
  });

  test('the waiting count is the server\'s total, not a page', () async {
    when(
      () => api.listIncomingReservations(
        pageable: any(named: 'pageable'),
        annonceId: any(named: 'annonceId'),
        status: any(named: 'status'),
      ),
    ).thenAnswer((_) async => _ok(_page([_response('r-1')], total: 7)));

    expect(await repository.pendingCount(), 7);
    final status = verify(
      () => api.listIncomingReservations(
        pageable: any(named: 'pageable'),
        annonceId: any(named: 'annonceId'),
        status: captureAny(named: 'status'),
      ),
    ).captured.single as BuiltList<String>;
    expect(status, ['PENDING']);
  });

  test('RM-M29-06 — a refusal carries its reason and a trimmed note', () async {
    when(() => api.refuseReservation(id: 'r-1', ownerDecisionRequest: any(named: 'ownerDecisionRequest')))
        .thenAnswer((_) async => _ok(_response('r-1', status: ReservationResponseStatusEnum.REFUSED)));

    final refused = await repository.refuse('r-1', reason: RefusalReason.datesIncompatible, note: '  Janvier  ');

    final body = verify(
      () => api.refuseReservation(id: 'r-1', ownerDecisionRequest: captureAny(named: 'ownerDecisionRequest')),
    ).captured.single as OwnerDecisionRequest;
    expect(body.reason, OwnerDecisionRequestReasonEnum.DATES_INCOMPATIBLE);
    expect(body.note, 'Janvier');
    expect(refused.status, ReservationStatus.refused);
  });

  test('a blank note is not sent', () async {
    when(() => api.cancelIncomingReservation(id: 'r-1', ownerDecisionRequest: any(named: 'ownerDecisionRequest')))
        .thenAnswer((_) async => _ok(_response('r-1', status: ReservationResponseStatusEnum.CANCELLED)));

    await repository.cancel('r-1', reason: RefusalReason.other, note: '  ');

    final body = verify(
      () => api.cancelIncomingReservation(id: 'r-1', ownerDecisionRequest: captureAny(named: 'ownerDecisionRequest')),
    ).captured.single as OwnerDecisionRequest;
    expect(body.note, isNull);
  });

  for (final (code, reason) in const [
    ('RESERVATION_CLOSED', DecisionRefusal.closed),
    ('LISTING_NOT_RESERVABLE', DecisionRefusal.notReservable),
    ('RESERVATION_ALREADY_EXTENDED', DecisionRefusal.alreadyExtended),
    ('RESERVATION_NOT_ACCEPTED', DecisionRefusal.notAccepted),
  ]) {
    test('$code is told as ${reason.name}', () async {
      when(() => api.acceptReservation(id: 'r-1')).thenThrow(_refused(code));

      await expectLater(
        repository.accept('r-1'),
        throwsA(isA<ReservationDecisionRefused>().having((e) => e.reason, 'reason', reason)),
      );
    });
  }

  test('anything else is rethrown', () async {
    when(() => api.extendReservation(id: 'r-1')).thenThrow(_offline);

    await expectLater(repository.extend('r-1'), throwsA(isA<DioException>()));
  });
}
