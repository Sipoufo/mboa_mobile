import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/visits/bloc/prestataire_visits_bloc.dart';
import 'package:mboa_pro/features/visits/bloc/visits_agenda_blocs.dart';
import 'package:mboa_pro/features/visits/ui/prestataire_visits_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockPrestataireAgendaBloc extends MockBloc<VisitsAgendaEvent, VisitsAgendaState>
    implements PrestataireAgendaBloc {}

class MockPrestataireVisitsBloc extends MockBloc<PrestataireVisitsEvent, PrestataireVisitsState>
    implements PrestataireVisitsBloc {}

/// The visits a prestataire carries out himself (RM-M11-10 / RM-M15-06).
///
/// Two blocs on one screen, on purpose: the agenda is shared with the agent,
/// the actions are not — he answers proposed times, the agent never does. Both
/// are provided by this route itself, so the screen is pumped with exactly
/// those two and nothing else.
void main() {
  late MockPrestataireAgendaBloc agenda;
  late MockPrestataireVisitsBloc actions;

  final today = DateTime(2026, 8, 19, 10);

  Visit visit({
    String id = 'v-1',
    VisitStatus status = VisitStatus.scheduled,
    DateTime? confirmedAt,
  }) => Visit(
    id: id,
    status: status,
    annonceTitle: 'Studio Bonapriso',
    scheduledAt: today,
    visitorKind: VisitorKind.owner,
    visitorConfirmedAt: confirmedAt,
  );

  void agendaWith(List<Visit> visits) => when(() => agenda.state).thenReturn(
    VisitsAgendaReady(
      weekStart: DateTime(2026, 8, 17),
      selectedDay: DateTime(2026, 8, 19),
      today: DateTime(2026, 8, 19),
      visits: visits,
    ),
  );

  setUp(() {
    agenda = MockPrestataireAgendaBloc();
    actions = MockPrestataireVisitsBloc();
    when(() => actions.state).thenReturn(const PrestataireVisitsIdle());
    agendaWith([visit()]);
  });

  Future<void> pump(WidgetTester tester) => tester.pumpWidget(
    MaterialApp(
      locale: const Locale('fr'),
      theme: MboaTheme.light(),
      localizationsDelegates: MboaLocalizations.delegates,
      supportedLocales: MboaLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<PrestataireAgendaBloc>.value(value: agenda),
          BlocProvider<PrestataireVisitsBloc>.value(value: actions),
        ],
        child: const PrestataireVisitsPage(),
      ),
    ),
  );

  testWidgets('shows the day he is expected somewhere', (tester) async {
    await pump(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('Studio Bonapriso'), findsOneWidget);
    expect(find.text('Confirmer ma présence'), findsOneWidget);
  });

  testWidgets('RM-M15-06 — a proposed time is answered, not just displayed', (tester) async {
    agendaWith([visit(id: 'ask', status: VisitStatus.requested)]);
    await pump(tester);

    expect(find.text('Demandes à confirmer'), findsOneWidget);

    await tester.tap(find.text('Confirmer le créneau'));
    await tester.pump();

    verify(() => actions.add(const VisitRequestConfirmed('ask'))).called(1);
  });

  testWidgets('a request is not offered a presence button as well', (tester) async {
    agendaWith([visit(id: 'ask', status: VisitStatus.requested)]);
    await pump(tester);

    // Nobody is at a property whose time has not been agreed.
    expect(find.text('Confirmer ma présence'), findsNothing);
  });

  testWidgets('once he has confirmed, the row waits on the client', (tester) async {
    agendaWith([visit(confirmedAt: today)]);
    await pump(tester);

    // RM-M07-05 — he cannot supply the client's half, so asking again would
    // promise something he cannot do.
    expect(find.text('Confirmer ma présence'), findsNothing);
    expect(find.text('Présence confirmée'), findsOneWidget);
  });

  testWidgets('confirming his presence takes a position through the bloc', (tester) async {
    await pump(tester);

    await tester.tap(find.text('Confirmer ma présence'));
    await tester.pump();

    verify(() => actions.add(const OwnerPresenceConfirmed('v-1'))).called(1);
  });

  testWidgets('an answered action reloads the week rather than patching it', (tester) async {
    whenListen(
      actions,
      Stream.fromIterable(const [PrestataireVisitsDone()]),
      initialState: const PrestataireVisitsIdle(),
    );
    await pump(tester);
    await tester.pump();

    verify(() => agenda.add(const AgendaRefreshed())).called(1);
  });
}
