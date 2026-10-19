import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/reservations/bloc/my_reservations_bloc.dart';
import 'package:mboa_user/features/reservations/bloc/reservation_bloc.dart';
import 'package:mboa_user/features/reservations/bloc/reservation_request_bloc.dart';
import 'package:mboa_user/features/reservations/data/reservations_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockReservationsRepository extends Mock implements ReservationsRepository {}

/// CDC M29 — the tenant's three reservation screens, bloc by bloc.
void main() {
  late MockReservationsRepository repository;

  const pending = Reservation(id: 'r-1', status: ReservationStatus.pending, annonceTitle: 'Studio', canCancel: true);
  const cancelled = Reservation(id: 'r-1', status: ReservationStatus.cancelled, annonceTitle: 'Studio');
  final start = DateTime(2026, 11, 1);

  setUp(() => repository = MockReservationsRepository());

  group('ReservationRequestBloc', () {
    ReservationRequestSubmitted submitted() =>
        ReservationRequestSubmitted(annonceId: 'a-1', start: start, units: 6, message: 'Bonjour');

    void answers(Future<Reservation> Function() answer) => when(
          () => repository.request(
            annonceId: any(named: 'annonceId'),
            start: any(named: 'start'),
            units: any(named: 'units'),
            message: any(named: 'message'),
          ),
        ).thenAnswer((_) => answer());

    blocTest<ReservationRequestBloc, ReservationRequestState>(
      'sends what was chosen, and hands the request on',
      setUp: () => answers(() async => pending),
      build: () => ReservationRequestBloc(repository: repository),
      act: (bloc) => bloc.add(submitted()),
      expect: () => const [ReservationRequestSubmitting(), ReservationRequestSent(pending)],
      verify: (_) => verify(
        () => repository.request(annonceId: 'a-1', start: start, units: 6, message: 'Bonjour'),
      ).called(1),
    );

    blocTest<ReservationRequestBloc, ReservationRequestState>(
      'CE-M29-02 — an incomplete profile is a reason, not a failure',
      setUp: () => answers(() async => throw const ReservationRequestRefused(RequestRefusal.profileIncomplete)),
      build: () => ReservationRequestBloc(repository: repository),
      act: (bloc) => bloc.add(submitted()),
      expect: () => const [
        ReservationRequestSubmitting(),
        ReservationRequestRefusedState(RequestRefusal.profileIncomplete),
      ],
    );

    blocTest<ReservationRequestBloc, ReservationRequestState>(
      'anything else is a failure the form survives',
      setUp: () => answers(() async => throw Exception('offline')),
      build: () => ReservationRequestBloc(repository: repository),
      act: (bloc) => bloc.add(submitted()),
      expect: () => const [ReservationRequestSubmitting(), ReservationRequestFailed()],
    );

    blocTest<ReservationRequestBloc, ReservationRequestState>(
      'a second tap while sending sends nothing more',
      setUp: () => answers(() async => pending),
      build: () => ReservationRequestBloc(repository: repository),
      seed: () => const ReservationRequestSubmitting(),
      act: (bloc) => bloc.add(submitted()),
      expect: () => const <ReservationRequestState>[],
      verify: (_) => verifyNever(
        () => repository.request(
          annonceId: any(named: 'annonceId'),
          start: any(named: 'start'),
          units: any(named: 'units'),
          message: any(named: 'message'),
        ),
      ),
    );
  });

  group('MyReservationsBloc', () {
    blocTest<MyReservationsBloc, MyReservationsState>(
      'reads the list',
      setUp: () => when(repository.mine).thenAnswer((_) async => const MyReservationsPage([pending])),
      build: () => MyReservationsBloc(repository: repository),
      act: (bloc) => bloc.add(const MyReservationsRequested()),
      expect: () => const [MyReservationsLoading(), MyReservationsReady(items: [pending])],
    );

    blocTest<MyReservationsBloc, MyReservationsState>(
      'offline, the copy — marked',
      setUp: () =>
          when(repository.mine).thenAnswer((_) async => const MyReservationsPage([pending], fromCache: true)),
      build: () => MyReservationsBloc(repository: repository),
      act: (bloc) => bloc.add(const MyReservationsRequested()),
      expect: () => const [MyReservationsLoading(), MyReservationsReady(items: [pending], isOffline: true)],
    );

    blocTest<MyReservationsBloc, MyReservationsState>(
      'nothing at all is a failure',
      setUp: () => when(repository.mine).thenThrow(Exception('offline')),
      build: () => MyReservationsBloc(repository: repository),
      act: (bloc) => bloc.add(const MyReservationsRequested()),
      expect: () => const [MyReservationsLoading(), MyReservationsFailure()],
    );

    blocTest<MyReservationsBloc, MyReservationsState>(
      'a refresh keeps the list on screen, and a failed one leaves it there',
      setUp: () => when(repository.mine).thenThrow(Exception('offline')),
      build: () => MyReservationsBloc(repository: repository),
      seed: () => const MyReservationsReady(items: [pending]),
      act: (bloc) => bloc.add(const MyReservationsRequested()),
      expect: () => const <MyReservationsState>[],
    );
  });

  group('ReservationBloc', () {
    blocTest<ReservationBloc, ReservationState>(
      'reads one request',
      setUp: () => when(() => repository.get('r-1')).thenAnswer((_) async => pending),
      build: () => ReservationBloc(repository: repository),
      act: (bloc) => bloc.add(const ReservationRequested('r-1')),
      expect: () => const [ReservationLoading(), ReservationReady(pending)],
    );

    blocTest<ReservationBloc, ReservationState>(
      'a failed read can be retried by id',
      setUp: () => when(() => repository.get('r-1')).thenThrow(Exception('offline')),
      build: () => ReservationBloc(repository: repository),
      act: (bloc) => bloc.add(const ReservationRequested('r-1')),
      expect: () => const [ReservationLoading(), ReservationFailure('r-1')],
    );

    blocTest<ReservationBloc, ReservationState>(
      'RM-M29-08 — cancelling, busy then the server\'s answer',
      setUp: () => when(() => repository.cancel('r-1')).thenAnswer((_) async => cancelled),
      build: () => ReservationBloc(repository: repository),
      seed: () => const ReservationReady(pending),
      act: (bloc) => bloc.add(const ReservationCancelRequested()),
      expect: () => const [ReservationReady(pending, isBusy: true), ReservationReady(cancelled)],
    );

    blocTest<ReservationBloc, ReservationState>(
      'a failed cancellation keeps the request, and says so once',
      setUp: () => when(() => repository.cancel('r-1')).thenThrow(Exception('offline')),
      build: () => ReservationBloc(repository: repository),
      seed: () => const ReservationReady(pending),
      act: (bloc) => bloc.add(const ReservationCancelRequested()),
      expect: () => const [ReservationReady(pending, isBusy: true), ReservationReady(pending, failed: true)],
    );

    blocTest<ReservationBloc, ReservationState>(
      'the server did not offer it: nothing is sent',
      build: () => ReservationBloc(repository: repository),
      seed: () => const ReservationReady(cancelled),
      act: (bloc) => bloc.add(const ReservationCancelRequested()),
      expect: () => const <ReservationState>[],
      verify: (_) => verifyNever(() => repository.cancel(any())),
    );
  });
}
