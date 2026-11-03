import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/app/router/app_router.gr.dart';
import 'package:mboa_pro/features/visits/bloc/prestataire_visits_bloc.dart';
import 'package:mboa_pro/features/visits/bloc/visit_detail_bloc.dart';
import 'package:mboa_pro/features/visits/bloc/visit_review_bloc.dart';
import 'package:mboa_pro/features/visits/bloc/visits_agenda_blocs.dart';
import 'package:mboa_pro/features/visits/models/agent_visit.dart';
import 'package:mboa_pro/features/visits/ui/listing_visits_page.dart';
import 'package:mboa_pro/features/visits/ui/prestataire_visits_page.dart';
import 'package:mboa_pro/features/visits/ui/visit_detail_page.dart';
import 'package:mboa_pro/features/visits/ui/visit_review_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockPrestataireAgendaBloc extends MockBloc<VisitsAgendaEvent, VisitsAgendaState>
    implements PrestataireAgendaBloc {}

class MockAgentsVisitsAgendaBloc extends MockBloc<VisitsAgendaEvent, VisitsAgendaState>
    implements AgentsVisitsAgendaBloc {}

class MockListingVisitsAgendaBloc extends MockBloc<VisitsAgendaEvent, VisitsAgendaState>
    implements ListingVisitsAgendaBloc {}

class MockPrestataireVisitsBloc extends MockBloc<PrestataireVisitsEvent, PrestataireVisitsState>
    implements PrestataireVisitsBloc {}

class MockVisitDetailBloc extends MockBloc<VisitDetailEvent, VisitDetailState> implements VisitDetailBloc {}

class MockVisitReviewBloc extends MockBloc<VisitReviewEvent, VisitReviewState> implements VisitReviewBloc {}

class MockStackRouter extends Mock implements StackRouter {
  @override
  bool canPop({bool ignoreChildRoutes = false, bool ignoreParentRoutes = false, bool ignorePagelessRoutes = false}) =>
      false;
}

class _FakeRoute extends Fake implements PageRouteInfo<Object?> {}

