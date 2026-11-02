import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/app/router/app_router.gr.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_pro/features/profile/ui/edit_profile_view.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState> implements ProProfileBloc {}

class MockStackRouter extends Mock implements StackRouter {
  // The form is pumped alone: nothing under it, so no back arrow.
  @override
  bool canPop({bool ignoreChildRoutes = false, bool ignoreParentRoutes = false, bool ignorePagelessRoutes = false}) =>
      false;
}

class _FakeRoute extends Fake implements PageRouteInfo<Object?> {}

/// The founder: « Ajouter l'option de modification d'infos personnelles chez
/// les agents ». The form existed and knew agents; nothing on the agent's
/// side opened it.
void main() {
  late MockProProfileBloc profile;
  late MockStackRouter router;

  const agent = ProfileData(
    firstName: 'Paul',
    lastName: 'Essomba',
    email: 'paul.essomba@example.cm',
    phoneNumber: '+237690000014',
    role: AccountRole.agent,
  );

  setUpAll(() async {
    await loadBrandFonts();
    registerFallbackValue(_FakeRoute());
    registerFallbackValue(const ProfileLoadRequested());
  });

  setUp(() {
    profile = MockProProfileBloc();
    router = MockStackRouter();
    when(() => profile.state).thenReturn(const ProProfileReady(agent));
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
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
        home: StackRouterScope(
          controller: router,
          stateHash: 0,
          child: BlocProvider<ProProfileBloc>.value(value: profile, child: const EditProfileView()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Button save(WidgetTester tester) => tester.widget<Button>(find.widgetWithText(Button, 'Enregistrer'));

  testWidgets('an agent: the names, the email to read, the phone — no business section', (tester) async {
    await pump(tester);

    expect(find.text('Paul'), findsOneWidget);
    expect(find.text('Essomba'), findsOneWidget);
    expect(find.text('paul.essomba@example.cm'), findsOneWidget);
    expect(find.text('+237690000014'), findsOneWidget);
    expect(find.text('Activité'), findsNothing);
    await expectLater(find.byType(EditProfileView), matchesGoldenFile('goldens/profile_edit_agent.png'));
  });

  testWidgets('nothing changed, nothing to save; a new name is saved as an agent\'s', (tester) async {
    await pump(tester);
    expect(save(tester).onPressed, isNull);

    await tester.enterText(find.widgetWithText(TextField, 'Essomba'), 'Essomba Ngo');
    await tester.pump();
    expect(save(tester).onPressed, isNotNull);

    await tester.tap(find.widgetWithText(Button, 'Enregistrer'));
    await tester.pump();

    final sent = verify(() => profile.add(captureAny())).captured.whereType<ProfileSaveRequested<ProfileEdit>>().single;
    expect(sent.edit.lastName, 'Essomba Ngo');
    expect(sent.edit.isAgent, isTrue);
    expect(sent.edit.isPrestataire, isFalse);
  });

  testWidgets('the phone opens its own change, and is read again on return', (tester) async {
    await pump(tester);

    await tester.tap(find.text('+237690000014'));
    await tester.pumpAndSettle();

    verify(() => router.push<Object?>(const ChangePhoneRoute())).called(1);
    verify(() => profile.add(const ProfileLoadRequested())).called(1);
  });
}
