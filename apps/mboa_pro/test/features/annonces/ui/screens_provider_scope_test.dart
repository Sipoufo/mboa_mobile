import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/annonces/bloc/annonce_form_bloc.dart';
import 'package:mboa_pro/features/annonces/bloc/annonces_bloc.dart';
import 'package:mboa_pro/features/annonces/bloc/residences_bloc.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/ui/annonce_detail_page.dart';
import 'package:mboa_pro/features/annonces/ui/annonce_form_page.dart';
import 'package:mboa_pro/features/annonces/ui/annonces_list_page.dart';
import 'package:mboa_pro/features/annonces/ui/residences_list_page.dart';
import 'package:mboa_pro/features/kyc/logic/kyc_cubit.dart';
import 'package:mboa_pro/features/kyc/models/kyc_draft.dart';
import 'package:mboa_pro/features/kyc/models/kyc_status.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_pro/features/subscription/bloc/subscription_bloc.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockAnnoncesBloc extends MockBloc<AnnoncesEvent, AnnoncesState>
    implements AnnoncesBloc {}

class MockResidencesBloc extends MockBloc<ResidencesEvent, ResidencesState>
    implements ResidencesBloc {}

class MockAnnonceFormBloc
    extends MockBloc<AnnonceFormEvent, AnnonceFormState>
    implements AnnonceFormBloc {}

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProProfileBloc {}

class MockKycCubit extends MockCubit<KycState> implements KycCubit {}

class MockSubscriptionBloc
    extends MockBloc<SubscriptionEvent, SubscriptionState>
    implements SubscriptionBloc {}

