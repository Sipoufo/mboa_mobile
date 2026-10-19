import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/auth/bloc/auth_bloc.dart';
import 'package:mboa_user/features/profile/profile_types.dart';
import 'package:mboa_user/features/shell/ui/account_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';

class MockUserProfileBloc extends MockBloc<ProfileEvent, ProfileState> implements UserProfileBloc {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

/// The Compte tab and the bar under it, as the tenant sees them — pinned so
/// a restyle is looked at, not assumed.
void main() {
  const me = BaseProfile(
    firstName: 'Awa',
    lastName: 'Nkeng',
    email: 'awa@example.cm',
    phoneNumber: '+237 6 99 00 11 22',
  );

  setUpAll(loadBrandFonts);

  setUp(() {
    if (!getIt.isRegistered<SessionSnapshot>()) {
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    }
    getIt<SessionSnapshot>().markAuthenticated();
  });

  tearDown(getIt.reset);

  testWidgets('Compte, signed in, matches the reference', (tester) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final profile = MockUserProfileBloc();
    final auth = MockAuthBloc();
    when(() => profile.state).thenReturn(const UserProfileReady(me));
    when(() => auth.state).thenReturn(const AuthInitial());

    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<UserProfileBloc>.value(value: profile),
            BlocProvider<AuthBloc>.value(value: auth),
          ],
          child: Scaffold(
            body: const AccountPage(),
            bottomNavigationBar: MboaBottomNav(
              selectedIndex: 3,
              onTap: (_) {},
              items: const [
                MboaBottomNavItem(icon: LucideIcons.search, label: 'Recherche'),
                MboaBottomNavItem(icon: LucideIcons.heart, label: 'Favoris'),
                MboaBottomNavItem(icon: LucideIcons.messageSquare, label: 'Messages'),
                MboaBottomNavItem(icon: LucideIcons.userRound, label: 'Compte'),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/account_signed_in.png'));
  });
}
