import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/visits/bloc/visit_detail_bloc.dart';
import 'package:mboa_pro/features/visits/models/agent_visit.dart';
import 'package:mboa_pro/features/visits/ui/visit_detail_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockVisitDetailBloc extends MockBloc<VisitDetailEvent, VisitDetailState> implements VisitDetailBloc {}

/// The visit detail, on the day (CDC M16).
///
/// Two states worth pinning: the visit the agent is about to confirm, and the
/// one where he has and the client has not — the second is the one that used to
/// be a sentence under a button.
void main() {
  late MockVisitDetailBloc bloc;

  final at = DateTime(2026, 8, 21, 14, 30);

  AgentVisitDetail visit({bool confirmed = false}) => AgentVisitDetail(
    id: 'v-1',
    status: VisitStatus.scheduled,
    annonceTitle: 'Studio meublé — Bonapriso',
    exactAddress: 'Rue 1.234, Bonapriso, Douala',
    scheduledAt: at,
    userName: 'Awa Nkeng',
    userPhone: '+237 690 00 00 00',
    prestataireName: 'Agence Deido',
    prestatairePhone: '+237 691 11 11 11',
    canConfirm: !confirmed,
    visitorConfirmedAt: confirmed ? at.add(const Duration(minutes: 3)) : null,
  );

  setUpAll(loadBrandFonts);

  setUp(() => bloc = MockVisitDetailBloc());

  Future<void> pump(WidgetTester tester) async {
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
        home: BlocProvider<VisitDetailBloc>.value(
          value: bloc,
          child: const VisitDetailPage(id: 'v-1'),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the visit he is about to confirm', (tester) async {
    when(() => bloc.state).thenReturn(VisitDetailReady(visit()));
    await pump(tester);

    await expectLater(
      find.byType(VisitDetailPage),
      matchesGoldenFile('goldens/visit_detail.png'),
    );
  });

  testWidgets('his half is in, the client is still owed', (tester) async {
    when(() => bloc.state).thenReturn(VisitDetailReady(visit(confirmed: true)));
    await pump(tester);

    await expectLater(
      find.byType(VisitDetailPage),
      matchesGoldenFile('goldens/visit_detail_awaiting_client.png'),
    );
  });
}
