import 'dart:typed_data';

import 'package:api_client/api_client.dart' as api;
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

class MockPastHomesApi extends Mock implements api.MesAnciensLogementsApi {}

class MockMonLogementApi extends Mock implements api.MonLogementApi {}

class MockHiveCache extends Mock implements HiveCache {}

class MockDio extends Mock implements Dio {}

class _FakePageable extends Fake implements api.Pageable {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/x'));

final _offline = DioException(requestOptions: RequestOptions(path: '/x'), type: DioExceptionType.connectionError);

api.HomeSummary _summary() => api.HomeSummary((b) => b
  ..contractId = 'c-1'
  ..annonceTitle = 'Studio à Bastos'
  ..city = 'Yaoundé'
  ..district = 'Bastos'
  ..rent = 80000
  ..depositAmount = 160000
  ..startDate = api.Date(2025, 1, 1)
  ..endDate = api.Date(2026, 9, 30));

api.PastPayment _payment(String id, {String status = 'CONFIRMED', String kind = 'RENT', String? receiptId}) =>
    api.PastPayment((b) => b
      ..declarationId = id
      ..kind = api.PastPaymentKindEnum.valueOf(kind)
      ..label = 'Loyer de septembre 2026'
      ..amount = 80000
      ..paidOn = api.Date(2026, 9, 2)
      ..status = api.PastPaymentStatusEnum.valueOf(status)
      ..receiptId = receiptId
      ..receiptReady = receiptId != null);

api.PastHomeResponse _response({bool withRating = true}) => api.PastHomeResponse((b) => b
  ..home.replace(_summary())
  ..listingOnline = true
  ..verificationCode = 'MB-7K2P'
  ..expenses.replace(api.PastHomeExpenses((e) => e
    ..confirmedTotal = 1360000
    ..byYear = ListBuilder([
      api.YearTotal((y) => y
        ..year = 2026
        ..total = 720000),
      api.YearTotal((y) => y
        ..year = 2025
        ..total = 640000),
    ])
    ..confirmed = ListBuilder([_payment('d-1', receiptId: 'r-1'), _payment('d-2', kind: 'INVOICE')])
    ..notConfirmed = ListBuilder([_payment('d-3', status: 'CONTESTED')])))
  ..requestCount = 4
  ..openRequestCount = 1
  ..rating = withRating
      ? (api.PropertyRatingBuilder()
        ..average = 4.2
        ..reviewCount = 7)
      : null
  ..myReview.replace(api.PastHomeReview((r) => r
    ..reviewId = 'rv-1'
    ..rating = 4
    ..canEdit = true
    ..editableUntil = DateTime.utc(2026, 11, 15))));

/// CDC M31 — « Mes anciens logements ».
void main() {
  setUpAll(() => registerFallbackValue(_FakePageable()));

  group('an ended tenancy', () {
    test('reads the server: confirmed payments in the total, the others apart (RM-M31-03)', () {
      final past = PastHome.fromResponse(_response());

      expect(past.home.contractId, 'c-1');
      expect(past.home.deposit.amount, 160000);
      expect(past.listingOnline, isTrue);
      expect(past.verificationCode, 'MB-7K2P');
      expect(past.confirmedTotal, 1360000);
      expect(past.byYear, [(2026, 720000), (2025, 640000)]);
      expect(past.confirmed.map((p) => p.declarationId), ['d-1', 'd-2']);
      expect(past.confirmed.first.receiptId, 'r-1');
      expect(past.confirmed.first.receiptReady, isTrue);
      expect(past.confirmed.last.kind, DeclarationKind.invoice);
      expect(past.confirmed.first.paidOn, DateTime(2026, 9, 2));
      expect(past.notConfirmed.single.status, DeclarationStatus.contested);
      expect(past.requestCount, 4);
      expect(past.openRequestCount, 1);
      expect(past.myReview.canEdit, isTrue);
      expect(past.myReview.canWrite, isFalse);
      expect(past.myReview.editableUntil, DateTime.utc(2026, 11, 15).toLocal());
    });

    test('the rating is today\'s, and none without reviews (RM-M31-04)', () {
      expect(PastHome.fromResponse(_response()).rating.hasRating, isTrue);
      expect(PastHome.fromResponse(_response()).rating.average, 4.2);
      expect(PastHome.fromResponse(_response(withRating: false)).rating.hasRating, isFalse);
    });

    test('the offline copy keeps what is read, not what must be asked again', () {
      final past = PastHome.fromResponse(_response());
      final copy = PastHome.fromCache(past.toCache())!;

      expect(copy.home.contractId, 'c-1');
      expect(copy.confirmedTotal, past.confirmedTotal);
      expect(copy.byYear, past.byYear);
      expect(copy.confirmed.map((p) => p.declarationId), ['d-1', 'd-2']);
      expect(copy.confirmed.first.receiptId, 'r-1');
      expect(copy.confirmed.last.kind, DeclarationKind.invoice);
      expect(copy.notConfirmed.single.status, DeclarationStatus.contested);
      expect(copy.rating.average, 4.2);
      expect(copy.rating.reviewCount, 7);
      expect(copy.verificationCode, 'MB-7K2P');
      expect(copy.listingOnline, isTrue);
      expect(copy.requestCount, 4);
      expect(copy.openRequestCount, 1);
      expect(copy.myReview.rating, 4);
      // Rights are the server's, today: offline, nothing to write.
      expect(copy.myReview.canEdit, isFalse);
      expect(copy.confirmed.first.receiptReady, isFalse);
      expect(PastHome.fromCache('junk'), isNull);
      expect(PastHome.fromCache({'home': null}), isNull);
    });
  });

  group('the repository', () {
    late MockPastHomesApi pastApi;
    late MockHiveCache cache;
    late MockDio dio;
    late PastHomesRepository repository;
    late Map<String, Map<String, dynamic>> stored;

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      pastApi = MockPastHomesApi();
      cache = MockHiveCache();
      dio = MockDio();
      stored = {};
      when(() => dioClient.api).thenReturn(apiClient);
      when(() => dioClient.dio).thenReturn(dio);
      when(apiClient.getMesAnciensLogementsApi).thenReturn(pastApi);
      when(() => cache.put(StorageKeys.homesBox, any(), any())).thenAnswer((call) async {
        stored[call.positionalArguments[1] as String] = call.positionalArguments[2] as Map<String, dynamic>;
      });
      when(() => cache.get(StorageKeys.homesBox, any(), ttl: any(named: 'ttl')))
          .thenAnswer((call) => stored[call.positionalArguments[1] as String]);
      repository = PastHomesRepository(dioClient: dioClient, cache: cache);
    });

    test('lists the ended tenancies, and keeps them for offline', () async {
      when(() => pastApi.listMyPastHomes(pageable: any(named: 'pageable'))).thenAnswer(
        (_) async => _ok(api.PageResponseHomeSummary((b) => b..content = ListBuilder([_summary()]))),
      );
      final online = await repository.list();
      expect(online.fromCache, isFalse);
      expect(online.value.single.contractId, 'c-1');

      when(() => pastApi.listMyPastHomes(pageable: any(named: 'pageable'))).thenThrow(_offline);
      final offline = await repository.list();
      expect(offline.fromCache, isTrue);
      expect(offline.value.single.annonceTitle, 'Studio à Bastos');
    });

    test('offline with nothing kept, the error goes up', () async {
      when(() => pastApi.listMyPastHomes(pageable: any(named: 'pageable'))).thenThrow(_offline);
      await expectLater(repository.list(), throwsA(isA<DioException>()));
      when(() => pastApi.getMyPastHome(contractId: 'c-1')).thenThrow(_offline);
      await expectLater(repository.get('c-1'), throwsA(isA<DioException>()));
    });

    test('one tenancy, kept for offline under its own key', () async {
      when(() => pastApi.getMyPastHome(contractId: 'c-1')).thenAnswer((_) async => _ok(_response()));
      final online = await repository.get('c-1');
      expect(online.fromCache, isFalse);
      expect(online.value.confirmedTotal, 1360000);
      expect(stored.keys, contains('past-home:c-1'));

      when(() => pastApi.getMyPastHome(contractId: 'c-1')).thenThrow(_offline);
      final offline = await repository.get('c-1');
      expect(offline.fromCache, isTrue);
      expect(offline.value.confirmedTotal, 1360000);
    });

    test('the expenses statement is read as bytes, never as text', () async {
      when(() => dio.get<List<int>>(any(), options: any(named: 'options')))
          .thenAnswer((_) async => _ok<List<int>>([37, 80, 68, 70]));

      final pdf = await repository.expensesPdf('c-1');

      expect(pdf, Uint8List.fromList([37, 80, 68, 70]));
      final options = verify(
        () => dio.get<List<int>>('/api/v1/past-homes/c-1/expenses.pdf', options: captureAny(named: 'options')),
      ).captured.single as Options;
      expect(options.responseType, ResponseType.bytes);
    });

    test('an empty statement is an error, not a blank file', () async {
      when(() => dio.get<List<int>>(any(), options: any(named: 'options'))).thenAnswer((_) async => _ok<List<int>>([]));
      await expectLater(repository.expensesPdf('c-1'), throwsStateError);
    });
  });

  group('before / after (CA-M31-04)', () {
    api.EvidencePhotoResponse photo(String id, String phase, DateTime at) => api.EvidencePhotoResponse((b) => b
      ..id = id
      ..room = api.EvidencePhotoResponseRoomEnum.valueOf('KITCHEN')
      ..phase = api.EvidencePhotoResponsePhaseEnum.valueOf(phase)
      ..recordedAt = at
      ..downloadUrl = 'https://r2/$id.jpg');

    test('room by room, each side with its photos and their time', () async {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      final monLogement = MockMonLogementApi();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getMonLogementApi).thenReturn(monLogement);
      when(() => monLogement.compareEvidence(contractId: 'c-1')).thenAnswer(
        (_) async => _ok(
          BuiltList<api.EvidenceRoomComparison>([
            api.EvidenceRoomComparison((b) => b
              ..room = api.EvidenceRoomComparisonRoomEnum.valueOf('KITCHEN')
              ..entry = ListBuilder([photo('p-1', 'ENTRY', DateTime.utc(2025, 1, 2))])
              ..exit = ListBuilder([photo('p-2', 'EXIT', DateTime.utc(2026, 9, 30))])),
            api.EvidenceRoomComparison((b) => b
              ..room = api.EvidenceRoomComparisonRoomEnum.valueOf('OTHER')
              ..roomLabel = 'Balcon'
              ..entry = ListBuilder([photo('p-3', 'ENTRY', DateTime.utc(2025, 1, 2))])),
          ]),
        ),
      );

      final rooms = await EvidenceRepository(dioClient: dioClient, cache: MockHiveCache()).compare('c-1');

      expect(rooms.first.room, EvidenceRoom.kitchen);
      expect(rooms.first.isPaired, isTrue);
      expect(rooms.first.entry.single.recordedAt, DateTime.utc(2025, 1, 2).toLocal());
      expect(rooms.first.exit.single.downloadUrl, 'https://r2/p-2.jpg');
      expect(rooms.last.room, EvidenceRoom.other);
      expect(rooms.last.roomLabel, 'Balcon');
      expect(rooms.last.isPaired, isFalse);
      expect(rooms.last.exit, isEmpty);
    });
  });
}
