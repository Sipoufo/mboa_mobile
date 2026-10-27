import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// §37 A — « Note des propriétaires » is real: how many rated, never who.
void main() {
  Future<void> pump(WidgetTester tester, MboaScoreSignal signal) => tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: Scaffold(body: SignalRow(signal: signal, withHint: true)),
        ),
      );

  testWidgets('no rating yet is said, not shown as « bientôt »', (tester) async {
    await pump(tester, const MboaScoreSignal(kind: ScoreSignalKind.providerRating, points: 0, maxPoints: 20, count: 0));

    expect(find.text('Pas encore de note'), findsOneWidget);
    expect(find.text('Bientôt'), findsNothing);
    expect(find.textContaining('à la fin d\'une location'), findsOneWidget);
  });

  testWidgets('rated: how many, and the points they earned', (tester) async {
    await pump(tester, const MboaScoreSignal(kind: ScoreSignalKind.providerRating, points: 20, maxPoints: 20, count: 2));

    expect(find.text('2 notes'), findsOneWidget);
  });
}
