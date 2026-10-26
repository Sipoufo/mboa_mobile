import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/finance/bloc/ledger_bloc.dart';
import 'package:mboa_pro/features/finance/bloc/ledger_entry_form_bloc.dart';
import 'package:mboa_pro/features/finance/data/finance_properties.dart';
import 'package:mboa_pro/features/finance/data/ledger_repository.dart';
import 'package:mboa_pro/features/finance/models/ledger.dart';
import 'package:mboa_pro/features/finance/ui/ledger_pages.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';
import '../../_helpers/mocks/mocks.dart';

class MockLedgerApi extends Mock implements FinanceLedgerApi {}

class MockLedgerRepository extends Mock implements LedgerRepository {}

class MockFinanceProperties extends Mock implements FinanceProperties {}

class MockMediaUploader extends Mock implements MediaUploader {}

class MockPdfSharer extends Mock implements PdfSharer {}

class MockLedgerBloc extends MockBloc<LedgerEvent, LedgerState> implements LedgerBloc {}

class MockLedgerEntryFormBloc extends MockBloc<LedgerEntryFormEvent, LedgerEntryFormState> implements LedgerEntryFormBloc {}

class _FakeDraft extends Fake implements LedgerDraft {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/x'));

/// CDC M25 — the landlord's register.
void main() {
  const deido = ResidenceProperty('r-1', 'Résidence Deido');
  final today = DateTime(2026, 10, 23);

  LedgerEntry entry(String id, {LedgerDirection direction = LedgerDirection.expense, bool readOnly = false}) =>
      LedgerEntry(
        id: id,
        direction: direction,
        category: direction == LedgerDirection.income ? LedgerCategory.rent : LedgerCategory.works,
        amount: direction == LedgerDirection.income ? 150000 : 45000,
        date: DateTime(2026, 10, 12),
        residenceId: 'r-1',
        propertyLabel: 'Résidence Deido',
        note: direction == LedgerDirection.income ? null : 'Plomberie salle de bain',
        readOnly: readOnly,
        hasAttachment: !readOnly && direction == LedgerDirection.expense,
      );

  const summary = LedgerSummary(
    income: 300000,
    expense: 45000,
    net: 255000,
    entryCount: 3,
    byCategory: [
      LedgerCategoryTotal(direction: LedgerDirection.income, category: LedgerCategory.rent, total: 300000),
      LedgerCategoryTotal(direction: LedgerDirection.expense, category: LedgerCategory.works, total: 45000),
    ],
  );

  setUpAll(() {
    registerFallbackValue(_FakeDraft());
    registerFallbackValue(Pageable());
    registerFallbackValue(const LedgerScope());
    registerFallbackValue(Uint8List(0));
    registerFallbackValue(ImageSource.camera);
    registerFallbackValue(CreateUploadRequestCategoryEnum.FINANCE_ATTACHMENT);
  });

  group('the period', () {
    test('this month, the last three, this year — every day included; all time has no bounds', () {
      expect(LedgerPeriod.thisMonth.range(today), (DateTime(2026, 10), DateTime(2026, 10, 31)));
      expect(LedgerPeriod.lastThreeMonths.range(today), (DateTime(2026, 8), DateTime(2026, 10, 31)));
      expect(LedgerPeriod.thisYear.range(today), (DateTime(2026), DateTime(2026, 12, 31)));
      expect(LedgerPeriod.all.range(today), isNull);
    });
  });

  group('the repository', () {
    late MockLedgerApi api;
    late LedgerRepository repository;

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      final cache = MockHiveCache();
      final stored = <String, Map<String, dynamic>>{};
      api = MockLedgerApi();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getFinanceLedgerApi).thenReturn(api);
      when(() => cache.put(any(), any(), any())).thenAnswer((call) async {
        stored[call.positionalArguments[1] as String] = call.positionalArguments[2] as Map<String, dynamic>;
      });
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl')))
          .thenAnswer((call) => stored[call.positionalArguments[1] as String]);
      repository = LedgerRepository(dioClient: dioClient, cache: cache);
    });

