import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/assignments/bloc/agent_missions_bloc.dart';
import 'package:mboa_pro/features/assignments/models/assignment.dart';
import 'package:mboa_pro/features/assignments/ui/agent_missions_page.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockAgentMissionsBloc
    extends MockBloc<AgentMissionsEvent, AgentMissionsState>
    implements AgentMissionsBloc {}

void main() {
  late MockAgentMissionsBloc bloc;

  const offer = Assignment(
    id: 'as-1',
    target: AnnonceTarget('a-1'),
    status: AssignmentStatus.pending,
    initiatedBy: AssignmentInitiator.prestataire,
    propertyTitle: 'Studio Bonapriso',
  );

  const mission = Assignment(
    id: 'as-2',
    target: AnnonceTarget('a-2'),
    status: AssignmentStatus.accepted,
    initiatedBy: AssignmentInitiator.agent,
    propertyTitle: 'Villa Bonanjo',
  );

  setUp(() => bloc = MockAgentMissionsBloc());

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<AgentMissionsBloc>.value(
          value: bloc,
          child: const AgentMissionsPage(),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('opens on offers, the only list that costs the agent',
      (tester) async {
    when(() => bloc.state)
        .thenReturn(const MissionsReady(assignments: [offer, mission]));
    await pump(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('Studio Bonapriso'), findsOneWidget);
    // A mission the agent already holds is not an offer.
    expect(find.text('Villa Bonanjo'), findsNothing);
  });

  testWidgets('counts waiting offers on the segment', (tester) async {
    when(() => bloc.state).thenReturn(const MissionsReady(assignments: [offer]));
    await pump(tester);

    expect(find.text('Propositions (1)'), findsOneWidget);
  });

  testWidgets('no badge when nothing is waiting', (tester) async {
    when(() => bloc.state)
        .thenReturn(const MissionsReady(assignments: [mission]));
    await pump(tester);

    expect(find.text('Propositions'), findsOneWidget);
  });

  testWidgets('accepting an offer dispatches, it does not navigate away',
      (tester) async {
    when(() => bloc.state).thenReturn(const MissionsReady(assignments: [offer]));
    await pump(tester);

    await tester.tap(find.text('Accepter'));
    await tester.pump();

    verify(() => bloc.add(const MissionAccepted(offer))).called(1);
  });

  testWidgets('stepping down asks first — it cancels booked visits',
      (tester) async {
    when(() => bloc.state).thenReturn(
      const MissionsReady(assignments: [mission], filter: MissionFilter.mine),
    );
    await pump(tester);

    await tester.tap(find.text('Me désister'));
    await tester.pumpAndSettle();

    // RM-M11-06 — the tenants who booked lose their visit, so this is not a
    // one-tap action.
    expect(
      find.text('Les visites déjà planifiées seront annulées.'),
      findsOneWidget,
    );
    verifyNever(() => bloc.add(const MissionResigned(mission)));
  });

  testWidgets('an empty opportunities list points at the agent\'s own zones',
      (tester) async {
    when(() => bloc.state)
        .thenReturn(const MissionsReady(filter: MissionFilter.opportunities));
    await pump(tester);

    // RM-M15-04 — the cause is fixable by the agent, so the copy says how.
    expect(
      find.text(
        'Élargissez vos zones d\'intervention pour recevoir plus de propositions.',
      ),
      findsOneWidget,
    );
  });
}
