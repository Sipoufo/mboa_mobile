import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late MockLocationRepository repository;

  setUp(() {
    repository = MockLocationRepository();
    when(() => repository.cities(regionId: any(named: 'regionId'))).thenAnswer(
      (_) async => const [CityOption(id: '1', name: 'Douala'), CityOption(id: '2', name: 'Yaoundé')],
    );
  });

  Future<void> open(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => showCityPicker(context, repository: repository),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  // Regression: iOS turned « Dou » into « D'où », and the correction bubble
  // swallowed the tap on Douala.
  testWidgets('the search field neither corrects nor suggests', (tester) async {
    await open(tester);

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.autocorrect, isFalse);
    expect(field.enableSuggestions, isFalse);
  });

  testWidgets('typing filters the cities', (tester) async {
    await open(tester);

    await tester.enterText(find.byType(TextField), 'dou');
    await tester.pumpAndSettle();

    expect(find.text('Douala'), findsOneWidget);
    expect(find.text('Yaoundé'), findsNothing);
  });
}
