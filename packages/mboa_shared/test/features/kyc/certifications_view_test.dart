import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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

  Future<void> pump(
    WidgetTester tester, {
    required bool withDeclarations,
    VoidCallback? onOpen,
    KycReady state = const KycReady(KycStatusData(status: KycStatus.notSubmitted), KycDraft()),
    String tab = 'Identification',
  }) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final cubit = MockKycCubit();
    when(() => cubit.state).thenReturn(state);
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
    await tester.tap(find.text(tab));
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

  group('refused', () {
    final refused = KycStatusData(
      status: KycStatus.rejected,
      reviewedAt: DateTime(2026, 11, 2, 10),
      rejectionReason: 'La photo du recto est floue : le numéro ne se lit pas. Reprends-la en pleine lumière.',
    );
    final state = KycReady(refused, KycDraft.of(refused));

    testWidgets('says when, the reason in full, and what to do — on the pieces\' tab', (tester) async {
      await pump(tester, withDeclarations: true, state: state);

      expect(find.text('Ta vérification a été refusée'), findsOneWidget);
      expect(find.text('Le 2 novembre 2026'), findsOneWidget);
      expect(find.text(refused.rejectionReason!), findsOneWidget);
      expect(find.textContaining('soumets à nouveau'), findsOneWidget);
      // Each piece is taken again — not each marked « Refusé ».
      expect(find.text('À reprendre'), findsNWidgets(2));
      expect(find.text('Refusé'), findsNothing);
      expect(find.widgetWithText(Button, 'Soumettre à nouveau'), findsOneWidget);
      await expectLater(find.byType(CertificationsView), matchesGoldenFile('goldens/kyc_refused.png'));
    });

    testWidgets('a piece taken again reads « Ajouté »', (tester) async {
      await pump(
        tester,
        withDeclarations: false,
        state: KycReady(refused, KycDraft.of(refused).withKey(KycSlot.selfie, 'kyc/u-1/selfie.jpg')),
      );

      expect(find.text('Ajouté'), findsOneWidget);
      expect(find.text('À reprendre'), findsOneWidget);
    });

    testWidgets('the status tab: the same card, and a refusal is not a wait', (tester) async {
      await pump(tester, withDeclarations: false, state: state, tab: 'Statut');

      expect(find.text('Ta vérification a été refusée'), findsOneWidget);
      expect(find.byIcon(LucideIcons.shieldX), findsNWidgets(2));
      expect(find.byIcon(LucideIcons.clock), findsNothing);
      await expectLater(find.byType(CertificationsView), matchesGoldenFile('goldens/kyc_refused_status.png'));
    });

    testWidgets('no reason given: still when, and what to do', (tester) async {
      await pump(
        tester,
        withDeclarations: false,
        state: KycReady(KycStatusData(status: KycStatus.rejected, reviewedAt: DateTime(2026, 11, 2)), const KycDraft()),
      );

      expect(find.text('Ta vérification a été refusée'), findsOneWidget);
      expect(find.textContaining('soumets à nouveau'), findsOneWidget);
    });
  });

  testWidgets('a first submission keeps « Soumettre »', (tester) async {
    await pump(tester, withDeclarations: false);

    expect(find.widgetWithText(Button, 'Soumettre'), findsOneWidget);
    expect(find.text('Ta vérification a été refusée'), findsNothing);
  });
}
