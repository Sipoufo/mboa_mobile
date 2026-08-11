import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/agent/bloc/agent_availability_bloc.dart';
import 'package:mboa_pro/features/auth/bloc/auth_bloc.dart';
import 'package:mboa_pro/features/agent/bloc/agent_profile_bloc.dart';
import 'package:mboa_pro/features/agent/models/agent_profile.dart';
import 'package:mboa_pro/features/agent/models/availability.dart';
import 'package:mboa_pro/features/agent/ui/agent_availability_page.dart';
import 'package:mboa_pro/features/agent/ui/agent_profile_page.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockAgentProfileBloc
    extends MockBloc<AgentProfileEvent, AgentProfileState>
    implements AgentProfileBloc {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockAgentAvailabilityBloc
    extends MockBloc<AgentAvailabilityEvent, AgentAvailabilityState>
    implements AgentAvailabilityBloc {}

/// The agent screens read `AgentProfileBloc` from `AuthenticatedWrapper`, not
/// from the agent shell — the zones screen is a *sibling* of the shell, and a
/// bloc provided by one route is invisible to its siblings. That has thrown
/// ProviderNotFoundException twice in this app, so each screen is pumped with
/// only the blocs its own route inherits.
void main() {
  late MockAgentProfileBloc profile;
  late MockAgentAvailabilityBloc availability;
  late MockAuthBloc auth;

  const ready = AgentProfile(
    accountId: 'a-1',
    firstName: 'Awa',
    lastName: 'Nkeng',
    photoObjectKey: 'photo.jpg',
    zones: [AgentCityZone('c-1')],
    completedVisitCount: 12,
    averageRating: 4.5,
    ratingCount: 8,
    status: AgentStatus.active,
    profileComplete: true,
  );

  setUp(() {
    profile = MockAgentProfileBloc();
    availability = MockAgentAvailabilityBloc();
    auth = MockAuthBloc();
    when(() => profile.state).thenReturn(const AgentProfileReady(ready));
    when(() => availability.state).thenReturn(
      const AvailabilityReady(saved: Availability(), draft: Availability()),
    );
  });

  Future<void> pump(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AgentProfileBloc>.value(value: profile),
            BlocProvider<AgentAvailabilityBloc>.value(value: availability),
            BlocProvider<AuthBloc>.value(value: auth),
          ],
          child: child,
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('the profile screen opens and loads on entry', (tester) async {
    await pump(tester, const AgentProfilePage());

    expect(tester.takeException(), isNull);
    expect(find.text('Awa Nkeng'), findsOneWidget);
    verify(() => profile.add(const AgentProfileLoadRequested())).called(1);
  });

  testWidgets('shows the status, so silence has a stated cause', (tester) async {
    when(() => profile.state).thenReturn(
      const AgentProfileReady(
        AgentProfile(accountId: 'a-1', status: AgentStatus.suspended),
      ),
    );
    await pump(tester, const AgentProfilePage());

    // RM-M11-05 pulls a suspended agent off their assignments; the app must not
    // leave them wondering why nothing arrives.
    expect(find.text('Suspendu'), findsOneWidget);
  });

  testWidgets('an incomplete profile says what is missing', (tester) async {
    when(() => profile.state).thenReturn(
      const AgentProfileReady(
        AgentProfile(accountId: 'a-1', profileComplete: false),
      ),
    );
    await pump(tester, const AgentProfilePage());

    expect(find.text('Profil incomplet'), findsOneWidget);
  });

  testWidgets('a complete profile shows no warning', (tester) async {
    await pump(tester, const AgentProfilePage());

    expect(find.text('Profil incomplet'), findsNothing);
  });

  testWidgets('an average is shown when there are reviews', (tester) async {
    await pump(tester, const AgentProfilePage());

    expect(find.text('4.5'), findsOneWidget);
    expect(find.text('8 avis'), findsOneWidget);
  });

  testWidgets('no rating shows a dash, never a zero', (tester) async {
    when(() => profile.state).thenReturn(
      const AgentProfileReady(AgentProfile(accountId: 'a-1')),
    );
    await pump(tester, const AgentProfilePage());

    // "0" would read as a bad average rather than as no reviews.
    expect(find.text('—'), findsOneWidget);
    expect(find.text('Pas encore noté'), findsOneWidget);
  });

  testWidgets('the agent can sign out from their profile', (tester) async {
    // The agent shell has no slide menu, so this screen is the only exit. An
    // agent without it is stuck in a session they cannot leave.
    await tester.binding.setSurfaceSize(const Size(800, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await pump(tester, const AgentProfilePage());

    await tester.tap(find.text('Quitter'));
    await tester.pump();

    verify(() => auth.add(const AuthLogoutRequested())).called(1);
  });

  testWidgets('the account surfaces are reachable from the profile',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await pump(tester, const AgentProfilePage());

    expect(find.text('Paramètres'), findsOneWidget);
    expect(find.text('Certifications'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
  });

  testWidgets('the availability screen renders every day of the week',
      (tester) async {
    // Seven day cards plus the days-off section run past the default 800x600
    // surface, and a ListView only builds what is near the viewport.
    await tester.binding.setSurfaceSize(const Size(800, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await pump(tester, const AgentAvailabilityPage());

    expect(tester.takeException(), isNull);
    for (final day in [
      'Lundi',
      'Mardi',
      'Mercredi',
      'Jeudi',
      'Vendredi',
      'Samedi',
      'Dimanche',
    ]) {
      expect(find.text(day), findsOneWidget, reason: day);
    }
  });

  testWidgets('a clean availability form cannot be saved', (tester) async {
    await pump(tester, const AgentAvailabilityPage());

    final button = tester.widget<Button>(find.byType(Button));
    expect(button.onPressed, isNull);
  });
}
