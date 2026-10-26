import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/favorites/bloc/favorites_bloc.dart';
import 'package:mboa_user/features/favorites/ui/favorites_page.dart';
import 'package:mboa_user/features/history/bloc/history_bloc.dart';
import 'package:mboa_user/features/history/data/history_repository.dart';
import 'package:mboa_user/features/history/models/history_entry.dart';
import 'package:mboa_user/features/history/ui/history_view.dart';
import 'package:mboa_user/features/profile/ui/settings_menu_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';
import '../../_helpers/mocks/mocks.dart';

class MockHistoriqueApi extends Mock implements HistoriqueApi {}

class MockHistoryRepository extends Mock implements HistoryRepository {}

class MockHistoryBloc extends MockBloc<HistoryEvent, HistoryState> implements HistoryBloc {}

class MockLocaleController extends Mock implements LocaleController {}

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState> implements FavoritesBloc {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/x'));

/// CDC M06 — « Historique »: the fiches the tenant opened, the last 30
/// (RM-M06-05), cleared from « Paramètres ».
void main() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day, 10, 30);
  final yesterday = today.subtract(const Duration(days: 1));
  final older = DateTime(2026, 10, 2, 18, 5);

  HistoryEntry entry(String? id, DateTime at, {String title = 'Studio meublé — Akwa'}) => HistoryEntry(
        annonceId: id,
        title: title,
        price: 85000,
        rentalPeriod: RentalPeriod.month,
        city: 'Douala',
        district: 'Akwa',
        viewedAt: at,
      );

  setUpAll(() => registerFallbackValue(Pageable()));

  group('the repository', () {
    late MockHistoriqueApi api;
    late HistoryRepository repository;
    final stored = <String, Map<String, dynamic>>{};

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      final cache = MockHiveCache();
      api = MockHistoriqueApi();
      stored.clear();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getHistoriqueApi).thenReturn(api);
      when(() => cache.put(any(), any(), any())).thenAnswer((call) async {
        expect(call.positionalArguments[0], StorageKeys.favoritesBox, reason: 'an account\'s own: emptied at sign-out');
        stored[call.positionalArguments[1] as String] = call.positionalArguments[2] as Map<String, dynamic>;
      });
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl')))
          .thenAnswer((call) => stored[call.positionalArguments[1] as String]);
      repository = HistoryRepository(dioClient: dioClient, cache: cache);
    });

    test('reads the last 30, deleted listings included; offline, the last read', () async {
      when(() => api.listMyHistorique(pageable: any(named: 'pageable'))).thenAnswer(
        (_) async => _ok(
          PageResponseHistoriqueResponse(
            (b) => b
              ..content = ListBuilder([
                HistoriqueResponse((h) => h
                  ..annonceId = 'a-1'
                  ..title = 'Studio'
                  ..price = 85000
                  ..rentalPeriod = HistoriqueResponseRentalPeriodEnum.WEEK
                  ..viewedAt = today.toUtc()),
                HistoriqueResponse((h) => h..title = 'Supprimée'),
              ]),
          ),
        ),
      );

      final online = await repository.list();
      expect(online.value.first.rentalPeriod, RentalPeriod.week);
      expect(online.value.last.isAvailable, isFalse);
      expect((verify(() => api.listMyHistorique(pageable: captureAny(named: 'pageable'))).captured.single as Pageable).size, 30);

      when(() => api.listMyHistorique(pageable: any(named: 'pageable')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '/x')));
      final offline = await repository.list();
      expect(offline.fromCache, isTrue);
      expect(offline.value, online.value);
    });

    test('clearing empties the server and the device\'s copy', () async {
      when(() => api.clearMyHistorique()).thenAnswer((_) async => _ok<void>(null));
      stored['historique'] = {'items': [entry('a-1', today).toCache()]};

      await repository.clear();

      verify(() => api.clearMyHistorique()).called(1);
      expect(stored['historique'], {'items': const <Object>[]});
    });
  });

  group('the bloc', () {
    late MockHistoryRepository repository;

    setUp(() => repository = MockHistoryRepository());

    blocTest<HistoryBloc, HistoryState>(
      'reads it; a failed refresh keeps the list on screen',
      setUp: () => when(() => repository.list()).thenAnswer((_) async => Cached([entry('a-1', today)])),
      build: () => HistoryBloc(repository: repository),
      act: (bloc) async {
        bloc.add(const HistoryRequested());
        await Future<void>.delayed(Duration.zero);
        when(() => repository.list()).thenThrow(Exception('offline, no copy'));
        bloc.add(const HistoryRequested());
      },
      expect: () => [
        const HistoryLoading(),
        HistoryReady(entries: [entry('a-1', today)]),
      ],
    );

    blocTest<HistoryBloc, HistoryState>(
      'cleared: empty, and said once',
      setUp: () => when(() => repository.clear()).thenAnswer((_) async {}),
      build: () => HistoryBloc(repository: repository),
      seed: () => HistoryReady(entries: [entry('a-1', today)]),
      act: (bloc) => bloc.add(const HistoryCleared()),
      expect: () => [
        HistoryReady(entries: [entry('a-1', today)], isClearing: true),
        const HistoryReady(entries: [], outcome: HistoryClearOutcome.cleared),
      ],
    );

    blocTest<HistoryBloc, HistoryState>(
      'not cleared (offline): nothing lost, and said',
      setUp: () => when(() => repository.clear()).thenThrow(DioException(requestOptions: RequestOptions(path: '/x'))),
      build: () => HistoryBloc(repository: repository),
      seed: () => HistoryReady(entries: [entry('a-1', today)]),
      act: (bloc) => bloc.add(const HistoryCleared()),
      skip: 1,
      expect: () => [HistoryReady(entries: [entry('a-1', today)], outcome: HistoryClearOutcome.failed)],
    );

    test('day by day, newest day first, each day\'s order kept', () {
      final ready = HistoryReady(
        entries: [entry('a', today), entry('b', today), entry('c', yesterday), entry('a', older)],
      );
      expect([for (final (_, entries) in ready.byDay) entries.length], [2, 1, 1]);
    });
  });

  group('the screens', () {
    late MockHistoryBloc bloc;

    setUpAll(loadBrandFonts);
    setUp(() => bloc = MockHistoryBloc());
    tearDown(getIt.reset);

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

    testWidgets('the tab: day by day, the time each was opened; a deleted listing stays, greyed', (tester) async {
      when(() => bloc.state).thenReturn(
        HistoryReady(
          entries: [
            entry('a-1', today),
            entry(null, today.subtract(const Duration(hours: 2)), title: 'Chambre — Bepanda'),
            entry('a-2', yesterday, title: 'Appartement — Deido'),
            entry('a-1', older),
          ],
        ),
      );
      await pump(tester, Builder(builder: (context) => Scaffold(backgroundColor: context.mboaColors.background, body: BlocProvider<HistoryBloc>.value(value: bloc, child: const HistoryView()))));

      expect(find.text('Aujourd\'hui'), findsOneWidget);
      expect(find.text('Hier'), findsOneWidget);
      expect(find.text('Vu à 10:30'), findsNWidgets(2));
      expect(find.text('Plus disponible'), findsOneWidget);
      expect(find.text('Vendredi 2 octobre 2026'), findsOneWidget);
      await expectLater(find.byType(HistoryView), matchesGoldenFile('goldens/history.png'));
    });

    testWidgets('empty: what it will hold', (tester) async {
      when(() => bloc.state).thenReturn(const HistoryReady(entries: []));
      await pump(tester, Builder(builder: (context) => Scaffold(backgroundColor: context.mboaColors.background, body: BlocProvider<HistoryBloc>.value(value: bloc, child: const HistoryView()))));

      expect(find.text('Aucune fiche consultée'), findsOneWidget);
    });

    testWidgets('« Favoris | Historique »: the history read again on the way in', (tester) async {
      final favorites = MockFavoritesBloc();
      when(() => favorites.state).thenReturn(const FavoritesReady());
      when(() => bloc.state).thenReturn(const HistoryReady(entries: []));
      getIt
        ..registerSingleton<SessionSnapshot>(SessionSnapshot()..markAuthenticated())
        ..registerSingleton<HistoryBloc>(bloc);
      await pump(tester, BlocProvider<FavoritesBloc>.value(value: favorites, child: const FavoritesPage()));

      verifyNever(() => bloc.add(const HistoryRequested()));
      await tester.tap(find.text('Historique'));
      await tester.pumpAndSettle();

      verify(() => bloc.add(const HistoryRequested())).called(1);
      expect(find.text('Aucune fiche consultée'), findsOneWidget);
    });

    testWidgets('« Paramètres »: cleared after asking once more (RM-M06-05)', (tester) async {
      when(() => bloc.state).thenReturn(const HistoryInitial());
      final locale = MockLocaleController();
      when(() => locale.value).thenReturn(null);
      getIt
        ..registerSingleton<HistoryBloc>(bloc)
        ..registerSingleton<LocaleController>(locale);
      await pump(tester, const SettingsMenuPage());

      // « Annuler »: nothing goes.
      await tester.tap(find.text('Effacer l\'historique'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Annuler'));
      await tester.pumpAndSettle();
      verifyNever(() => bloc.add(const HistoryCleared()));

      await tester.tap(find.text('Effacer l\'historique'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Tes favoris ne sont pas touchés'), findsOneWidget);
      await tester.tap(find.text('Effacer l\'historique').last);
      await tester.pumpAndSettle();
      verify(() => bloc.add(const HistoryCleared())).called(1);
    });
  });
}
