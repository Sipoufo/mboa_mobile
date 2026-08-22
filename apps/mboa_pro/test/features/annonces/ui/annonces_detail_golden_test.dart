import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/annonces/bloc/annonces_bloc.dart';
import 'package:mboa_pro/features/annonces/bloc/residences_bloc.dart';
import 'package:mboa_pro/features/annonces/models/amenity.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/models/residence.dart';
import 'package:mboa_pro/features/annonces/ui/annonce_detail_page.dart';
import 'package:mboa_pro/features/annonces/ui/residence_detail_page.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_pro/features/subscription/bloc/subscription_bloc.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockAnnoncesBloc extends MockBloc<AnnoncesEvent, AnnoncesState> implements AnnoncesBloc {}

class MockResidencesBloc extends MockBloc<ResidencesEvent, ResidencesState> implements ResidencesBloc {}

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState> implements ProProfileBloc {}

class MockSubscriptionBloc extends MockBloc<SubscriptionEvent, SubscriptionState> implements SubscriptionBloc {}

/// The two "détail" screens of M10, as they render.
void main() {
  late MockAnnoncesBloc annonces;
  late MockResidencesBloc residences;
  late MockProProfileBloc profile;
  late MockSubscriptionBloc subscription;

  final listing = Annonce(
    id: 'a1',
    title: 'Appartement à louer',
    status: AnnonceStatus.published,
    propertyType: PropertyType.apartment,
    city: 'Douala',
    district: 'Deido',
    price: 110000,
    rentalPeriod: RentalPeriod.month,
    surfaceArea: 30,
    roomCount: 6,
    bathroomCount: 2,
    furnished: true,
    chargesIncluded: false,
    availableFrom: DateTime(2026, 9, 1),
    description: 'Appartement lumineux, à deux pas du marché de Deido.',
    amenities: const [Amenity.airConditioning, Amenity.parking, Amenity.wifi],
    ownerVisitsEnabled: true,
  );

  const residence = Residence(
    id: 'r1',
    name: 'Résidence Deido',
    status: AnnonceStatus.published,
    district: 'Deido',
    unitCount: 8,
    publishedUnitCount: 5,
    units: [
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
        status: AnnonceStatus.draft,
        propertyType: PropertyType.room,
        price: 50000,
      ),
    ],
  );

  const profileData = ProfileData(
    firstName: 'Inesse',
    lastName: 'Kiawantio',
    role: AccountRole.prestataire,
    mainCity: 'Douala',
  );

  setUpAll(loadBrandFonts);

  setUp(() {
    annonces = MockAnnoncesBloc();
    residences = MockResidencesBloc();
    profile = MockProProfileBloc();
    subscription = MockSubscriptionBloc();

    when(() => annonces.state).thenReturn(
      AnnoncesReady(items: [listing], filter: AnnonceFilter.available),
    );
    when(() => residences.state).thenReturn(const ResidencesReady(items: [residence]));
    when(() => profile.state).thenReturn(const ProProfileReady(profileData));
    when(() => subscription.state).thenReturn(const SubscriptionReady(SubscriptionPlan.free()));
  });

  Future<void> pump(WidgetTester tester, Widget child) async {
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
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AnnoncesBloc>.value(value: annonces),
            BlocProvider<ResidencesBloc>.value(value: residences),
            BlocProvider<ProProfileBloc>.value(value: profile),
            BlocProvider<SubscriptionBloc>.value(value: subscription),
          ],
          child: child,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the listing detail', (tester) async {
    await pump(tester, const AnnonceDetailPage(id: 'a1'));

    await expectLater(
      find.byType(AnnonceDetailPage),
      matchesGoldenFile('goldens/annonce_detail.png'),
    );
  });

  testWidgets('the residence detail', (tester) async {
    await pump(tester, const ResidenceDetailPage(id: 'r1'));

    await expectLater(
      find.byType(ResidenceDetailPage),
      matchesGoldenFile('goldens/residence_detail.png'),
    );
  });
}
