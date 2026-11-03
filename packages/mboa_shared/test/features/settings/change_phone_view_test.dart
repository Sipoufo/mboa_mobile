import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../score/load_brand_fonts.dart';

class MockChangePhoneBloc extends MockBloc<ChangePhoneEvent, ChangePhoneState> implements ChangePhoneBloc {}

/// RM-M02-02 — « Il faut renseigner l'ancien numéro avant le nouveau ». The
/// screen asked for the new number only.
void main() {
  late MockChangePhoneBloc bloc;
  late StreamController<ChangePhoneState> states;

  setUpAll(loadBrandFonts);

  setUp(() {
    bloc = MockChangePhoneBloc();
    states = StreamController<ChangePhoneState>();
    whenListen(bloc, states.stream, initialState: const ChangePhoneEnterPhone());
    GetIt.I.registerFactory<ChangePhoneBloc>(() => bloc);
  });

  tearDown(() async {
    await states.close();
    await GetIt.I.reset();
  });

  Future<void> pump(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: const ChangePhoneView(),
      ),
    );
    await tester.pump();
  }

  // The current number's field comes first (the order is tested below).
  Finder field(String label) => find.byType(TextField).at(label == 'Ton numéro actuel' ? 0 : 1);
  Button send(WidgetTester tester) => tester.widget<Button>(find.widgetWithText(Button, 'Recevoir les codes'));

  Future<void> type(WidgetTester tester, {required String current, required String next}) async {
    await tester.enterText(field('Ton numéro actuel'), current);
    await tester.enterText(field('Ton nouveau numéro'), next);
    await tester.pump();
  }

  Future<void> refuse(WidgetTester tester, ChangePhoneError error) async {
    await tester.tap(find.widgetWithText(Button, 'Recevoir les codes'));
    await tester.pump();
    states.add(ChangePhoneEnterPhone(error: error));
    await tester.pump();
    await tester.pump();
    // The error fades in.
    await tester.pump(const Duration(milliseconds: 300));
  }

  testWidgets('the current number first, then the new one', (tester) async {
    await pump(tester);

    final currentTop = tester.getTopLeft(find.text('Ton numéro actuel')).dy;
    final nextTop = tester.getTopLeft(find.text('Ton nouveau numéro')).dy;
    expect(currentTop, lessThan(nextTop));
  });

  testWidgets('the codes are asked for only once both are complete and different', (tester) async {
    await pump(tester);
    expect(send(tester).onPressed, isNull);

    await type(tester, current: '690000014', next: '6900000');
    expect(send(tester).onPressed, isNull);

    await type(tester, current: '690000014', next: '690000014');
    expect(send(tester).onPressed, isNull);

    await type(tester, current: '690000014', next: '690000000');
    expect(send(tester).onPressed, isNotNull);
  });

  testWidgets('both numbers go, the current one first', (tester) async {
    await pump(tester);
    await type(tester, current: '690000014', next: '690000000');

    await tester.tap(find.widgetWithText(Button, 'Recevoir les codes'));
    await tester.pump();

    verify(
      () => bloc.add(const ChangePhoneRequested(currentPhoneNumber: '+237690000014', newPhoneNumber: '+237690000000')),
    ).called(1);
  });

  testWidgets('not the account\'s number: said under it — and gone once it is edited', (tester) async {
    await pump(tester);
    await type(tester, current: '690000015', next: '690000000');
    await refuse(tester, ChangePhoneError.currentMismatch);

    expect(find.text("Ce n'est pas ton numéro actuel."), findsOneWidget);
    final errorTop = tester.getTopLeft(find.text("Ce n'est pas ton numéro actuel.")).dy;
    expect(errorTop, lessThan(tester.getTopLeft(find.text('Ton nouveau numéro')).dy));
    await expectLater(find.byType(ChangePhoneView), matchesGoldenFile('goldens/change_phone_mismatch.png'));

    await tester.enterText(field('Ton numéro actuel'), '690000014');
    await tester.tap(find.widgetWithText(Button, 'Recevoir les codes'));
    await tester.pump();
    expect(find.text("Ce n'est pas ton numéro actuel."), findsNothing);
  });

  testWidgets('the new number taken: said under the new number', (tester) async {
    await pump(tester);
    await type(tester, current: '690000014', next: '690000000');
    await refuse(tester, ChangePhoneError.alreadyUsed);

    final error = find.text('Ce numéro est déjà utilisé par un autre compte.');
    expect(error, findsOneWidget);
    expect(tester.getTopLeft(error).dy, greaterThan(tester.getTopLeft(find.text('Ton nouveau numéro')).dy));
  });

  testWidgets('the new number is the current one, by the server: said under it', (tester) async {
    await pump(tester);
    await type(tester, current: '690000014', next: '690000000');
    await refuse(tester, ChangePhoneError.unchanged);

    expect(find.text("C'est déjà ton numéro."), findsOneWidget);
  });

  testWidgets('the codes step names both numbers', (tester) async {
    await pump(tester);
    states.add(const ChangePhoneEnterCodes(currentPhoneNumber: '+237690000014', newPhoneNumber: '+237690000000'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Code reçu sur +237690000014'), findsOneWidget);
    expect(find.text('Code reçu sur +237690000000'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 300));
    await expectLater(find.byType(ChangePhoneView), matchesGoldenFile('goldens/change_phone_codes.png'));
  });
}
