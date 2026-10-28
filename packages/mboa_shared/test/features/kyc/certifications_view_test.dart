import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../score/load_brand_fonts.dart';

class MockKycCubit extends MockCubit<KycState> implements KycCubit {}

/// §39 C — the tenant's identity screen is the Pro one, without what only a
/// prestataire declares.
void main() {
  setUpAll(loadBrandFonts);

  Future<void> pump(WidgetTester tester, {required bool withDeclarations, VoidCallback? onOpen}) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final cubit = MockKycCubit();
    when(() => cubit.state).thenReturn(const KycReady(KycStatusData(status: KycStatus.notSubmitted), KycDraft()));
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<KycCubit>.value(
          value: cubit,
          child: CertificationsView(onOpenIdDocument: onOpen ?? () {}, withDeclarations: withDeclarations),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Identification'));
    await tester.pumpAndSettle();
  }

  testWidgets('a tenant: the selfie and the document, no NUI, no address', (tester) async {
    await pump(tester, withDeclarations: false);

    expect(find.text('Selfie'), findsOneWidget);
    expect(find.text('Pièce d\'identité'), findsOneWidget);
    expect(find.text('NUI'), findsNothing);
    expect(find.text('Adresse'), findsNothing);
  });

  testWidgets('a prestataire: the NUI and the address too', (tester) async {
    await pump(tester, withDeclarations: true);

    expect(find.text('NUI'), findsOneWidget);
    expect(find.text('Adresse'), findsOneWidget);
  });

  testWidgets('the document opens the app\'s own route', (tester) async {
    var opened = 0;
    await pump(tester, withDeclarations: false, onOpen: () => opened++);

    await tester.tap(find.text('Pièce d\'identité'));

    expect(opened, 1);
  });
}
