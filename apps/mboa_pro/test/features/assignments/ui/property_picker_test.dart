import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/annonces/bloc/annonces_bloc.dart';
import 'package:mboa_pro/features/annonces/bloc/residences_bloc.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/models/residence.dart';
import 'package:mboa_pro/features/assignments/models/assignment.dart';
import 'package:mboa_pro/features/assignments/ui/widgets/property_picker_sheet.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockAnnoncesBloc extends MockBloc<AnnoncesEvent, AnnoncesState>
    implements AnnoncesBloc {}

class MockResidencesBloc extends MockBloc<ResidencesEvent, ResidencesState>
    implements ResidencesBloc {}

Annonce annonce({
  String id = 'a-1',
  String title = 'Studio Bonapriso',
  AnnonceStatus status = AnnonceStatus.published,
  String? residenceId,
}) =>
    Annonce(
      id: id,
      title: title,
      status: status,
      propertyType: PropertyType.studio,
      district: 'Bonapriso',
      residenceId: residenceId,
    );

/// Which properties can take an agent, and where the list comes from.
///
/// The sheet used to read whatever `Mes biens` happened to have loaded —
/// `AnnoncesBloc` and `ResidencesBloc` are session-scoped but deliberately not
/// loaded at session start, so arriving from the home dashboard showed an empty
/// picker.
void main() {
  late MockAnnoncesBloc annonces;
  late MockResidencesBloc residences;

  setUp(() {
    annonces = MockAnnoncesBloc();
    residences = MockResidencesBloc();
  });

  /// [settle] must be false while a loader is on screen — it animates forever.
  Future<void> open(WidgetTester tester, {bool settle = true}) async {
    AssignmentTarget? picked;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AnnoncesBloc>.value(value: annonces),
            BlocProvider<ResidencesBloc>.value(value: residences),
          ],
          child: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () async =>
                      picked = await showPropertyPickerSheet(context),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    if (settle) {
      await tester.pumpAndSettle();
    } else {
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
    }
    expect(picked, isNull, reason: 'nothing picked yet');
  }

  testWidgets('loads both lists itself rather than trusting what was cached',
      (tester) async {
    when(() => annonces.state).thenReturn(const AnnoncesInitial());
    when(() => residences.state).thenReturn(const ResidencesInitial());

    await open(tester, settle: false);

    // Arriving from the home dashboard, neither list has ever been fetched.
    verify(() => annonces.add(const AnnoncesLoadRequested())).called(1);
    verify(() => residences.add(const ResidencesLoadRequested())).called(1);
  });

  testWidgets('waits rather than showing half the portfolio', (tester) async {
    when(() => annonces.state).thenReturn(
      AnnoncesReady(items: [annonce()], filter: AnnonceFilter.available),
    );
    when(() => residences.state).thenReturn(const ResidencesLoadInProgress());

    await open(tester, settle: false);

    // One list ready and the other still arriving would read as "that is
    // everything you have".
    expect(find.byType(Loader), findsWidgets);
    expect(find.text('Studio Bonapriso'), findsNothing);
  });

  group('what may take an agent', () {
    testWidgets('a published listing may', (tester) async {
      when(() => annonces.state).thenReturn(
        AnnoncesReady(items: [annonce()], filter: AnnonceFilter.available),
      );
      when(() => residences.state).thenReturn(const ResidencesReady(items: []));

      await open(tester);

      expect(find.text('Studio Bonapriso'), findsOneWidget);
    });

    testWidgets('a draft or reserved listing may not', (tester) async {
      when(() => annonces.state).thenReturn(
        AnnoncesReady(
          items: [
            annonce(id: 'a-1', title: 'Brouillon', status: AnnonceStatus.draft),
            annonce(
              id: 'a-2',
              title: 'Réservé',
              status: AnnonceStatus.reserved,
            ),
          ],
          filter: AnnonceFilter.available,
        ),
      );
      when(() => residences.state).thenReturn(const ResidencesReady(items: []));

      await open(tester);

      // The backend refuses both with ANNONCE_NOT_PUBLISHED; offering them
      // would only produce a failed call.
      expect(find.text('Brouillon'), findsNothing);
      expect(find.text('Réservé'), findsNothing);
    });

    testWidgets('a residence unit is never offered on its own', (tester) async {
      when(() => annonces.state).thenReturn(
        AnnoncesReady(
          items: [annonce(title: 'Chambre 1', residenceId: 'r-1')],
          filter: AnnonceFilter.available,
        ),
      );
      when(() => residences.state).thenReturn(const ResidencesReady(items: []));

      await open(tester);

      // Reads `standalone`, never `items` — the listings-vs-units invariant.
      expect(find.text('Chambre 1'), findsNothing);
    });

    testWidgets('a draft residence with published units may', (tester) async {
      when(() => annonces.state).thenReturn(
        const AnnoncesReady(items: [], filter: AnnonceFilter.available),
      );
      when(() => residences.state).thenReturn(
        const ResidencesReady(
          items: [
            Residence(
              id: 'r-1',
              name: 'Résidence Deido',
              // Aggregate status is draft, but three units are live — the
              // backend only requires one (NO_PUBLISHED_UNITS).
              status: AnnonceStatus.draft,
              unitCount: 10,
              publishedUnitCount: 3,
            ),
          ],
        ),
      );

      await open(tester);

      expect(find.text('Résidence Deido'), findsOneWidget);
    });

    testWidgets('a residence with no published unit may not', (tester) async {
      when(() => annonces.state).thenReturn(
        const AnnoncesReady(items: [], filter: AnnonceFilter.available),
      );
      when(() => residences.state).thenReturn(
        const ResidencesReady(
          items: [
            Residence(
              id: 'r-1',
              name: 'Résidence Deido',
              status: AnnonceStatus.published,
              unitCount: 10,
              publishedUnitCount: 0,
            ),
          ],
        ),
      );

      await open(tester);

      expect(find.text('Résidence Deido'), findsNothing);
    });
  });

  testWidgets('an empty picker says why, and what to do', (tester) async {
    when(() => annonces.state).thenReturn(
      const AnnoncesReady(items: [], filter: AnnonceFilter.available),
    );
    when(() => residences.state).thenReturn(const ResidencesReady(items: []));

    await open(tester);

    expect(find.text('Aucun bien publié'), findsOneWidget);
    expect(find.textContaining('Publiez une annonce'), findsOneWidget);
  });
}
