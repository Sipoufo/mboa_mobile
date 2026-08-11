import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/annonces/ui/widgets/form_field_shell.dart';
import 'package:mboa_pro/features/annonces/ui/widgets/form_text_field.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The per-field help affordance: an icon by the label that opens a sheet.
///
/// A tooltip was rejected — it needs a long-press on touch, advertises nothing,
/// and leaves no room for the copy. The icon must therefore be present, tappable
/// at a real target size, and absent where no help was written.
void main() {
  Widget host(Widget child) => MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Scaffold(body: child),
      );

  testWidgets('a text field with help shows the icon and opens the sheet',
      (tester) async {
    await tester.pumpWidget(
      host(
        FormTextField(
          label: 'Loyer',
          helpText: 'Le loyer mensuel en FCFA.',
          onChanged: (_) {},
        ),
      ),
    );

    expect(find.byIcon(Icons.info_outline), findsOneWidget);
    // The copy is behind the icon, not on the form.
    expect(find.text('Le loyer mensuel en FCFA.'), findsNothing);

    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pumpAndSettle();

    expect(find.text('Le loyer mensuel en FCFA.'), findsOneWidget);
    // The sheet titles itself, so it stands on its own over the form.
    expect(find.text('Loyer'), findsNWidgets(2));
  });

  testWidgets('a non-text field with help gets the same affordance',
      (tester) async {
    await tester.pumpWidget(
      host(
        const FormFieldShell(
          label: 'Charges incluses',
          helpText: "Indiquez si l'eau et l'électricité sont comprises.",
          child: SizedBox.shrink(),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pumpAndSettle();

    expect(
      find.text("Indiquez si l'eau et l'électricité sont comprises."),
      findsOneWidget,
    );
  });

  testWidgets('no icon where no help was written', (tester) async {
    await tester.pumpWidget(
      host(FormTextField(label: 'Titre', onChanged: (_) {})),
    );

    // An icon on every label becomes wallpaper; only the fields whose answer is
    // not obvious carry one.
    expect(find.byIcon(Icons.info_outline), findsNothing);
  });

  testWidgets('the tap target is large enough to hit', (tester) async {
    await tester.pumpWidget(
      host(
        const FieldHelp(label: 'Photos', text: '3 photos minimum.'),
      ),
    );

    final size = tester.getSize(find.byType(FieldHelp));
    expect(size.width, greaterThanOrEqualTo(44));
    expect(size.height, greaterThanOrEqualTo(44));
  });
}
