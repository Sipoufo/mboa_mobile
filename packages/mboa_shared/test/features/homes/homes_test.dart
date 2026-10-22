import 'package:api_client/api_client.dart' as api;
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

class MockMonLogementApi extends Mock implements api.MonLogementApi {}

class MockHiveCache extends Mock implements HiveCache {}

class _FakeDeclare extends Fake implements api.DeclarePaymentRequest {}

class _FakeContest extends Fake implements api.ContestDeclarationRequest {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/homes'));

DioException _refused(String code) => DioException(
      requestOptions: RequestOptions(path: '/homes'),
      response: Response(requestOptions: RequestOptions(path: '/homes'), statusCode: 409, data: {'error': code}),
    );

DioException get _offline =>
    DioException(requestOptions: RequestOptions(path: '/homes'), type: DioExceptionType.connectionError);

api.HomeSummary _summary() => api.HomeSummary(
      (b) => b
        ..contractId = 'c-1'
        ..annonceTitle = 'Studio Akwa'
        ..state = api.HomeSummaryStateEnum.ACTIVE
        ..rent = 150000
        ..rentalPeriod = api.HomeSummaryRentalPeriodEnum.MONTH
        ..depositAmount = 300000
        ..deposit.amount = 300000
        ..deposit.status = api.HomeDepositStatusEnum.CONTESTED
        ..startDate = api.Date(2026, 10, 18)
        ..tacitRenewal = true
        ..tenant.displayName = 'Awa Nkeng'
        ..prestataire.displayName = 'Agence Deido'
        ..nextDue.index = 3
        ..nextDue.amount = 150000
        ..nextDue.confirmedTotal = 50000
        ..nextDue.status = api.DueStatusEnum.LATE
        ..nextDue.late_ = true
        ..overdueCount = 1
        ..overdueAmount = 100000,
    );

api.Due _due(int index, api.DueStatusEnum status) => api.Due(
      (b) => b
        ..index = index
        ..dueDate = api.Date(2026, 10 + index, 18)
        ..amount = 150000
        ..status = status,
    );

api.DeclarationResponse _declaration(String id, {api.DeclarationResponseStatusEnum? status}) =>
    api.DeclarationResponse(
      (b) => b
        ..id = id
        ..contractId = 'c-1'
        ..kind = api.DeclarationResponseKindEnum.RENT
        ..dueIndexes = ListBuilder([0, 1, 2])
        ..amount = 450000
        ..paidOn = api.Date(2026, 10, 20)
        ..method = api.DeclarationResponseMethodEnum.ORANGE_MONEY
        ..hasProof = false
        ..status = status ?? api.DeclarationResponseStatusEnum.DECLARED
        ..canConfirm = true,
    );

/// CDC M30 — "Mon Logement": what the server says, kept as it said it.
void main() {
  group('the models', () {
    test('a space reads the server\'s verdicts — lateness, partial payment, the deposit', () {
      final home = Home.fromResponse(_summary());

      expect(home.state, HomeStage.active);
      expect(home.rentalPeriod, RentalPeriod.month);
      expect(home.deposit.status, DepositStatus.contested);
      expect(home.deposit.status.isOpen, isTrue);
      expect(home.nextDue!.late, isTrue);
      expect(home.nextDue!.isPartlyPaid, isTrue);
      expect(home.nextDue!.remaining, 100000);
      expect(home.isOverdue, isTrue);
      expect(home.tenant?.displayName, 'Awa Nkeng');
    });

    test('a tracking start reads as such, never as late', () {
      final due = RentDue.fromResponse(_due(0, api.DueStatusEnum.UNTRACKED));

      expect(due.status, DueStatus.untracked);
      expect(due.status.isOpen, isFalse);
      expect(due.late, isFalse);
    });

    test('a space, its schedule and a declaration survive the device\'s copy', () {
      final home = Home.fromResponse(_summary());
      final schedule = RentSchedule.fromResponse(
        api.HomeSchedule((b) => b
          ..dues = ListBuilder([_due(0, api.DueStatusEnum.CONFIRMED), _due(1, api.DueStatusEnum.DUE)])
          ..moreAfter = true),
      );
      final declaration = Declaration.fromResponse(_declaration('d-1'));

      final readBack = Home.fromCache(home.toCache())!;
      expect(readBack.nextDue, home.nextDue);
      expect(readBack.deposit, home.deposit);
      expect(readBack.tenant?.displayName, 'Awa Nkeng');
      expect(RentSchedule.fromCache(schedule.toCache()), schedule);
      final declarationBack = Declaration.fromCache(declaration.toCache())!;
      expect(declarationBack.dueIndexes, [0, 1, 2]);
      expect(declarationBack.method, RentPaymentMethod.orangeMoney);
      expect(declarationBack.hasProof, isFalse);
    });

    test('paging back puts the older échéances first, without doubles', () {
      final now = RentSchedule.fromResponse(
        api.HomeSchedule((b) => b..dues = ListBuilder([_due(2, api.DueStatusEnum.DUE), _due(3, api.DueStatusEnum.UPCOMING)])),
      );
      final older = RentSchedule.fromResponse(
        api.HomeSchedule((b) => b
          ..dues = ListBuilder([_due(1, api.DueStatusEnum.CONFIRMED), _due(2, api.DueStatusEnum.DUE)])
          ..moreBefore = true),
      );

      final both = now.prepend(older);
      expect(both.dues.map((d) => d.index), [1, 2, 3]);
      expect(both.moreBefore, isTrue);
    });

    test('HOME pushes are known (M30)', () {
      expect(PushType.parse('HOME'), PushType.home);
    });
  });

  group('the repository', () {
    late MockMonLogementApi monLogement;
    late MockHiveCache cache;
    late HomesRepository repository;

    setUpAll(() {
      registerFallbackValue(api.Pageable());
      registerFallbackValue(_FakeDeclare());
      registerFallbackValue(_FakeContest());
    });

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      monLogement = MockMonLogementApi();
      cache = MockHiveCache();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getMonLogementApi).thenReturn(monLogement);
      when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn(null);
      repository = HomesRepository(dioClient: dioClient, cache: cache);
    });

