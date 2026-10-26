import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/app/router/app_router.gr.dart';
import 'package:mboa_pro/features/home/ui/widgets/home_header.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState> implements ProProfileBloc {}

class MockStackRouter extends Mock implements StackRouter {}

class _FakeRoute extends Fake implements PageRouteInfo<dynamic> {}

/// The Pro home's header.
void main() {
  setUpAll(() => registerFallbackValue(_FakeRoute()));

  testWidgets('its messages icon opens the inbox (M12) — it said « Bientôt »', (tester) async {
    final profile = MockProProfileBloc();
    when(() => profile.state).thenReturn(const ProfileInitial());
    final router = MockStackRouter();
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: StackRouterScope(
          controller: router,
          stateHash: 0,
          child: Scaffold(
            body: BlocProvider<ProProfileBloc>.value(value: profile, child: const HomeHeader()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Message'));

    final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
    expect(route.routeName, MessagesRoute.name);
  });
}
