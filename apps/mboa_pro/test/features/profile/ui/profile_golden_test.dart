import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/auth/bloc/auth_bloc.dart';
import 'package:mboa_pro/features/profile/models/prestataire_type.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_pro/features/profile/ui/edit_profile_view.dart';
import 'package:mboa_pro/features/profile/ui/settings_view.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProProfileBloc {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

/// The prestataire's Profil (CDC M02).
void main() {
  late MockProProfileBloc profile;
  late MockAuthBloc auth;

  const complete = ProfileData(
    firstName: 'Ydille',
    lastName: 'Fynem',
    email: 'kiawantio.izess@si-dji.home.com',
    role: AccountRole.prestataire,
    displayName: 'Agence Deido Immobilier',
    mainCity: 'Douala',
    mainCityId: 'c1',
    type: PrestataireType.agence,
    registrationNumber: 'RC/DLA/2024/B/1234',
    profileComplete: true,
  );

  const incomplete = ProfileData(
    firstName: 'Ydille',
    lastName: 'Fynem',
    email: 'kiawantio.izess@si-dji.home.com',
    role: AccountRole.prestataire,
    displayName: 'Agence Deido Immobilier',
    type: PrestataireType.agence,
    profileComplete: false,
  );

  setUpAll(loadBrandFonts);

  setUp(() {
    profile = MockProProfileBloc();
    auth = MockAuthBloc();
    when(() => profile.state).thenReturn(const ProProfileReady(complete));
  });

  Future<void> pump(WidgetTester tester, Widget child) async {
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
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ProProfileBloc>.value(value: profile),
            BlocProvider<AuthBloc>.value(value: auth),
          ],
          child: child,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the profile hub', (tester) async {
    await pump(tester, const SettingsView());

    await expectLater(
      find.byType(SettingsView),
      matchesGoldenFile('goldens/profile_hub.png'),
    );
  });

  testWidgets('RM-M10-01 — an incomplete profile says so before publish does',
      (tester) async {
    when(() => profile.state).thenReturn(const ProProfileReady(incomplete));
    await pump(tester, const SettingsView());

    expect(find.text('Profil incomplet'), findsOneWidget);

    await expectLater(
      find.byType(SettingsView),
      matchesGoldenFile('goldens/profile_hub_incomplete.png'),
    );
  });

  testWidgets('the hub shows the business the account speaks for',
      (tester) async {
    await pump(tester, const SettingsView());

    // Both are facts the app already held and never displayed; the second is
    // what the Contrat Mboa prints (M08).
    expect(find.text('Agence Deido Immobilier'), findsOneWidget);
    expect(find.text('RC/DLA/2024/B/1234'), findsOneWidget);
  });

  testWidgets('a missing registration reads as missing, not as blank',
      (tester) async {
    when(() => profile.state).thenReturn(const ProProfileReady(incomplete));
    await pump(tester, const SettingsView());

    expect(find.text('À renseigner'), findsNWidgets(2));
  });

  testWidgets('the edit form carries the registration number', (tester) async {
    await pump(tester, const EditProfileView());

    expect(find.text('RC/DLA/2024/B/1234'), findsOneWidget);
    expect(find.text('Identité'), findsOneWidget);
    expect(find.text('Activité'), findsOneWidget);
  });

  testWidgets('the edit form', (tester) async {
    await pump(tester, const EditProfileView());

    await expectLater(
      find.byType(EditProfileView),
      matchesGoldenFile('goldens/profile_edit.png'),
    );
  });
}
