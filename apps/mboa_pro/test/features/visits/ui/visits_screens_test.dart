import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/visits/bloc/agent_visits_bloc.dart';
import 'package:mboa_pro/features/visits/bloc/visit_detail_bloc.dart';
import 'package:mboa_pro/features/visits/models/agent_visit.dart';
import 'package:mboa_pro/features/visits/ui/agent_visits_page.dart';
import 'package:mboa_pro/features/visits/ui/visit_detail_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockAgentVisitsBloc extends MockBloc<AgentVisitsEvent, AgentVisitsState>
    implements AgentVisitsBloc {}

class MockVisitDetailBloc extends MockBloc<VisitDetailEvent, VisitDetailState>
    implements VisitDetailBloc {}

/// The M16 screens, each pumped with **only** the blocs its own route provides
/// or inherits.
///
/// `VisitDetailRoute` is a sibling of the Visites tab under `/app`, so anything
/// it reads has to come from `AuthenticatedWrapper` or from its own
/// `wrappedRoute`.
///
/// **Each screen gets only its own bloc.** The detail shipped reaching for
/// `AgentVisitsBloc` to cancel and threw on a device; this test provided it and
/// so proved nothing. Cancelling now goes through the detail's own bloc, and
/// the absence of `AgentVisitsBloc` below is the assertion.
void main() {
  late MockAgentVisitsBloc visits;
  late MockVisitDetailBloc detail;

  final today = DateTime.now();

  AgentVisitDetail detailFor({
    bool canConfirm = false,
    bool visitorConfirmed = false,
    bool clientConfirmed = false,
    VisitStatus status = VisitStatus.scheduled,
  }) =>
      AgentVisitDetail(
        id: 'v-1',
        status: status,
        annonceTitle: 'Studio Bonapriso',
        exactAddress: 'Rue 1.234, Bonapriso',
        scheduledAt: today,
        userName: 'Awa Nkeng',
        userPhone: '+237690000000',
        prestataireName: 'Agence Deido',
        prestatairePhone: '+237691111111',
        visitorConfirmedAt: visitorConfirmed ? today : null,
        clientConfirmedAt: clientConfirmed ? today : null,
        canConfirm: canConfirm,
      );

  setUp(() {
    visits = MockAgentVisitsBloc();
    detail = MockVisitDetailBloc();

    when(() => visits.state).thenReturn(
      VisitsReady(
        visits: [
          Visit(
            id: 'v-1',
            status: VisitStatus.scheduled,
            annonceTitle: 'Studio Bonapriso',
            scheduledAt: today,
          ),
        ],
      ),
    );
    when(() => detail.state).thenReturn(VisitDetailReady(detailFor()));
  });

  Widget withVisits(Widget child) =>
      BlocProvider<AgentVisitsBloc>.value(value: visits, child: child);

  Widget withDetail(Widget child) =>
      BlocProvider<VisitDetailBloc>.value(value: detail, child: child);

  Future<void> pump(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: child,
      ),
    );
    await tester.pump();
  }

  group('the list', () {
    testWidgets('opens on today', (tester) async {
      await pump(tester, withVisits(const AgentVisitsPage()));

      expect(tester.takeException(), isNull);
      expect(find.text("Aujourd'hui (1)"), findsOneWidget);
      expect(find.text('Studio Bonapriso'), findsOneWidget);
    });

    testWidgets('no badge when there is nothing today', (tester) async {
      when(() => visits.state).thenReturn(const VisitsReady());
      await pump(tester, withVisits(const AgentVisitsPage()));

      expect(find.text("Aujourd'hui"), findsOneWidget);
      expect(find.text('Aucune visite aujourd\'hui'), findsOneWidget);
    });
  });

  group('the detail', () {
    testWidgets('shows the exact address, which exists nowhere else',
        (tester) async {
      await pump(tester, withDetail(const VisitDetailPage(id: 'v-1')));

      // RM-M16-01 — the agent's view is the only place it appears.
      expect(find.text('Rue 1.234, Bonapriso'), findsOneWidget);
      expect(find.textContaining('Visible uniquement par vous'), findsOneWidget);
    });

    testWidgets('gives the agent both numbers', (tester) async {
      await pump(tester, withDetail(const VisitDetailPage(id: 'v-1')));

      // They are going to a stranger's property to meet another stranger.
      expect(find.textContaining('+237690000000'), findsOneWidget);
      expect(find.textContaining('+237691111111'), findsOneWidget);
    });

    testWidgets('cannot confirm before the day — the server decides',
        (tester) async {
      await pump(tester, withDetail(const VisitDetailPage(id: 'v-1')));

      final button = tester.widget<Button>(find.byType(Button));
      expect(button.onPressed, isNull);
      expect(find.text('Disponible le jour de la visite'), findsOneWidget);
    });

    testWidgets('confirms presence when the server says it may', (tester) async {
      when(() => detail.state)
          .thenReturn(VisitDetailReady(detailFor(canConfirm: true)));
      await pump(tester, withDetail(const VisitDetailPage(id: 'v-1')));

      await tester.tap(find.text('Confirmer ma présence'));
      await tester.pump();

      verify(() => detail.add(const VisitPresenceConfirmed())).called(1);
    });

    testWidgets('says the client is being waited on, and offers nothing else',
        (tester) async {
      when(() => detail.state).thenReturn(
        VisitDetailReady(detailFor(visitorConfirmed: true)),
      );
      await pump(tester, withDetail(const VisitDetailPage(id: 'v-1')));

      // RM-M07-05 — the agent cannot supply the client's confirmation, so
      // showing the button again would promise something they cannot do.
      expect(find.text('Présence confirmée'), findsOneWidget);
      expect(find.text('Confirmer ma présence'), findsNothing);
    });

    testWidgets('a completed visit cannot be restarted', (tester) async {
      when(() => detail.state).thenReturn(
        VisitDetailReady(
          detailFor(
            status: VisitStatus.completed,
            visitorConfirmed: true,
            clientConfirmed: true,
          ),
        ),
      );
      await pump(tester, withDetail(const VisitDetailPage(id: 'v-1')));

      // RM-M16-03, and RM-M07bis — the report is the client's to write, so
      // this screen must not offer one.
      expect(find.text('Visite effectuée'), findsOneWidget);
      expect(find.text('Confirmer ma présence'), findsNothing);
      expect(find.textContaining('rapport'), findsNothing);
    });

    testWidgets('a visit nobody confirmed is stated as not fulfilled',
        (tester) async {
      when(() => detail.state).thenReturn(
        VisitDetailReady(detailFor(status: VisitStatus.notFulfilled)),
      );
      await pump(tester, withDetail(const VisitDetailPage(id: 'v-1')));

      // RM-M16-05 — it is over, and no action brings it back.
      expect(find.text('Visite non honorée'), findsOneWidget);
      expect(find.byType(Button), findsNothing);
    });
  });
}
