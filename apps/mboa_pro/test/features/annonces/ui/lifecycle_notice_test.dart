import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/annonces/bloc/annonces_bloc.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/ui/widgets/lifecycle_notice.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockAnnoncesBloc extends MockBloc<AnnoncesEvent, AnnoncesState>
    implements AnnoncesBloc {}

/// RM-M10-04 — the notice says what happened, and offers the way back.
void main() {
  late MockAnnoncesBloc bloc;

  setUp(() {
    bloc = MockAnnoncesBloc();
    when(() => bloc.state).thenReturn(const AnnoncesInitial());
  });

  Future<void> pump(WidgetTester tester, Annonce annonce) async {
    final notice = LifecycleNotice.of(annonce)!;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<AnnoncesBloc>.value(
          value: bloc,
          child: Scaffold(
            body: LifecycleNoticeCard(notice: notice, annonceId: annonce.id),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Annonce archived(ArchivedReason reason) => Annonce(
        id: 'a-1',
        title: 'Studio Akwa',
        status: AnnonceStatus.archived,
        propertyType: PropertyType.studio,
        archivedReason: reason,
      );

  testWidgets('an expired listing is unarchived from the notice', (tester) async {
    await pump(tester, archived(ArchivedReason.expired));

    expect(find.text('Expirée après 30 jours'), findsOneWidget);
    await tester.tap(find.text('Désarchiver'));

    verify(
      () => bloc.add(const AnnonceStatusChangeRequested('a-1', AnnonceTransition.unarchive)),
    ).called(1);
  });

  testWidgets('a plan-limit archive points to the plans, not to unarchiving',
      (tester) async {
    await pump(tester, archived(ArchivedReason.planLimit));

    expect(find.text('Archivée : limite de la formule gratuite'), findsOneWidget);
    expect(find.text('Voir les formules'), findsOneWidget);
    expect(find.text('Désarchiver'), findsNothing);
  });

  testWidgets('far from its deadline, a live listing just says when', (tester) async {
    await pump(
      tester,
      Annonce(
        id: 'a-1',
        title: 'Studio Akwa',
        status: AnnonceStatus.published,
        propertyType: PropertyType.studio,
        expiresAt: DateTime.now().add(const Duration(days: 20)),
      ),
    );

    expect(find.textContaining('Expire dans'), findsOneWidget);
    expect(find.text('Voir les formules'), findsNothing);
  });
}
