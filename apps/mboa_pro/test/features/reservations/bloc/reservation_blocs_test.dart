import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/annonces/data/annonce_repository.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/reservations/bloc/incoming_reservation_bloc.dart';
import 'package:mboa_pro/features/reservations/bloc/incoming_reservations_bloc.dart';
import 'package:mboa_pro/features/reservations/bloc/pending_reservations_bloc.dart';
import 'package:mboa_pro/features/reservations/data/incoming_reservations_repository.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockIncomingReservationsRepository extends Mock implements IncomingReservationsRepository {}

class MockAnnonceRepository extends Mock implements AnnonceRepository {}

class MockContractRepository extends Mock implements ContractRepository {}

/// CDC M29 — the prestataire's side, bloc by bloc.
void main() {
  late MockIncomingReservationsRepository repository;
  late MockAnnonceRepository annonces;
  late MockContractRepository contracts;

  const pending = Reservation(
    id: 'r-1',
    status: ReservationStatus.pending,
    annonceId: 'a-1',
    canAccept: true,
    canRefuse: true,
  );
  const accepted = Reservation(
    id: 'r-1',
    status: ReservationStatus.accepted,
    annonceId: 'a-1',
    canExtend: true,
    canCancel: true,
    canDraftContract: true,
  );
  const refused = Reservation(
    id: 'r-1',
    status: ReservationStatus.refused,
    annonceId: 'a-1',
    ownerReason: RefusalReason.other,
  );
  const listing = Annonce(
    id: 'a-1',
    title: 'Studio',
    status: AnnonceStatus.published,
    propertyType: PropertyType.studio,
    price: 110000,
  );

  setUp(() {
    repository = MockIncomingReservationsRepository();
    annonces = MockAnnonceRepository();
    contracts = MockContractRepository();
    when(() => contracts.list()).thenAnswer((_) async => const []);
  });

  group('IncomingReservationsBloc', () {
    blocTest<IncomingReservationsBloc, IncomingReservationsState>(
      'reads one listing\'s requests when built with it',
      setUp: () => when(() => repository.list(annonceId: 'a-1'))
          .thenAnswer((_) async => const IncomingReservations([pending, refused])),
      build: () => IncomingReservationsBloc(repository: repository, annonceId: 'a-1'),
      act: (bloc) => bloc.add(const IncomingReservationsRequested()),
      expect: () => const [
        IncomingReservationsLoading(),
        IncomingReservationsReady(items: [pending, refused]),
      ],
      verify: (bloc) => expect((bloc.state as IncomingReservationsReady).pending, [pending]),
    );

    blocTest<IncomingReservationsBloc, IncomingReservationsState>(
      'offline, the copy — marked',
      setUp: () => when(() => repository.list())
          .thenAnswer((_) async => const IncomingReservations([pending], fromCache: true)),
      build: () => IncomingReservationsBloc(repository: repository),
      act: (bloc) => bloc.add(const IncomingReservationsRequested()),
      expect: () => const [IncomingReservationsLoading(), IncomingReservationsReady(items: [pending], isOffline: true)],
    );

    blocTest<IncomingReservationsBloc, IncomingReservationsState>(
      'nothing at all is a failure; a failed refresh keeps the list',
      setUp: () => when(() => repository.list()).thenThrow(Exception('offline')),
      build: () => IncomingReservationsBloc(repository: repository),
      act: (bloc) => bloc.add(const IncomingReservationsRequested()),
      expect: () => const [IncomingReservationsLoading(), IncomingReservationsFailure()],
    );
  });

  group('PendingReservationsBloc', () {
    blocTest<PendingReservationsBloc, PendingReservationsState>(
      'counts what waits',
      setUp: () => when(() => repository.pendingCount()).thenAnswer((_) async => 3),
      build: () => PendingReservationsBloc(repository: repository),
      act: (bloc) => bloc.add(const PendingReservationsRequested()),
      expect: () => const [PendingReservationsCounted(3)],
    );

    blocTest<PendingReservationsBloc, PendingReservationsState>(
      'a failed read keeps the last count',
      setUp: () => when(() => repository.pendingCount()).thenThrow(Exception('offline')),
      build: () => PendingReservationsBloc(repository: repository),
      seed: () => const PendingReservationsCounted(3),
      act: (bloc) => bloc.add(const PendingReservationsRequested()),
      expect: () => const <PendingReservationsState>[],
    );
  });

  group('IncomingReservationBloc', () {
    IncomingReservationBloc build() =>
        IncomingReservationBloc(repository: repository, annonces: annonces, contracts: contracts);

    blocTest<IncomingReservationBloc, IncomingReservationState>(
      'reads the request, its listing and the others waiting on it',
      setUp: () {
        when(() => repository.get('r-1')).thenAnswer((_) async => pending);
        when(() => annonces.getOne('a-1')).thenAnswer((_) async => listing);
        when(() => repository.pendingCount(annonceId: 'a-1')).thenAnswer((_) async => 4);
      },
      build: build,
      act: (bloc) => bloc.add(const IncomingReservationRequested('r-1')),
      // Four waiting, this one among them.
      expect: () => const [
        IncomingReservationLoading(),
        IncomingReservationReady(pending, listing: listing, otherPending: 3),
      ],
    );

    blocTest<IncomingReservationBloc, IncomingReservationState>(
      'the listing and the count are best-effort: the request stands alone',
      setUp: () {
        when(() => repository.get('r-1')).thenAnswer((_) async => pending);
        when(() => annonces.getOne('a-1')).thenThrow(Exception('gone'));
        when(() => repository.pendingCount(annonceId: 'a-1')).thenThrow(Exception('offline'));
      },
      build: build,
      act: (bloc) => bloc.add(const IncomingReservationRequested('r-1')),
      expect: () => const [IncomingReservationLoading(), IncomingReservationReady(pending)],
    );

    blocTest<IncomingReservationBloc, IncomingReservationState>(
      'RM-M08-10 — a contract already drawn up from it is found, to be opened rather than drawn again',
      setUp: () {
        when(() => repository.get('r-1')).thenAnswer((_) async => accepted);
        when(() => annonces.getOne('a-1')).thenAnswer((_) async => listing);
        when(() => repository.pendingCount(annonceId: 'a-1')).thenAnswer((_) async => 0);
        when(() => contracts.list()).thenAnswer(
          (_) async => const [
            // Another request's, and a cancelled one of this request's: neither.
            Contract(id: 'c-0', status: ContractStatus.draft, reservationRequestId: 'r-9'),
            Contract(id: 'c-1', status: ContractStatus.cancelled, reservationRequestId: 'r-1'),
            Contract(id: 'c-2', status: ContractStatus.draft, reservationRequestId: 'r-1'),
          ],
        );
      },
      build: build,
      act: (bloc) => bloc.add(const IncomingReservationRequested('r-1')),
      expect: () => const [
        IncomingReservationLoading(),
        IncomingReservationReady(accepted, listing: listing, contractId: 'c-2'),
      ],
    );

    blocTest<IncomingReservationBloc, IncomingReservationState>(
      'a waiting request has no contract to look for',
      setUp: () {
        when(() => repository.get('r-1')).thenAnswer((_) async => pending);
        when(() => annonces.getOne('a-1')).thenAnswer((_) async => listing);
        when(() => repository.pendingCount(annonceId: 'a-1')).thenAnswer((_) async => 1);
      },
      build: build,
      act: (bloc) => bloc.add(const IncomingReservationRequested('r-1')),
      verify: (_) => verifyNever(() => contracts.list()),
    );

    blocTest<IncomingReservationBloc, IncomingReservationState>(
      'no request, a failure that can be retried by id',
      setUp: () => when(() => repository.get('r-1')).thenThrow(Exception('offline')),
      build: build,
      act: (bloc) => bloc.add(const IncomingReservationRequested('r-1')),
      expect: () => const [IncomingReservationLoading(), IncomingReservationFailure('r-1')],
    );

    blocTest<IncomingReservationBloc, IncomingReservationState>(
      'RM-M29-04 — accepting closes the others',
      setUp: () => when(() => repository.accept('r-1')).thenAnswer((_) async => accepted),
      build: build,
      seed: () => const IncomingReservationReady(pending, otherPending: 3),
      act: (bloc) => bloc.add(const IncomingReservationAccepted()),
      expect: () => const [
        IncomingReservationReady(pending, otherPending: 3, isBusy: true),
        IncomingReservationReady(accepted, done: ReservationDecision.accepted),
      ],
    );

    blocTest<IncomingReservationBloc, IncomingReservationState>(
      'RM-M29-06 — refusing sends the reason and the note',
      setUp: () => when(() => repository.refuse('r-1', reason: RefusalReason.other, note: 'Non'))
          .thenAnswer((_) async => refused),
      build: build,
      seed: () => const IncomingReservationReady(pending),
      act: (bloc) => bloc.add(const IncomingReservationRefused(reason: RefusalReason.other, note: 'Non')),
      expect: () => const [
        IncomingReservationReady(pending, isBusy: true),
        IncomingReservationReady(refused, done: ReservationDecision.refused),
      ],
    );

    blocTest<IncomingReservationBloc, IncomingReservationState>(
      'extending and cancelling, when the server offers them',
      setUp: () {
        when(() => repository.extend('r-1')).thenAnswer((_) async => accepted);
      },
      build: build,
      seed: () => const IncomingReservationReady(accepted),
      act: (bloc) => bloc.add(const IncomingReservationExtended()),
      expect: () => const [
        IncomingReservationReady(accepted, isBusy: true),
        IncomingReservationReady(accepted, done: ReservationDecision.extended),
      ],
    );

    blocTest<IncomingReservationBloc, IncomingReservationState>(
      'what the server did not offer is not sent',
      build: build,
      seed: () => const IncomingReservationReady(refused),
      act: (bloc) => bloc
        ..add(const IncomingReservationAccepted())
        ..add(const IncomingReservationExtended())
        ..add(const IncomingReservationCancelled(reason: RefusalReason.other)),
      expect: () => const <IncomingReservationState>[],
      verify: (_) {
        verifyNever(() => repository.accept(any()));
        verifyNever(() => repository.extend(any()));
      },
    );

    blocTest<IncomingReservationBloc, IncomingReservationState>(
      'turned down by the server: said once, and the request shown as it now stands',
      setUp: () {
        when(() => repository.accept('r-1')).thenThrow(const ReservationDecisionRefused(DecisionRefusal.closed));
        when(() => repository.get('r-1')).thenAnswer((_) async => refused);
      },
      build: build,
      seed: () => const IncomingReservationReady(pending),
      act: (bloc) => bloc.add(const IncomingReservationAccepted()),
      expect: () => const [
        IncomingReservationReady(pending, isBusy: true),
        IncomingReservationReady(refused, refusal: DecisionRefusal.closed),
      ],
    );

    blocTest<IncomingReservationBloc, IncomingReservationState>(
      'a failed answer keeps the request and says so',
      setUp: () => when(() => repository.accept('r-1')).thenThrow(Exception('offline')),
      build: build,
      seed: () => const IncomingReservationReady(pending),
      act: (bloc) => bloc.add(const IncomingReservationAccepted()),
      expect: () => const [
        IncomingReservationReady(pending, isBusy: true),
        IncomingReservationReady(pending, failed: true),
      ],
    );
  });
}
