import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_ui/mboa_ui.dart';

void main() {
  group('MboaTheme', () {
    test('light/dark register the brand token extensions', () {
      final light = MboaTheme.light();
      final dark = MboaTheme.dark();

      expect(light.useMaterial3, isTrue);
      expect(light.colorScheme.brightness, Brightness.light);
      expect(dark.colorScheme.brightness, Brightness.dark);

      // Brand palette from Doc 05 is mapped onto Material + the extension.
      expect(light.colorScheme.primary, MboaPalette.forest);
      expect(light.colorScheme.secondary, MboaPalette.coral);
      expect(light.extension<MboaColorScheme>(), isNotNull);
      expect(light.extension<MboaTextTheme>(), isNotNull);
    });
  });

  group('token accessors', () {
    testWidgets('context.mboaColors / context.mboaText read the extensions',
        (tester) async {
      late Color primary;
      late double h1Size;

      await tester.pumpWidget(
        MaterialApp(
          theme: MboaTheme.light(),
          home: Builder(
            builder: (context) {
              primary = context.mboaColors.primary;
              h1Size = context.mboaText.h1.fontSize!;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(primary, MboaPalette.forest);
      expect(h1Size, 28); // Doc 05 §3.2
    });
  });

  group('MboaSplashView', () {
    testWidgets('shows a custom logo, spinner and footer', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MboaTheme.light(),
          home: const MboaSplashView(logo: Text('MBOA'), footer: Text('v1.0.0')),
        ),
      );

      expect(find.text('MBOA'), findsOneWidget);
      expect(find.text('v1.0.0'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('hides the spinner when showProgress is false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MboaTheme.light(),
          home: const MboaSplashView(logo: Text('MBOA'), showProgress: false),
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
          theme: MboaTheme.light(),
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
      expect(tapped, isFalse);
    });

    testWidgets('fires onPressed when idle', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: MboaTheme.light(),
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