    void stubList() => when(
          () => api.listLedgerEntries(
            pageable: any(named: 'pageable'),
            from: any(named: 'from'),
            to: any(named: 'to'),
            annonceId: any(named: 'annonceId'),
            residenceId: any(named: 'residenceId'),
            unassigned: any(named: 'unassigned'),
          ),
        ).thenAnswer(
          (_) async => _ok(PageResponseLedgerEntryResponse((b) => b
            ..content = ListBuilder([
              LedgerEntryResponse((e) => e
                ..id = 'l-1'
                ..direction = LedgerEntryResponseDirectionEnum.INCOME
                ..category = LedgerEntryResponseCategoryEnum.RENT
                ..amount = 150000
                ..source_ = LedgerEntryResponseSource_Enum.RENT
                ..readOnly = true),
            ])
            ..last = true)),
        );

    test('one scope on the wire: the period\'s days, one residence', () async {
      stubList();

      final read = await repository.entries(const LedgerScope(property: deido), today: today);

      expect(read.value.entries.single.readOnly, isTrue);
      verify(
        () => api.listLedgerEntries(
          pageable: any(named: 'pageable'),
          from: Date(2026, 10, 1),
          to: Date(2026, 10, 31),
          // ignore: avoid_redundant_argument_values
          annonceId: null,
          residenceId: 'r-1',
          unassigned: false,
        ),
      ).called(1);
    });

