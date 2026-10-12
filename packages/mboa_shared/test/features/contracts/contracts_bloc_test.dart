import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
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

/// The Contrat Mboa (CDC M08) — the blocs both apps drive.
///
/// They live in `mboa_shared` for the same reason [ContractRepository] does:
/// the landlord and the tenant call the same endpoints, and the server decides
/// who may do what. Drawing one up is the landlord's alone (RM-M08-01) and is
/// tested in `mboa_pro`.
void main() {
  late MockContractRepository repository;

  setUp(() => repository = MockContractRepository());

  group('the list', () {
    ContractsBloc build() => ContractsBloc(repository: repository);

    blocTest<ContractsBloc, ContractsState>(
      'RM-M08-09 — "à toi de jouer" filters on awaiting, not on status',
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

  // The two moves only a tenant makes. They go through the same bloc as the
  // landlord's: the server refuses what the caller may not do, so nothing here
  // branches on a role.
  group("the tenant's side", () {
    ContractDetailBloc build() => ContractDetailBloc(repository: repository);

    blocTest<ContractDetailBloc, ContractDetailState>(
      'RM-M08-02 — accepting takes the contract the server answers with',
      setUp: () => when(() => repository.accept('c-1')).thenAnswer(
        (_) async => contract(
          status: ContractStatus.accepted,
          awaiting: ContractParty.both,
          canSign: true,
        ),
      ),
      build: build,
      seed: () => ContractDetailReady(contract()),
      act: (bloc) => bloc.add(const ContractAccepted()),
      verify: (bloc) {
        final state = bloc.state as ContractDetailReady;
        // canSign is the server's (RM-M08-02); accepting must not be read here
        // as "signing is now open" without being told so.
        expect(state.contract.status, ContractStatus.accepted);
        expect(state.contract.canSign, isTrue);
        expect(state.justActed, isTrue);
      },
    );

    blocTest<ContractDetailBloc, ContractDetailState>(
      'CE-M08-03 — an objection with no words is not an objection',
      build: build,
      seed: () => ContractDetailReady(contract()),
      act: (bloc) => bloc.add(const ContractChangesRequested(comment: '   ')),
      verify: (_) => verifyNever(
        () => repository.requestChanges(
          any(),
          comment: any(named: 'comment'),
          terms: any(named: 'terms'),
        ),
      ),
    );

    blocTest<ContractDetailBloc, ContractDetailState>(
      'RM-M08-07 — the contested terms travel with the comment, trimmed',
      setUp: () => when(
        () => repository.requestChanges(
          'c-1',
          comment: 'La caution est trop haute.',
          terms: const [ContestedTerm.depositAmount],
        ),
      ).thenAnswer(
        (_) async => contract(
          status: ContractStatus.changesRequested,
          awaiting: ContractParty.prestataire,
        ),
      ),
      build: build,
      seed: () => ContractDetailReady(contract()),
      act: (bloc) => bloc.add(
        const ContractChangesRequested(
          comment: '  La caution est trop haute.  ',
          terms: [ContestedTerm.depositAmount],
        ),
      ),
      verify: (bloc) {
        verify(
          () => repository.requestChanges(
            'c-1',
            comment: 'La caution est trop haute.',
            terms: const [ContestedTerm.depositAmount],
          ),
        ).called(1);
        expect(
          (bloc.state as ContractDetailReady).contract.awaiting,
          ContractParty.prestataire,
        );
      },
    );

    blocTest<ContractDetailBloc, ContractDetailState>(
      'a refused acceptance leaves the contract where it was',
      setUp: () =>
          when(() => repository.accept(any())).thenThrow(Exception('409')),
      build: build,
      seed: () => ContractDetailReady(contract()),
      act: (bloc) => bloc.add(const ContractAccepted()),
      verify: (bloc) {
        final state = bloc.state as ContractDetailReady;
        expect(state.lastActionFailed, isTrue);
        expect(state.contract.status, ContractStatus.sent);
      },
    );
  });
}