    void online() {
      when(() => monLogement.getHome(contractId: 'c-1')).thenAnswer(
        (_) async => _ok(api.HomeDetail((b) => b
          ..home.replace(_summary())
          ..schedule.dues = ListBuilder([_due(0, api.DueStatusEnum.DUE)]))),
      );
      when(() => monLogement.listHomeDeclarations(contractId: 'c-1', pageable: any(named: 'pageable'))).thenAnswer(
        (_) async => _ok(api.PageResponseDeclarationResponse((b) => b..content = ListBuilder([_declaration('d-1')]))),
      );
      when(() => monLogement.getHomeFinanceSummary(contractId: 'c-1')).thenAnswer(
        (_) async => _ok(api.HomeFinanceSummary((b) => b
          ..confirmedTotal = 500000
          ..declaredTotal = 450000)),
      );
    }

    test('one space is read whole, and kept for offline', () async {
      online();

      final read = await repository.bundle('c-1');

      expect(read.fromCache, isFalse);
      expect(read.value.schedule.dues.single.status, DueStatus.due);
      expect(read.value.declarations.single.id, 'd-1');
      expect(read.value.totals?.confirmedTotal, 500000);
      verify(() => cache.put(StorageKeys.homesBox, 'home:c-1', any())).called(1);
    });

    test('slice D — the receipts come with the space, and are kept with it', () async {
      online();
      when(() => monLogement.listHomeReceipts(contractId: 'c-1', pageable: any(named: 'pageable'))).thenAnswer(
        (_) async => _ok(
          api.PageResponseHomeReceiptResponse(
            (b) => b
              ..content = ListBuilder([
                api.HomeReceiptResponse((r) => r
                  ..id = 'r-1'
                  ..declarationId = 'd-1'
                  ..kind = api.HomeReceiptResponseKindEnum.RENT
                  ..amount = 150000
                  ..ready = true),
              ]),
          ),
        ),
      );

      final read = await repository.bundle('c-1');

      expect(read.value.receipts.single.kind, ReceiptKind.rent);
      final kept = verify(() => cache.put(StorageKeys.homesBox, 'home:c-1', captureAny())).captured.single as Map;
      expect((kept['receipts'] as List).single, containsPair('id', 'r-1'));
    });

    test('receipts that do not come spoil nothing, and keep the last list read', () async {
      online();
      when(() => monLogement.listHomeReceipts(contractId: 'c-1', pageable: any(named: 'pageable'))).thenThrow(_offline);
      when(() => cache.get(StorageKeys.homesBox, 'home:c-1', ttl: any(named: 'ttl'))).thenReturn({
        'receipts': [const HomeReceipt(id: 'r-0', declarationId: 'd-0', ready: true).toCache()],
      });

      final read = await repository.bundle('c-1');

      expect(read.fromCache, isFalse);
      expect(read.value.declarations.single.id, 'd-1');
      expect(read.value.receipts.single.id, 'r-0');
    });

    test('offline, the copy — and the failure when there is none', () async {
      online();
      final stored = <String, dynamic>{};
      when(() => cache.put(StorageKeys.homesBox, 'home:c-1', any())).thenAnswer((invocation) async {
        stored.addAll(invocation.positionalArguments[2] as Map<String, dynamic>);
      });
      await repository.bundle('c-1');

      when(() => monLogement.getHome(contractId: 'c-1')).thenThrow(_offline);
      when(() => cache.get(StorageKeys.homesBox, 'home:c-1', ttl: any(named: 'ttl'))).thenReturn(stored);
      final offline = await repository.bundle('c-1');
      expect(offline.fromCache, isTrue);
      expect(offline.value.home.annonceTitle, 'Studio Akwa');
      expect(offline.value.declarations.single.id, 'd-1');

      when(() => cache.get(StorageKeys.homesBox, 'home:c-1', ttl: any(named: 'ttl'))).thenReturn(null);
      await expectLater(repository.bundle('c-1'), throwsA(isA<DioException>()));
    });

