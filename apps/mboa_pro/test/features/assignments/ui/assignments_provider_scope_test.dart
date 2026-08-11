import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/agent/bloc/agent_profile_bloc.dart';
import 'package:mboa_pro/features/annonces/bloc/annonces_bloc.dart';
import 'package:mboa_pro/features/annonces/bloc/residences_bloc.dart';
import 'package:mboa_pro/features/assignments/bloc/agent_detail_bloc.dart';
import 'package:mboa_pro/features/assignments/bloc/my_agents_bloc.dart';
import 'package:mboa_pro/features/assignments/bloc/property_agent_bloc.dart';
import 'package:mboa_pro/features/assignments/models/assignment.dart';
import 'package:mboa_pro/features/assignments/ui/agent_assignment_page.dart';
import 'package:mboa_pro/features/assignments/ui/agent_detail_page.dart';
import 'package:mboa_pro/features/assignments/ui/mes_agents_page.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockMyAgentsBloc extends MockBloc<MyAgentsEvent, MyAgentsState>
    implements MyAgentsBloc {}

class MockAgentDetailBloc extends MockBloc<AgentDetailEvent, AgentDetailState>
    implements AgentDetailBloc {}

class MockPropertyAgentBloc
    extends MockBloc<PropertyAgentEvent, PropertyAgentState>
    implements PropertyAgentBloc {}

class MockAgentProfileBloc
    extends MockBloc<AgentProfileEvent, AgentProfileState>
    implements AgentProfileBloc {}

class MockAnnoncesBloc extends MockBloc<AnnoncesEvent, AnnoncesState>
    implements AnnoncesBloc {}

class MockResidencesBloc extends MockBloc<ResidencesEvent, ResidencesState>
    implements ResidencesBloc {}

/// Every M11 screen, pumped with **only** the blocs its own route inherits.
///
/// `MesAgentsRoute`, `AgentDetailRoute` and `AgentAssignmentRoute` are all
/// *siblings* under `/app`, so a bloc provided by one is invisible to the
/// others. The agent detail shipped reading `MyAgentsBloc` while Mes agents
/// provided it, and threw `ProviderNotFoundException` on a device — the third
/// time this app has hit that.
///
/// The earlier test missed it by providing every bloc the screen might want.
/// **Provide only what the route really inherits, or the test proves nothing.**
void main() {
  late MockMyAgentsBloc myAgents;
  late MockAgentDetailBloc agentDetail;
  late MockPropertyAgentBloc propertyAgent;

  setUp(() {
    myAgents = MockMyAgentsBloc();
    agentDetail = MockAgentDetailBloc();
    propertyAgent = MockPropertyAgentBloc();

    when(() => myAgents.state).thenReturn(const MyAgentsReady());
    when(() => agentDetail.state).thenReturn(const AgentDetailInitial());
    when(() => propertyAgent.state).thenReturn(
      const PropertyAgentReady(target: AnnonceTarget('a-1')),
    );
  });

  /// Exactly what `AuthenticatedWrapper` provides — nothing route-scoped.
  Widget sessionScoped({required Widget child}) => MultiBlocProvider(
        providers: [
          BlocProvider<MyAgentsBloc>.value(value: myAgents),
          BlocProvider<AnnoncesBloc>.value(value: MockAnnoncesBloc()),
          BlocProvider<ResidencesBloc>.value(value: MockResidencesBloc()),
          BlocProvider<AgentProfileBloc>.value(value: MockAgentProfileBloc()),
        ],
        child: child,
      );

  Future<void> pump(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: sessionScoped(child: child),
      ),
    );
    await tester.pump();
  }

  testWidgets('Mes agents renders from the session-scoped bloc',
      (tester) async {
    await pump(tester, const MesAgentsPage());

    expect(tester.takeException(), isNull);
    // It no longer provides the bloc itself, so it has to ask for the load.
    verify(() => myAgents.add(const MyAgentsLoadRequested())).called(1);
  });

  testWidgets('the agent detail reads MyAgentsBloc from the wrapper',
      (tester) async {
    // This is the exact failure: AgentDetailRoute is a sibling of
    // MesAgentsRoute, so it can only see what `/app` provides.
    await pump(
      tester,
      BlocProvider<AgentDetailBloc>.value(
        value: agentDetail,
        child: const AgentDetailPage(agentAccountId: 'ag-1'),
      ),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('a deep link into the detail loads the assignments itself',
      (tester) async {
    when(() => myAgents.state).thenReturn(const MyAgentsInitial());

    await pump(
      tester,
      BlocProvider<AgentDetailBloc>.value(
        value: agentDetail,
        child: const AgentDetailPage(agentAccountId: 'ag-1'),
      ),
    );

    // Arriving without passing through Mes agents, the list is empty.
    verify(() => myAgents.add(const MyAgentsLoadRequested())).called(1);
  });

  testWidgets('the assignment screen needs nothing but its own bloc',
      (tester) async {
    await pump(
      tester,
      BlocProvider<PropertyAgentBloc>.value(
        value: propertyAgent,
        child: const AgentAssignmentPage(target: AnnonceTarget('a-1')),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}
