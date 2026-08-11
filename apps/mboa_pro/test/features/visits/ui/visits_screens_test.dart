import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/visits/bloc/agent_visits_bloc.dart';
import 'package:mboa_pro/features/visits/bloc/visit_detail_bloc.dart';
import 'package:mboa_pro/features/visits/bloc/visit_report_bloc.dart';
import 'package:mboa_pro/features/visits/models/agent_visit.dart';
import 'package:mboa_pro/features/visits/models/visit_report.dart';
import 'package:mboa_pro/features/visits/ui/agent_visits_page.dart';
import 'package:mboa_pro/features/visits/ui/visit_detail_page.dart';
import 'package:mboa_pro/features/visits/ui/visit_report_page.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockAgentVisitsBloc extends MockBloc<AgentVisitsEvent, AgentVisitsState>
    implements AgentVisitsBloc {}

class MockVisitDetailBloc extends MockBloc<VisitDetailEvent, VisitDetailState>
    implements VisitDetailBloc {}

class MockVisitReportBloc extends MockBloc<VisitReportEvent, VisitReportState>
    implements VisitReportBloc {}

/// The M16 screens, each pumped with **only** the blocs its own route provides
/// or inherits.
///
/// `VisitDetailRoute` and `VisitReportRoute` are siblings of the Visites tab
/// under `/app`, so anything they read has to come from `AuthenticatedWrapper`
/// or from their own `wrappedRoute`.
///
/// **Each screen gets only its own bloc.** The detail shipped reaching for
/// `AgentVisitsBloc` to cancel and threw on a device; this test provided it and
/// so proved nothing. Cancelling now goes through the detail's own bloc, and
/// the absence of `AgentVisitsBloc` below is the assertion.
void main() {
  late MockAgentVisitsBloc visits;
  late MockVisitDetailBloc detail;
  late MockVisitReportBloc report;

  final today = DateTime.now();

  AgentVisitDetail detailFor({
    bool canStart = false,
    bool started = false,
    bool reportSubmitted = false,
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
        startedAt: started ? today : null,
        canStart: canStart,
        reportSubmitted: reportSubmitted,
      );

  setUp(() {
    visits = MockAgentVisitsBloc();
    detail = MockVisitDetailBloc();
    report = MockVisitReportBloc();

    when(() => visits.state).thenReturn(
      VisitsReady(
        visits: [
          AgentVisit(
            id: 'v-1',
            status: VisitStatus.scheduled,
            annonceTitle: 'Studio Bonapriso',
            scheduledAt: today,
          ),
        ],
      ),
    );
    when(() => detail.state).thenReturn(VisitDetailReady(detailFor()));
    when(() => report.state).thenReturn(const ReportEditing());
  });

  Widget withVisits(Widget child) =>
      BlocProvider<AgentVisitsBloc>.value(value: visits, child: child);

  Widget withDetail(Widget child) =>
      BlocProvider<VisitDetailBloc>.value(value: detail, child: child);

  Widget withReport(Widget child) =>
      BlocProvider<VisitReportBloc>.value(value: report, child: child);

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

    testWidgets('cannot start before the day — the server decides',
        (tester) async {
      await pump(tester, withDetail(const VisitDetailPage(id: 'v-1')));

      final button = tester.widget<Button>(find.byType(Button));
      expect(button.onPressed, isNull);
      expect(find.text('Disponible le jour de la visite'), findsOneWidget);
    });

    testWidgets('starts when the server says it may', (tester) async {
      when(() => detail.state)
          .thenReturn(VisitDetailReady(detailFor(canStart: true)));
      await pump(tester, withDetail(const VisitDetailPage(id: 'v-1')));

      await tester.tap(find.text('Démarrer la visite'));
      await tester.pump();

      verify(() => detail.add(const VisitStartRequested())).called(1);
    });

    testWidgets('a started visit offers the report instead', (tester) async {
      when(() => detail.state).thenReturn(
        VisitDetailReady(detailFor(canStart: true, started: true)),
      );
      await pump(tester, withDetail(const VisitDetailPage(id: 'v-1')));

      expect(find.text('Rédiger le rapport'), findsOneWidget);
      expect(find.text('Démarrer la visite'), findsNothing);
    });

    testWidgets('a filed report is stated as locked, not editable',
        (tester) async {
      when(() => detail.state).thenReturn(
        VisitDetailReady(
          detailFor(started: true, reportSubmitted: true),
        ),
      );
      await pump(tester, withDetail(const VisitDetailPage(id: 'v-1')));

      // RM-M16-03 — offering an edit the server would refuse is worse than
      // saying it cannot be changed.
      expect(find.text('Rapport envoyé'), findsOneWidget);
      expect(
        find.text('Un rapport envoyé ne peut plus être modifié.'),
        findsOneWidget,
      );
      expect(find.text('Rédiger le rapport'), findsNothing);
    });
  });

  group('the report', () {
    testWidgets('cannot be sent until it is complete', (tester) async {
      await pump(tester, withReport(const VisitReportPage(visitId: 'v-1')));

      final button = tester.widget<Button>(find.byType(Button));
      expect(button.onPressed, isNull);
      // Says how many more, rather than leaving the button dead and silent.
      expect(find.text('Ajoutez encore 3 photo(s)'), findsOneWidget);
    });

    testWidgets('three photos alone are still not enough', (tester) async {
      when(() => report.state).thenReturn(
        const ReportEditing(
          draft: VisitReportDraft(photoKeys: ['a', 'b', 'c']),
        ),
      );
      await pump(tester, withReport(const VisitReportPage(visitId: 'v-1')));

      // Condition and conformity are required too.
      expect(tester.widget<Button>(find.byType(Button)).onPressed, isNull);
      expect(find.textContaining('Ajoutez encore'), findsNothing);
    });

    testWidgets('a complete report asks before filing it', (tester) async {
      when(() => report.state).thenReturn(
        const ReportEditing(
          draft: VisitReportDraft(
            overallCondition: 4,
            conformity: ListingConformity.oui,
            photoKeys: ['a', 'b', 'c'],
          ),
        ),
      );
      await pump(tester, withReport(const VisitReportPage(visitId: 'v-1')));

      await tester.tap(find.text('Envoyer le rapport'));
      await tester.pumpAndSettle();

      expect(
        find.text('Le rapport ne pourra plus être modifié après l\'envoi.'),
        findsOneWidget,
      );
      // Not filed until confirmed.
      verifyNever(() => report.add(const ReportSubmitted('v-1')));
    });
  });
}
