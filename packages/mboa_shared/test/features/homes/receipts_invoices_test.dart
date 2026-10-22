import 'package:api_client/api_client.dart' as api;
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

class MockMonLogementApi extends Mock implements api.MonLogementApi {}

class MockQuittancesApi extends Mock implements api.QuittancesApi {}

class MockInvoicesTenantApi extends Mock implements api.InvoicesTenantApi {}

class MockHiveCache extends Mock implements HiveCache {}

class MockDio extends Mock implements Dio {}

class _FakeDeclareInvoice extends Fake implements api.DeclareInvoicePaymentRequest {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/x'));

DioException _refused(String code, {int status = 409}) => DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response(requestOptions: RequestOptions(path: '/x'), statusCode: status, data: {'error': code}),
    );

DioException get _offline => DioException(requestOptions: RequestOptions(path: '/x'), type: DioExceptionType.connectionError);

api.InvoiceResponse _invoice(String id, {String contractId = 'c-1', api.InvoiceResponseStatusEnum? status}) =>
    api.InvoiceResponse(
      (b) => b
        ..id = id
        ..contractId = contractId
        ..annonceTitle = 'Studio Akwa'
        ..kind = api.InvoiceResponseKindEnum.ELECTRICITY
        ..label = 'Électricité — septembre'
        ..amount = 12000
        ..dueDate = api.Date(2026, 10, 30)
        ..status = status ?? api.InvoiceResponseStatusEnum.TO_PAY,
    );

