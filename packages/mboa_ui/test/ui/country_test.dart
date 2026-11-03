import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

/// §40 A — any country's number: its dial code, its lengths, its name. The
/// sign-in took a Cameroonian number of nine digits, nothing else.
void main() {
  test('every country, Central Africa first among them', () {
    expect(MboaCountry.all.length, greaterThan(200));
    expect(MboaCountry.centralAfrica.first, MboaCountry.cameroon);
    expect(MboaCountry.centralAfrica.map((c) => c.dialCode), ['+237', '+241', '+242', '+235', '+236', '+240']);
  });

  test('a number is checked by its own country\'s rules, and written as the server takes it', () {
    expect(MboaCountry.cameroon.e164('690000000'), '+237690000000');
    expect(MboaCountry.cameroon.e164('69000000'), isNull);
    const gabon = MboaCountry(IsoCode.GA);
    expect(gabon.e164(gabon.example!), startsWith('+241'));
    expect(const MboaCountry(IsoCode.FR).e164('612345678'), '+33612345678');
  });

  test('named in the reader\'s language', () {
    expect(MboaCountry.cameroon.name(const Locale('fr')), 'Cameroun');
    expect(MboaCountry.cameroon.name(const Locale('en')), 'Cameroon');
  });

  testWidgets('the picker: found by name, accents aside, or by dial code', (tester) async {
    MboaCountry? chosen;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async => chosen = await showCountryPicker(context, selected: MboaCountry.cameroon),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('Afrique centrale'), findsOneWidget);
    expect(find.text('Gabon'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'cote');
    await tester.pumpAndSettle();
    expect(find.text('Côte d’Ivoire'), findsOneWidget);
    expect(find.text('Gabon'), findsNothing);

    await tester.enterText(find.byType(TextField), '+241');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Gabon'));
    await tester.pumpAndSettle();

    expect(chosen, const MboaCountry(IsoCode.GA));
  });
}
