import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/visits/bloc/visit_review_bloc.dart';
import 'package:mboa_pro/features/visits/ui/visit_review_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockVisitReviewBloc extends MockBloc<VisitReviewEvent, VisitReviewState>
    implements VisitReviewBloc {}

/// The review screen both personas share (CDC M07bis).
void main() {
  late MockVisitReviewBloc bloc;

  final review = VisitReview(
    id: 'r-1',
    authorName: 'Awa Nkeng',
    rating: 4,
    perceivedCondition: 4,
    comment: 'Beau studio, très lumineux. Le quartier est bruyant le soir.',
    pros: const ['Lumineux', 'Proche du marché'],
    cons: const ['Bruit la nuit'],
    publishedAt: DateTime(2026, 8, 21),
    comments: [
      ReviewComment(
        authorName: 'Emmanuel NDJOKO',
        body: 'Merci pour votre retour, des double-vitrages sont prévus.',
        createdAt: DateTime(2026, 8, 22),
      ),
    ],
  );

  setUpAll(loadBrandFonts);

  setUp(() {
    bloc = MockVisitReviewBloc();
    when(() => bloc.state)
        .thenReturn(VisitReviewReady(visiteId: 'v-1', review: review));
  });

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
        home: BlocProvider<VisitReviewBloc>.value(
          value: bloc,
          child: const VisitReviewPage(id: 'v-1', propertyTitle: 'Studio'),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows the note and the words, which are the client\'s',
      (tester) async {
    await pump(tester);

    expect(find.text('Awa Nkeng'), findsOneWidget);
    expect(find.text('4/5'), findsOneWidget);
    expect(find.textContaining('Beau studio'), findsOneWidget);
    expect(find.text('Lumineux'), findsOneWidget);
    expect(find.text('Bruit la nuit'), findsOneWidget);
  });

  testWidgets('RM-M07bis-04 — replies are additions, and the screen says so',
      (tester) async {
    await pump(tester);

    expect(find.textContaining('Merci pour votre retour'), findsOneWidget);
    expect(
      find.textContaining('ne modifie ni la note ni le texte'),
      findsOneWidget,
    );
  });

  testWidgets('a reply goes through the bloc', (tester) async {
    await pump(tester);

    await tester.enterText(find.byType(TextField), 'Bien noté, merci.');
    await tester.tap(find.text('Publier ma réponse'));
    await tester.pump();

    verify(() => bloc.add(const VisitReviewCommented('Bien noté, merci.')))
        .called(1);
  });

  testWidgets('RM-M07bis-06 — the export names the property, not the id',
      (tester) async {
    await pump(tester);

    await tester.tap(find.byTooltip('Exporter en PDF'));
    await tester.pump();

    verify(
      () => bloc.add(
        const VisitReviewPdfRequested(fileName: 'Avis de visite - Studio'),
      ),
    ).called(1);
  });

  testWidgets('RM-M07bis-02 — no review yet says whose move it is',
      (tester) async {
    when(() => bloc.state).thenReturn(const VisitReviewReady(visiteId: 'v-1'));
    await pump(tester);

    expect(find.text('Aucun avis pour le moment'), findsOneWidget);
    // Nothing to export, and nothing to answer.
    expect(find.byTooltip('Exporter en PDF'), findsNothing);
    expect(find.text('Publier ma réponse'), findsNothing);
  });

  testWidgets('RM-M07bis-08 — a deleted author still leaves their review',
      (tester) async {
    when(() => bloc.state).thenReturn(
      VisitReviewReady(
        visiteId: 'v-1',
        review: VisitReview(id: 'r-1', rating: 3, publishedAt: DateTime(2026, 8, 1)),
      ),
    );
    await pump(tester);

    expect(find.text('Utilisateur supprimé'), findsOneWidget);
    expect(find.text('3/5'), findsOneWidget);
  });

  testWidgets('the review screen', (tester) async {
    await pump(tester);

    await expectLater(
      find.byType(VisitReviewPage),
      matchesGoldenFile('goldens/visit_review.png'),
    );
  });
}
