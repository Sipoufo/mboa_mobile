import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';


class MockKycRepository extends Mock implements KycRepository {}

class MockMediaUploader extends Mock implements MediaUploader {}

void main() {
  late MockKycRepository repository;
  late MockMediaUploader uploader;

  const notSubmitted = KycStatusData(status: KycStatus.notSubmitted);
  const pending = KycStatusData(status: KycStatus.pending);

  setUpAll(() {
    registerFallbackValue(CreateUploadRequestCategoryEnum.KYC_DOCUMENT);
    registerFallbackValue(ImageSource.camera);
    registerFallbackValue(const DocumentIdentity());
  });

  setUp(() {
    repository = MockKycRepository();
    uploader = MockMediaUploader();
  });

  KycCubit build() => KycCubit(repository: repository, uploader: uploader);

  group('KycStatusX.parse', () {
    test('maps backend vocabulary defensively', () {
      expect(KycStatusX.parse(null), KycStatus.notSubmitted);
      expect(KycStatusX.parse('NOT_SUBMITTED'), KycStatus.notSubmitted);
      expect(KycStatusX.parse('pending'), KycStatus.pending);
      expect(KycStatusX.parse('APPROVED'), KycStatus.approved);
      expect(KycStatusX.parse('REJECTED'), KycStatus.rejected);
    });
  });

  group('load', () {
    blocTest<KycCubit, KycState>(
      'emits [loading, ready] on success',
      setUp: () => when(repository.loadStatus).thenAnswer((_) async => notSubmitted),
      build: build,
      act: (cubit) => cubit.load(),
      expect: () => const [KycLoadInProgress(), KycReady(notSubmitted, KycDraft())],
    );

    blocTest<KycCubit, KycState>(
      'emits [loading, failure] when the load throws',
      setUp: () => when(repository.loadStatus).thenThrow(Exception('boom')),
      build: build,
      act: (cubit) => cubit.load(),
      expect: () => const [KycLoadInProgress(), KycLoadFailure()],
    );
  });

  group('capture', () {
    blocTest<KycCubit, KycState>(
      'stores the uploaded key for the slot',
      setUp: () => when(
        () => uploader.captureAndUpload(source: any(named: 'source'), category: any(named: 'category')),
      ).thenAnswer((_) async => 'selfie_key'),
      build: build,
      seed: () => const KycReady(notSubmitted, KycDraft()),
      act: (cubit) => cubit.capture(KycSlot.selfie, ImageSource.camera),
      expect: () => const [
        KycReady(notSubmitted, KycDraft(), uploading: KycSlot.selfie),
        KycReady(notSubmitted, KycDraft(selfieKey: 'selfie_key')),
      ],
    );

    blocTest<KycCubit, KycState>(
      'surfaces an upload error',
      setUp: () => when(
        () => uploader.captureAndUpload(source: any(named: 'source'), category: any(named: 'category')),
      ).thenThrow(Exception('network')),
      build: build,
      seed: () => const KycReady(notSubmitted, KycDraft()),
      act: (cubit) => cubit.capture(KycSlot.selfie, ImageSource.camera),
      expect: () => const [
        KycReady(notSubmitted, KycDraft(), uploading: KycSlot.selfie),
        KycReady(notSubmitted, KycDraft(), error: KycError.uploadFailed),
      ],
    );
  });

  group('submit', () {
    final doc = DocumentIdentity(
      type: KycDocType.cni,
      number: 'CM1234567',
      issuedOn: DateTime(2020, 3, 1),
      expiresOn: DateTime(2035, 3, 1),
      issuedAt: 'Douala',
    );
    final complete = KycDraft(selfieKey: 's', idFrontKey: 'f', idBackKey: 'b', identity: doc);

    blocTest<KycCubit, KycState>(
      'submits the complete draft and reflects the new status',
      setUp: () => when(
        () => repository.submit(
          selfieKey: any(named: 'selfieKey'),
          idFrontKey: any(named: 'idFrontKey'),
          idBackKey: any(named: 'idBackKey'),
          identity: any(named: 'identity'),
        ),
      ).thenAnswer((_) async => pending),
      build: build,
      seed: () => KycReady(notSubmitted, complete),
      act: (cubit) => cubit.submit(),
      expect: () => [
        KycReady(notSubmitted, complete, submitting: true),
        const KycReady(pending, KycDraft(), justSubmitted: true),
      ],
      verify: (_) => verify(
        () => repository.submit(selfieKey: 's', idFrontKey: 'f', idBackKey: 'b', identity: doc),
      ).called(1),
    );

    blocTest<KycCubit, KycState>(
      'does nothing when the draft is incomplete',
      build: build,
      seed: () => const KycReady(notSubmitted, KycDraft(selfieKey: 's')),
      act: (cubit) => cubit.submit(),
      expect: () => const <KycState>[],
    );
  });
}
