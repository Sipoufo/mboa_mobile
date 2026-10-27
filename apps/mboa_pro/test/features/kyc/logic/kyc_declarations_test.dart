import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/kyc/data/kyc_repository.dart';
import 'package:mboa_pro/features/kyc/logic/kyc_cubit.dart';
import 'package:mboa_pro/features/kyc/models/kyc_draft.dart';
import 'package:mboa_pro/features/kyc/models/kyc_status.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockKycApi extends Mock implements KYCApi {}

class _FakeSubmit extends Fake implements SubmitKycRequest {}

/// §37 B — the NUI and the address, beside the documents (RM-M01bis-10/11).
void main() {
  const akwa = DeclaredAddress(districtId: 'd-akwa', city: 'Douala', district: 'Akwa', details: 'Derrière la pharmacie');
  const complete = KycDraft(selfieKey: 's', idFrontKey: 'f', idBackKey: 'b');

  setUpAll(() => registerFallbackValue(_FakeSubmit()));

  group('the NUI as typed', () {
    test('spaces dropped, letters upper-cased; 14 letters and digits', () {
      expect(KycDraft.normalizeNui(' m0123 4567 8901x '), 'M012345678901X');
      expect(KycDraft.normalizeNui('   '), isNull);
      expect(KycDraft.isValidNui('M012345678901X'), isTrue);
      expect(KycDraft.isValidNui('M0123'), isFalse);
      expect(KycDraft.isValidNui('M012345678901X9'), isFalse);
    });

    test('an agence or a promoteur cannot send without one; a particulier can', () {
      expect(complete.canSubmit(nuiRequired: false), isTrue);
      expect(complete.canSubmit(nuiRequired: true), isFalse);
      expect(complete.withNui('M0123 4567 8901X').canSubmit(nuiRequired: true), isTrue);
      // Typed, it has to read as a NUI, whoever types it.
      expect(complete.withNui('M0123').canSubmit(nuiRequired: false), isFalse);
    });
  });

  group('the cubit', () {
    late MockKycRepository repository;

    setUp(() {
      repository = MockKycRepository();
      when(() => repository.submit(
            selfieKey: any(named: 'selfieKey'),
            idFrontKey: any(named: 'idFrontKey'),
            idBackKey: any(named: 'idBackKey'),
            nui: any(named: 'nui'),
            address: any(named: 'address'),
          )).thenAnswer((_) async => const KycStatusData(status: KycStatus.pending, nui: 'M012345678901X', address: akwa));
    });

    KycCubit build() => KycCubit(repository: repository, uploader: MockMediaUploader());

    blocTest<KycCubit, KycState>(
      'after a refusal, the form starts from what was declared',
      setUp: () => when(repository.loadStatus).thenAnswer(
        (_) async => const KycStatusData(status: KycStatus.rejected, nui: 'M012345678901X', address: akwa),
      ),
      build: build,
      act: (cubit) => cubit.load(),
      verify: (cubit) {
        final draft = (cubit.state as KycReady).draft;
        expect((draft.nui, draft.address), ('M012345678901X', akwa));
      },
    );

    blocTest<KycCubit, KycState>(
      'sends the NUI as the server reads it, and the address',
      build: build,
      seed: () => KycReady(const KycStatusData(status: KycStatus.notSubmitted), complete.withNui('m0123 4567 8901x').withAddress(akwa)),
      act: (cubit) => cubit.submit(),
      verify: (_) => verify(() => repository.submit(
            selfieKey: 's',
            idFrontKey: 'f',
            idBackKey: 'b',
            nui: 'M012345678901X',
            address: akwa,
          )).called(1),
    );

    blocTest<KycCubit, KycState>(
      'a malformed NUI is said before anything is sent',
      build: build,
      seed: () => KycReady(const KycStatusData(status: KycStatus.notSubmitted), complete.withNui('M0123')),
      act: (cubit) => cubit.submit(),
      expect: () => [
        KycReady(const KycStatusData(status: KycStatus.notSubmitted), complete.withNui('M0123'), error: KycError.invalidNui),
      ],
      verify: (_) => verifyNever(() => repository.submit(
            selfieKey: any(named: 'selfieKey'),
            idFrontKey: any(named: 'idFrontKey'),
            idBackKey: any(named: 'idBackKey'),
            nui: any(named: 'nui'),
            address: any(named: 'address'),
          )),
    );

    blocTest<KycCubit, KycState>(
      'NUI_REQUIRED is said as such',
      setUp: () => when(() => repository.submit(
            selfieKey: any(named: 'selfieKey'),
            idFrontKey: any(named: 'idFrontKey'),
            idBackKey: any(named: 'idBackKey'),
            nui: any(named: 'nui'),
            address: any(named: 'address'),
          )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/kyc'),
        response: Response(requestOptions: RequestOptions(path: '/kyc'), statusCode: 400, data: {'error': 'NUI_REQUIRED'}),
      )),
      build: build,
      seed: () => const KycReady(KycStatusData(status: KycStatus.notSubmitted), complete),
      act: (cubit) => cubit.submit(),
      verify: (cubit) => expect((cubit.state as KycReady).error, KycError.nuiRequired),
    );

    blocTest<KycCubit, KycState>(
      'RM-M01bis-10 — an approved KYC receives its NUI without a new review',
      setUp: () => when(() => repository.addNui('M012345678901X')).thenAnswer(
        (_) async => const KycStatusData(status: KycStatus.approved, nui: 'M012345678901X'),
      ),
      build: build,
      seed: () => const KycReady(KycStatusData(status: KycStatus.approved), KycDraft()),
      act: (cubit) => cubit.addNui('m0123 4567 8901x'),
      verify: (cubit) {
        final state = cubit.state as KycReady;
        expect(state.status.nui, 'M012345678901X');
        expect(state.status.canAddNui, isFalse);
      },
    );
  });

  test('the wire: the address goes as a district and a landmark, and comes back named', () async {
    final dioClient = MockDioClient();
    final apiClient = MockApiClient();
    final api = MockKycApi();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getKYCApi).thenReturn(api);
    when(() => api.submitKyc(submitKycRequest: any(named: 'submitKycRequest'))).thenAnswer(
      (_) async => Response(
        data: KycStatusResponse((b) => b
          ..status = 'PENDING'
          ..nui = 'M012345678901X'
          ..address.districtId = 'd-akwa'
          ..address.city = 'Douala'
          ..address.district = 'Akwa'),
        requestOptions: RequestOptions(path: '/kyc'),
        statusCode: 200,
      ),
    );

    final status = await KycRepository(dioClient: dioClient).submit(
      selfieKey: 's',
      idFrontKey: 'f',
      idBackKey: 'b',
      nui: 'M012345678901X',
      address: const DeclaredAddress(districtId: 'd-akwa', details: '  '),
    );

    final sent = verify(() => api.submitKyc(submitKycRequest: captureAny(named: 'submitKycRequest'))).captured.single
        as SubmitKycRequest;
    expect((sent.nui, sent.address?.districtId, sent.address?.details), ('M012345678901X', 'd-akwa', null));
    expect(status.address, const DeclaredAddress(districtId: 'd-akwa', city: 'Douala', district: 'Akwa'));
  });
}
