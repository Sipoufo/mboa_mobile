import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/annonces/bloc/residences_bloc.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/models/residence.dart';
import 'package:mboa_pro/features/annonces/ui/residence_detail_page.dart';
import 'package:mboa_pro/features/profile/models/prestataire_type.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_pro/features/subscription/bloc/subscription_bloc.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockResidencesBloc extends MockBloc<ResidencesEvent, ResidencesState>
    implements ResidencesBloc {}

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProProfileBloc {}

class MockSubscriptionBloc
    extends MockBloc<SubscriptionEvent, SubscriptionState>
    implements SubscriptionBloc {}

void main() {
  late MockResidencesBloc residences;
  late MockProProfileBloc profile;
  late MockSubscriptionBloc subscription;

  const units = [
    ResidenceUnit(
      id: 'u1',
      title: 'Chambre 1',
      status: AnnonceStatus.published,
      propertyType: PropertyType.room,
      price: 45000,
    ),
    ResidenceUnit(
      id: 'u2',
      title: 'Chambre 2',
      status: AnnonceStatus.draft,
      propertyType: PropertyType.room,
      price: 45000,
    ),
  ];

  const residence = Residence(
    id: 'r1',
    name: 'Résidence Deido',
    status: AnnonceStatus.published,
    district: 'Deido',
    unitCount: 2,
    publishedUnitCount: 1,
    units: units,
  );

  setUp(() {
    residences = MockResidencesBloc();
    profile = MockProProfileBloc();
    subscription = MockSubscriptionBloc();

    when(() => residences.state)
        .thenReturn(const ResidencesReady(items: [residence]));
    when(() => profile.state).thenReturn(
      const ProProfileReady(
        ProfileData(
          role: AccountRole.prestataire,
          photoObjectKey: 'p',
          type: PrestataireType.agence,
          mainCityId: 'c-1',
        ),
      ),
    );
    when(() => subscription.state).thenReturn(
      const SubscriptionReady(SubscriptionPlan.free()),
    );
  });

  /// [settle] must be false when a loader is on screen — it animates forever.
  Future<void> pump(
    WidgetTester tester, {
    String id = 'r1',
    bool settle = true,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ResidencesBloc>.value(value: residences),
            BlocProvider<ProProfileBloc>.value(value: profile),
            BlocProvider<SubscriptionBloc>.value(value: subscription),
          ],
          child: ResidenceDetailPage(id: id),
        ),
      ),
    );
    if (settle) {
      await tester.pumpAndSettle();
    } else {
      await tester.pump();
    }
  }

  testWidgets('opens without a provider error', (tester) async {
    // Reads ResidencesBloc from the wrapper, as a sibling of the list route.
    await pump(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('Résidence Deido'), findsOneWidget);
  });

  testWidgets('fetches the full residence on open', (tester) async {
    // The list payload carries counts but not necessarily the units array, so
    // the detail must ask for its own — this is why units were missing.
    await pump(tester);

    verify(() => residences.add(const ResidenceDetailRequested('r1'))).called(1);
  });

  testWidgets('lists every unit with its status and rent', (tester) async {
    await pump(tester);

    expect(find.text('Chambre 1'), findsOneWidget);
    expect(find.text('Chambre 2'), findsOneWidget);
    expect(find.textContaining('XAF / Mois'), findsNWidgets(2));
    // Statuses are per unit, so a draft unit is visible as such.
    expect(find.text('Disponible'), findsWidgets);
    expect(find.text('Brouillon'), findsOneWidget);
  });

  testWidgets('shows the unit counts', (tester) async {
    await pump(tester);

    expect(find.textContaining('2 unités'), findsOneWidget);
    expect(find.textContaining('1 publiées'), findsOneWidget);
  });

  testWidgets('every unit row is tappable and offers an edit', (tester) async {
    // A unit id is an annonce id, so a row opens the ordinary listing detail
    // and the ordinary edit form — nothing unit-specific beyond the entry.
    await pump(tester);

    expect(find.byType(InkWell), findsWidgets);
    expect(find.byIcon(LucideIcons.squarePen), findsNWidgets(2));
  });

  testWidgets('offers the bulk transitions for the status', (tester) async {
    await pump(tester);

    await tester.tap(find.byIcon(LucideIcons.ellipsisVertical));
    await tester.pumpAndSettle();

    // Published: reserve / rent / archive, applied to every unit at once.
    expect(find.text('Marquer réservé'), findsOneWidget);
    expect(find.text('Archiver'), findsOneWidget);

    await tester.tap(find.text('Archiver'));
    await tester.pumpAndSettle();

    verify(
      () => residences.add(
        const ResidenceStatusChangeRequested('r1', AnnonceTransition.archive),
      ),
    ).called(1);
  });

  testWidgets('renders a residence with no units', (tester) async {
    when(() => residences.state).thenReturn(
      const ResidencesReady(
        items: [
          Residence(
            id: 'r1',
            name: 'Vide',
            status: AnnonceStatus.draft,
            unitCount: 0,
          ),
        ],
      ),
    );

    await pump(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('Chambre 1'), findsNothing);
  });

  testWidgets('waits rather than erroring while the fetch is in flight', (tester) async {
    // A deep link lands here before the list exists; showing "error" would be
    // wrong, since the residence is simply not fetched yet.
    when(() => residences.state).thenReturn(const ResidencesReady(items: []));

    await pump(tester, id: 'not-loaded-yet', settle: false);

    expect(tester.takeException(), isNull);
    expect(find.byType(Loader), findsOneWidget);
  });

  group('filtering the units', () {
    const mixed = [
      ResidenceUnit(
        id: 'u1',
        title: 'Chambre 1',
        status: AnnonceStatus.published,
        propertyType: PropertyType.room,
        price: 45000,
      ),
      ResidenceUnit(
        id: 'u2',
        title: 'Chambre 2',
        status: AnnonceStatus.rented,
        propertyType: PropertyType.room,
        price: 45000,
      ),
      ResidenceUnit(
        id: 'u3',
        title: 'Chambre 3',
        status: AnnonceStatus.archived,
        propertyType: PropertyType.room,
        price: 45000,
      ),
    ];

    setUp(() {
      when(() => residences.state).thenReturn(
        const ResidencesReady(
          items: [
            Residence(
              id: 'r1',
              name: 'Résidence Deido',
              status: AnnonceStatus.published,
              unitCount: 3,
              units: mixed,
            ),
          ],
        ),
      );
    });

    testWidgets('opens on the available units', (tester) async {
      await pump(tester);

      expect(find.text('Chambre 1'), findsOneWidget);
      // Occupied and archived units are real but not what you land on.
      expect(find.text('Chambre 2'), findsNothing);
      expect(find.text('Chambre 3'), findsNothing);
    });

    testWidgets('the occupied tab shows rented and reserved units',
        (tester) async {
      await pump(tester);
      await tester.tap(find.text('Occupés'));
      await tester.pumpAndSettle();

      expect(find.text('Chambre 2'), findsOneWidget);
      expect(find.text('Chambre 1'), findsNothing);
    });

    testWidgets('the archived tab shows archived units', (tester) async {
      await pump(tester);
      await tester.tap(find.text('Archivés'));
      await tester.pumpAndSettle();

      expect(find.text('Chambre 3'), findsOneWidget);
      // Archived is where un-archiving starts, so the tab must not be a
      // dead end — the row still opens.
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('an empty tab names the tab, not the search', (tester) async {
      when(() => residences.state).thenReturn(
        const ResidencesReady(
          items: [
            Residence(
              id: 'r1',
              name: 'Résidence Deido',
              status: AnnonceStatus.published,
              unitCount: 1,
              // Nothing occupied.
              units: [
                ResidenceUnit(
                  id: 'u1',
                  title: 'Chambre 1',
                  status: AnnonceStatus.published,
                  propertyType: PropertyType.room,
                  price: 45000,
                ),
              ],
            ),
          ],
        ),
      );
      await pump(tester);

      await tester.tap(find.text('Occupés'));
      await tester.pumpAndSettle();

      expect(find.text('Aucun bien occupé.'), findsOneWidget);
      expect(find.text('Chambre 1'), findsNothing);
    });

    testWidgets('no search box for a handful of units', (tester) async {
      // Below the threshold a search field is more chrome than help.
      await pump(tester);

      expect(find.byIcon(LucideIcons.search), findsNothing);
    });
  });

  group('searching the units', () {
    List<ResidenceUnit> many() => [
          for (var i = 1; i <= 9; i++)
            ResidenceUnit(
              id: 'u$i',
              title: i.isEven ? 'Studio $i' : 'Chambre $i',
              status: AnnonceStatus.published,
              propertyType: PropertyType.room,
              price: 45000,
            ),
        ];

    setUp(() {
      when(() => residences.state).thenReturn(
        ResidencesReady(
          items: [
            Residence(
              id: 'r1',
              name: 'Résidence Deido',
              status: AnnonceStatus.published,
              unitCount: 9,
              units: many(),
            ),
          ],
        ),
      );
    });

    testWidgets('appears once there are enough units to sift through',
        (tester) async {
      await pump(tester);

      expect(find.byIcon(LucideIcons.search), findsOneWidget);
    });

    testWidgets('narrows the list as you type', (tester) async {
      await pump(tester);

      await tester.enterText(find.byType(Input), 'studio');
      await tester.pumpAndSettle();

      expect(find.text('Studio 2'), findsOneWidget);
      expect(find.text('Chambre 1'), findsNothing);
    });

    testWidgets('ignores case and accents', (tester) async {
      await pump(tester);

      // "Chambre" typed without care still finds it.
      await tester.enterText(find.byType(Input), 'CHÂMBRE 3');
      await tester.pumpAndSettle();

      expect(find.text('Chambre 3'), findsOneWidget);
      expect(find.text('Chambre 1'), findsNothing);
    });

    testWidgets('a search that finds nothing says so, quoting the query',
        (tester) async {
      await pump(tester);

      await tester.enterText(find.byType(Input), 'penthouse');
      await tester.pumpAndSettle();

      // Distinct from an empty tab: the units exist, the query missed them.
      expect(find.textContaining('penthouse'), findsWidgets);
    });

    testWidgets('search and tab compose', (tester) async {
      await pump(tester);

      await tester.enterText(find.byType(Input), 'chambre');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Archivés'));
      await tester.pumpAndSettle();

      // Every fixture is published, so an archived + "chambre" search is empty.
      expect(find.text('Chambre 1'), findsNothing);
    });
  });

}
