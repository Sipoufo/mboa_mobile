import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockResidentReplyBloc
    extends MockBloc<ResidentReplyEvent, ResidentReplyState>
    implements ResidentReplyBloc {}

class MockContractDetailBloc
    extends MockBloc<ContractDetailEvent, ContractDetailState>
    implements ContractDetailBloc {}

/// The landlord's side of a resident review (CDC M27, RM-M27-03).
void main() {
  late MockResidentReplyBloc bloc;

  ReviewEntry review({List<ReviewReply> replies = const []}) => ReviewEntry(
        id: 'r-1',
        kind: ReviewKind.resident,
        rating: 2,
        comment: 'Coupures d’eau fréquentes.',
        cons: const ['Eau'],
        residenceMonths: 12,
        residenceDuration: 12,
        residencePeriod: RentalPeriod.month,
        publishedAt: DateTime(2026, 3, 2),
        replies: replies,
      );

  setUp(() => bloc = MockResidentReplyBloc());

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

  Widget view() => BlocProvider<ResidentReplyBloc>.value(
        value: bloc,
        child: const ResidentReplyView(contractId: 'c-1'),
      );

  testWidgets('RM-M27-02 — no review yet reads as waiting, not as nothing',
      (tester) async {
    when(() => bloc.state).thenReturn(const ResidentReplyReady());
    await pump(tester, view());

    expect(find.text('Aucun avis pour le moment'), findsOneWidget);
    expect(find.textContaining('pendant tout le bail'), findsOneWidget);
    // Nothing to answer, so no field pretending otherwise.
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('the review is shown whole before anything can be answered',
      (tester) async {
    when(() => bloc.state).thenReturn(ResidentReplyReady(review: review()));
    await pump(tester, view());

    expect(find.text('Coupures d’eau fréquentes.'), findsOneWidget);
    expect(find.widgetWithText(Chip, 'Eau'), findsOneWidget);
    expect(find.text('12 mois sur place'), findsOneWidget);
  });

  testWidgets('RM-M27-03 — the rule is stated before the field, not after',
      (tester) async {
    when(() => bloc.state).thenReturn(ResidentReplyReady(review: review()));
    await pump(tester, view());

    // A landlord about to answer a 2-star review should know, before he
    // starts typing, that it will not change the 2 stars.
    expect(
      find.textContaining('ne modifie ni la note ni le texte'),
      findsOneWidget,
    );
  });

  testWidgets('an empty answer cannot be spent', (tester) async {
    when(() => bloc.state).thenReturn(ResidentReplyReady(review: review()));
    await pump(tester, view());

    final send = tester.widget<Button>(
      find.widgetWithText(Button, 'Publier ma réponse'),
    );
    expect(send.onPressed, isNull);
  });

  testWidgets('RM-M27-03 — once answered, there is no second composer',
      (tester) async {
    when(() => bloc.state).thenReturn(
      ResidentReplyReady(
        review: review(
          replies: const [
            ReviewReply(authorName: 'Agence Deido', body: 'Le forage est réparé.'),
          ],
        ),
      ),
    );
    await pump(tester, view());

    expect(find.text('Le forage est réparé.'), findsOneWidget);
    expect(find.text('Tu as déjà répondu à cet avis.'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
  });

  group('getting there', () {
    late MockContractDetailBloc detail;

    Contract contract({required ContractStatus status}) => Contract(
          id: 'c-1',
          status: status,
          annonceTitle: 'Studio Bonapriso',
          prestataire: const ContractParticipant(displayName: 'Agence Deido'),
          tenant: const ContractParticipant(displayName: 'Awa Nkeng'),
          price: 110000,
          awaiting: ContractParty.nobody,
        );

    setUp(() => detail = MockContractDetailBloc());

    Future<void> pumpContract(WidgetTester tester, ContractStatus status) async {
      when(() => detail.state)
          .thenReturn(ContractDetailReady(contract(status: status)));
      await pump(
        tester,
        BlocProvider<ContractDetailBloc>.value(
          value: detail,
          child: ContractDetailView(
            id: 'c-1',
            viewer: ContractParty.prestataire,
            onReview: (_) {},
            onAmend: (_) {},
          ),
        ),
      );
    }

    testWidgets('a signed contract may carry a review, so the door is there',
        (tester) async {
      await pumpContract(tester, ContractStatus.signed);
      expect(find.text("Voir l'avis du locataire"), findsOneWidget);
      // The landlord never writes one — RM-M27-01 is the tenant's.
      expect(find.text('Laisser mon avis'), findsNothing);
    });

    testWidgets('a contract still being negotiated cannot have one yet',
        (tester) async {
      await pumpContract(tester, ContractStatus.sent);
      expect(find.text("Voir l'avis du locataire"), findsNothing);
    });
  });
}