    test('« non affecté » is its own filter; offline, the scope\'s last first page', () async {
      stubList();
      const scope = LedgerScope(period: LedgerPeriod.all, property: UnassignedProperty());
      await repository.entries(scope, today: today);
      verify(
        () => api.listLedgerEntries(
          pageable: any(named: 'pageable'),
          // ignore: avoid_redundant_argument_values
          from: null,
          // ignore: avoid_redundant_argument_values
          to: null,
          // ignore: avoid_redundant_argument_values
          annonceId: null,
          // ignore: avoid_redundant_argument_values
          residenceId: null,
          unassigned: true,
        ),
      ).called(1);

      when(
        () => api.listLedgerEntries(
          pageable: any(named: 'pageable'),
          from: any(named: 'from'),
          to: any(named: 'to'),
          annonceId: any(named: 'annonceId'),
          residenceId: any(named: 'residenceId'),
          unassigned: any(named: 'unassigned'),
        ),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '/x')));
      final offline = await repository.entries(scope, today: today);
      expect(offline.fromCache, isTrue);
      expect(offline.value.entries.single.id, 'l-1');
    });

    test('a line on a listing goes as the listing; the CSV comes as UTF-8 bytes', () async {
      registerFallbackValue(LedgerEntryRequest((b) => b
        ..direction = LedgerEntryRequestDirectionEnum.EXPENSE
        ..category = LedgerEntryRequestCategoryEnum.OTHER
        ..amount = 1
        ..date = Date(2026, 1, 1)));
      when(() => api.createLedgerEntry(ledgerEntryRequest: any(named: 'ledgerEntryRequest'))).thenAnswer(
        (_) async => _ok(LedgerEntryResponse((e) => e
          ..id = 'l-2'
          ..direction = LedgerEntryResponseDirectionEnum.EXPENSE
          ..category = LedgerEntryResponseCategoryEnum.WORKS
          ..amount = 45000)),
      );

      await repository.create(
        LedgerDraft(
          direction: LedgerDirection.expense,
          category: LedgerCategory.works,
          amount: 45000,
          date: DateTime(2026, 10, 12),
          property: const ListingProperty('a-1', 'Studio Akwa'),
          note: '  ',
        ),
      );
      final sent = verify(() => api.createLedgerEntry(ledgerEntryRequest: captureAny(named: 'ledgerEntryRequest')))
          .captured
          .single as LedgerEntryRequest;
      expect(sent.annonceId, 'a-1');
      expect(sent.residenceId, isNull);
      expect(sent.category, LedgerEntryRequestCategoryEnum.WORKS);
      expect(sent.note, isNull);

      when(
        () => api.exportLedger(
          from: any(named: 'from'),
          to: any(named: 'to'),
          annonceId: any(named: 'annonceId'),
          residenceId: any(named: 'residenceId'),
          unassigned: any(named: 'unassigned'),
        ),
      ).thenAnswer((_) async => _ok('date;montant\n2026-10-12;45000 — Électricité'));
      final csv = await repository.exportCsv(const LedgerScope(), today: today);
      expect(utf8.decode(csv), 'date;montant\n2026-10-12;45000 — Électricité');
    });
  });

  group('the register', () {
    late MockLedgerRepository repository;
    late MockFinanceProperties properties;
    late MockPdfSharer sharer;

    setUp(() {
      repository = MockLedgerRepository();
      properties = MockFinanceProperties();
      sharer = MockPdfSharer();
      when(properties.choices).thenAnswer((_) async => const [deido]);
      when(() => repository.entries(any(), page: any(named: 'page')))
          .thenAnswer((_) async => Cached(LedgerLines(entries: [entry('a')], isLast: true)));
      when(() => repository.summary(any())).thenAnswer((_) async => const Cached(summary));
    });

    blocTest<LedgerBloc, LedgerState>(
      'the figures and the lines over this month, then what the filter can narrow to',
      build: () => LedgerBloc(repository: repository, properties: properties, sharer: sharer),
      act: (bloc) => bloc.add(const LedgerStarted()),
      expect: () => [
        LedgerReady(scope: const LedgerScope(), summary: summary, entries: [entry('a')]),
        LedgerReady(scope: const LedgerScope(), summary: summary, entries: [entry('a')], properties: const [deido]),
      ],
    );

    blocTest<LedgerBloc, LedgerState>(
      'a narrower scope reads both again, the choices kept',
      build: () => LedgerBloc(repository: repository, properties: properties, sharer: sharer),
      seed: () => const LedgerReady(scope: LedgerScope(), properties: [deido]),
      act: (bloc) => bloc.add(const LedgerScopeChanged(LedgerScope(property: deido))),
      verify: (bloc) {
        final state = bloc.state as LedgerReady;
        expect(state.scope.property, deido);
        expect(state.properties, const [deido]);
        verify(() => repository.summary(const LedgerScope(property: deido))).called(1);
      },
    );

    blocTest<LedgerBloc, LedgerState>(
      'the export is the same scope, as a CSV on the share sheet',
      setUp: () {
        when(() => repository.exportCsv(any())).thenAnswer((_) async => Uint8List.fromList([1, 2]));
        when(
          () => sharer.shareFile(any(), name: any(named: 'name'), extension: any(named: 'extension'), mimeType: any(named: 'mimeType')),
        ).thenAnswer((_) async {});
      },
      build: () => LedgerBloc(repository: repository, properties: properties, sharer: sharer),
      seed: () => const LedgerReady(scope: LedgerScope(property: deido)),
      act: (bloc) => bloc.add(const LedgerExportRequested(name: 'Registre Mboa')),
      verify: (_) {
        verify(() => repository.exportCsv(const LedgerScope(property: deido))).called(1);
        verify(
          () => sharer.shareFile(Uint8List.fromList([1, 2]), name: 'Registre Mboa', extension: 'csv', mimeType: 'text/csv'),
        ).called(1);
      },
    );
  });

  group('a line', () {
    late MockLedgerRepository repository;
    late MockFinanceProperties properties;
    late MockMediaUploader uploader;

    setUp(() {
      repository = MockLedgerRepository();
      properties = MockFinanceProperties();
      uploader = MockMediaUploader();
      when(properties.choices).thenAnswer((_) async => const [deido]);
    });

    LedgerEntryFormBloc build() => LedgerEntryFormBloc(repository: repository, properties: properties, uploader: uploader);

    test('a category of the other side does not follow', () async {
      final bloc = build()..add(const LedgerEntryFormChanged(category: LedgerCategory.works));
      await Future<void>.delayed(Duration.zero);
      bloc.add(const LedgerEntryFormChanged(direction: LedgerDirection.income));
      await Future<void>.delayed(Duration.zero);
      expect(bloc.state.category, LedgerCategory.rent);
      await bloc.close();
    });

    blocTest<LedgerEntryFormBloc, LedgerEntryFormState>(
      'its receipt goes as a compressed FINANCE_ATTACHMENT, then with the line',
      setUp: () {
        when(() => uploader.captureAndUpload(source: ImageSource.camera, category: CreateUploadRequestCategoryEnum.FINANCE_ATTACHMENT))
            .thenAnswer((_) async => 'finance/acc/1.jpg');
        when(() => repository.create(any())).thenAnswer((_) async => entry('n'));
      },
      build: build,
      act: (bloc) async {
        bloc
          ..add(const LedgerEntryAttachmentAdded(ImageSource.camera))
          ..add(LedgerEntryFormChanged(amount: 45000, date: DateTime(2026, 10, 12), property: deido));
        // The upload runs beside the change: done before the line goes.
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const LedgerEntryFormSubmitted());
      },
      verify: (bloc) {
        expect(bloc.state.done, LedgerFormDone.saved);
        final draft = verify(() => repository.create(captureAny())).captured.single as LedgerDraft;
        expect(draft.attachmentKey, 'finance/acc/1.jpg');
        expect(draft.property, deido);
        expect(draft.amount, 45000);
      },
    );

    group('correcting a line that had a photo (§34)', () {
      Future<String?> sent(LedgerEntryFormBloc bloc, List<LedgerEntryFormEvent> events) async {
        when(() => repository.update(any(), any())).thenAnswer((_) async => entry('a'));
        bloc.add(LedgerEntryFormStarted(editing: entry('a')));
        await Future<void>.delayed(Duration.zero);
        for (final event in events) {
          bloc.add(event);
        }
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const LedgerEntryFormSubmitted());
        await Future<void>.delayed(Duration.zero);
        final draft = verify(() => repository.update('a', captureAny())).captured.single as LedgerDraft;
        await bloc.close();
        return draft.attachmentKey;
      }

      test('untouched, it stays: nothing said about it', () async {
        expect(await sent(build(), const []), isNull);
      });

      test('removed, it goes: « "" »; taken back, it stays', () async {
        expect(await sent(build(), const [LedgerEntryAttachmentRemoved()]), '');
        expect(await sent(build(), const [LedgerEntryAttachmentRemoved(), LedgerEntryAttachmentKept()]), isNull);
      });

      test('a new photo replaces it, even after removing it; dropping the new one keeps the old', () async {
        when(() => uploader.captureAndUpload(source: ImageSource.camera, category: CreateUploadRequestCategoryEnum.FINANCE_ATTACHMENT))
            .thenAnswer((_) async => 'finance/acc/2.jpg');
        expect(
          await sent(build(), const [LedgerEntryAttachmentRemoved(), LedgerEntryAttachmentAdded(ImageSource.camera)]),
          'finance/acc/2.jpg',
        );
        expect(
          await sent(build(), const [LedgerEntryAttachmentAdded(ImageSource.camera), LedgerEntryAttachmentRemoved()]),
          isNull,
        );
      });
    });
  });

  group('the screens', () {
    setUpAll(loadBrandFonts);

    Future<void> pump(WidgetTester tester, Widget child, {double height = 844}) async {
      tester.view.physicalSize = Size(390 * 3, height * 3);
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

    testWidgets('the register: the net on the brand card, the lines beneath — a kept one locked', (tester) async {
      final bloc = MockLedgerBloc();
      when(() => bloc.state).thenReturn(
        LedgerReady(
          scope: const LedgerScope(),
          summary: summary,
          entries: [entry('a'), entry('b', direction: LedgerDirection.income, readOnly: true)],
        ),
      );
      final edited = <String>[];
      await pump(
        tester,
        BlocProvider<LedgerBloc>.value(
          value: bloc,
          child: LedgerView(canWrite: true, onAdd: () {}, onEdit: (e) => edited.add(e.id)),
        ),
        height: 1100,
      );

      expect(find.textContaining('255'), findsOneWidget);
      await tester.tap(find.text('Plomberie salle de bain'));
      await tester.tap(find.textContaining('paiement confirmé'));
      expect(edited, ['a']);
      await tester.pumpAndSettle();
      await expectLater(find.byType(LedgerView), matchesGoldenFile('goldens/ledger.png'));
    });

    testWidgets('expired: no adding — the export is what is left', (tester) async {
      final bloc = MockLedgerBloc();
      when(() => bloc.state).thenReturn(const LedgerReady(scope: LedgerScope(), summary: summary));
      await pump(
        tester,
        BlocProvider<LedgerBloc>.value(value: bloc, child: LedgerView(canWrite: false, onAdd: () {}, onEdit: (_) {})),
      );

      expect(find.text('Ajouter un mouvement'), findsNothing);
      await tester.tap(find.text('Exporter en CSV'));
      verify(() => bloc.add(const LedgerExportRequested(name: 'Registre Mboa'))).called(1);
    });

    testWidgets('the form, correcting a line that had a photo', (tester) async {
      final bloc = MockLedgerEntryFormBloc();
      when(() => bloc.state).thenReturn(
        LedgerEntryFormState(
          editing: entry('a'),
          amount: 45000,
          date: DateTime(2026, 10, 12),
          property: deido,
          note: 'Plomberie salle de bain',
          hadAttachment: true,
          properties: const [deido, ListingProperty('a-1', 'Studio Akwa')],
        ),
      );
      await pump(tester, BlocProvider<LedgerEntryFormBloc>.value(value: bloc, child: const LedgerEntryFormView()), height: 1000);

      // §34 — kept unless removed: no warning, the photo to look at, a cross to remove it.
      expect(find.textContaining('sera retirée'), findsNothing);
      expect(find.text('Remplacer la photo'), findsOneWidget);
      await expectLater(find.byType(LedgerEntryFormView), matchesGoldenFile('goldens/ledger_form.png'));
      await tester.tap(find.text('Voir la pièce jointe actuelle'));
      verify(() => bloc.add(const LedgerEntryAttachmentViewed())).called(1);
      await tester.tap(find.byTooltip('Retirer la pièce jointe'));
      verify(() => bloc.add(const LedgerEntryAttachmentRemoved())).called(1);
    });

    testWidgets('the form, the line\'s photo asked to go: said, and it can be taken back', (tester) async {
      final bloc = MockLedgerEntryFormBloc();
      when(() => bloc.state).thenReturn(
        LedgerEntryFormState(
          editing: entry('a'),
          amount: 45000,
          date: DateTime(2026, 10, 12),
          hadAttachment: true,
          removesAttachment: true,
        ),
      );
      await pump(tester, BlocProvider<LedgerEntryFormBloc>.value(value: bloc, child: const LedgerEntryFormView()), height: 1000);

      expect(find.text("La pièce jointe sera retirée à l'enregistrement."), findsOneWidget);
      expect(find.text('Voir la pièce jointe actuelle'), findsNothing);
      await tester.tap(find.text('Annuler'));
      verify(() => bloc.add(const LedgerEntryAttachmentKept())).called(1);
    });
  });
}
