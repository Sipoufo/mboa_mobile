import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/contracts/bloc/contract_detail_bloc.dart';
import 'package:mboa_pro/features/contracts/bloc/contract_form_bloc.dart';
import 'package:mboa_pro/features/contracts/bloc/contracts_bloc.dart';
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

/// The Contrat Mboa (CDC M08).
void main() {
  late MockContractRepository repository;

  setUpAll(() => registerFallbackValue(const ContractTerms()));

  setUp(() => repository = MockContractRepository());

  group('the list', () {
    ContractsBloc build() => ContractsBloc(repository: repository);

    blocTest<ContractsBloc, ContractsState>(
      'RM-M08-09 — "à vous de jouer" filters on awaiting, not on status',
      setUp: () => when(() => repository.list()).thenAnswer(
        (_) async => [
          contract(id: 'mine', awaiting: ContractParty.prestataire),
          contract(id: 'both', awaiting: ContractParty.both),
          contract(id: 'theirs'),
        ],
      ),
      build: build,
      act: (bloc) => bloc
        ..add(const ContractsLoadRequested())
        ..add(const ContractsFilterChanged(ContractFilter.awaitingMe())),
      verify: (bloc) {
        final state = bloc.state as ContractsReady;
        // BOTH counts: two signatures pending means he owes one of them.
        expect(state.visible.map((c) => c.id), ['mine', 'both']);
        expect(state.awaitingMeCount, 2);
      },
    );

    blocTest<ContractsBloc, ContractsState>(
      'a failed refresh keeps what is on screen',
      setUp: () => when(() => repository.list()).thenThrow(Exception('offline')),
      build: build,
      seed: () => ContractsReady(items: [contract()]),
      act: (bloc) => bloc.add(const ContractsRefreshRequested()),
      verify: (bloc) =>
          expect((bloc.state as ContractsReady).items, hasLength(1)),
    );
  });

  group('one contract', () {
    ContractDetailBloc build() => ContractDetailBloc(repository: repository);

    blocTest<ContractDetailBloc, ContractDetailState>(
      'sending replaces the contract with the server\'s version',
      setUp: () => when(() => repository.send('c-1')).thenAnswer(
        (_) async => contract(status: ContractStatus.sent),
      ),
      build: build,
      seed: () => ContractDetailReady(
        contract(status: ContractStatus.draft, awaiting: ContractParty.prestataire),
      ),
      act: (bloc) => bloc.add(const ContractSent()),
      verify: (bloc) {
        final state = bloc.state as ContractDetailReady;
        // `status` and `awaiting` are the server's verdicts (RM-M08-09); a
        // locally patched status would be a second source of truth.
        expect(state.contract.status, ContractStatus.sent);
        expect(state.justActed, isTrue);
      },
    );

    blocTest<ContractDetailBloc, ContractDetailState>(
      'CE-M08-03 — an empty answer to an objection is not sent',
      build: build,
      seed: () => ContractDetailReady(
        contract(
          status: ContractStatus.changesRequested,
          changes: const [ChangeRequest(id: 'ch-1', pending: true)],
        ),
      ),
      act: (bloc) =>
          bloc.add(const ContractChangeAnswered(changeId: 'ch-1', body: '   ')),
      verify: (_) => verifyNever(
        () => repository.respondToChange(
          any(),
          changeId: any(named: 'changeId'),
          body: any(named: 'body'),
        ),
      ),
    );

    blocTest<ContractDetailBloc, ContractDetailState>(
      'CE-M08-03 — a refusal is an answer and goes through trimmed',
      setUp: () => when(
        () => repository.respondToChange(
          'c-1',
          changeId: 'ch-1',
          body: 'La caution ne bouge pas.',
        ),
      ).thenAnswer((_) async => contract(status: ContractStatus.sent)),
      build: build,
      seed: () => ContractDetailReady(
        contract(
          status: ContractStatus.changesRequested,
          changes: const [ChangeRequest(id: 'ch-1', pending: true)],
        ),
      ),
      act: (bloc) => bloc.add(
        const ContractChangeAnswered(
          changeId: 'ch-1',
          body: '  La caution ne bouge pas.  ',
        ),
      ),
      verify: (_) => verify(
        () => repository.respondToChange(
          'c-1',
          changeId: 'ch-1',
          body: 'La caution ne bouge pas.',
        ),
      ).called(1),
    );

    blocTest<ContractDetailBloc, ContractDetailState>(
      'a refused action leaves the contract as it was',
      setUp: () => when(() => repository.sign(any())).thenThrow(Exception('409')),
      build: build,
      seed: () => ContractDetailReady(contract(canSign: true)),
      act: (bloc) => bloc.add(const ContractSigned()),
      verify: (bloc) {
        final state = bloc.state as ContractDetailReady;
        expect(state.lastActionFailed, isTrue);
        expect(state.contract.status, ContractStatus.sent);
      },
    );

    blocTest<ContractDetailBloc, ContractDetailState>(
      'CA-M08-01 — the PDF link is carried once, not stored',
      setUp: () => when(() => repository.pdfUrl('c-1'))
          .thenAnswer((_) async => 'https://r2/signed.pdf'),
      build: build,
      seed: () => ContractDetailReady(contract(status: ContractStatus.signed)),
      act: (bloc) => bloc.add(const ContractPdfRequested()),
      verify: (bloc) => expect(
        (bloc.state as ContractDetailReady).pdfUrl,
        'https://r2/signed.pdf',
      ),
    );

    blocTest<ContractDetailBloc, ContractDetailState>(
      'cancelling ends the screen rather than showing a dead contract',
      setUp: () => when(() => repository.cancel('c-1')).thenAnswer((_) async {}),
      build: build,
      seed: () => ContractDetailReady(contract()),
      act: (bloc) => bloc.add(const ContractCancelled()),
      verify: (bloc) => expect(bloc.state, isA<ContractWasCancelled>()),
    );
  });

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
