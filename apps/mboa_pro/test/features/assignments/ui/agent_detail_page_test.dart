import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/assignments/bloc/agent_detail_bloc.dart';
import 'package:mboa_pro/features/assignments/bloc/my_agents_bloc.dart';
import 'package:mboa_pro/features/assignments/models/assignment.dart';
import 'package:mboa_pro/features/assignments/ui/agent_detail_page.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockAgentDetailBloc extends MockBloc<AgentDetailEvent, AgentDetailState>
    implements AgentDetailBloc {}

class MockMyAgentsBloc extends MockBloc<MyAgentsEvent, MyAgentsState>
    implements MyAgentsBloc {}

Assignment assignment({
  String id = 'as-1',
  AssignmentTarget target = const AnnonceTarget('a-1'),
  AssignmentStatus status = AssignmentStatus.accepted,
  String? title = 'Studio Bonapriso',
  int? unitCount,
}) =>
    Assignment(
      id: id,
      target: target,
      status: status,
      initiatedBy: AssignmentInitiator.prestataire,
      agentAccountId: 'ag-1',
      agentName: 'Emmanuel NDJOKO',
      propertyTitle: title,
      unitCount: unitCount,
    );

/// The agent as a prestataire sees them.
///
/// Two sources on purpose: the public profile for who they are, and
/// `MyAgentsBloc` for what they hold *for this prestataire* — which no endpoint
/// reports.
void main() {
  late MockAgentDetailBloc detail;
  late MockMyAgentsBloc agents;

  const profile = AgentPublicProfileView(
    accountId: 'ag-1',
    firstName: 'Emmanuel',
    lastName: 'NDJOKO',
    completedVisitCount: 12,
    averageRating: 4.75,
    ratingCount: 4,
    zones: [
      AgentZoneLabel(city: 'Douala'),
      AgentZoneLabel(city: 'Douala', district: 'Akwa'),
    ],
  );

  setUp(() {
    detail = MockAgentDetailBloc();
    agents = MockMyAgentsBloc();
    when(() => detail.state).thenReturn(const AgentDetailReady(profile));
    when(() => agents.state).thenReturn(
      MyAgentsReady(
        rows: [
          AgentRow(
            agentAccountId: 'ag-1',
            agentName: 'Emmanuel NDJOKO',
            assignments: [assignment()],
          ),
        ],
      ),
    );
  });

  Future<void> pump(WidgetTester tester, {String id = 'ag-1'}) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AgentDetailBloc>.value(value: detail),
            BlocProvider<MyAgentsBloc>.value(value: agents),
          ],
          child: AgentDetailPage(agentAccountId: id),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('shows who they are and what they have done', (tester) async {
    await pump(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('Emmanuel NDJOKO'), findsWidgets);
    expect(find.text('4.8'), findsOneWidget);
    expect(find.text('4 avis'), findsOneWidget);
    expect(find.textContaining('12 visites'), findsOneWidget);
  });

  group('the rating', () {
    testWidgets('an unrated agent is not shown as zero stars', (tester) async {
      when(() => detail.state).thenReturn(
        const AgentDetailReady(
          AgentPublicProfileView(
            accountId: 'ag-1',
            firstName: 'Emmanuel',
            lastName: 'NDJOKO',
            // Rating a visit is optional (RM-M07-07), so twelve visits with no
            // rating is ordinary — "0 ★" would libel them.
            completedVisitCount: 12,
            ratingCount: 0,
          ),
        ),
      );
      await pump(tester);

      expect(find.text('Pas encore noté'), findsOneWidget);
      expect(find.text('0.0'), findsNothing);
      expect(find.text('0 avis'), findsNothing);
    });

    testWidgets('a rating with no reviews behind it is not shown either',
        (tester) async {
      when(() => detail.state).thenReturn(
        const AgentDetailReady(
          AgentPublicProfileView(
            accountId: 'ag-1',
            averageRating: 4.5,
            ratingCount: 0,
          ),
        ),
      );
      await pump(tester);

      expect(find.text('Pas encore noté'), findsOneWidget);
    });
  });

  testWidgets('zones distinguish a whole city from a district', (tester) async {
    await pump(tester);

    expect(find.text('Douala — Toute la ville'), findsOneWidget);
    expect(find.text('Akwa, Douala'), findsOneWidget);
  });

  group('what they hold for this prestataire', () {
    testWidgets('live work and unanswered offers are separated',
        (tester) async {
      when(() => agents.state).thenReturn(
        MyAgentsReady(
          rows: [
            AgentRow(
              agentAccountId: 'ag-1',
              agentName: 'Emmanuel NDJOKO',
              assignments: [
                assignment(),
                assignment(
                  id: 'as-2',
                  target: const ResidenceTarget('r-1'),
                  status: AssignmentStatus.pending,
                  title: 'Résidence Deido',
                  unitCount: 8,
                ),
              ],
            ),
          ],
        ),
      );
      await pump(tester);

      expect(find.text('Biens confiés'), findsOneWidget);
      expect(find.text('Studio Bonapriso'), findsOneWidget);
      // An offer they have not answered is not a property they hold.
      expect(find.text('En attente de réponse'), findsWidgets);
      expect(find.text('Résidence Deido'), findsOneWidget);
    });

    testWidgets('an agent with nothing yet says so', (tester) async {
      when(() => agents.state).thenReturn(
        const MyAgentsReady(
          rows: [AgentRow(agentAccountId: 'ag-1', assignments: [])],
        ),
      );
      await pump(tester);

      expect(find.text('Aucun bien confié pour le moment'), findsOneWidget);
    });
  });

  testWidgets('a failed profile still names the agent', (tester) async {
    when(() => detail.state).thenReturn(const AgentDetailFailure());
    await pump(tester);

    // The assignment list already knew the name, so the screen is not anonymous
    // just because the public profile did not load.
    expect(find.text('Emmanuel NDJOKO'), findsOneWidget);
    expect(find.text('Profil indisponible'), findsOneWidget);
    expect(find.text('Studio Bonapriso'), findsOneWidget);
  });

  testWidgets('an agent no longer in the list does not crash the screen',
      (tester) async {
    // A refresh behind this screen can drop the row.
    await pump(tester, id: 'ag-gone');

    expect(tester.takeException(), isNull);
    expect(find.text('Aucun bien confié pour le moment'), findsOneWidget);
  });
}
