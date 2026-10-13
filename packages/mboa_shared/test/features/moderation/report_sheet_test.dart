import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockReportCubit extends MockCubit<ReportState> implements ReportCubit {}

/// The report sheet (CDC M23), and what it is willing to ask.
void main() {
  late MockReportCubit cubit;

  setUpAll(() {
    registerFallbackValue(const ReportTarget.annonce('x'));
    registerFallbackValue(ReportReason.inappropriateContent);
  });

  setUp(() {
    cubit = MockReportCubit();
    when(() => cubit.state).thenReturn(const ReportIdle());
    when(
      () => cubit.send(
        any(),
        reason: any(named: 'reason'),
        comment: any(named: 'comment'),
      ),
    ).thenAnswer((_) async {});
  });

  /// Opens the sheet the way the app does, from a button.
  Future<void> openSheet(WidgetTester tester, ReportTarget target) async {
    tester.view.physicalSize = const Size(390 * 3, 1200 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () =>
                  showReportSheet(context, target: target, cubit: cubit),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('a listing may be reported as fraudulent or overpriced',
      (tester) async {
    await openSheet(tester, const ReportTarget.annonce('a-1'));

    expect(find.text('Annonce frauduleuse'), findsOneWidget);
    expect(find.text('Prix anormal'), findsOneWidget);
  });

  testWidgets('RM-M27-06 — a review is never asked to justify its price',
      (tester) async {
    await openSheet(tester, const ReportTarget.review('r-1'));

    // The API's reason list was drawn for listings; two thirds of it is
    // nonsense against somebody's account of living somewhere.
    expect(find.text('Prix anormal'), findsNothing);
    expect(find.text('Annonce frauduleuse'), findsNothing);
    expect(find.text('Contenu inapproprié'), findsOneWidget);
    expect(find.text('Harcèlement'), findsOneWidget);
  });

  testWidgets('RM-M23-01 — nothing is sent without a reason', (tester) async {
    await openSheet(tester, const ReportTarget.review('r-1'));

    final send = tester.widget<Button>(
      find.widgetWithText(Button, 'Envoyer le signalement'),
    );
    expect(send.onPressed, isNull);
  });

  testWidgets('a chosen reason and a note reach the cubit as typed',
      (tester) async {
    await openSheet(tester, const ReportTarget.review('r-1'));

    await tester.tap(find.text('Harcèlement'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Insultes répétées.');
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(Button, 'Envoyer le signalement'));
    await tester.pump();

    verify(
      () => cubit.send(
        const ReportTarget.review('r-1'),
        reason: ReportReason.harassment,
        comment: 'Insultes répétées.',
      ),
    ).called(1);
  });
}
