import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
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
      price: 120000,
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

  group('photos of a unit group (RM-M10bis-13)', () {
    AnnonceDraft residence({List<String> groupPhotos = const []}) => AnnonceDraft(
          kind: AnnonceKind.residence,
          title: 'Cité blanche',
          availableFrom: DateTime(2026, 11, 1),
          location: location,
          photoKeys: const ['shared-1'],
          units: [
            const UnitGroupDraft(count: 4, namePrefix: 'Studio', price: 90000),
            UnitGroupDraft(count: 12, namePrefix: 'Chambre', price: 35000, photoKeys: groupPhotos),
          ],
        );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'lands in its group, and only its strip spins',
      setUp: () => stubUpload('room-1'),
      build: build,
      seed: () => AnnonceFormEditing(residence()),
      act: (bloc) => bloc.add(const AnnonceFormPhotoAdded(ImageSource.camera, group: 1)),
      expect: () => [
        AnnonceFormEditing(residence(), uploadingPhoto: true, uploadingGroup: 1),
        AnnonceFormEditing(residence(groupPhotos: ['room-1'])),
      ],
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'removes one of its photos by key, the residence\'s untouched',
      build: build,
      seed: () => AnnonceFormEditing(residence(groupPhotos: ['room-1', 'room-2'])),
      act: (bloc) => bloc.add(const AnnonceFormPhotoRemoved('room-1', group: 1)),
      expect: () => [AnnonceFormEditing(residence(groupPhotos: ['room-2']))],
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'refuses a sixteenth photo in a group',
      build: build,
      seed: () => AnnonceFormEditing(residence(groupPhotos: List.generate(15, (i) => 'room-$i'))),
      act: (bloc) => bloc.add(const AnnonceFormPhotoAdded(ImageSource.camera, group: 1)),
      expect: () => const <AnnonceFormState>[],
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'a group cannot be removed while its photo uploads — the photo would land on another',
      build: build,
      seed: () => AnnonceFormEditing(residence(), uploadingPhoto: true, uploadingGroup: 1),
      act: (bloc) => bloc.add(const AnnonceFormUnitGroupRemoved(0)),
      expect: () => const <AnnonceFormState>[],
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'one upload at a time',
      build: build,
      seed: () => AnnonceFormEditing(residence(), uploadingPhoto: true),
      act: (bloc) => bloc.add(const AnnonceFormPhotoAdded(ImageSource.camera, group: 1)),
      expect: () => const <AnnonceFormState>[],
      verify: (_) => verifyNever(
        () => uploader.captureAndUpload(source: any(named: 'source'), category: any(named: 'category')),
      ),
    );
  });

  // Regression: the photo landing put back the draft as it was when the upload
  // started, so whatever was typed meanwhile was silently dropped.
  test('what is typed while a photo uploads is kept when it lands', () async {
    final upload = Completer<String?>();
    when(() => uploader.captureAndUpload(source: any(named: 'source'), category: any(named: 'category')))
        .thenAnswer((_) => upload.future);

    final bloc = build()..emit(AnnonceFormEditing(completeSingle()));
    bloc
      ..add(const AnnonceFormPhotoAdded(ImageSource.camera))
      ..add(AnnonceFormChanged((d) => d.copyWith(description: 'Lumineux, au calme.')));
    await bloc.stream.firstWhere((s) => s is AnnonceFormEditing && s.draft.description != null);
    upload.complete('photo-1');
    final landed = await bloc.stream.firstWhere(
      (s) => s is AnnonceFormEditing && s.draft.photoKeys.isNotEmpty,
    ) as AnnonceFormEditing;

    expect(landed.draft.photoKeys, ['photo-1']);
    expect(landed.draft.description, 'Lumineux, au calme.');
    await bloc.close();
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
            UnitGroupDraft(count: 4, namePrefix: 'Chambre', price: 45000),
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
            UnitGroupDraft(count: 4, namePrefix: 'Chambre', price: 45000),
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
            UnitGroupDraft(count: 6, namePrefix: 'Studio', price: 60000),
          ),
        )
        ..add(const AnnonceFormUnitGroupRemoved(0)),
      expect: () => [
        AnnonceFormEditing(base.copyWith(units: const [UnitGroupDraft()])),
        AnnonceFormEditing(
          base.copyWith(
            units: const [
              UnitGroupDraft(count: 6, namePrefix: 'Studio', price: 60000),
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

  group('steps', () {
    test('a single listing walks five; a residence four — its rents are in its units', () {
      expect(const AnnonceDraft(kind: AnnonceKind.single).steps, AnnonceFormStep.values);
      expect(const AnnonceDraft(kind: AnnonceKind.residence).steps, [
        AnnonceFormStep.basics,
        AnnonceFormStep.place,
        AnnonceFormStep.details,
        AnnonceFormStep.media,
      ]);
    });

    test('each step asks for its own required fields; together, what saving needs', () {
      const empty = AnnonceDraft(kind: AnnonceKind.single);
      expect(empty.isStepComplete(AnnonceFormStep.basics), isFalse);
      expect(empty.copyWith(title: 'Studio').isStepComplete(AnnonceFormStep.basics), isTrue);
      expect(empty.isStepComplete(AnnonceFormStep.place), isFalse);
      expect(empty.copyWith(location: location).isStepComplete(AnnonceFormStep.place), isTrue);
      // What is inside is optional; the photos too, for a draft.
      expect(empty.isStepComplete(AnnonceFormStep.details), isTrue);
      expect(empty.isStepComplete(AnnonceFormStep.media), isTrue);
      expect(empty.copyWith(price: 120000).isStepComplete(AnnonceFormStep.rent), isFalse);
      expect(
        empty.copyWith(price: 120000, availableFrom: DateTime(2026, 9)).isStepComplete(AnnonceFormStep.rent),
        isTrue,
      );
      expect(completeSingle().steps.every(completeSingle().isStepComplete), completeSingle().canSave);

      final residence = const AnnonceDraft(kind: AnnonceKind.residence)
          .copyWith(units: const [UnitGroupDraft(namePrefix: 'Chambre', price: 45000)]);
      expect(residence.isStepComplete(AnnonceFormStep.details), isFalse, reason: 'its availability goes with its units');
      expect(residence.copyWith(availableFrom: DateTime(2026, 9)).isStepComplete(AnnonceFormStep.details), isTrue);
    });

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'creating: forward only past a step done, one at a time; back always',
      build: build,
      seed: () => const AnnonceFormEditing(AnnonceDraft(kind: AnnonceKind.single)),
      act: (bloc) => bloc
        // No title yet.
        ..add(const AnnonceFormStepRequested(AnnonceFormStep.place))
        ..add(AnnonceFormChanged((d) => d.copyWith(title: 'Studio Akwa')))
        // Not two steps at once.
        ..add(const AnnonceFormStepRequested(AnnonceFormStep.details))
        ..add(const AnnonceFormStepRequested(AnnonceFormStep.place))
        // No address yet.
        ..add(const AnnonceFormStepRequested(AnnonceFormStep.details))
        ..add(const AnnonceFormStepRequested(AnnonceFormStep.basics)),
      expect: () => [
        isA<AnnonceFormEditing>().having((s) => s.draft.title, 'title', 'Studio Akwa'),
        isA<AnnonceFormEditing>().having((s) => s.step, 'step', AnnonceFormStep.place),
        isA<AnnonceFormEditing>().having((s) => s.step, 'step', AnnonceFormStep.basics),
      ],
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'correcting: any step, straight away',
      build: build,
      seed: () => AnnonceFormEditing(completeSingle().copyWith(id: 'existing')),
      act: (bloc) => bloc.add(const AnnonceFormStepRequested(AnnonceFormStep.rent)),
      expect: () => [
        isA<AnnonceFormEditing>().having((s) => s.step, 'step', AnnonceFormStep.rent),
      ],
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'a residence has no rent step to go to',
      build: build,
      seed: () => const AnnonceFormEditing(
        AnnonceDraft(kind: AnnonceKind.residence, id: 'r'),
        step: AnnonceFormStep.details,
      ),
      act: (bloc) => bloc.add(const AnnonceFormStepRequested(AnnonceFormStep.rent)),
      expect: () => const <AnnonceFormState>[],
    );

    blocTest<AnnonceFormBloc, AnnonceFormState>(
      'saving stays on the step it was asked from',
      setUp: () => when(() => annonces.create(any())).thenAnswer(
        (_) async => const Annonce(
          id: 'new-1',
          title: 'Appartement à louer',
          status: AnnonceStatus.draft,
          propertyType: PropertyType.apartment,
        ),
      ),
      build: build,
      seed: () => AnnonceFormEditing(completeSingle(), step: AnnonceFormStep.media),
      act: (bloc) => bloc.add(const AnnonceFormSubmitted()),
      expect: () => [
        AnnonceFormSubmitting(completeSingle(), step: AnnonceFormStep.media),
        const AnnonceFormSaved(id: 'new-1', kind: AnnonceKind.single),
      ],
    );
  });
}
