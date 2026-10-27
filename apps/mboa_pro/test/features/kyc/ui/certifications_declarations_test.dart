import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/kyc/logic/kyc_cubit.dart';
import 'package:mboa_pro/features/kyc/models/kyc_draft.dart';
import 'package:mboa_pro/features/kyc/models/kyc_status.dart';
import 'package:mboa_pro/features/kyc/ui/certifications_view.dart';
import 'package:mboa_pro/features/profile/models/prestataire_type.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockKycCubit extends MockCubit<KycState> implements KycCubit {}

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState> implements ProProfileBloc {}

/// §37 B — the two « Bientôt » tiles are real now.
void main() {
  late MockKycCubit cubit;
  const complete = KycDraft(selfieKey: 's', idFrontKey: 'f', idBackKey: 'b');

  setUpAll(loadBrandFonts);

  setUp(() => cubit = MockKycCubit());
  tearDown(getIt.reset);

  Future<void> pump(WidgetTester tester, KycState state, {PrestataireType type = PrestataireType.particulier}) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final profile = MockProProfileBloc();
    when(() => profile.state).thenReturn(
      ProProfileReady(ProfileData(firstName: 'Inesse', role: AccountRole.prestataire, type: type)),
    );
    getIt.registerSingleton<ProProfileBloc>(profile);
    when(() => cubit.state).thenReturn(state);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<KycCubit>.value(
          value: cubit,
          child: const CertificationsView(accountRole: AccountRole.prestataire),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Identification'));
    await tester.pumpAndSettle();
  }

  Button submit(WidgetTester tester) => tester.widget<Button>(find.widgetWithText(Button, 'Soumettre'));

  testWidgets('a particulier: both optional, and the documents are enough', (tester) async {
    await pump(tester, const KycReady(KycStatusData(status: KycStatus.notSubmitted), complete));

    expect(find.text('Bientôt'), findsNothing);
    expect(find.text('Facultatif'), findsNWidgets(2));
    expect(submit(tester).onPressed, isNotNull);
  });

  testWidgets('an agence owes a NUI: said on the tile, and nothing is sent without it', (tester) async {
    await pump(tester, const KycReady(KycStatusData(status: KycStatus.notSubmitted), complete), type: PrestataireType.agence);

    expect(find.text('Obligatoire pour une agence ou un promoteur'), findsOneWidget);
    expect(submit(tester).onPressed, isNull);
  });

  testWidgets('declared: the NUI and the place read back on the tiles', (tester) async {
    await pump(
      tester,
      KycReady(
        const KycStatusData(status: KycStatus.notSubmitted),
        complete
            .withNui('m0123 4567 8901x')
            .withAddress(const DeclaredAddress(districtId: 'd', city: 'Douala', district: 'Akwa')),
      ),
      type: PrestataireType.agence,
    );

    expect(find.text('M012345678901X'), findsOneWidget);
    expect(find.text('Akwa, Douala'), findsOneWidget);
    expect(submit(tester).onPressed, isNotNull);
  });

  testWidgets('RM-M01bis-10 — approved without a NUI: one can still be added', (tester) async {
    await pump(tester, const KycReady(KycStatusData(status: KycStatus.approved), KycDraft()));

    expect(find.text('Ajouter mon NUI'), findsOneWidget);
  });
}
