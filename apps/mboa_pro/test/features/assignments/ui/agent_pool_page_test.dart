import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/assignments/bloc/property_agent_bloc.dart';
import 'package:mboa_pro/features/assignments/models/assignment.dart';
import 'package:mboa_pro/features/assignments/ui/agent_assignment_page.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockPropertyAgentBloc
    extends MockBloc<PropertyAgentEvent, PropertyAgentState>
    implements PropertyAgentBloc {}

Assignment assignment({
  String id = 'as-1',
  String agentId = 'ag-1',
  String name = 'Emmanuel NDJOKO',
  AssignmentStatus status = AssignmentStatus.accepted,
}) =>
    Assignment(
      id: id,
      target: const AnnonceTarget('a-1'),
      status: status,
      initiatedBy: AssignmentInitiator.prestataire,
      agentAccountId: agentId,
      agentName: name,
    );

/// A property's pool of agents (CDC M11, revised 2026-08-13).
///
/// The screen used to hide the picker as soon as one agent held the property.
/// That exclusivity was repealed: several agents may cover the same listing and
/// the client picks one at booking time (RM-M07-01), so *Ajouter un agent* has
/// to stay reachable however full the pool is.
void main() {
  late MockPropertyAgentBloc bloc;

  setUp(() {
    bloc = MockPropertyAgentBloc();
    when(() => bloc.state).thenReturn(
      const PropertyAgentReady(target: AnnonceTarget('a-1')),
    );
  });

  Future<void> pump(WidgetTester tester) => tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<PropertyAgentBloc>.value(
            value: bloc,
            child: const AgentAssignmentPage(target: AnnonceTarget('a-1')),
          ),
        ),
      );

  testWidgets('an empty property says so and still offers to add', (tester) async {
    await pump(tester);

    expect(find.text('Aucun agent assigné pour le moment.'), findsOneWidget);
    expect(find.text('Ajouter un agent'), findsOneWidget);
  });

  testWidgets('several agents are listed, and one more may still be added',
      (tester) async {
    when(() => bloc.state).thenReturn(
      PropertyAgentReady(
        target: const AnnonceTarget('a-1'),
        assignments: [
          assignment(),
          assignment(id: 'as-2', agentId: 'ag-2', name: 'Awa Nkeng'),
        ],
      ),
    );
    await pump(tester);

    expect(find.text('Emmanuel NDJOKO'), findsOneWidget);
    expect(find.text('Awa Nkeng'), findsOneWidget);
    // The assertion that matters: the button survived a full property.
    expect(find.text('Ajouter un agent'), findsOneWidget);
  });

  testWidgets('an unanswered offer shows as waiting, not as working',
      (tester) async {
    when(() => bloc.state).thenReturn(
      PropertyAgentReady(
        target: const AnnonceTarget('a-1'),
        assignments: [assignment(status: AssignmentStatus.pending)],
      ),
    );
    await pump(tester);

    expect(find.text('En attente de réponse'), findsOneWidget);
  });

  testWidgets('removal is withheld while several agents are assigned',
      (tester) async {
    when(() => bloc.state).thenReturn(
      PropertyAgentReady(
        target: const AnnonceTarget('a-1'),
        assignments: [
          assignment(),
          assignment(id: 'as-2', agentId: 'ag-2', name: 'Awa Nkeng'),
        ],
      ),
    );
    await pump(tester);

    // RM-M11-06 — `DELETE /annonces/{id}/agent` names no agent, so the app
    // cannot say which one would go. It says that instead of guessing.
    expect(find.text("Retirer l'assignation"), findsNothing);
    expect(
      find.textContaining("Le retrait d'un agent n'est pas encore possible"),
      findsOneWidget,
    );
  });

  testWidgets('a single agent can be removed', (tester) async {
    when(() => bloc.state).thenReturn(
      PropertyAgentReady(
        target: const AnnonceTarget('a-1'),
        assignments: [assignment()],
      ),
    );
    await pump(tester);

    expect(find.text("Retirer l'assignation"), findsOneWidget);
  });

  group('RM-M11-10 — the owner as a visitor', () {
    testWidgets('the toggle flips the flag on the listing', (tester) async {
      when(() => bloc.state).thenReturn(
        const PropertyAgentReady(
          target: AnnonceTarget('a-1'),
          ownerVisitsEnabled: false,
        ),
      );
      await pump(tester);

      expect(find.text('Je fais les visites moi-même'), findsOneWidget);
      await tester.tap(find.byType(Switch));
      await tester.pump();

      verify(() => bloc.add(const OwnerVisitsToggled(enabled: true))).called(1);
    });

    testWidgets('a residence shows no such toggle', (tester) async {
      when(() => bloc.state).thenReturn(
        const PropertyAgentReady(target: ResidenceTarget('r-1')),
      );
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<PropertyAgentBloc>.value(
            value: bloc,
            child: const AgentAssignmentPage(target: ResidenceTarget('r-1')),
          ),
        ),
      );

      // Null means "no such flag here" — drawing it off would claim the owner
      // had declined something nobody asked him.
      expect(find.byType(Switch), findsNothing);
    });
  });
}
