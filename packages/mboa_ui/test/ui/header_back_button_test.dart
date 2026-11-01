import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The back arrow — one rule for every screen of both apps.
///
/// It shows when the router that holds the page can go back, itself or
/// through its parents, and goes back through that same router. Two rules
/// used to coexist, neither that one: the arrow asked the root navigator and
/// closed a whole nested stack instead of its last page, or vanished where
/// only the nested stack had something to pop; Material's default arrow asked
/// the nearest navigator and missed every page alone in a nested router.
void main() {
  group('under auto_route', () {
    late _Router router;

    Future<void> pump(WidgetTester tester) async {
      router = _Router();
      await tester.pumpWidget(MaterialApp.router(routerConfig: router.config()));
      await tester.pumpAndSettle();
    }

    Future<void> goBack(WidgetTester tester) async {
      await tester.tap(find.byType(MboaHeaderBackButton));
      await tester.pumpAndSettle();
    }

    testWidgets('two pages in a nested stack — back steps to the one beneath, not out of the stack',
        (tester) async {
      await pump(tester);
      unawaited(router.push(_app(children: [_a()])));
      await tester.pumpAndSettle();
      await tester.tap(find.text('to b'));
      await tester.pumpAndSettle();

      expect(find.text('page b'), findsOneWidget);
      await goBack(tester);

      expect(find.text('page a'), findsOneWidget);
    });

    testWidgets('a page alone in a nested stack — back closes it and returns beneath', (tester) async {
      await pump(tester);
      unawaited(router.push(_app(children: [_a()])));
      await tester.pumpAndSettle();

      // The nested navigator has nothing under it; the root does.
      expect(find.byType(MboaHeaderBackButton), findsOneWidget);
      await goBack(tester);

      expect(find.text('page home'), findsOneWidget);
    });

    testWidgets('a screen that closes itself once done — alone in a nested stack, it still closes',
        (tester) async {
      await pump(tester);
      unawaited(router.push(_app(children: [_a()])));
      await tester.pumpAndSettle();

      // What a save listener does; the nearest navigator alone had nothing to
      // pop, and the screen stayed after its work went through.
      MboaHeaderBackButton.pop(tester.element(find.text('page a')));
      await tester.pumpAndSettle();

      expect(find.text('page home'), findsOneWidget);
    });

    testWidgets('a tab has nothing beneath it — no arrow, and no empty slot', (tester) async {
      await pump(tester);
      unawaited(router.replaceAll([_tabs()]));
      await tester.pumpAndSettle();

      expect(find.text('page tab'), findsOneWidget);
      expect(find.byType(MboaHeaderBackButton), findsNothing);
      expect(find.byType(BackButton), findsNothing);
    });

    testWidgets('the first page of the app — nothing to go back to', (tester) async {
      await pump(tester);

      expect(find.text('page home'), findsOneWidget);
      expect(find.byType(MboaHeaderBackButton), findsNothing);
    });
  });

  group('without a router', () {
    testWidgets('a route below on the nearest navigator — it pops it', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (context) => const _Page('pushed')),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(MboaHeaderBackButton));
      await tester.pumpAndSettle();

      expect(find.text('open'), findsOneWidget);
    });

    testWidgets('nothing to pop — standing alone it holds the space instead', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: MboaHeaderBackButton())),
      );

      // A centred title must not shift depending on whether a back arrow is
      // there, so the gap is kept.
      expect(find.byType(IconButton), findsNothing);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('with no navigator at all it still builds', (tester) async {
      // Golden tests pump these views bare.
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: MboaHeaderBackButton(),
        ),
      );

      expect(tester.takeException(), isNull);
    });
  });
}

/// A screen the way the apps build them.
class _Page extends StatelessWidget {
  const _Page(this.name, {this.next});

  final String name;
  final PageRouteInfo? next;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: MboaHeaderBackButton.leading(context),
          title: Text('page $name'),
        ),
        body: next == null
            ? null
            : TextButton(onPressed: () => unawaited(context.router.push(next!)), child: const Text('to b')),
      );
}

const _appShell = EmptyShellRoute('App');
PageRouteInfo _app({List<PageRouteInfo>? children}) => _appShell(children: children);
PageRouteInfo _a() => const PageRouteInfo('A');
PageRouteInfo _tabs() => const PageRouteInfo('Tabs');

class _Router extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: PageInfo('Home', builder: (_) => const _Page('home')), path: '/', initial: true),
        AutoRoute(
          page: _appShell,
          path: '/app',
          children: [
            AutoRoute(page: PageInfo('A', builder: (_) => const _Page('a', next: PageRouteInfo('B'))), path: 'a'),
            AutoRoute(page: PageInfo('B', builder: (_) => const _Page('b')), path: 'b'),
          ],
        ),
        AutoRoute(
          page: PageInfo('Tabs', builder: (_) => const AutoTabsRouter(routes: [PageRouteInfo('Tab')])),
          path: '/tabs',
          children: [AutoRoute(page: PageInfo('Tab', builder: (_) => const _Page('tab')), path: 'tab')],
        ),
      ];
}
