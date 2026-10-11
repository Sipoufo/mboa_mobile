import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/auth/bloc/auth_bloc.dart';
import 'package:mboa_user/features/profile/profile_types.dart';
import 'package:mboa_user/features/shell/ui/account_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';

class MockUserProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements UserProfileBloc {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

/// The Compte tab (CDC M02).
///
/// It used to show two tiles and never said who was signed in, which made it
/// the one tab that told you nothing. What is pinned here is that it answers
/// the question it is named after.
void main() {
  late MockUserProfileBloc profile;
  late MockAuthBloc auth;

  const me = BaseProfile(
    firstName: 'Awa',
    lastName: 'Nkeng',
    email: 'awa@example.cm',
    phoneNumber: '+237 6 99 00 11 22',
  );

  setUpAll(loadBrandFonts);

  setUp(() {
    profile = MockUserProfileBloc();
    auth = MockAuthBloc();
    when(() => profile.state).thenReturn(const UserProfileReady(me));
    when(() => auth.state).thenReturn(const AuthInitial());
    if (!getIt.isRegistered<SessionSnapshot>()) {
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    }
  });

  tearDown(getIt.reset);

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<UserProfileBloc>.value(value: profile),
            BlocProvider<AuthBloc>.value(value: auth),
          ],
          child: const AccountPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('signed in, it says who you are', (tester) async {
    getIt<SessionSnapshot>().markAuthenticated();
    await pump(tester);

    expect(find.text('Awa Nkeng'), findsOneWidget);
    expect(find.text('+237 6 99 00 11 22'), findsOneWidget);
  });

  testWidgets('and where an account leads', (tester) async {
    getIt<SessionSnapshot>().markAuthenticated();
    await pump(tester);

    expect(find.text('Profil'), findsOneWidget);
    expect(find.text('Mes visites'), findsOneWidget);
    expect(find.text('Paramètres'), findsOneWidget);
    expect(find.text('Déconnexion'), findsOneWidget);
  });

  testWidgets('a visitor is offered a way in, not an empty profile',
      (tester) async {
    await pump(tester);

    expect(find.textContaining('Crée ton compte'), findsOneWidget);
    expect(find.text('Awa Nkeng'), findsNothing);
  });

  testWidgets('a profile still loading shows its shape, not a blank screen',
      (tester) async {
    getIt<SessionSnapshot>().markAuthenticated();
    when(() => profile.state).thenReturn(const ProfileInitial());
    await pump(tester);

    // The rows do not depend on the profile: they are where the account
    // leads, whether or not the name has arrived.
    expect(find.text('Mes visites'), findsOneWidget);
  });
}
