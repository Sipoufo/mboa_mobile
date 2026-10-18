import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import 'load_brand_fonts.dart';

class MockMboaScoreBloc extends MockBloc<MboaScoreEvent, MboaScoreState> implements MboaScoreBloc {}

/// The Mboa Score screen (CDC M09) — the tenant's own page (RM-M09-03) and
/// the prestataire's sheet (RM-M09-04), read from a mocked bloc.
void main() {
  late MockMboaScoreBloc bloc;

  /// The server held the score at 30 while its lines add up to 45
  /// (10 + 20 + 0 + 30 + 0 − 15): the view must show 30, never re-add.
  const score = MboaScore(
    score: 30,
    signals: [
      MboaScoreSignal(kind: ScoreSignalKind.profileComplete, points: 10, maxPoints: 10),
      MboaScoreSignal(kind: ScoreSignalKind.identityVerified, points: 20, maxPoints: 20),
      MboaScoreSignal(kind: ScoreSignalKind.accountSeniority, points: 0, maxPoints: 10),
      MboaScoreSignal(kind: ScoreSignalKind.signedContracts, points: 30, maxPoints: 30, count: 3),
      MboaScoreSignal(kind: ScoreSignalKind.providerRating, points: 0, maxPoints: 20, available: false),
      MboaScoreSignal(kind: ScoreSignalKind.validatedReports, points: -15, maxPoints: 0, count: 1),
    ],
  );

  setUpAll(loadBrandFonts);

  setUp(() => bloc = MockMboaScoreBloc());

  /// The own score as a page; the tenant's as the sheet draws it — a white,
  /// top-rounded surface that scrolls, over a dimmed scrim.
  Widget host({required bool isOwn}) => Builder(
    builder: (context) => isOwn
        ? Scaffold(
            backgroundColor: context.mboaColors.background,
            body: const SafeArea(child: MboaScoreContent(isOwn: true)),
          )
        // showModalBottomSheet gives its content a Material; without one the
        // text would draw with the debug yellow underline.
        : Material(
            color: Colors.black54,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
                ),
                child: const SingleChildScrollView(
                  padding: EdgeInsets.all(Dimens.screenMargin),
                  child: MboaScoreContent(isOwn: false),
                ),
              ),
            ),
          ),
  );

  Future<void> pump(
    WidgetTester tester,
    MboaScoreState state, {
    required bool isOwn,
    Size size = const Size(390, 844),
    Locale locale = const Locale('fr'),
    double textScale = 1,
    bool settle = true,
  }) async {
    tester.view.physicalSize = size * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    when(() => bloc.state).thenReturn(state);
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: locale,
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
          child: child!,
        ),
        home: BlocProvider<MboaScoreBloc>.value(
          value: bloc,
          child: host(isOwn: isOwn),
        ),
      ),
    );
    // The ring animates its arc for 600 ms on entrance; the loader spins forever.
    settle ? await tester.pumpAndSettle() : await tester.pump();
  }

  group('own score (RM-M09-03)', () {
    testWidgets("shows the server's score, not the sum of its lines", (tester) async {
      await pump(tester, const MboaScoreReady(score), isOwn: true);

      final ring = find.byType(MboaScoreRing);
      expect(find.descendant(of: ring, matching: find.text('30')), findsOneWidget);
      expect(find.descendant(of: ring, matching: find.text('sur 90')), findsOneWidget);
      expect(find.text('45'), findsNothing);
    });

    testWidgets('lists every line, the penalty with a true minus sign', (tester) async {
      await pump(tester, const MboaScoreReady(score), isOwn: true);

      expect(find.text('Ce qui compte dans ton score'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('Signalements retenus'), 200);
      expect(find.text('−15', findRichText: true), findsOneWidget);
      expect(find.text('-15', findRichText: true), findsNothing);
      expect(find.text('1 signalement retenu'), findsOneWidget);
      expect(find.text('Bientôt'), findsOneWidget);
    });

    testWidgets('coaches each line with a hint', (tester) async {
      await pump(tester, const MboaScoreReady(score), isOwn: true);

      await tester.scrollUntilVisible(find.text('Celui-là vient tout seul, avec le temps.'), 200);
      expect(find.text('Celui-là vient tout seul, avec le temps.'), findsOneWidget);
      expect(find.text('Les propriétaires pourront bientôt te noter.'), findsOneWidget);
    });
  });

  group("a tenant's score, for a prestataire (RM-M09-04)", () {
    testWidgets('speaks in the third person, without coaching', (tester) async {
      await pump(tester, const MboaScoreReady(score), isOwn: false);

      expect(find.textContaining('La fiabilité de ce locataire'), findsOneWidget);
      expect(find.descendant(of: find.byType(MboaScoreRing), matching: find.text('30')), findsOneWidget);
      expect(find.text('Celui-là vient tout seul, avec le temps.'), findsNothing);
      expect(find.text('Complète ton profil pour booster ton Mboa Score.'), findsNothing);
      expect(find.text('Une aide à la décision, pas un verdict.'), findsOneWidget);
      expect(find.text('Bientôt'), findsOneWidget);
    });
  });

  group('states', () {
    testWidgets('a failure offers a retry, which asks the bloc again', (tester) async {
      await pump(tester, const MboaScoreFailure(), isOwn: true);

      expect(find.text("Le score n'a pas pu se charger"), findsOneWidget);
      await tester.tap(find.text('Réessayer'));

      verify(() => bloc.add(const MboaScoreRequested())).called(1);
    });

    testWidgets('not contacted yet: a refusal, not an error — no retry', (tester) async {
      await pump(tester, const MboaScoreUnavailable(ScoreRefusal.notContacted), isOwn: false);

      expect(find.text('Pas encore visible'), findsOneWidget);
      expect(find.text('Réessayer'), findsNothing);
      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('no score for this account — no retry', (tester) async {
      await pump(tester, const MboaScoreUnavailable(ScoreRefusal.noScore), isOwn: false);

      expect(find.text('Pas de score pour ce compte'), findsOneWidget);
      expect(find.text('Réessayer'), findsNothing);
    });

    testWidgets('loading shows the loader', (tester) async {
      await pump(tester, const MboaScoreLoading(), isOwn: false, settle: false);

      expect(find.byType(Loader), findsOneWidget);
    });
  });

  group('semantics', () {
    testWidgets('the ring reads as a sentence', (tester) async {
      final handle = tester.ensureSemantics();
      await pump(tester, const MboaScoreReady(score), isOwn: true);

      expect(find.bySemanticsLabel('Mboa Score : 30 sur 90'), findsOneWidget);
      handle.dispose();
    });

    testWidgets('the penalty is spoken as "moins", not a dash', (tester) async {
      final handle = tester.ensureSemantics();
      await pump(tester, const MboaScoreReady(score), isOwn: false);

      expect(find.bySemanticsLabel(RegExp('^Signalements retenus, .*moins 15 points')), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('Note des propriétaires, bientôt disponible')), findsOneWidget);
      handle.dispose();
    });
  });

  group('no overflow', () {
    for (final isOwn in [true, false]) {
      for (final locale in const [Locale('fr'), Locale('en')]) {
        final who = isOwn ? 'own' : 'tenant';

        testWidgets('$who, ${locale.languageCode}, 320×640 at text ×2', (tester) async {
          await pump(
            tester,
            const MboaScoreReady(score),
            isOwn: isOwn,
            size: const Size(320, 640),
            locale: locale,
            textScale: 2,
          );
          expect(tester.takeException(), isNull);

          // The own page is a lazy list: scroll it to the end so every line
          // is laid out at least once.
          if (isOwn) {
            final penalty = find.byWidgetPredicate((w) => w is SignalRow && w.signal.isPenalty);
            await tester.scrollUntilVisible(penalty, 200);
            for (var i = 0; i < 10; i++) {
              await tester.drag(find.byType(ListView), const Offset(0, -200));
              await tester.pump();
              expect(tester.takeException(), isNull);
            }
            expect(penalty, findsOneWidget);
          }
        });

        testWidgets('$who, ${locale.languageCode}, 390 wide at text ×1', (tester) async {
          await pump(tester, const MboaScoreReady(score), isOwn: isOwn, locale: locale);
          expect(tester.takeException(), isNull);
        });
      }
    }

    testWidgets('refusal panels at 320×640, text ×2', (tester) async {
      for (final state in const [
        MboaScoreFailure(),
        MboaScoreUnavailable(ScoreRefusal.notContacted),
        MboaScoreUnavailable(ScoreRefusal.noScore),
      ]) {
        await pump(tester, state, isOwn: false, size: const Size(320, 640), textScale: 2);
        expect(tester.takeException(), isNull, reason: '$state');
      }
    });
  });

  group('goldens', () {
    testWidgets('own score, 390×844', (tester) async {
      await pump(tester, const MboaScoreReady(score), isOwn: true);

      await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/score_own.png'));
    });

    testWidgets("a tenant's score, in its sheet, 390×844", (tester) async {
      await pump(tester, const MboaScoreReady(score), isOwn: false);

      await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/score_tenant.png'));
    });
  });
}
