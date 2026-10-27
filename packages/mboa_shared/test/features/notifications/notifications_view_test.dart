import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../score/load_brand_fonts.dart';

class MockInboxBloc extends MockBloc<InboxEvent, InboxState> implements InboxBloc {}

/// The notifications page and the bell (§38), as both apps show them.
void main() {
  late MockInboxBloc bloc;
  final today = DateTime.now();
  DateTime at(int daysAgo, int hour) => DateTime(today.year, today.month, today.day - daysAgo, hour, 5);

  final items = [
    InboxItem(
      id: 'n-1',
      type: PushType.message,
      title: 'Nouveau message',
      body: 'Awa : « Le studio est-il toujours libre ? »',
      entityId: 'c-1',
      createdAt: at(0, 9),
    ),
    InboxItem(
      id: 'n-2',
      type: PushType.contract,
      title: 'Contrat signé',
      body: 'Ton contrat pour « Studio Akwa » est signé par les deux parties.',
      entityId: 'k-1',
      createdAt: at(0, 8),
      readAt: at(0, 8),
    ),
    InboxItem(
      id: 'n-3',
      type: PushType.visit,
      title: 'Visite confirmée',
      body: 'Le propriétaire a confirmé ta visite de « Villa Bonapriso ».',
      entityId: 'v-1',
      createdAt: at(1, 17),
      readAt: at(1, 18),
    ),
  ];

  setUpAll(() async {
    registerFallbackValue(const InboxRequested());
    await loadBrandFonts();
  });

  setUp(() {
    bloc = MockInboxBloc();
    when(() => bloc.state).thenReturn(InboxReady(items: items, unread: 1));
  });

  Future<void> pump(WidgetTester tester, {List<PushMessage>? opened}) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Scaffold(
          // As both apps' pages: the warm canvas behind the cards.
          backgroundColor: MboaColorScheme.light.background,
          appBar: AppBar(title: const Text('Notifications')),
          body: BlocProvider<InboxBloc>.value(
            value: bloc,
            child: NotificationsView(onOpen: (message) => opened?.add(message)),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('day by day, newest first', (tester) async {
    await pump(tester);

    expect(find.text('Aujourd\'hui'), findsOneWidget);
    expect(find.text('Hier'), findsOneWidget);
    expect(tester.getTopLeft(find.text('Nouveau message')).dy, lessThan(tester.getTopLeft(find.text('Visite confirmée')).dy));
  });

  testWidgets('CA-M03-02 — an item opens where its push would, and is read', (tester) async {
    final opened = <PushMessage>[];
    await pump(tester, opened: opened);

    await tester.tap(find.text('Nouveau message'));

    expect((opened.single.type, opened.single.entityId), (PushType.message, 'c-1'));
    verify(() => bloc.add(const InboxItemOpened('n-1'))).called(1);
  });

  testWidgets('« Tout marquer comme lu » while something is unread', (tester) async {
    await pump(tester);
    await tester.tap(find.text('Tout marquer comme lu'));

    verify(() => bloc.add(const InboxAllReadRequested())).called(1);
  });

  testWidgets('everything read: nothing to mark', (tester) async {
    when(() => bloc.state).thenReturn(InboxReady(items: [items[1], items[2]]));
    await pump(tester);

    expect(find.text('Tout marquer comme lu'), findsNothing);
  });

  testWidgets('nothing in 30 days: said, not a blank screen', (tester) async {
    when(() => bloc.state).thenReturn(const InboxReady(items: []));
    await pump(tester);

    expect(find.text('Rien de neuf'), findsOneWidget);
  });

  testWidgets('offline: the kept page, marked, and nothing to mark as read', (tester) async {
    when(() => bloc.state).thenReturn(InboxReady(items: items, unread: 1, isOffline: true));
    await pump(tester);

    expect(find.text('Données hors ligne'), findsOneWidget);
    expect(find.text('Tout marquer comme lu'), findsNothing);
  });

  testWidgets('the bell says how many, and asks for the count when it appears', (tester) async {
    when(() => bloc.state).thenReturn(const InboxInitial(unread: 3));
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Scaffold(body: Center(child: NotificationBell(bloc: bloc, onPressed: () {}))),
      ),
    );
    await tester.pump();

    expect(find.text('3'), findsOneWidget);
    expect(find.bySemanticsLabel('Notifications, 3 non lues'), findsOneWidget);
    verify(() => bloc.add(const InboxUnreadCountRequested())).called(1);
  });

  testWidgets('the page', (tester) async {
    await pump(tester);

    await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/notifications.png'));
  });
}
