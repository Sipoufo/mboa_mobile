import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/app/router/app_router.gr.dart';
import 'package:mboa_user/features/profile/profile_types.dart';
import 'package:mboa_user/features/profile/ui/edit_profile_view.dart';
import 'package:mocktail/mocktail.dart';

class MockUserProfileBloc extends MockBloc<ProfileEvent, ProfileState> implements UserProfileBloc {}

class MockStackRouter extends Mock implements StackRouter {
  @override
  bool canPop({bool ignoreChildRoutes = false, bool ignoreParentRoutes = false, bool ignorePagelessRoutes = false}) =>
      false;
}

class _FakeRoute extends Fake implements PageRouteInfo<Object?> {}

/// §40 A — the tenant's email and number, each added or changed on its own
/// code-verified screen. The email was read-only and the number not shown.
void main() {
  late MockUserProfileBloc profile;
  late MockStackRouter router;

  setUpAll(() {
    registerFallbackValue(_FakeRoute());
    registerFallbackValue(const ProfileLoadRequested());
  });

  setUp(() {
    profile = MockUserProfileBloc();
    router = MockStackRouter();
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
  });

  Future<void> pump(WidgetTester tester, BaseProfile data) async {
    when(() => profile.state).thenReturn(UserProfileReady(data));
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: StackRouterScope(
          controller: router,
          stateHash: 0,
          child: BlocProvider<UserProfileBloc>.value(value: profile, child: const EditProfileView()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('a phone account: « Ajouter » an email — with its phone to verify', (tester) async {
    await pump(tester, const BaseProfile(firstName: 'Awa', lastName: 'Nkeng', phoneNumber: '+237690000000'));

    expect(find.text('Ajouter'), findsOneWidget);
    expect(find.text('Changer'), findsOneWidget);

    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();

    // A route's equality ignores its arguments: they are read off the push.
    final pushed = verify(() => router.push<Object?>(captureAny())).captured.single as ChangeEmailRoute;
    expect((pushed.args?.currentEmail, pushed.args?.phoneNumber), (null, '+237690000000'));
    verify(() => profile.add(const ProfileLoadRequested())).called(1);
  });

  testWidgets('an email account: « Ajouter » a number — its first, one code', (tester) async {
    await pump(tester, const BaseProfile(firstName: 'Awa', lastName: 'Nkeng', email: 'awa@example.cm'));

    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();

    final pushed = verify(() => router.push<Object?>(captureAny())).captured.single as ChangePhoneRoute;
    expect(pushed.args?.adding, isTrue);
  });
}
