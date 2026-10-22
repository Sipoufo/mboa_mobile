import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/my_home/bloc/my_homes_bloc.dart';
import 'package:mboa_user/features/my_home/ui/my_homes_page.dart';
import 'package:mboa_user/features/my_home/ui/widgets/next_rent_banner.dart';
import 'package:mboa_user/features/past_homes/bloc/past_homes_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockHomesRepository extends Mock implements HomesRepository {}

class MockMyHomesBloc extends MockBloc<MyHomesEvent, MyHomesState> implements MyHomesBloc {}

class MockPastHomesBloc extends MockBloc<PastHomesEvent, PastHomesState> implements PastHomesBloc {}

/// CDC M30 — the tenant's spaces, and the search tab's reminder.
void main() {
  Home home(String id, {HomeStage state = HomeStage.active, RentDue? next, int overdue = 0}) => Home(
        contractId: id,
        annonceTitle: 'Studio Akwa',
        district: 'Akwa',
        city: 'Douala',
        state: state,
        rent: 150000,
        nextDue: next,
        overdueCount: overdue,
        overdueAmount: overdue * 150000,
      );

  final due = RentDue(index: 1, dueDate: DateTime(2026, 11, 18), amount: 150000, status: DueStatus.due);

  group('MyHomesBloc', () {
    late MockHomesRepository repository;

    setUp(() => repository = MockHomesRepository());

    blocTest<MyHomesBloc, MyHomesState>(
      'reads the spaces',
      setUp: () => when(repository.myHomes).thenAnswer((_) async => Cached([home('c-1')])),
      build: () => MyHomesBloc(repository: repository),
      act: (bloc) => bloc.add(const MyHomesRequested()),
      expect: () => [const MyHomesLoading(), MyHomesReady(items: [home('c-1')])],
    );

    blocTest<MyHomesBloc, MyHomesState>(
      'nothing at all is a failure; a failed refresh keeps the list',
      setUp: () => when(repository.myHomes).thenThrow(Exception('offline')),
      build: () => MyHomesBloc(repository: repository),
      seed: () => MyHomesReady(items: [home('c-1')]),
      act: (bloc) => bloc.add(const MyHomesRequested()),
      expect: () => const <MyHomesState>[],
    );

    test('the search tab speaks of the first active space with something due', () {
      final state = MyHomesReady(
        items: [home('c-0', state: HomeStage.upcoming, next: due), home('c-1', next: due), home('c-2', next: due)],
      );
      expect(state.current?.contractId, 'c-1');
      expect(MyHomesReady(items: [home('c-3', state: HomeStage.readOnly, next: due)]).current, isNull);
    });
  });

  group('the screens', () {
    late MockMyHomesBloc bloc;
    late MockPastHomesBloc pastBloc;
    late List<String> opened;

    setUp(() {
      bloc = MockMyHomesBloc();
      pastBloc = MockPastHomesBloc();
      opened = [];
      when(() => pastBloc.state).thenReturn(const PastHomesReady(items: []));
    });

    Widget homes() => MultiBlocProvider(
          providers: [
            BlocProvider<MyHomesBloc>.value(value: bloc),
            BlocProvider<PastHomesBloc>.value(value: pastBloc),
          ],
          child: MyHomesView(
            onOpen: (home) => opened.add('space:${home.contractId}'),
            onOpenPast: (home) => opened.add('past:${home.contractId}'),
          ),
        );

    tearDown(getIt.reset);

    Future<void> pump(WidgetTester tester, Widget child) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: Scaffold(body: child),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('no signed contract yet: when a space opens, said', (tester) async {
      when(() => bloc.state).thenReturn(const MyHomesReady(items: []));
      await pump(tester, homes());

      expect(find.text('Pas encore de logement'), findsOneWidget);
      expect(find.textContaining('signé par les deux parties'), findsOneWidget);
    });

    testWidgets('a space: the place and what is due next', (tester) async {
      when(() => bloc.state).thenReturn(MyHomesReady(items: [home('c-1', next: due)]));
      await pump(tester, homes());

      expect(find.text('Studio Akwa'), findsOneWidget);
      expect(find.textContaining('Prochain loyer'), findsOneWidget);
      await tester.tap(find.text('Studio Akwa'));
      expect(opened, ['space:c-1']);
    });

    testWidgets('M31 — over, a tenancy leaves « En cours » for « Anciens », where it opens its sheet', (tester) async {
      when(() => bloc.state).thenReturn(
        MyHomesReady(items: [home('c-1', next: due), home('c-2', state: HomeStage.readOnly)]),
      );
      when(() => pastBloc.state).thenReturn(PastHomesReady(items: [home('c-2', state: HomeStage.readOnly)]));
      await pump(tester, homes());

      expect(find.text('En cours'), findsOneWidget);
      expect(find.text('Anciens'), findsOneWidget);
      expect(find.text('Location terminée'), findsNothing);

      await tester.tap(find.text('Anciens'));
      await tester.pumpAndSettle();
      expect(find.text('Location terminée'), findsOneWidget);
      await tester.tap(find.text('Studio Akwa'));
      expect(opened, ['past:c-2']);
    });

    testWidgets('M31 — no ended tenancy yet: « Anciens » says what will be there', (tester) async {
      when(() => bloc.state).thenReturn(MyHomesReady(items: [home('c-1', next: due)]));
      await pump(tester, homes());
      await tester.tap(find.text('Anciens'));
      await tester.pumpAndSettle();

      expect(find.text('Aucun ancien logement'), findsOneWidget);
      expect(find.textContaining('tes dépenses et tes reçus'), findsOneWidget);
    });

    testWidgets('the banner: the next rent while a space is active', (tester) async {
      getIt.registerSingleton<MyHomesBloc>(bloc);
      when(() => bloc.state).thenReturn(MyHomesReady(items: [home('c-1', next: due)]));
      await pump(tester, const NextRentBanner());

      expect(find.textContaining('Prochain loyer'), findsOneWidget);
    });

    testWidgets('…late, it says how many', (tester) async {
      getIt.registerSingleton<MyHomesBloc>(bloc);
      when(() => bloc.state).thenReturn(MyHomesReady(items: [home('c-1', next: due, overdue: 2)]));
      await pump(tester, const NextRentBanner());

      expect(find.textContaining('2 échéances en retard'), findsOneWidget);
    });

    testWidgets('…and nothing without a space, or for a visitor', (tester) async {
      await pump(tester, const NextRentBanner());
      expect(find.byType(Material), findsWidgets);
      expect(find.textContaining('loyer'), findsNothing);

      getIt.registerSingleton<MyHomesBloc>(bloc);
      when(() => bloc.state).thenReturn(const MyHomesReady(items: []));
      await pump(tester, const NextRentBanner());
      expect(find.textContaining('loyer'), findsNothing);
    });
  });
}
