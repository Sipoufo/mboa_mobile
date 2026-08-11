import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/app/router/role_gate_page.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProProfileBloc {}

/// Which shell `/app` opens on, and why the gate cannot simply await a state
/// change.
///
/// `ProfileBloc` skips `ProfileLoadInProgress` when it already holds data, and
/// drops a reload producing an equal `ProfileReady` as a duplicate. The bloc is
/// a get_it singleton that nothing reset on sign-out, so a second sign-in
/// emitted **nothing at all** — and a gate waiting for a change waited forever.
/// Reported from a device as a stuck loading screen.
void main() {
  const prestataire = ProProfileReady(ProfileData(role: AccountRole.prestataire));
  const agent = ProProfileReady(ProfileData(role: AccountRole.agent));

  group('the decision', () {
    test('a role known at startup decides on its own', () {
      // Resume: /me already reported it, so the profile is irrelevant.
      expect(
        roleGateDecisionFor(
          knownRole: AccountRole.agent,
          profileState: const ProfileInitial(),
        ),
        RoleGateDecision.agent,
      );
      expect(
        roleGateDecisionFor(
          knownRole: AccountRole.prestataire,
          profileState: const ProfileLoadFailure(),
        ),
        RoleGateDecision.prestataire,
      );
    });

    test('a profile already loaded decides, with no emission needed', () {
      // The exact shape of the reported hang.
      expect(
        roleGateDecisionFor(knownRole: null, profileState: agent),
        RoleGateDecision.agent,
      );
      expect(
        roleGateDecisionFor(knownRole: null, profileState: prestataire),
        RoleGateDecision.prestataire,
      );
    });

    test('an unknown role waits rather than guessing', () {
      for (final state in [
        const ProfileInitial(),
        const ProfileLoadInProgress(),
      ]) {
        expect(
          roleGateDecisionFor(knownRole: null, profileState: state),
          RoleGateDecision.wait,
          reason: '$state',
        );
      }
    });

    test('a failed load asks again instead of spinning', () {
      expect(
        roleGateDecisionFor(
          knownRole: null,
          profileState: const ProfileLoadFailure(),
        ),
        RoleGateDecision.askAgain,
      );
    });

    test('a plain user is not mistaken for an agent', () {
      // AccountRole defaults to `user` in several places; only `agent` may take
      // the agent shell.
      expect(
        roleGateDecisionFor(
          knownRole: AccountRole.user,
          profileState: const ProfileInitial(),
        ),
        RoleGateDecision.prestataire,
      );
    });
  });

  testWidgets('a failed load renders a retry, not an endless spinner',
      (tester) async {
    // The gate consults the snapshot before falling back to the profile.
    if (getIt.isRegistered<SessionSnapshot>()) {
      getIt.unregister<SessionSnapshot>();
    }
    getIt.registerSingleton<SessionSnapshot>(SessionSnapshot());
    addTearDown(() => getIt.unregister<SessionSnapshot>());

    final profile = MockProProfileBloc();
    when(() => profile.state).thenReturn(const ProfileLoadFailure());

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<ProProfileBloc>.value(
          value: profile,
          child: const RoleGatePage(),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(Loader), findsNothing);
    await tester.tap(find.text('Réessayer'));
    await tester.pump();

    verify(() => profile.add(const ProfileLoadRequested())).called(1);
  });
}
