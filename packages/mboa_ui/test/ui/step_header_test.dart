import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The top of a step in a multi-step flow.
void main() {
  Future<void> pump(WidgetTester tester, Widget header) => tester.pumpWidget(
    MaterialApp(
      locale: const Locale('fr'),
      theme: MboaTheme.light(),
      localizationsDelegates: MboaLocalizations.delegates,
      supportedLocales: MboaLocalizations.supportedLocales,
      home: Scaffold(body: header),
    ),
  );

  testWidgets('says where the reader is, and asks the step\'s question', (tester) async {
    await pump(tester, const MboaStepHeader(current: 2, total: 3, title: 'Quelle charge ?'));

    expect(find.text('Étape 2 sur 3'), findsOneWidget);
    expect(find.text('Quelle charge ?'), findsOneWidget);
    expect(find.byType(AnimatedContainer), findsNWidgets(3));
  });

  testWidgets('a segment tapped names its step — never the current one', (tester) async {
    final tapped = <int>[];
    await pump(tester, MboaStepHeader(current: 2, total: 3, title: 'Quelle charge ?', onStepTap: tapped.add));

    final segments = find.byType(AnimatedContainer);
    await tester.tap(segments.at(0));
    await tester.tap(segments.at(1));
    await tester.tap(segments.at(2));

    expect(tapped, [1, 3]);
  });
}
