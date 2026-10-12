import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/contracts/bloc/contract_form_bloc.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockContractRepository extends Mock implements ContractRepository {}

Contract contract({
  String id = 'c-1',
  ContractStatus status = ContractStatus.sent,
  ContractParty awaiting = ContractParty.tenant,
  bool canSign = false,
  List<ChangeRequest> changes = const [],
}) =>
    Contract(
      id: id,
      status: status,
      annonceTitle: 'Studio Bonapriso',
      awaiting: awaiting,
      canSign: canSign,
      changeRequests: changes,
    );

/// Drawing a contract up — the landlord's alone (RM-M08-01), so it stays here
/// while the rest of M08 is shared.
void main() {
  late MockContractRepository repository;

  setUpAll(() => registerFallbackValue(const ContractTerms()));

  setUp(() => repository = MockContractRepository());

  group('drawing one up', () {
    ContractFormBloc build() => ContractFormBloc(repository: repository);

    final terms = ContractTerms(
      annonceId: 'a-1',
      tenantPhone: '+237690000000',
      price: 110000,
      depositAmount: 220000,
      startDate: DateTime(2026, 9, 1),
      durationUnits: 12,
    );

    blocTest<ContractFormBloc, ContractFormState>(
      'an incomplete draft is not sent',
      build: build,
      seed: () => const ContractFormState(
        terms: ContractTerms(annonceId: 'a-1'),
      ),
      act: (bloc) => bloc.add(const ContractFormSubmitted()),
      verify: (_) => verifyNever(() => repository.create(any())),
    );

    blocTest<ContractFormBloc, ContractFormState>(
      'CE-M08-01 — a tenant with no account is a wait, not an error',
      setUp: () => when(() => repository.create(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/contracts'),
          response: Response(
            requestOptions: RequestOptions(path: '/contracts'),
            statusCode: 404,
          ),
        ),
      ),
      build: build,
      seed: () => ContractFormState(terms: terms),
      act: (bloc) => bloc.add(const ContractFormSubmitted()),
      verify: (bloc) => expect(
        bloc.state.failure,
        ContractFormFailure.tenantHasNoAccount,
      ),
    );

    blocTest<ContractFormBloc, ContractFormState>(
      'RM-M08-08 — amending sends the terms to the contract, not a new one',
      setUp: () => when(() => repository.amend('c-1', any()))
          .thenAnswer((_) async => contract()),
      build: build,
      seed: () => ContractFormState(terms: terms, amendingId: 'c-1'),
      act: (bloc) => bloc.add(const ContractFormSubmitted()),
      verify: (_) {
        verify(() => repository.amend('c-1', any())).called(1);
        verifyNever(() => repository.create(any()));
      },
    );
  });
}
