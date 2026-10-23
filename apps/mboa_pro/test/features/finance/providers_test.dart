import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/finance/bloc/provider_bloc.dart';
import 'package:mboa_pro/features/finance/bloc/provider_form_bloc.dart';
import 'package:mboa_pro/features/finance/bloc/provider_payment_form_bloc.dart';
import 'package:mboa_pro/features/finance/bloc/providers_bloc.dart';
import 'package:mboa_pro/features/finance/data/finance_properties.dart';
import 'package:mboa_pro/features/finance/data/providers_repository.dart';
import 'package:mboa_pro/features/finance/models/finance_refusal.dart';
import 'package:mboa_pro/features/finance/models/ledger.dart';
import 'package:mboa_pro/features/finance/models/service_provider.dart';
import 'package:mboa_pro/features/finance/ui/providers_pages.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';
import '../../_helpers/mocks/mocks.dart';

class MockProvidersApi extends Mock implements FinanceServiceProvidersApi {}

class MockMessagingRepository extends Mock implements MessagingRepository {}

class MockProvidersRepository extends Mock implements ProvidersRepository {}

class MockFinanceProperties extends Mock implements FinanceProperties {}

class MockProvidersBloc extends MockBloc<ProvidersEvent, ProvidersState> implements ProvidersBloc {}

class MockProviderBloc extends MockBloc<ProviderEvent, ProviderState> implements ProviderBloc {}

class MockProviderFormBloc extends MockBloc<ProviderFormEvent, ProviderFormState> implements ProviderFormBloc {}

class _FakeRequest extends Fake implements ServiceProviderRequest {}

class _FakeDraft extends Fake implements ProviderDraft {}

class _FakePaymentDraft extends Fake implements ProviderPaymentDraft {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/x'));

DioException _refused(String code) => DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response(requestOptions: RequestOptions(path: '/x'), statusCode: 409, data: {'error': code}),
    );

