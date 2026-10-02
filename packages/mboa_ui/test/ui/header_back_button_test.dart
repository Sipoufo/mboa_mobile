import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The back arrow of a self-painted header.
///
/// The bug it exists for: a screen pushed into a nested router is alone in
/// that router's stack, so the nearest navigator has nothing to pop and the
/// arrow vanished — on the Settings hub, with no way back to the app.
void main() {
  Widget host({required bool pushed}) => MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const Scaffold(
                      // A nested Navigator, the way a nested router gives one:
                      // nothing to pop *here*, something to pop above.
                      body: _NestedHost(),
                    ),
                  ),
                ),
              child: const Text('open'),
              ),
            ),
          ),
        ),
      );

  testWidgets('nothing to pop — it holds the space instead', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: MboaHeaderBackButton())),
    );

    // A centred title must not shift depending on whether a back arrow is
    // there, so the gap is kept.
    expect(find.byType(IconButton), findsNothing);
    expect(find.byType(SizedBox), findsOneWidget);
  });

  testWidgets('a route below, even behind a nested navigator', (tester) async {
    await tester.pumpWidget(host(pushed: true));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    // The nested navigator has a single route and cannot pop; the root can.
    expect(find.byType(IconButton), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(find.text('open'), findsOneWidget);
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
}

class _NestedHost extends StatelessWidget {
  const _NestedHost();

  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (_) => MaterialPageRoute<void>(
          builder: (_) => const MboaHeaderBackButton(),
        ),
      );
}
