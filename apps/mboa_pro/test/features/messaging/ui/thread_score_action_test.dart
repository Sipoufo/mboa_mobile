import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/messaging/ui/messages_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockThreadBloc extends MockBloc<ThreadEvent, ThreadState> implements ThreadBloc {}

class MockMboaScoreRepository extends Mock implements MboaScoreRepository {}

/// RM-M09-04 — a thread is the contact that opens a tenant's score, for a
/// prestataire only: the score route is PRESTATAIRE-only, agents get none.
void main() {
  late MockThreadBloc thread;

  const conversation = Conversation(id: 'c-1', peerAccountId: 'u-1', peerName: 'Awa Nkeng');

  setUp(() {
    thread = MockThreadBloc();
    when(() => thread.state).thenReturn(const ThreadLoadInProgress());
    getIt
      ..registerLazySingleton<SessionSnapshot>(SessionSnapshot.new)
      ..registerLazySingleton<MediaUploader>(MockMediaUploader.new);
  });

  tearDown(getIt.reset);

  Future<void> pump(WidgetTester tester, Conversation conversation) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<ThreadBloc>.value(
          value: thread,
          child: ThreadPage(conversation: conversation),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('a prestataire can open the tenant\'s score', (tester) async {
    getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);
    await pump(tester, conversation);

    expect(find.byTooltip('Voir son Mboa Score'), findsOneWidget);
  });

  testWidgets('the action opens that tenant\'s score in a sheet', (tester) async {
    final scores = MockMboaScoreRepository();
    when(() => scores.tenant('u-1')).thenAnswer((_) async => const MboaScore(score: 30));
    // The app's own registration, so the sheet is built the way it ships.
    getIt.registerFactoryParam<MboaScoreBloc, ScoreSource, void>(
      (source, _) => MboaScoreBloc(repository: scores, source: source),
    );
    getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);
    await pump(tester, conversation);

    await tester.tap(find.byTooltip('Voir son Mboa Score'));
    // The thread behind keeps its loader spinning, so time is stepped rather
    // than settled: the sheet's slide, the read, the ring's 600 ms.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 700));

    verify(() => scores.tenant('u-1')).called(1);
    expect(find.text('Awa Nkeng'), findsWidgets);
    expect(find.bySemanticsLabel('Mboa Score : 30 sur 90'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('an agent cannot — the score is not theirs to read', (tester) async {
    getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.agent);
    await pump(tester, conversation);

    expect(find.byTooltip('Voir son Mboa Score'), findsNothing);
  });

  testWidgets('without the other party\'s account, there is nothing to ask with', (tester) async {
    getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);
    await pump(tester, const Conversation(id: 'c-1', peerName: 'Awa Nkeng'));

    expect(find.byTooltip('Voir son Mboa Score'), findsNothing);
  });
}
