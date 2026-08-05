import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/annonces/bloc/annonce_form_bloc.dart';
import 'package:mboa_pro/features/annonces/data/annonce_repository.dart';
import 'package:mboa_pro/features/annonces/data/residence_repository.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/models/residence.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockAnnonceRepository extends Mock implements AnnonceRepository {}

class MockResidenceRepository extends Mock implements ResidenceRepository {}

const location = ListingLocation(
  districtId: 'd-1',
  districtName: 'Deido',
  latitude: 4.05,
  longitude: 9.7,
  cityName: 'Douala',
);

AnnonceDraft completeSingle() => AnnonceDraft(
      kind: AnnonceKind.single,
      title: 'Appartement à louer',
      monthlyRent: 120000,
      availableFrom: DateTime(2026, 9, 1),
      location: location,
    );

void main() {
  late MockAnnonceRepository annonces;
  late MockResidenceRepository residences;
  late MockMediaUploader uploader;

  setUpAll(() {
    registerFallbackValue(ImageSource.camera);
    registerFallbackValue(CreateUploadRequestCategoryEnum.LISTING_PHOTO);
    registerFallbackValue(const AnnonceDraft(kind: AnnonceKind.single));
  });

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

  void stubUpload(String? key) {
    when(
      () => uploader.captureAndUpload(
        source: any(named: 'source'),
        category: any(named: 'category'),
      ),
    ).thenAnswer((_) async => key);
  }

  group('photos', () {
    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'uploads as picked and appends the key',
      setUp: () => stubUpload('photo-1'),
      build: build,
      seed: () => AnnonceFormEditing(completeSingle()),
      act: (bloc) => bloc.add(const AnnonceFormPhotoAdded(ImageSource.camera)),
      expect: () => [
        AnnonceFormEditing(completeSingle(), uploadingPhoto: true),
        AnnonceFormEditing(completeSingle().copyWith(photoKeys: ['photo-1'])),
      ],
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'treats a cancelled picker as a no-op, not a failure',
      setUp: () => stubUpload(null),
      build: build,
      seed: () => AnnonceFormEditing(completeSingle()),
      act: (bloc) => bloc.add(const AnnonceFormPhotoAdded(ImageSource.gallery)),
      expect: () => [
        AnnonceFormEditing(completeSingle(), uploadingPhoto: true),
        AnnonceFormEditing(completeSingle()),
      ],
    );

    test('CE-M10-01 — retries a failing upload three times', () async {
      var calls = 0;
      when(
        () => uploader.captureAndUpload(
          source: any(named: 'source'),
          category: any(named: 'category'),
        ),
      ).thenAnswer((_) async {
        calls++;
        throw Exception('network');
      });

      final bloc = build()..emit(AnnonceFormEditing(completeSingle()));
      bloc.add(const AnnonceFormPhotoAdded(ImageSource.camera));
      await bloc.stream.firstWhere(
        (s) => s is AnnonceFormEditing && s.error == AnnonceFormError.photoUpload,
      );

      expect(calls, 3);
      await bloc.close();
    });

    test('succeeds on a retry after a transient failure', () async {
      var calls = 0;
      when(
        () => uploader.captureAndUpload(
          source: any(named: 'source'),
          category: any(named: 'category'),
        ),
      ).thenAnswer((_) async {
        calls++;
        if (calls == 1) throw Exception('network');
        return 'photo-2';
      });

      final bloc = build()..emit(AnnonceFormEditing(completeSingle()));
      bloc.add(const AnnonceFormPhotoAdded(ImageSource.camera));
      final state = await bloc.stream.firstWhere(
        (s) => s is AnnonceFormEditing && s.draft.photoKeys.isNotEmpty,
      ) as AnnonceFormEditing;

      expect(state.draft.photoKeys, ['photo-2']);
      expect(state.error, isNull);
      await bloc.close();
    });

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'refuses to exceed the 15-photo maximum',
      build: build,
      seed: () => AnnonceFormEditing(
        completeSingle().copyWith(
          photoKeys: List.generate(15, (i) => 'photo-$i'),
        ),
      ),
      act: (bloc) => bloc.add(const AnnonceFormPhotoAdded(ImageSource.camera)),
      expect: () => const <AnnonceFormState>[],
      verify: (_) => verifyNever(
        () => uploader.captureAndUpload(
          source: any(named: 'source'),
          category: any(named: 'category'),
        ),
      ),
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'removes a photo by key',
      build: build,
      seed: () => AnnonceFormEditing(
        completeSingle().copyWith(photoKeys: ['a', 'b']),
      ),
      act: (bloc) => bloc.add(const AnnonceFormPhotoRemoved('a')),
      expect: () =>
          [AnnonceFormEditing(completeSingle().copyWith(photoKeys: ['b']))],
    );
  });

  group('validation', () {
    test('a draft may be saved without the three photos', () {
      // Enregistrer saves a draft; publishing is what enforces CE-M10-03.
      final draft = completeSingle();

      expect(draft.hasEnoughPhotos, isFalse);
      expect(draft.canSave, isTrue);
    });

    test('required fields gate saving', () {
      expect(const AnnonceDraft(kind: AnnonceKind.single).canSave, isFalse);
      expect(completeSingle().copyWith(title: '   ').canSave, isFalse);
    });

    test('a residence needs at least one valid unit group', () {
      final base = AnnonceDraft(
        kind: AnnonceKind.residence,
        title: 'Résidence Deido',
        availableFrom: DateTime(2026, 9, 1),
        location: location,
      );

      expect(base.canSave, isFalse);
      expect(
        base.copyWith(units: const [UnitGroupDraft()]).canSave,
        isFalse,
        reason: 'an empty unit group is not valid',
      );
      expect(
        base.copyWith(
          units: const [
            UnitGroupDraft(count: 4, namePrefix: 'Chambre', monthlyRent: 45000),
          ],
        ).canSave,
        isTrue,
      );
    });

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'reports incomplete rather than calling the API',
      build: build,
      seed: () => const AnnonceFormEditing(AnnonceDraft(kind: AnnonceKind.single)),
      act: (bloc) => bloc.add(const AnnonceFormSubmitted()),
      expect: () => [
        const AnnonceFormEditing(
          AnnonceDraft(kind: AnnonceKind.single),
          error: AnnonceFormError.incomplete,
        ),
      ],
      verify: (_) => verifyNever(() => annonces.create(any())),
    );
  });

  group('saving', () {
    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'creates a single listing',
      setUp: () => when(() => annonces.create(any())).thenAnswer(
        (_) async => const Annonce(
          id: 'new-1',
          title: 'Appartement à louer',
          status: AnnonceStatus.draft,
          propertyType: PropertyType.apartment,
        ),
      ),
      build: build,
      seed: () => AnnonceFormEditing(completeSingle()),
      act: (bloc) => bloc.add(const AnnonceFormSubmitted()),
      expect: () => [
        AnnonceFormSubmitting(completeSingle()),
        const AnnonceFormSaved(id: 'new-1', kind: AnnonceKind.single),
      ],
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'updates instead of creating when editing',
      setUp: () => when(() => annonces.update(any())).thenAnswer(
        (_) async => const Annonce(
          id: 'existing',
          title: 'Appartement à louer',
          status: AnnonceStatus.published,
          propertyType: PropertyType.apartment,
        ),
      ),
      build: build,
      seed: () => AnnonceFormEditing(completeSingle().copyWith(id: 'existing')),
      act: (bloc) => bloc.add(const AnnonceFormSubmitted()),
      skip: 1,
      expect: () =>
          [const AnnonceFormSaved(id: 'existing', kind: AnnonceKind.single)],
      verify: (_) => verifyNever(() => annonces.create(any())),
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'routes a residence draft to the residence repository',
      setUp: () => when(() => residences.create(any())).thenAnswer(
        (_) async => const Residence(
          id: 'res-1',
          name: 'Résidence Deido',
          status: AnnonceStatus.draft,
        ),
      ),
      build: build,
      seed: () => AnnonceFormEditing(
        AnnonceDraft(
          kind: AnnonceKind.residence,
          title: 'Résidence Deido',
          availableFrom: DateTime(2026, 9, 1),
          location: location,
          units: const [
            UnitGroupDraft(count: 4, namePrefix: 'Chambre', monthlyRent: 45000),
          ],
        ),
      ),
      act: (bloc) => bloc.add(const AnnonceFormSubmitted()),
      skip: 1,
      expect: () =>
          [const AnnonceFormSaved(id: 'res-1', kind: AnnonceKind.residence)],
      verify: (_) => verifyNever(() => annonces.create(any())),
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'keeps the draft on screen when saving fails',
      setUp: () =>
          when(() => annonces.create(any())).thenThrow(Exception('boom')),
      build: build,
      seed: () => AnnonceFormEditing(completeSingle()),
      act: (bloc) => bloc.add(const AnnonceFormSubmitted()),
      skip: 1,
      expect: () => [
        AnnonceFormEditing(completeSingle(), error: AnnonceFormError.save),
      ],
    );
  });

  group('unit groups', () {
    final base = const AnnonceDraft(kind: AnnonceKind.residence);

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'adds, updates and removes rows',
      build: build,
      seed: () => AnnonceFormEditing(base),
      act: (bloc) => bloc
        ..add(const AnnonceFormUnitGroupAdded())
        ..add(
          const AnnonceFormUnitGroupUpdated(
            0,
            UnitGroupDraft(count: 6, namePrefix: 'Studio', monthlyRent: 60000),
          ),
        )
        ..add(const AnnonceFormUnitGroupRemoved(0)),
      expect: () => [
        AnnonceFormEditing(base.copyWith(units: const [UnitGroupDraft()])),
        AnnonceFormEditing(
          base.copyWith(
            units: const [
              UnitGroupDraft(count: 6, namePrefix: 'Studio', monthlyRent: 60000),
            ],
          ),
        ),
        AnnonceFormEditing(base.copyWith(units: const [])),
      ],
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'ignores an out-of-range update',
      build: build,
      seed: () => AnnonceFormEditing(base),
      act: (bloc) => bloc.add(
        const AnnonceFormUnitGroupUpdated(3, UnitGroupDraft()),
      ),
      expect: () => const <AnnonceFormState>[],
    );
  });
}