/// CDC M30 slices D and E — a confirmed payment's receipt, and an invoice
/// declared paid.
void main() {
  group('the models', () {
    test('a confirmed declaration names its receipt; an invoice declaration its invoice', () {
      final d = Declaration.fromResponse(
        api.DeclarationResponse(
          (b) => b
            ..id = 'd-1'
            ..kind = api.DeclarationResponseKindEnum.INVOICE
            ..invoiceId = 'i-1'
            ..amount = 12000
            ..status = api.DeclarationResponseStatusEnum.CONFIRMED
            ..receiptId = 'r-1'
            ..receiptReady = false,
        ),
      );

      expect(d.kind, DeclarationKind.invoice);
      expect(d.invoiceId, 'i-1');
      expect(d.receiptId, 'r-1');
      expect(d.receiptReady, isFalse);

      // The offline copy keeps which receipt and which invoice, not whether
      // the PDF was ready: that is asked again online.
      final copy = Declaration.fromCache(d.toCache());
      expect(copy?.kind, DeclarationKind.invoice);
      expect(copy?.invoiceId, 'i-1');
      expect(copy?.receiptId, 'r-1');
    });

    test('an invoice reads the server\'s status; open means it can be declared', () {
      final invoice = HomeInvoice.fromResponse(
        _invoice('i-1', status: api.InvoiceResponseStatusEnum.OVERDUE)
            .rebuild((b) => b..paidVia = api.InvoiceResponsePaidViaEnum.DECLARED),
      );

      expect(invoice.kind, InvoiceKind.electricity);
      expect(invoice.status, InvoiceStatus.overdue);
      expect(invoice.status.isOpen, isTrue);
      expect(InvoiceStatus.paid.isOpen, isFalse);
      expect(InvoiceStatus.cancelled.isOpen, isFalse);
      expect(invoice.paidViaDeclaration, isTrue);
      expect(HomeInvoice.fromCache(invoice.toCache()), invoice);
    });

    test('INVOICE pushes are known (slice E)', () {
      expect(PushType.parse('INVOICE'), PushType.invoice);
    });
  });

  group('the repository', () {
    late MockMonLogementApi monLogement;
    late MockQuittancesApi quittances;
    late MockInvoicesTenantApi invoices;
    late MockHiveCache cache;
    late HomesRepository repository;

    setUpAll(() {
      registerFallbackValue(api.Pageable());
      registerFallbackValue(_FakeDeclareInvoice());
    });

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      monLogement = MockMonLogementApi();
      quittances = MockQuittancesApi();
      invoices = MockInvoicesTenantApi();
      cache = MockHiveCache();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getMonLogementApi).thenReturn(monLogement);
      when(apiClient.getQuittancesApi).thenReturn(quittances);
      when(apiClient.getInvoicesTenantApi).thenReturn(invoices);
      when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn(null);
      repository = HomesRepository(dioClient: dioClient, cache: cache);
    });

    test('a receipt\'s PDF is a short-lived link', () async {
      when(() => quittances.getReceiptPdf(receiptId: 'r-1'))
          .thenAnswer((_) async => _ok(api.ReceiptPdfResponse((b) => b..downloadUrl = 'https://r2/r-1.pdf')));

      expect(await repository.receiptPdfUrl('r-1'), 'https://r2/r-1.pdf');
    });

    test('CA-M30-02 — while it is made, "not ready", not a failure', () async {
      when(() => quittances.getReceiptPdf(receiptId: 'r-1')).thenThrow(_refused('RECEIPT_NOT_READY'));

      await expectLater(repository.receiptPdfUrl('r-1'), throwsA(isA<ReceiptNotReady>()));
    });

    test('one tenancy\'s invoices — the API lists them all — kept for offline', () async {
      when(() => invoices.listMyInvoices(pageable: any(named: 'pageable'))).thenAnswer(
        (_) async => _ok(
          api.PageResponseInvoiceResponse((b) => b..content = ListBuilder([_invoice('i-1'), _invoice('i-2', contractId: 'c-2')])),
        ),
      );

      final read = await repository.invoices(contractId: 'c-1');

      expect(read.value.map((i) => i.id), ['i-1']);
      expect(read.fromCache, isFalse);
      final kept = verify(() => cache.put(StorageKeys.homesBox, 'invoices', captureAny())).captured.single as Map;
      // All of them kept: another tenancy's screen reads the same copy.
      expect((kept['items'] as List).length, 2);
    });

    test('offline, the copy — narrowed the same way', () async {
      when(() => invoices.listMyInvoices(pageable: any(named: 'pageable'))).thenThrow(_offline);
      when(() => cache.get(StorageKeys.homesBox, 'invoices', ttl: any(named: 'ttl'))).thenReturn({
        'items': [
          HomeInvoice.fromResponse(_invoice('i-1')).toCache(),
          HomeInvoice.fromResponse(_invoice('i-2', contractId: 'c-2')).toCache(),
        ],
      });

      final read = await repository.invoices(contractId: 'c-2');

      expect(read.fromCache, isTrue);
      expect(read.value.map((i) => i.id), ['i-2']);
    });

    test('offline with no copy: the failure', () async {
      when(() => invoices.listMyInvoices(pageable: any(named: 'pageable'))).thenThrow(_offline);

      await expectLater(repository.invoices(), throwsA(isA<DioException>()));
    });

    test('declaring an invoice paid sends what the form says, on the invoice', () async {
      when(
        () => monLogement.declareInvoicePayment(
          invoiceId: 'i-1',
          declareInvoicePaymentRequest: any(named: 'declareInvoicePaymentRequest'),
        ),
      ).thenAnswer(
        (_) async => _ok(
          api.DeclarationResponse(
            (b) => b
              ..id = 'd-9'
              ..kind = api.DeclarationResponseKindEnum.INVOICE
              ..invoiceId = 'i-1'
              ..amount = 5000
              ..status = api.DeclarationResponseStatusEnum.DECLARED,
          ),
        ),
      );

      final sent = await repository.declareInvoice(
        'i-1',
        DeclarationDraft(
          kind: DeclarationKind.invoice,
          amount: 5000,
          paidOn: DateTime(2026, 10, 21),
          method: RentPaymentMethod.cash,
          reference: '  ',
          proofKeys: const ['proof/1.jpg'],
        ),
      );

      final body = verify(
        () => monLogement.declareInvoicePayment(
          invoiceId: 'i-1',
          declareInvoicePaymentRequest: captureAny(named: 'declareInvoicePaymentRequest'),
        ),
      ).captured.single as api.DeclareInvoicePaymentRequest;
      expect(body.amount, 5000);
      expect(body.method, api.DeclareInvoicePaymentRequestMethodEnum.CASH);
      expect(body.reference, isNull);
      expect(body.proofKeys, ['proof/1.jpg']);
      expect(sent.kind, DeclarationKind.invoice);
    });

    test('an invoice settled meanwhile is told as such', () async {
      when(
        () => monLogement.declareInvoicePayment(
          invoiceId: 'i-1',
          declareInvoicePaymentRequest: any(named: 'declareInvoicePaymentRequest'),
        ),
      ).thenThrow(_refused('INVOICE_SETTLED'));

      await expectLater(
        repository.declareInvoice(
          'i-1',
          DeclarationDraft(kind: DeclarationKind.invoice, amount: 1, paidOn: DateTime(2026, 10, 21), method: RentPaymentMethod.cash),
        ),
        throwsA(isA<DeclarationRefused>().having((e) => e.reason, 'reason', DeclarationRefusal.invoiceSettled)),
      );
    });

    test('an invoice and its declarations', () async {
      when(() => invoices.getMyInvoice(id: 'i-1')).thenAnswer((_) async => _ok(_invoice('i-1')));
      when(() => monLogement.listInvoiceDeclarations(invoiceId: 'i-1', pageable: any(named: 'pageable'))).thenAnswer(
        (_) async => _ok(
          api.PageResponseDeclarationResponse(
            (b) => b
              ..content = ListBuilder([
                api.DeclarationResponse((d) => d
                  ..id = 'd-1'
                  ..kind = api.DeclarationResponseKindEnum.INVOICE),
              ]),
          ),
        ),
      );

      expect((await repository.invoice('i-1')).value.label, 'Électricité — septembre');
      expect((await repository.invoiceDeclarations('i-1')).single.id, 'd-1');
    });
  });

  group('one invoice, offline', () {
    late MockInvoicesTenantApi invoices;
    late MockHiveCache cache;
    late HomesRepository repository;

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      invoices = MockInvoicesTenantApi();
      cache = MockHiveCache();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getInvoicesTenantApi).thenReturn(invoices);
      when(() => invoices.getMyInvoice(id: any(named: 'id'))).thenThrow(_offline);
      repository = HomesRepository(dioClient: dioClient, cache: cache);
    });

    test('the copy kept with the list, marked', () async {
      when(() => cache.get(StorageKeys.homesBox, 'invoices', ttl: any(named: 'ttl'))).thenReturn({
        'items': [HomeInvoice.fromResponse(_invoice('i-1')).toCache(), HomeInvoice.fromResponse(_invoice('i-2')).toCache()],
      });

      final read = await repository.invoice('i-2');

      expect(read.value.id, 'i-2');
      expect(read.fromCache, isTrue);
    });

    test('not in the copy: the failure', () async {
      when(() => cache.get(StorageKeys.homesBox, 'invoices', ttl: any(named: 'ttl'))).thenReturn({
        'items': [HomeInvoice.fromResponse(_invoice('i-1')).toCache()],
      });

      await expectLater(repository.invoice('i-9'), throwsA(isA<DioException>()));
    });
  });

  group('the PDF', () {
    test('a link is fetched as bytes by a client of its own', () async {
      final dio = MockDio();
      when(() => dio.get<List<int>>(any(), options: any(named: 'options'))).thenAnswer(
        (_) async => Response(requestOptions: RequestOptions(path: '/r'), data: const <int>[]),
      );

      // Empty: refused before anything is written or offered.
      await expectLater(PdfSharer(client: dio).shareLink('https://r2/r-1.pdf', name: 'Quittance'), throwsStateError);
      final options = verify(() => dio.get<List<int>>('https://r2/r-1.pdf', options: captureAny(named: 'options')))
          .captured
          .single as Options;
      expect(options.responseType, ResponseType.bytes);
    });
  });
}
