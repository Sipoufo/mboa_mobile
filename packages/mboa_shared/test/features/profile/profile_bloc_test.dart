import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements ProfileRepository<BaseProfile, BaseProfileEdit> {}

class _MockUploader extends Mock implements MediaUploader {}

typedef _Bloc = ProfileBloc<BaseProfile, BaseProfileEdit>;
typedef _Ready = ProfileReady<BaseProfile>;

void main() {
  late _MockRepo repo;
  late _MockUploader uploader;

  const loaded = BaseProfile(firstName: 'Ydille', lastName: 'Fynem');
  const withPhoto = BaseProfile(firstName: 'Ydille', lastName: 'Fynem', photoObjectKey: 'k');

  setUpAll(() {
    registerFallbackValue(ImageSource.camera);
    registerFallbackValue(CreateUploadRequestCategoryEnum.PROFILE_PHOTO);
  });

  setUp(() {
    repo = _MockRepo();
    uploader = _MockUploader();
  });

  _Bloc build() => ProfileBloc(repository: repo, uploader: uploader);

  group('ProfilePhotoChangeRequested', () {
    blocTest<_Bloc, ProfileState>(
      'uploads then persists the new photo',
      setUp: () {
        when(() => uploader.captureAndUpload(
              source: any(named: 'source'),
              category: any(named: 'category'),
            )).thenAnswer((_) async => 'k');
        when(() => repo.updatePhoto(any())).thenAnswer((_) async => withPhoto);
      },
      build: build,
      seed: () => const _Ready(loaded),
      act: (bloc) => bloc.add(const ProfilePhotoChangeRequested(ImageSource.camera)),
      expect: () => const [
        _Ready(loaded, saving: true),
        _Ready(withPhoto, photoJustUpdated: true),
      ],
      verify: (_) => verify(() => repo.updatePhoto('k')).called(1),
    );

    blocTest<_Bloc, ProfileState>(
      'reverts (no persist) when the picker is cancelled',
      setUp: () => when(() => uploader.captureAndUpload(
            source: any(named: 'source'),
            category: any(named: 'category'),
          )).thenAnswer((_) async => null),
      build: build,
      seed: () => const _Ready(loaded),
      act: (bloc) => bloc.add(const ProfilePhotoChangeRequested(ImageSource.gallery)),
      expect: () => const [_Ready(loaded, saving: true), _Ready(loaded)],
      verify: (_) => verifyNever(() => repo.updatePhoto(any())),
    );

    blocTest<_Bloc, ProfileState>(
      'flags photoFailed when the upload throws',
      setUp: () => when(() => uploader.captureAndUpload(
            source: any(named: 'source'),
            category: any(named: 'category'),
          )).thenThrow(Exception('network')),
      build: build,
      seed: () => const _Ready(loaded),
      act: (bloc) => bloc.add(const ProfilePhotoChangeRequested(ImageSource.camera)),
      expect: () => const [_Ready(loaded, saving: true), _Ready(loaded, photoFailed: true)],
    );
  });
}
