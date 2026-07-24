import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_ui/mboa_ui.dart';

void main() {
  group('MboaTheme', () {
    test('builds light and dark themes from a seed', () {
      final light = MboaTheme.light(MboaColors.userSeed);
      final dark = MboaTheme.dark(MboaColors.proSeed);

      expect(light.useMaterial3, isTrue);
      expect(light.colorScheme.brightness, Brightness.light);
      expect(dark.colorScheme.brightness, Brightness.dark);
    });
  });

  group('MboaSplashView', () {
    testWidgets('shows a custom logo, spinner and footer', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MboaSplashView(
            logo: Text('MBOA'),
            footer: Text('v1.0.0'),
          ),
        ),
      );

      expect(find.text('MBOA'), findsOneWidget);
      expect(find.text('v1.0.0'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('hides the spinner when showProgress is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MboaSplashView(logo: Text('MBOA'), showProgress: false),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  group('PrimaryButton', () {
    testWidgets('shows a spinner and disables when loading', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              label: 'Valider',
              isLoading: true,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Valider'), findsNothing);

      await tester.tap(find.byType(PrimaryButton));
      expect(tapped, isFalse); // disabled while loading
    });

    testWidgets('fires onPressed when idle', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(label: 'Valider', onPressed: () => tapped = true),
          ),
        ),
      );

      await tester.tap(find.byType(PrimaryButton));
      expect(tapped, isTrue);
    });
  });
}
