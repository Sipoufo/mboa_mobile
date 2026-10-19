import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockResidentReviewBloc
    extends MockBloc<ResidentReviewEvent, ResidentReviewState>
    implements ResidentReviewBloc {}

class MockContractDetailBloc
    extends MockBloc<ContractDetailEvent, ContractDetailState>
    implements ContractDetailBloc {}

/// The resident review screen, and the one thing that decides it is reachable
/// at all (CDC M27).
void main() {
  late MockResidentReviewBloc bloc;

  ReviewEntry review() => ReviewEntry(
        id: 'r-1',
        kind: ReviewKind.resident,
        rating: 4,
        comment: 'Quartier calme.',
        residenceMonths: 12,
        publishedAt: DateTime(2026, 3, 2),
      );

  setUp(() => bloc = MockResidentReviewBloc());

  Future<void> pump(WidgetTester tester, Widget child) async {
    tester.view.physicalSize = const Size(390 * 3, 1600 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: child,
      ),
    );
    await tester.pumpAndSettle();
  }

  Widget view() => BlocProvider<ResidentReviewBloc>.value(
        value: bloc,
        child: const ResidentReviewView(contractId: 'c-1'),
      );

  group('the form', () {
    testWidgets('RM-M27 — without a rating there is nothing to publish',
        (tester) async {
      when(() => bloc.state).thenReturn(const ResidentReviewEditing());
      await pump(tester, view());

      final publish = tester.widget<Button>(
        find.widgetWithText(Button, 'Publier mon avis'),
      );
      expect(publish.onPressed, isNull);
    });

    testWidgets('a rating is all it takes — the rest is optional',
        (tester) async {
      when(() => bloc.state)
          .thenReturn(const ResidentReviewEditing(rating: 4));
      await pump(tester, view());

      final publish = tester.widget<Button>(
        find.widgetWithText(Button, 'Publier mon avis'),
      );
      expect(publish.onPressed, isNotNull);
    });

    testWidgets(
      'RM-M27-02 — a correction says so, and says the window exists',
      (tester) async {
        when(() => bloc.state).thenReturn(
          const ResidentReviewEditing(
            rating: 4,
            comment: 'Quartier calme.',
            isRevision: true,
          ),
        );
        await pump(tester, view());

        // The verb differs from a first publication, because what happens is
        // different — and because a visit report cannot be corrected at all
        // (RM-M07bis-03), a tenant needs telling that this one can.
        expect(find.text('Enregistrer mes corrections'), findsOneWidget);
        expect(find.text('Publier mon avis'), findsNothing);
        expect(find.textContaining('30 jours après ton départ'), findsOneWidget);
      },
    );
  });

  group('the window closing', () {
    testWidgets('RM-M27-02 — a locked review is shown, not an error',
        (tester) async {
      when(() => bloc.state).thenReturn(ResidentReviewLocked(review()));
      await pump(tester, view());

      expect(find.text('Avis verrouillé'), findsOneWidget);
      // It is still published and still theirs — the words are on screen.
      expect(find.text('Quartier calme.'), findsOneWidget);
      // And there is nothing to submit, so no button pretends otherwise.
      expect(find.widgetWithText(Button, 'Publier mon avis'), findsNothing);
      expect(
        find.widgetWithText(Button, 'Enregistrer mes corrections'),
        findsNothing,
      );
    });
  });

  group('getting there at all', () {
    late MockContractDetailBloc detail;

    Contract contract({bool eligible = false}) => Contract(
          id: 'c-1',
          status: ContractStatus.signed,
          annonceTitle: 'Studio Bonapriso',
          prestataire: const ContractParticipant(displayName: 'Agence Deido'),
          tenant: const ContractParticipant(displayName: 'Awa Nkeng'),
          price: 110000,
          awaiting: ContractParty.nobody,
          residentReviewEligible: eligible,
        );

    setUp(() => detail = MockContractDetailBloc());

    Future<void> pumpContract(WidgetTester tester, {required bool eligible}) async {
      when(() => detail.state)
          .thenReturn(ContractDetailReady(contract(eligible: eligible)));
      await pump(
        tester,
        BlocProvider<ContractDetailBloc>.value(
          value: detail,
          child: ContractDetailView(
            id: 'c-1',
            viewer: ContractParty.tenant,
            onReview: (_) {},
          ),
        ),
      );
    }

    testWidgets('CA-M27-02 — the server says who may review, and nobody else',
        (tester) async {
      await pumpContract(tester, eligible: false);
      expect(find.text('Laisser mon avis'), findsNothing);
    });

    testWidgets('and offers it the moment it says so', (tester) async {
      await pumpContract(tester, eligible: true);
      // Behind "⋯": a signed contract's bar keeps the PDF as its one button.
      await tester.tap(find.byTooltip("Plus d'actions"));
      await tester.pumpAndSettle();
      expect(find.text('Laisser mon avis'), findsOneWidget);
    });
  });
}
