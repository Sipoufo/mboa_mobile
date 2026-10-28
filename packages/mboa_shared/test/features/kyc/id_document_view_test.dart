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

/// The document's screen, both apps (§39 B / C).
void main() {
  late MockKycCubit cubit;
  const notSubmitted = KycStatusData(status: KycStatus.notSubmitted);
  final details = DocumentIdentity(
    type: KycDocType.passport,
    number: 'AA0123456',
    issuedOn: DateTime(2022, 5, 2),
    expiresOn: DateTime(2032, 5, 1),
    issuedAt: 'Yaoundé',
  );

  setUpAll(loadBrandFonts);
  setUp(() => cubit = MockKycCubit());

  Future<void> pump(WidgetTester tester, KycDraft draft, {List<KycDocType> types = KycDocType.values}) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    when(() => cubit.state).thenReturn(KycReady(notSubmitted, draft));
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<KycCubit>.value(value: cubit, child: IdDocumentView(types: types)),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the tenant app offers the CNI and the passport only', (tester) async {
    await pump(tester, const KycDraft(), types: const [KycDocType.cni, KycDocType.passport]);

    expect(find.text('Carte d’identité'), findsOneWidget);
    expect(find.text('Passeport'), findsOneWidget);
    expect(find.text('Permis de conduire'), findsNothing);
  });

  testWidgets('a passport: no back to photograph, and what it says below the photos', (tester) async {
    await pump(tester, KycDraft(identity: details));

    expect(find.text('Recto'), findsOneWidget);
    expect(find.text('Verso'), findsNothing);
    expect(find.text('Les informations de la pièce'), findsOneWidget);
    expect(find.text('AA0123456'), findsOneWidget);
  });

  testWidgets('not photographed: not « Terminé »', (tester) async {
    await pump(tester, KycDraft(identity: details));

    expect(tester.widget<Button>(find.widgetWithText(Button, 'Terminé')).onPressed, isNull);
  });

  testWidgets('photographed and filled in: « Terminé »', (tester) async {
    await pump(tester, KycDraft(idFrontKey: 'f', identity: details));

    expect(tester.widget<Button>(find.widgetWithText(Button, 'Terminé')).onPressed, isNotNull);
  });

  testWidgets('an expired document is said under its date', (tester) async {
    await pump(tester, KycDraft(identity: details.copyWith(expiresOn: DateTime(2020, 1, 1))));

    expect(find.text('Cette pièce a expiré.'), findsOneWidget);
  });

  testWidgets('« Changer de pièce » goes back to the types', (tester) async {
    await pump(tester, KycDraft(identity: details));
    await tester.tap(find.text('Changer de pièce'));

    verify(() => cubit.clearDocType()).called(1);
  });

  testWidgets('the screen', (tester) async {
    await pump(
      tester,
      KycDraft(idFrontKey: 'f', idBackKey: 'b', identity: details.copyWith(type: KycDocType.cni, number: 'CM1234567')),
    );

    await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/id_document.png'));
  });
}