/// Every M10 screen, pumped with exactly the blocs its route inherits.
///
/// `AnnonceDetailPage` reads `AnnoncesBloc` but is a **sibling** route of the
/// list, not a child — so a list-scoped provider never reached it and opening a
/// listing threw `ProviderNotFoundException`. Same shape of bug as the Mes
/// biens hub. These tests are what make that class visible: analyze and the
/// bloc tests both pass while the screen crashes on open.
void main() {
  late MockAnnoncesBloc annonces;
  late MockResidencesBloc residences;
  late MockProProfileBloc profile;
  late MockKycCubit kyc;
  late MockSubscriptionBloc subscription;

  const listing = Annonce(
    id: 'a',
    title: 'Appartement à louer',
    status: AnnonceStatus.published,
    propertyType: PropertyType.apartment,
    district: 'Deido',
    monthlyRent: 120000,
    photoKeys: ['p1', 'p2', 'p3'],
  );

  setUp(() {
    annonces = MockAnnoncesBloc();
    residences = MockResidencesBloc();
    profile = MockProProfileBloc();
    kyc = MockKycCubit();
    subscription = MockSubscriptionBloc();

    when(() => annonces.state).thenReturn(
      const AnnoncesReady(items: [listing], filter: AnnonceFilter.available),
    );
    when(() => residences.state).thenReturn(const ResidencesReady(items: []));
    when(() => profile.state).thenReturn(
      const ProProfileReady(ProfileData(role: AccountRole.prestataire)),
    );
    when(() => kyc.state).thenReturn(
      const KycReady(KycStatusData(status: KycStatus.approved), KycDraft()),
    );
    when(() => subscription.state).thenReturn(
      const SubscriptionReady(SubscriptionPlan.free()),
    );
  });

  tearDown(() => getIt.reset());

  /// Mirrors what `AuthenticatedWrapper` provides to every authenticated route.
  ///
  /// [settle] must be false when a loader is on screen — it animates forever.
  Future<void> pump(
    WidgetTester tester,
    Widget screen, {
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
            BlocProvider<AnnoncesBloc>.value(value: annonces),
            BlocProvider<ResidencesBloc>.value(value: residences),
            BlocProvider<ProProfileBloc>.value(value: profile),
            BlocProvider<KycCubit>.value(value: kyc),
            BlocProvider<SubscriptionBloc>.value(value: subscription),
          ],
          child: screen,
        ),
      ),
    );
    if (settle) {
      await tester.pumpAndSettle();
    } else {
      await tester.pump();
    }
  }

  testWidgets('AnnoncesListPage renders from the inherited bloc', (tester) async {
    await pump(tester, const AnnoncesListPage());

    expect(tester.takeException(), isNull);
    expect(find.text('Appartement à louer'), findsOneWidget);
    // Loading is triggered by the screen, not the wrapper.
    verify(() => annonces.add(const AnnoncesLoadRequested())).called(1);
  });

  testWidgets('ResidencesListPage renders and loads on open', (tester) async {
    await pump(tester, const ResidencesListPage());

    expect(tester.takeException(), isNull);
    verify(() => residences.add(const ResidencesLoadRequested())).called(1);
  });

  testWidgets('AnnonceDetailPage opens without a provider error', (tester) async {
    // The regression: this reads AnnoncesBloc from a sibling route.
    await pump(tester, const AnnonceDetailPage(id: 'a'));

    expect(tester.takeException(), isNull);
    expect(find.text('Appartement à louer'), findsOneWidget);
    expect(find.textContaining('Aucune information'), findsWidgets);
  });

  testWidgets('AnnonceDetailPage offers the transitions for the status', (tester) async {
    await pump(tester, const AnnonceDetailPage(id: 'a'));

    // Published: reserve / rent / archive — but not publish.
    expect(find.text('Marquer réservé'), findsOneWidget);
    expect(find.text('Marquer loué'), findsOneWidget);
    expect(find.text('Archiver'), findsOneWidget);
    expect(find.text('Publier'), findsNothing);
  });

  testWidgets('AnnonceDetailPage waits rather than erroring on an unknown id', (tester) async {
    // A residence unit is not in the list, so "not there yet" is normal —
    // showing an error would be wrong.
    await pump(tester, const AnnonceDetailPage(id: 'missing'), settle: false);

    expect(tester.takeException(), isNull);
    verify(() => annonces.add(const AnnonceDetailRequested('missing')))
        .called(1);
  });

  testWidgets('AnnonceDetailPage opens a residence unit', (tester) async {
    const unit = Annonce(
      id: 'u1',
      title: 'Chambre 1',
      status: AnnonceStatus.published,
      propertyType: PropertyType.room,
      residenceId: 'r1',
      photoKeys: ['a', 'b', 'c'],
    );
    when(() => annonces.state).thenReturn(
      const AnnoncesReady(
        items: [listing, unit],
        filter: AnnonceFilter.available,
      ),
    );

    await pump(tester, const AnnonceDetailPage(id: 'u1'));

    expect(tester.takeException(), isNull);
    expect(find.text('Chambre 1'), findsOneWidget);
    // Says what it is, since the unit is absent from Biens Uniques.
    expect(find.textContaining('résidence'), findsOneWidget);
  });

  test('the list hides units while the bloc still holds them', () {
    const unit = Annonce(
      id: 'u1',
      title: 'Chambre 1',
      status: AnnonceStatus.published,
      propertyType: PropertyType.room,
      residenceId: 'r1',
    );
    const state = AnnoncesReady(
      items: [listing, unit],
      filter: AnnonceFilter.available,
    );

    expect(state.visible.map((a) => a.id), ['a']);
    // A unit does not consume the tier's active-listing allowance.
    expect(state.activeCount, 1);
  });

  testWidgets('AnnonceFormPage renders with its own bloc', (tester) async {
    final form = MockAnnonceFormBloc();
    when(() => form.state).thenReturn(
      const AnnonceFormEditing(AnnonceDraft(kind: AnnonceKind.single)),
    );
    getIt.registerFactory<AnnonceFormBloc>(() => form);

    // Routed through its own wrappedRoute, exactly as auto_route does — the
    // form is the one screen that legitimately provides its own bloc.
    await pump(
      tester,
      Builder(
        builder: (context) =>
            const AnnonceFormPage(kind: AnnonceKind.single).wrappedRoute(context),
      ),
    );

    expect(tester.takeException(), isNull);
    // Two fields labelled "Type" was the reported bug: the title field now
    // reads "Titre", leaving "Type" to the property-type dropdown alone.
    expect(find.text('Titre'), findsOneWidget);
    expect(find.text('Type'), findsOneWidget);
  });
}
