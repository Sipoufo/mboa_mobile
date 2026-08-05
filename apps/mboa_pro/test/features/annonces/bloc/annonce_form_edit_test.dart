import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/annonces/bloc/annonce_form_bloc.dart';
import 'package:mboa_pro/features/annonces/data/annonce_repository.dart';
import 'package:mboa_pro/features/annonces/data/residence_repository.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockAnnonceRepository extends Mock implements AnnonceRepository {}

class MockResidenceRepository extends Mock implements ResidenceRepository {}

/// Editing was opening a blank form: the route's `annonceId` was accepted and
/// then ignored, so nothing was ever fetched or seeded.
void main() {
  late MockAnnonceRepository annonces;
  late MockResidenceRepository residences;
  late MockMediaUploader uploader;

  final existing = Annonce(
    id: 'a-1',
    title: 'Appartement à louer',
    status: AnnonceStatus.published,
    propertyType: PropertyType.studio,
    city: 'Douala',
    cityId: 'c-1',
    district: 'Deido',
    districtId: 'd-1',
    latitude: 4.05,
    longitude: 9.7,
    exactAddress: 'Rue 12',
    monthlyRent: 120000,
    chargesIncluded: false,
    chargesAmount: 5000,
    surfaceArea: 65,
    roomCount: 6,
    bathroomCount: 2,
    furnished: true,
    availableFrom: DateTime(2026, 9, 1),
    description: 'Bel appartement',
    photoKeys: const ['p1', 'p2'],
  );

  setUp(() {
    annonces = MockAnnonceRepository();
    residences = MockResidenceRepository();
    uploader = MockMediaUploader();
  });

  AnnonceFormBloc build() => AnnonceFormBloc(
        annonces: annonces,
        residences: residences,
        uploader: uploader,
      );

  blocTest<AnnonceFormBloc, AnnonceFormState>(
    'a blank form needs no fetch',
    build: build,
    act: (bloc) =>
        bloc.add(const AnnonceFormStarted(kind: AnnonceKind.single)),
    expect: () => [const AnnonceFormEditing(AnnonceDraft(kind: AnnonceKind.single))],
    verify: (_) => verifyNever(() => annonces.getOne(any())),
  );

  blocTest<AnnonceFormBloc, AnnonceFormState>(
    'editing fetches the listing and seeds every field',
    setUp: () =>
        when(() => annonces.getOne('a-1')).thenAnswer((_) async => existing),
    build: build,
    act: (bloc) => bloc.add(
      const AnnonceFormStarted(kind: AnnonceKind.single, annonceId: 'a-1'),
    ),
    expect: () => [
      const AnnonceFormLoading(),
      AnnonceFormEditing(AnnonceDraft.fromAnnonce(existing)),
    ],
    verify: (bloc) {
      final draft = (bloc.state as AnnonceFormEditing).draft;
      expect(draft.isEditing, isTrue);
      expect(draft.title, 'Appartement à louer');
      expect(draft.propertyType, PropertyType.studio);
      expect(draft.monthlyRent, 120000);
      expect(draft.surfaceArea, 65);
      expect(draft.roomCount, 6);
      expect(draft.bathroomCount, 2);
      expect(draft.furnished, isTrue);
      expect(draft.chargesAmount, 5000);
      expect(draft.description, 'Bel appartement');
      expect(draft.photoKeys, ['p1', 'p2']);
    },
  );

  test('the seeded draft rebuilds the location without re-capturing GPS', () {
    final draft = AnnonceDraft.fromAnnonce(existing);

    expect(draft.location, isNotNull);
    expect(draft.location!.districtId, 'd-1');
    expect(draft.location!.latitude, 4.05);
    expect(draft.location!.exactAddress, 'Rue 12');
    // Fully seeded, so an edit can be saved without touching the map at all.
    expect(draft.canSave, isTrue);
  });

  test('a listing without coordinates yields no location', () {
    // Older listings may predate the required lat/lng; do not invent a point.
    const partial = Annonce(
      id: 'a-2',
      title: 'Sans position',
      status: AnnonceStatus.draft,
      propertyType: PropertyType.room,
      districtId: 'd-9',
    );

    expect(AnnonceDraft.fromAnnonce(partial).location, isNull);
  });

  blocTest<AnnonceFormBloc, AnnonceFormState>(
    'reports a failure rather than showing an empty form',
    setUp: () => when(() => annonces.getOne(any())).thenThrow(Exception('404')),
    build: build,
    act: (bloc) => bloc.add(
      const AnnonceFormStarted(kind: AnnonceKind.single, annonceId: 'gone'),
    ),
    expect: () => [const AnnonceFormLoading(), const AnnonceFormLoadFailure()],
  );
}
