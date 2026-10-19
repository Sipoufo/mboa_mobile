import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/reservations/data/reservations_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockReservationsApi extends Mock implements RservationsApi {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/reservations'));

DioException _refused(String code, {int status = 409}) => DioException(
      requestOptions: RequestOptions(path: '/reservations'),
      response: Response(
        requestOptions: RequestOptions(path: '/reservations'),
        statusCode: status,
        data: {'error': code},
      ),
    );

DioException get _offline => DioException(
      requestOptions: RequestOptions(path: '/reservations'),
      type: DioExceptionType.connectionError,
    );

ReservationResponse _response(String id, {ReservationResponseStatusEnum? status}) => ReservationResponse(
      (b) => b
        ..id = id
        ..annonceId = 'a-1'
        ..annonceTitle = 'Studio Bonapriso'
        ..desiredStartDate = Date(2026, 11, 1)
        ..durationUnits = 6
        ..rentalPeriod = ReservationResponseRentalPeriodEnum.MONTH
        ..status = status ?? ReservationResponseStatusEnum.PENDING
        ..canCancel = true,
    );

/// CDC M29 — the tenant's requests, on the wire and in the cache.
void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockReservationsApi api;
  late MockHiveCache cache;
  late ReservationsRepository repository;

  setUpAll(() {
    registerFallbackValue(
      CreateReservationRequest(
        (b) => b
          ..annonceId = 'x'
          ..desiredStartDate = Date(2026, 1, 1)
          ..durationUnits = 1,
      ),
    );
    registerFallbackValue(Pageable());
  });

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    api = MockReservationsApi();
    cache = MockHiveCache();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getRservationsApi).thenReturn(api);
    when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});
    when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn(null);
    repository = ReservationsRepository(dioClient: dioClient, cache: cache);
  });

  group('request', () {
    test('sends the listing, the day, the duration — and no amount', () async {
      when(() => api.requestReservation(createReservationRequest: any(named: 'createReservationRequest')))
          .thenAnswer((_) async => _ok(_response('r-1')));

      final sent = await repository.request(
        annonceId: 'a-1',
        start: DateTime(2026, 11, 1, 15, 30),
        units: 6,
        message: '  Bonjour  ',
      );

      final body = verify(
        () => api.requestReservation(createReservationRequest: captureAny(named: 'createReservationRequest')),
      ).captured.single as CreateReservationRequest;
      expect(body.annonceId, 'a-1');
      expect(body.desiredStartDate, Date(2026, 11, 1));
      expect(body.durationUnits, 6);
      expect(body.message, 'Bonjour');
      expect(sent.id, 'r-1');
      expect(sent.status, ReservationStatus.pending);
    });

    test('a blank message is not sent', () async {
      when(() => api.requestReservation(createReservationRequest: any(named: 'createReservationRequest')))
          .thenAnswer((_) async => _ok(_response('r-1')));

      await repository.request(annonceId: 'a-1', start: DateTime(2026, 11, 1), units: 1, message: '   ');

      final body = verify(
        () => api.requestReservation(createReservationRequest: captureAny(named: 'createReservationRequest')),
      ).captured.single as CreateReservationRequest;
      expect(body.message, isNull);
    });

    for (final (code, reason) in const [
      ('LISTING_NOT_RESERVABLE', RequestRefusal.notReservable),
      ('PROFILE_INCOMPLETE', RequestRefusal.profileIncomplete),
      ('RESERVATION_ALREADY_ACTIVE', RequestRefusal.alreadyActive),
      ('RESERVATION_LIMIT_REACHED', RequestRefusal.limitReached),
      ('RESERVATION_START_PAST', RequestRefusal.startPast),
      ('RESERVATION_START_TOO_FAR', RequestRefusal.startTooFar),
    ]) {
      test('$code is told as ${reason.name}', () async {
        when(() => api.requestReservation(createReservationRequest: any(named: 'createReservationRequest')))
            .thenThrow(_refused(code));

        await expectLater(
          repository.request(annonceId: 'a-1', start: DateTime(2026, 11, 1), units: 1),
          throwsA(isA<ReservationRequestRefused>().having((e) => e.reason, 'reason', reason)),
        );
      });
    }

    test('anything else is rethrown as is', () async {
      when(() => api.requestReservation(createReservationRequest: any(named: 'createReservationRequest')))
          .thenThrow(_offline);

      await expectLater(
        repository.request(annonceId: 'a-1', start: DateTime(2026, 11, 1), units: 1),
        throwsA(isA<DioException>()),
      );
    });
  });

  group('mine', () {
    test('reads the list and keeps a copy for offline', () async {
      when(() => api.listMyReservations(pageable: any(named: 'pageable'))).thenAnswer(
        (_) async => _ok(PageResponseReservationResponse((b) => b..content = ListBuilder([_response('r-1')]))),
      );

      final page = await repository.mine();

      expect(page.fromCache, isFalse);
      expect(page.items.single.id, 'r-1');
      final stored = verify(() => cache.put(StorageKeys.reservationsBox, 'mine', captureAny())).captured.single as Map;
      expect((stored['items'] as List).single, containsPair('id', 'r-1'));
    });

    test('offline, the last list read — marked as such', () async {
      when(() => api.listMyReservations(pageable: any(named: 'pageable'))).thenThrow(_offline);
      when(() => cache.get(StorageKeys.reservationsBox, 'mine', ttl: any(named: 'ttl'))).thenReturn({
        'items': [Reservation.fromResponse(_response('r-1')).toCache()],
      });

      final page = await repository.mine();

      expect(page.fromCache, isTrue);
      expect(page.items.single.id, 'r-1');
      expect(page.items.single.status, ReservationStatus.pending);
      expect(page.items.single.durationUnits, 6);
    });

    test('offline with nothing kept is a failure', () async {
      when(() => api.listMyReservations(pageable: any(named: 'pageable'))).thenThrow(_offline);

      await expectLater(repository.mine(), throwsA(isA<DioException>()));
    });
  });

  test('cancel returns the request as the server now has it', () async {
    when(() => api.cancelMyReservation(id: 'r-1'))
        .thenAnswer((_) async => _ok(_response('r-1', status: ReservationResponseStatusEnum.CANCELLED)));

    final cancelled = await repository.cancel('r-1');

    expect(cancelled.status, ReservationStatus.cancelled);
  });
}
