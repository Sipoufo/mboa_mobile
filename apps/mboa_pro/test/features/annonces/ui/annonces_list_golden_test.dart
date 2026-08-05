import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/annonces/bloc/annonces_bloc.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/ui/widgets/annonce_card.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockAnnoncesBloc extends MockBloc<AnnoncesEvent, AnnoncesState>
    implements AnnoncesBloc {}

void main() {
  const listings = [
    Annonce(
      id: 'a',
      title: 'Chambre Moderne à louer',
      status: AnnonceStatus.published,
      propertyType: PropertyType.room,
      district: 'Bepanda',
      surfaceArea: 50,
      roomCount: 2,
      monthlyRent: 45000,
    ),
    Annonce(
      id: 'b',
      title: 'Appartement à louer',
      status: AnnonceStatus.published,
      propertyType: PropertyType.apartment,
      district: 'Deido',
      surfaceArea: 65,
      roomCount: 6,
      monthlyRent: 120000,
    ),
    // A draft sits in Disponibles with its own chip, per the agreed behaviour.
    Annonce(
      id: 'c',
      title: 'Studio Moderne à louer',
      status: AnnonceStatus.draft,
      propertyType: PropertyType.studio,
      district: 'Bonanjo',
      surfaceArea: 30,
      roomCount: 3,
      monthlyRent: 90000,
    ),
  ];

  setUpAll(loadBrandFonts);

  testWidgets('listing cards match the reference design', (tester) async {
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
        home: Scaffold(
          backgroundColor: MboaTheme.light().extension<MboaColorScheme>()!.surfaceWarm,
          body: ListView(
            padding: const EdgeInsets.all(Dimens.spacing),
            children: [
              for (final annonce in listings)
                AnnonceCard(
                  annonce: annonce,
                  onEdit: () {},
                  onHistory: () {},
                  onAttributions: () {},
                ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Chambre Moderne à louer'), findsOneWidget);
    // The FR locale groups thousands with a narrow no-break space, so match on
    // the parts rather than embedding an invisible character in the literal.
    expect(find.textContaining('XAF / Mois'), findsNWidgets(3));
    expect(find.text('50 m² – 2 Pièces'), findsOneWidget);
    // The draft is visible and labelled, not hidden.
    expect(find.text('Brouillon'), findsOneWidget);
    expect(find.text('Disponible'), findsNWidgets(2));

    await expectLater(
      find.byType(ListView),
      matchesGoldenFile('goldens/annonces_list.png'),
    );
  });
}