/// CDC M26 — the landlord's intervenants and what he paid them.
void main() {
  const plumber = ServiceProvider(
    id: 'p-1',
    name: 'Jean Mbarga',
    kind: ProviderKind.plumbing,
    linkedAccountId: 'acc-9',
    totalPaid: 85000,
    paymentCount: 2,
  );
  const caretaker = ServiceProvider(id: 'p-2', name: 'Paul', kind: ProviderKind.other, kindLabel: 'Gardien');

  setUpAll(() {
    registerFallbackValue(_FakeRequest());
    registerFallbackValue(_FakeDraft());
    registerFallbackValue(_FakePaymentDraft());
  });

  group('the repository', () {
    late MockProvidersApi api;
    late MockMessagingRepository messaging;
    late ProvidersRepository repository;

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      final cache = MockHiveCache();
      api = MockProvidersApi();
      messaging = MockMessagingRepository();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getFinanceServiceProvidersApi).thenReturn(api);
      when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn(null);
      repository = ProvidersRepository(dioClient: dioClient, cache: cache, messaging: messaging);
    });

    test('the contacts are the people he has a thread with — each once', () async {
      when(messaging.conversations).thenAnswer(
        (_) async => const [
          Conversation(id: 'c-1', peerAccountId: 'acc-9', peerName: 'Jean Mbarga'),
          Conversation(id: 'c-2', peerAccountId: 'acc-9', peerName: 'Jean Mbarga'),
          Conversation(id: 'c-3', peerAccountId: 'acc-7', peerName: 'Awa'),
          Conversation(id: 'c-4'),
        ],
      );

      expect(await repository.contacts(), const [
        ProviderContact(accountId: 'acc-9', name: 'Jean Mbarga'),
        ProviderContact(accountId: 'acc-7', name: 'Awa'),
      ]);
    });

    test('linked, the name is his account\'s: none sent; « Autre » carries its words', () async {
      when(() => api.createServiceProvider(serviceProviderRequest: any(named: 'serviceProviderRequest')))
          .thenAnswer((_) async => _ok(ServiceProviderResponse((b) => b
            ..id = 'p-1'
            ..name = 'Jean Mbarga')));

      await repository.create(const ProviderDraft(kind: ProviderKind.plumbing, name: 'typed', linkedAccountId: 'acc-9', kindLabel: 'x'));
      final sent = verify(() => api.createServiceProvider(serviceProviderRequest: captureAny(named: 'serviceProviderRequest')))
          .captured
          .single as ServiceProviderRequest;
      expect(sent.name, isNull);
      expect(sent.linkedAccountId, 'acc-9');
      expect(sent.kindLabel, isNull);
    });

    test('one with payments is archived, not deleted — said as such', () async {
      when(() => api.deleteServiceProvider(id: 'p-1')).thenThrow(_refused('SERVICE_PROVIDER_HAS_PAYMENTS'));
      await expectLater(
        repository.delete('p-1'),
        throwsA(isA<FinanceRefused>().having((r) => r.reason, 'reason', FinanceRefusal.providerHasPayments)),
      );
    });

    test('a payment on a residence goes as the residence', () async {
      registerFallbackValue(ServiceProviderPaymentRequest((b) => b
        ..amount = 1
        ..paidOn = Date(2026, 1, 1)));
      when(
        () => api.addServiceProviderPayment(
          id: 'p-1',
          serviceProviderPaymentRequest: any(named: 'serviceProviderPaymentRequest'),
        ),
      ).thenAnswer((_) async => _ok(ServiceProviderPaymentResponse((b) => b
        ..id = 'pay-1'
        ..amount = 45000
        ..inLedger = true)));

      final payment = await repository.addPayment(
        'p-1',
        ProviderPaymentDraft(amount: 45000, paidOn: DateTime(2026, 10, 12), property: const ResidenceProperty('r-1', 'Deido')),
      );

      expect(payment.inLedger, isTrue);
      final sent = verify(
        () => api.addServiceProviderPayment(
          id: 'p-1',
          serviceProviderPaymentRequest: captureAny(named: 'serviceProviderPaymentRequest'),
        ),
      ).captured.single as ServiceProviderPaymentRequest;
      expect(sent.residenceId, 'r-1');
      expect(sent.annonceId, isNull);
      expect(sent.paidOn, Date(2026, 10, 12));
    });

    test('the list asks for the archived ones only when shown', () async {
      when(() => api.listServiceProviders(includeArchived: any(named: 'includeArchived')))
          .thenAnswer((_) async => _ok(BuiltList<ServiceProviderResponse>()));
      await repository.list(includeArchived: true);
      verify(() => api.listServiceProviders(includeArchived: true)).called(1);
    });
  });

  group('the blocs', () {
    late MockProvidersRepository repository;
    late MockFinanceProperties properties;

    setUp(() {
      repository = MockProvidersRepository();
      properties = MockFinanceProperties();
    });

    blocTest<ProvidersBloc, ProvidersState>(
      'showing the archived ones is kept on a refresh',
      setUp: () => when(() => repository.list(includeArchived: true)).thenAnswer((_) async => const Cached([plumber])),
      build: () => ProvidersBloc(repository: repository),
      seed: () => const ProvidersReady(items: [], includeArchived: true),
      act: (bloc) => bloc.add(const ProvidersRequested()),
      expect: () => const [ProvidersReady(items: [plumber], includeArchived: true)],
    );

    blocTest<ProviderBloc, ProviderState>(
      'archived: hidden from the lists, the history kept',
      setUp: () => when(() => repository.archive('p-1')).thenAnswer((_) async => plumber.archivedCopy),
      build: () => ProviderBloc(repository: repository),
      seed: () => const ProviderReady(provider: plumber),
      act: (bloc) => bloc.add(const ProviderArchived()),
      expect: () => [
        const ProviderReady(provider: plumber, isBusy: true),
        ProviderReady(provider: plumber.archivedCopy, done: ProviderDone.archived),
      ],
    );

    test('a name typed, or a contact; « Autre » says which', () {
      const typed = ProviderFormState(kind: ProviderKind.cleaning);
      expect(typed.canSubmit, isFalse);
      expect(typed.copyWith(name: 'Marie').canSubmit, isTrue);
      expect(typed.copyWith(contact: const ProviderContact(accountId: 'a', name: 'Jean')).canSubmit, isTrue);
      expect(typed.copyWith(name: 'Paul', kind: ProviderKind.other).canSubmit, isFalse);
      expect(typed.copyWith(name: 'Paul', kind: ProviderKind.other, kindLabel: 'Gardien').canSubmit, isTrue);
    });

    blocTest<ProviderPaymentFormBloc, ProviderPaymentFormState>(
      'a payment is declared on today unless said otherwise, then saved',
      setUp: () {
        when(properties.choices).thenAnswer((_) async => const []);
        when(() => repository.addPayment('p-1', any())).thenAnswer((_) async => const ProviderPayment(id: 'x', amount: 1));
      },
      build: () => ProviderPaymentFormBloc(repository: repository, properties: properties),
      act: (bloc) async {
        bloc.add(ProviderPaymentFormStarted(providerId: 'p-1', today: DateTime(2026, 10, 23)));
        await Future<void>.delayed(Duration.zero);
        bloc
          ..add(const ProviderPaymentFormChanged(amount: 20000))
          ..add(const ProviderPaymentFormSubmitted());
      },
      verify: (bloc) {
        expect(bloc.state.done, ProviderPaymentDone.saved);
        final draft = verify(() => repository.addPayment('p-1', captureAny())).captured.single as ProviderPaymentDraft;
        expect(draft.paidOn, DateTime(2026, 10, 23));
        expect(draft.amount, 20000);
      },
    );
  });

  group('the screens', () {
    setUpAll(loadBrandFonts);

    Future<void> pump(WidgetTester tester, Widget child) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: child,
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('the list: who, what trade, what was paid', (tester) async {
      final bloc = MockProvidersBloc();
      when(() => bloc.state).thenReturn(const ProvidersReady(items: [plumber, caretaker]));
      await pump(tester, BlocProvider<ProvidersBloc>.value(value: bloc, child: ProvidersView(onOpen: (_) {}, onAdd: () {})));

      expect(find.text('Gardien'), findsOneWidget);
      expect(find.text('Sur Mboa'), findsOneWidget);
      expect(find.text('Aucun paiement'), findsOneWidget);
      await expectLater(find.byType(ProvidersView), matchesGoldenFile('goldens/providers.png'));
    });

    testWidgets('one: « Déclarer un paiement », the rest behind « ⋯ » — no delete once paid', (tester) async {
      final bloc = MockProviderBloc();
      when(() => bloc.state).thenReturn(
        ProviderReady(
          provider: plumber,
          payments: [
            ProviderPayment(
              id: 'a',
              amount: 45000,
              paidOn: DateTime(2026, 10, 12),
              note: 'Fuite salle de bain',
              residenceId: 'r-1',
              propertyLabel: 'Résidence Deido',
            ),
            ProviderPayment(id: 'b', amount: 40000, paidOn: DateTime(2026, 9, 3), annonceId: 'a-1', propertyLabel: 'Studio Akwa'),
          ],
        ),
      );
      var paid = 0;
      await pump(
        tester,
        BlocProvider<ProviderBloc>.value(
          value: bloc,
          child: ProviderView(canWrite: true, onPay: () => paid++, onEditPayment: (_) {}, onEdit: (_) {}),
        ),
      );

      await expectLater(find.byType(ProviderView), matchesGoldenFile('goldens/provider.png'));
      await tester.tap(find.text('Déclarer un paiement'));
      expect(paid, 1);
      await tester.tap(find.byTooltip("Plus d'actions"));
      await tester.pumpAndSettle();
      expect(find.text('Archiver'), findsOneWidget);
      expect(find.text('Supprimer'), findsNothing);
    });

    testWidgets('archived: « Restaurer » is the one action', (tester) async {
      final bloc = MockProviderBloc();
      when(() => bloc.state).thenReturn(ProviderReady(provider: caretaker.archivedCopy));
      await pump(
        tester,
        BlocProvider<ProviderBloc>.value(
          value: bloc,
          child: ProviderView(canWrite: true, onPay: () {}, onEditPayment: (_) {}, onEdit: (_) {}),
        ),
      );

      expect(find.text('Déclarer un paiement'), findsNothing);
      await tester.tap(find.text('Restaurer'));
      verify(() => bloc.add(const ProviderRestored())).called(1);
    });

    testWidgets('the form: a contact, or a name typed', (tester) async {
      final bloc = MockProviderFormBloc();
      when(() => bloc.state).thenReturn(
        const ProviderFormState(
          contacts: [ProviderContact(accountId: 'acc-9', name: 'Jean Mbarga'), ProviderContact(accountId: 'acc-7', name: 'Awa Nkeng')],
          contact: ProviderContact(accountId: 'acc-9', name: 'Jean Mbarga'),
        ),
      );
      await pump(tester, BlocProvider<ProviderFormBloc>.value(value: bloc, child: const ProviderFormView()));

      // Linked: no name to type — his account's.
      expect(find.text('Nom'), findsNothing);
      await expectLater(find.byType(ProviderFormView), matchesGoldenFile('goldens/provider_form.png'));
    });
  });
}

extension on ServiceProvider {
  ServiceProvider get archivedCopy => ServiceProvider(
        id: id,
        name: name,
        kind: kind,
        kindLabel: kindLabel,
        linkedAccountId: linkedAccountId,
        archived: true,
        totalPaid: totalPaid,
        paymentCount: paymentCount,
      );
}