/// §40 D — the founder (M07): « Le propriétaire doit pouvoir voir tout ce qui
/// concerne les visites de ses agents, avec les rapports. » His visits page
/// listed only the visits he carried out himself.
void main() {
  final day = DateTime(2026, 8, 19, 10);
  const paul = VisitConductor(isAgent: true, agentId: 'ag-1', displayName: 'Paul Essomba');
  const me = VisitConductor(isAgent: false);

  Visit visit(String id, VisitConductor conductor, {VisitStatus status = VisitStatus.scheduled}) => Visit(
        id: id,
        status: status,
        annonceTitle: 'Studio Bonapriso',
        scheduledAt: day,
        conductor: conductor,
      );

  VisitsAgendaReady week(List<Visit> visits) => VisitsAgendaReady(
        weekStart: DateTime(2026, 8, 17),
        selectedDay: DateTime(2026, 8, 19),
        today: DateTime(2026, 8, 19),
        visits: visits,
      );

  late MockStackRouter router;

  setUpAll(() async {
    await loadBrandFonts();
    registerFallbackValue(_FakeRoute());
  });

  setUp(() {
    router = MockStackRouter();
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
  });

  Future<void> pump(WidgetTester tester, Widget child) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: StackRouterScope(controller: router, stateHash: 0, child: child),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('« Visites »', () {
    late MockPrestataireAgendaBloc mine;
    late MockAgentsVisitsAgendaBloc agents;
    late MockPrestataireVisitsBloc actions;

    setUp(() {
      mine = MockPrestataireAgendaBloc();
      agents = MockAgentsVisitsAgendaBloc();
      actions = MockPrestataireVisitsBloc();
      when(() => mine.state).thenReturn(week([visit('v-mine', me)]));
      when(() => agents.state).thenReturn(
        week([visit('v-agent', paul), visit('v-done', paul, status: VisitStatus.completed)]),
      );
      when(() => actions.state).thenReturn(const PrestataireVisitsIdle());
    });

    Widget page() => MultiBlocProvider(
          providers: [
            BlocProvider<PrestataireAgendaBloc>.value(value: mine),
            BlocProvider<AgentsVisitsAgendaBloc>.value(value: agents),
            BlocProvider<PrestataireVisitsBloc>.value(value: actions),
          ],
          child: const PrestataireVisitsPage(),
        );

    testWidgets('opens on his own; « Celles de mes agents » shows theirs, who carries each, and nothing to do',
        (tester) async {
      await pump(tester, page());
      expect(find.text('Mes visites'), findsOneWidget);
      expect(find.text('Confirmer ma présence'), findsOneWidget);

      await tester.tap(find.text('Celles de mes agents'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Menée par Paul Essomba'), findsNWidgets(2));
      // His agent confirms and cancels; nothing is offered here.
      expect(find.text('Confirmer ma présence'), findsNothing);
      await expectLater(find.byType(PrestataireVisitsPage), matchesGoldenFile('goldens/visits_agents.png'));
    });

    testWidgets('an agent\'s visit that is over: its report, read only', (tester) async {
      await pump(tester, page());
      await tester.tap(find.text('Celles de mes agents'));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Voir l'avis du locataire"));
      await tester.pumpAndSettle();

      verify(
        () => router.push<Object?>(
          VisitReviewRoute(id: 'v-done', propertyTitle: 'Studio Bonapriso', readOnly: true),
        ),
      ).called(1);
    });
  });

  testWidgets('one listing\'s visits: his and his agents\', each said', (tester) async {
    final listing = MockListingVisitsAgendaBloc();
    when(() => listing.state).thenReturn(week([visit('v-mine', me), visit('v-agent', paul)]));

    await pump(
      tester,
      BlocProvider<ListingVisitsAgendaBloc>.value(
        value: listing,
        child: const ListingVisitsPage(annonceId: 'a-1', annonceTitle: 'Studio Bonapriso'),
      ),
    );

    expect(find.text('Visites de ce bien'), findsOneWidget);
    expect(find.textContaining('Menée par toi'), findsOneWidget);
    expect(find.textContaining('Menée par Paul Essomba'), findsOneWidget);
  });

  testWidgets('his agent\'s visit sheet: who carries it out, why it fell through, and nothing to do',
      (tester) async {
    final detail = MockVisitDetailBloc();
    when(() => detail.state).thenReturn(
      VisitDetailReady(
        AgentVisitDetail(
          id: 'v-agent',
          status: VisitStatus.scheduled,
          annonceTitle: 'Studio Bonapriso',
          scheduledAt: day,
          userName: 'Awa Nkeng',
          readOnly: true,
          conductor: paul,
        ),
      ),
    );

    await pump(tester, BlocProvider<VisitDetailBloc>.value(value: detail, child: const VisitDetailPage(id: 'v-agent')));

    expect(find.text('Menée par'), findsOneWidget);
    // On the card that names him, and on his half of the presence.
    expect(find.text('Paul Essomba'), findsNWidgets(2));
    expect(find.text('Toi'), findsNothing);
    expect(find.text("C'est ton agent qui la mène"), findsOneWidget);
    expect(find.text('Confirmer ma présence'), findsNothing);
    expect(find.text('Annuler la visite'), findsNothing);
    await expectLater(find.byType(VisitDetailPage), matchesGoldenFile('goldens/visit_detail_agent.png'));
  });

  testWidgets('cancelled: the reason, on the sheet', (tester) async {
    final detail = MockVisitDetailBloc();
    when(() => detail.state).thenReturn(
      VisitDetailReady(
        AgentVisitDetail(
          id: 'v-agent',
          status: VisitStatus.cancelled,
          scheduledAt: day,
          readOnly: true,
          conductor: paul,
          cancellationReason: VisitCancellationReason.byVisitor,
        ),
      ),
    );

    await pump(tester, BlocProvider<VisitDetailBloc>.value(value: detail, child: const VisitDetailPage(id: 'v-agent')));

    expect(find.text('Annulée : Annulée par le visiteur'), findsOneWidget);
  });

  testWidgets('the report of his agent\'s visit: read, never answered — the visitor answers', (tester) async {
    final review = MockVisitReviewBloc();
    when(() => review.state).thenReturn(
      VisitReviewReady(
        visiteId: 'v-done',
        review: VisitReview(id: 'r-1', authorName: 'Awa Nkeng', rating: 4, publishedAt: DateTime(2026, 8, 20)),
      ),
    );

    await pump(
      tester,
      BlocProvider<VisitReviewBloc>.value(
        value: review,
        child: const VisitReviewPage(id: 'v-done', propertyTitle: 'Studio', readOnly: true),
      ),
    );

    expect(find.text('Awa Nkeng'), findsOneWidget);
    expect(find.text('Publier ma réponse'), findsNothing);
  });
}
