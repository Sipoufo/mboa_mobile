import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/home/ui/home_page.dart';

void main() {
  testWidgets('HomePage renders the localised Pro landing content', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: const HomePage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Mboa Pro'), findsOneWidget);
    expect(find.textContaining('Bienvenue'), findsOneWidget);
  });
}