    test('RM-M30-03 — several months at once: the indexes, the total, no amount checked here', () async {
      when(() => monLogement.declarePayment(contractId: 'c-1', declarePaymentRequest: any(named: 'declarePaymentRequest')))
          .thenAnswer((_) async => _ok(_declaration('d-2')));

      await repository.declare(
        'c-1',
        DeclarationDraft(
          kind: DeclarationKind.rent,
          dueIndexes: const [3, 4, 5],
          amount: 450000,
          paidOn: DateTime(2026, 10, 20),
          method: RentPaymentMethod.mobileMoney,
          reference: '  MP2610.1234  ',
          proofKeys: const ['proof/1.jpg'],
        ),
      );

      final body = verify(
        () => monLogement.declarePayment(contractId: 'c-1', declarePaymentRequest: captureAny(named: 'declarePaymentRequest')),
      ).captured.single as api.DeclarePaymentRequest;
      expect(body.kind, api.DeclarePaymentRequestKindEnum.RENT);
      expect(body.dueIndexes!.toList(), [3, 4, 5]);
      expect(body.amount, 450000);
      expect(body.paidOn, api.Date(2026, 10, 20));
      expect(body.method, api.DeclarePaymentRequestMethodEnum.MOBILE_MONEY);
      expect(body.reference, 'MP2610.1234');
      expect(body.proofKeys!.toList(), ['proof/1.jpg']);
    });

    test('the deposit names no échéance', () async {
      when(() => monLogement.declarePayment(contractId: 'c-1', declarePaymentRequest: any(named: 'declarePaymentRequest')))
          .thenAnswer((_) async => _ok(_declaration('d-3')));

      await repository.declare(
        'c-1',
        DeclarationDraft(
          kind: DeclarationKind.deposit,
          dueIndexes: const [9],
          amount: 300000,
          paidOn: DateTime(2026, 10, 20),
          method: RentPaymentMethod.cash,
        ),
      );

      final body = verify(
        () => monLogement.declarePayment(contractId: 'c-1', declarePaymentRequest: captureAny(named: 'declarePaymentRequest')),
      ).captured.single as api.DeclarePaymentRequest;
      expect(body.kind, api.DeclarePaymentRequestKindEnum.DEPOSIT);
      expect(body.dueIndexes, isNull);
      expect(body.proofKeys, isNull);
    });

    for (final (code, reason) in const [
      ('DECLARATION_AMOUNT_INVALID', DeclarationRefusal.amountInvalid),
      ('DUE_INDEXES_INVALID', DeclarationRefusal.duesInvalid),
      ('DUE_ALREADY_CONFIRMED', DeclarationRefusal.dueAlreadyConfirmed),
      ('HOME_READ_ONLY', DeclarationRefusal.readOnly),
      ('DECLARATION_ANSWERED', DeclarationRefusal.answered),
      ('CONTEST_REASON_REQUIRED', DeclarationRefusal.contestReasonRequired),
    ]) {
      test('$code is told as ${reason.name}', () async {
        when(() => monLogement.confirmDeclaration(declarationId: 'd-1')).thenThrow(_refused(code));

        await expectLater(
          repository.confirm('d-1'),
          throwsA(isA<DeclarationRefused>().having((e) => e.reason, 'reason', reason)),
        );
      });
    }

    test('the landlord\'s counter is the server\'s total, of what waits', () async {
      when(
        () => monLogement.listMyReceivedDeclarations(pageable: any(named: 'pageable'), status: any(named: 'status')),
      ).thenAnswer((_) async => _ok(api.PageResponseDeclarationResponse((b) => b..totalElements = 4)));

      expect(await repository.waitingCount(), 4);
      final status = verify(
        () => monLogement.listMyReceivedDeclarations(pageable: any(named: 'pageable'), status: captureAny(named: 'status')),
      ).captured.single as BuiltList<String>;
      expect(status, ['DECLARED', 'UNCONFIRMED']);
    });

    test('a contest carries its reason, trimmed', () async {
      when(() => monLogement.contestDeclaration(declarationId: 'd-1', contestDeclarationRequest: any(named: 'contestDeclarationRequest')))
          .thenAnswer((_) async => _ok(_declaration('d-1', status: api.DeclarationResponseStatusEnum.CONTESTED)));

      final contested = await repository.contest('d-1', reason: '  Rien reçu sur Orange Money  ');

      final body = verify(
        () => monLogement.contestDeclaration(
          declarationId: 'd-1',
          contestDeclarationRequest: captureAny(named: 'contestDeclarationRequest'),
        ),
      ).captured.single as api.ContestDeclarationRequest;
      expect(body.reason, 'Rien reçu sur Orange Money');
      expect(contested.status, DeclarationStatus.contested);
    });
  });
}
