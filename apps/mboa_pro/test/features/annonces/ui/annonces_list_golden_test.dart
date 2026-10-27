import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/app/router/app_router.gr.dart';
import 'package:mboa_pro/features/annonces/bloc/annonces_bloc.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/ui/annonces_list_page.dart';
import 'package:mboa_pro/features/annonces/ui/widgets/annonce_card.dart';
import 'package:mboa_pro/features/assignments/models/assignment.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockAnnoncesBloc extends MockBloc<AnnoncesEvent, AnnoncesState>
    implements AnnoncesBloc {}

class MockStackRouter extends Mock implements StackRouter {}

class _FakeRoute extends Fake implements PageRouteInfo<dynamic> {}

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
                  activeCount: 2,
                  onTransition: (_) {},
                  onDelete: () {},
                  onEdit: () {},
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
    expect(find.textContaining('FCFA / mois'), findsNWidgets(3));
    expect(find.text('50 m² – 2 Pièces'), findsOneWidget);
    // The draft is visible and labelled, not hidden.
    expect(find.text('Brouillon'), findsOneWidget);
    expect(find.text('Disponible'), findsNWidgets(2));

    await expectLater(
      find.byType(ListView),
      matchesGoldenFile('goldens/annonces_list.png'),
    );
  });

  testWidgets('a card\'s « Attributions » opens that listing\'s agents (M11) — it said « Bientôt »', (tester) async {
    registerFallbackValue(_FakeRoute());
    final bloc = MockAnnoncesBloc();
    when(() => bloc.state).thenReturn(
      AnnoncesReady(items: [listings.first], filter: AnnonceFilter.available),
    );
    final router = MockStackRouter();
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: StackRouterScope(
          controller: router,
          stateHash: 0,
          child: BlocProvider<AnnoncesBloc>.value(value: bloc, child: const AnnoncesListPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Attributions'));

    final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
    expect(route.routeName, AgentAssignmentRoute.name);
    expect((route.args! as AgentAssignmentRouteArgs).target, const AnnonceTarget('a'));
  });
}
