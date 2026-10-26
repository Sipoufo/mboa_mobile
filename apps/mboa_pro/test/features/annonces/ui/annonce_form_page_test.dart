import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/annonces/bloc/annonce_form_bloc.dart';
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart';
import 'package:mboa_pro/features/annonces/ui/annonce_form_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockAnnonceFormBloc extends MockBloc<AnnonceFormEvent, AnnonceFormState> implements AnnonceFormBloc {}

const location = ListingLocation(
  districtId: 'd-1',
  districtName: 'Deido',
  latitude: 4.05,
  longitude: 9.7,
  cityName: 'Douala',
);

/// « Ajouter un bien », step by step (CDC M10 / M10bis).
void main() {
  late MockAnnonceFormBloc bloc;

  setUpAll(() async {
    registerFallbackValue(const AnnonceFormSubmitted());
    await loadBrandFonts();
  });
  setUp(() => bloc = MockAnnonceFormBloc());

  Future<void> form(WidgetTester tester, AnnonceFormEditing state, {AnnonceKind kind = AnnonceKind.single}) async {
    when(() => bloc.state).thenReturn(state);
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
        home: BlocProvider<AnnonceFormBloc>.value(
          value: bloc,
          child: AnnonceFormPage(kind: kind, annonceId: state.draft.id),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> golden(String name) =>
      expectLater(find.byType(AnnonceFormPage), matchesGoldenFile('goldens/$name.png'));

  testWidgets('1 — what it is: the two kinds as cards, its name, its type; « Continuer » once named', (tester) async {
    await form(tester, const AnnonceFormEditing(AnnonceDraft(kind: AnnonceKind.single, title: 'Studio Akwa')));

    expect(find.text('Étape 1 sur 5'), findsOneWidget);
    expect(find.text('Quel est ce bien ?'), findsOneWidget);
    expect(find.text('Bien unique'), findsOneWidget);
    await golden('annonce_form_basics');

    // A new kind is a new form; the name typed so far follows.
    await tester.tap(find.text('Bien multiple'));
    verify(
      () => bloc.add(
        const AnnonceFormStarted(
          kind: AnnonceKind.residence,
          draft: AnnonceDraft(kind: AnnonceKind.residence, title: 'Studio Akwa'),
        ),
      ),
    ).called(1);
    await tester.tap(find.text('Continuer'));
    verify(() => bloc.add(const AnnonceFormStepRequested(AnnonceFormStep.place))).called(1);
  });

  testWidgets('1 — not named yet: « Continuer » waits', (tester) async {
    await form(tester, const AnnonceFormEditing(AnnonceDraft(kind: AnnonceKind.single)));

    await tester.tap(find.text('Continuer'));
    verifyNever(() => bloc.add(any()));
  });

  testWidgets('2 — where: back is the step before, not out of the form', (tester) async {
    await form(
      tester,
      const AnnonceFormEditing(
        AnnonceDraft(kind: AnnonceKind.single, title: 'Studio Akwa', location: location),
        step: AnnonceFormStep.place,
      ),
    );

    expect(find.text('Où se trouve-t-il ?'), findsOneWidget);
    await golden('annonce_form_place');
    await tester.tap(find.byIcon(LucideIcons.arrowLeft));
    verify(() => bloc.add(const AnnonceFormStepRequested(AnnonceFormStep.basics))).called(1);
  });

  testWidgets('3 — what is inside, all optional', (tester) async {
    await form(
      tester,
      const AnnonceFormEditing(
        AnnonceDraft(
          kind: AnnonceKind.single,
          title: 'Studio Akwa',
          location: location,
          surfaceArea: 30,
          roomCount: 2,
          bathroomCount: 1,
          furnished: true,
          amenities: [Amenity.wifi, Amenity.parking],
        ),
        step: AnnonceFormStep.details,
      ),
    );

    expect(find.text('Étape 3 sur 5'), findsOneWidget);
    expect(find.text('Comment est le logement ?'), findsOneWidget);
    await golden('annonce_form_details');
  });

  testWidgets('4 — the rent, its period, the charges, from when', (tester) async {
    await form(
      tester,
      AnnonceFormEditing(
        const AnnonceDraft(kind: AnnonceKind.single, title: 'Studio Akwa', location: location, price: 85000)
            .copyWith(availableFrom: DateTime(2026, 11, 1)),
        step: AnnonceFormStep.rent,
      ),
    );

    expect(find.text('Combien, et à partir de quand ?'), findsOneWidget);
    await golden('annonce_form_rent');
  });

  testWidgets('5 — the photos and the words; the last step saves', (tester) async {
    await form(
      tester,
      AnnonceFormEditing(
        const AnnonceDraft(kind: AnnonceKind.single, title: 'Studio Akwa', location: location, price: 85000)
            .copyWith(availableFrom: DateTime(2026, 11, 1)),
        step: AnnonceFormStep.media,
      ),
    );

    expect(find.text('Étape 5 sur 5'), findsOneWidget);
    expect(find.text('Continuer'), findsNothing);
    await golden('annonce_form_media');
    await tester.tap(find.text('Enregistrer'));
    verify(() => bloc.add(const AnnonceFormSubmitted())).called(1);
  });

  testWidgets('a residence: four steps — its units, their rents and when they are free, on the third', (tester) async {
    await form(
      tester,
      const AnnonceFormEditing(
        AnnonceDraft(
          kind: AnnonceKind.residence,
          title: 'Résidence Deido',
          location: location,
          units: [UnitGroupDraft(count: 6, namePrefix: 'Chambre', price: 45000)],
        ),
        step: AnnonceFormStep.details,
      ),
      kind: AnnonceKind.residence,
    );

    expect(find.text('Étape 3 sur 4'), findsOneWidget);
    expect(find.text('Quels logements contient-elle ?'), findsOneWidget);
    // The step asks for the units: no second title over them.
    expect(find.text('Unités'), findsNothing);
    await golden('annonce_form_units');
  });

  testWidgets('correcting: no kind to choose, saved from any step, any step a tap away', (tester) async {
    await form(
      tester,
      AnnonceFormEditing(
        const AnnonceDraft(kind: AnnonceKind.single, id: 'a-1', title: 'Studio Akwa', location: location, price: 85000)
            .copyWith(availableFrom: DateTime(2026, 11, 1)),
      ),
    );

    expect(find.text('Modifier le bien'), findsOneWidget);
    expect(find.text('Bien multiple'), findsNothing);
    expect(find.text('Continuer'), findsNothing);
    await tester.tap(find.text('Enregistrer'));
    verify(() => bloc.add(const AnnonceFormSubmitted())).called(1);

    // The fourth segment of the step bar: the rent.
    await tester.tap(find.byType(AnimatedContainer).at(3));
    verify(() => bloc.add(const AnnonceFormStepRequested(AnnonceFormStep.rent))).called(1);
  });
}
