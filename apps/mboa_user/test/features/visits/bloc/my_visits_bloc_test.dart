import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/visits/bloc/my_visits_bloc.dart';
import 'package:mboa_user/features/visits/data/visits_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockVisitsRepository extends Mock implements VisitsRepository {}

class MockVisitReviewRepository extends Mock implements VisitReviewRepository {}

/// The tenant's own visits (CDC M07).
void main() {
  late MockVisitsRepository repository;
  late MockVisitReviewRepository reviews;

  final now = DateTime(2026, 10, 1, 12);

  Visit visit(
    String id, {
    VisitStatus status = VisitStatus.scheduled,
    DateTime? at,
    VisitorKind kind = VisitorKind.agent,
    DateTime? visitorConfirmedAt,
    DateTime? clientConfirmedAt,
  }) =>
      Visit(
        id: id,
        status: status,
        annonceId: 'a-1',
        annonceTitle: 'Studio Bonapriso',
        scheduledAt: at,
        visitorKind: kind,
        visitorConfirmedAt: visitorConfirmedAt,
        clientConfirmedAt: clientConfirmedAt,
      );

  setUp(() {
    repository = MockVisitsRepository();
    reviews = MockVisitReviewRepository();
    when(() => reviews.fetch(any())).thenAnswer((_) async => null);
    when(repository.cachedUpcoming).thenReturn(const []);
    when(() => repository.cancel(any())).thenAnswer((_) async {});
    when(() => repository.confirmPresence(any()))
        .thenAnswer((_) async => visit('v-1'));
    when(
      () => repository.rateVisitor(
        visitId: any(named: 'visitId'),
        rating: any(named: 'rating'),
      ),
    ).thenAnswer((_) async {});
  });

  MyVisitsBloc build() => MyVisitsBloc(
        repository: repository,
        reviews: reviews,
        now: () => now,
      );

  blocTest<MyVisitsBloc, MyVisitsState>(
    'what is coming reads soonest first, what is done reads newest first',
    setUp: () => when(repository.mine).thenAnswer(
      (_) async => [
        visit('late', at: DateTime(2026, 10, 9)),
        visit('soon', at: DateTime(2026, 10, 3)),
        visit('done', status: VisitStatus.completed, at: DateTime(2026, 9, 20)),
      ],
    ),
    build: build,
    act: (bloc) => bloc.add(const MyVisitsRequested()),
    verify: (bloc) {
      final state = bloc.state as MyVisitsReady;
      expect(state.upcoming.map((v) => v.id), ['soon', 'late']);
      expect(state.past.map((v) => v.id), ['done']);
    },
  );

  blocTest<MyVisitsBloc, MyVisitsState>(
    'a visit whose hour has passed but which nobody closed stays on top',
    setUp: () => when(repository.mine).thenAnswer(
      // Earlier today, still SCHEDULED: the tenant may yet have to confirm
      // being there (RM-M07-05), and history is where that would be missed.
      (_) async => [visit('this-morning', at: DateTime(2026, 10, 1, 9))],
    ),
    build: build,
    act: (bloc) => bloc.add(const MyVisitsRequested()),
    verify: (bloc) {
      final state = bloc.state as MyVisitsReady;
      expect(state.upcoming.map((v) => v.id), ['this-morning']);
      expect(state.past, isEmpty);
    },
  );

  blocTest<MyVisitsBloc, MyVisitsState>(
    'offline, the times and places of what is coming are still there',
    setUp: () {
      when(repository.mine).thenThrow(Exception('offline'));
      when(repository.cachedUpcoming)
          .thenReturn([visit('cached', at: DateTime(2026, 10, 3))]);
    },
    build: build,
    act: (bloc) => bloc.add(const MyVisitsRequested()),
    verify: (bloc) {
      final state = bloc.state as MyVisitsReady;
      expect(state.upcoming.single.id, 'cached');
      expect(state.isOffline, isTrue);
    },
  );

  blocTest<MyVisitsBloc, MyVisitsState>(
    'offline with nothing cached is a failure, not an empty list',
    setUp: () => when(repository.mine).thenThrow(Exception('offline')),
    build: build,
    act: (bloc) => bloc.add(const MyVisitsRequested()),
    // "No visits" would read as "your booking is gone".
    verify: (bloc) => expect(bloc.state, isA<MyVisitsFailure>()),
  );

  blocTest<MyVisitsBloc, MyVisitsState>(
    'RM-M07-05 — confirming presence re-reads the list, never patches it',
    setUp: () => when(repository.mine).thenAnswer(
      (_) async => [visit('v-1', at: DateTime(2026, 10, 1, 14))],
    ),
    build: build,
    act: (bloc) => bloc
      ..add(const MyVisitsRequested())
      ..add(const VisitPresenceConfirmed('v-1')),
    // A reload also asks which completed visits carry a report.
    wait: const Duration(milliseconds: 150),
    verify: (_) {
      verify(() => repository.confirmPresence('v-1')).called(1);
      // Whether both halves are in is the server's call, so the answer comes
      // from the list rather than from the response to this one action.
      verify(repository.mine).called(2);
    },
  );

  group('RM-M07bis-01 — one report per visit', () {
    blocTest<MyVisitsBloc, MyVisitsState>(
      'a completed visit is asked whether it already carries one',
      setUp: () {
        when(repository.mine).thenAnswer(
          (_) async => [
            visit('done', status: VisitStatus.completed, at: DateTime(2026, 9, 20)),
            visit('soon', at: DateTime(2026, 10, 5)),
          ],
        );
        when(() => reviews.fetch('done'))
            .thenAnswer((_) async => const VisitReview(id: 'r-1', rating: 4));
      },
      build: build,
      act: (bloc) => bloc.add(const MyVisitsRequested()),
      verify: (bloc) {
        expect((bloc.state as MyVisitsReady).reviewedVisitIds, {'done'});
        // Only the completed ones: a visit still to happen cannot have one.
        verifyNever(() => reviews.fetch('soon'));
      },
    );

    blocTest<MyVisitsBloc, MyVisitsState>(
      'a lookup that fails leaves the visit open to writing',
      setUp: () {
        when(repository.mine).thenAnswer(
          (_) async => [
            visit('done', status: VisitStatus.completed, at: DateTime(2026, 9, 20)),
          ],
        );
        when(() => reviews.fetch('done')).thenThrow(Exception('boom'));
      },
      build: build,
      act: (bloc) => bloc.add(const MyVisitsRequested()),
      // Not knowing is not knowing there is none: the button stays, and the
      // server's 409 catches a second attempt.
      verify: (bloc) =>
          expect((bloc.state as MyVisitsReady).reviewedVisitIds, isEmpty),
    );
  });

  blocTest<MyVisitsBloc, MyVisitsState>(
    'RM-M07-07 — a rating given is not offered again',
    setUp: () => when(repository.mine).thenAnswer(
      (_) async => [
        visit('v-1', status: VisitStatus.completed, at: DateTime(2026, 9, 28)),
      ],
    ),
    build: build,
    act: (bloc) => bloc
      ..add(const MyVisitsRequested())
      ..add(const VisitorRated(visitId: 'v-1', rating: 5)),
    // A reload also asks which completed visits carry a report.
    wait: const Duration(milliseconds: 150),
    verify: (bloc) {
      // Shown at once, before the next read brings `agentRating` back.
      expect((bloc.state as MyVisitsReady).ratedVisitIds, {'v-1'});
    },
  );

  blocTest<MyVisitsBloc, MyVisitsState>(
    '§22 — after a restart the server says it is rated, not memory',
    setUp: () => when(repository.mine).thenAnswer(
      (_) async => [
        const Visit(
          id: 'v-1',
          status: VisitStatus.completed,
          visitorKind: VisitorKind.agent,
          agentRating: 4,
        ),
      ],
    ),
    build: build,
    act: (bloc) => bloc.add(const MyVisitsRequested()),
    wait: const Duration(milliseconds: 150),
    verify: (bloc) {
      final state = bloc.state as MyVisitsReady;
      // Nothing rated in this session — and still rated. This is the case that
      // used to offer the stars again and get `409 ALREADY_RATED` back.
      expect(state.ratedVisitIds, isEmpty);
      expect(state.isRated(state.past.single), isTrue);
    },
  );

  blocTest<MyVisitsBloc, MyVisitsState>(
    '§22 — ALREADY_RATED is an answer, not an error',
    setUp: () {
      when(repository.mine).thenAnswer(
        (_) async => [
          visit('v-1', status: VisitStatus.completed, at: DateTime(2026, 9, 28)),
        ],
      );
      when(
        () => repository.rateVisitor(
          visitId: any(named: 'visitId'),
          rating: any(named: 'rating'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/visites/v-1/rating'),
          response: Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/visites/v-1/rating'),
            statusCode: 409,
            data: {'error': 'ALREADY_RATED'},
          ),
        ),
      );
    },
    build: build,
    act: (bloc) => bloc
      ..add(const MyVisitsRequested())
      ..add(const VisitorRated(visitId: 'v-1', rating: 5)),
    wait: const Duration(milliseconds: 150),
    verify: (bloc) {
      final state = bloc.state as MyVisitsReady;
      expect(state.ratedVisitIds, {'v-1'});
      expect(state.failed, isFalse);
    },
  );

  blocTest<MyVisitsBloc, MyVisitsState>(
    'a failed cancellation keeps the visit on screen',
    setUp: () =>
        when(() => repository.cancel(any())).thenThrow(Exception('boom')),
    build: build,
    // Seeded rather than loaded first: firing the load and the cancellation
    // together races the reload against the failure, and which one lands last
    // is not what this pins.
    seed: () => MyVisitsReady(
      upcoming: [visit('v-1', at: DateTime(2026, 10, 5))],
    ),
    act: (bloc) => bloc.add(const VisitCancelled('v-1')),
    wait: const Duration(milliseconds: 50),
    verify: (bloc) {
      final state = bloc.state as MyVisitsReady;
      // Removing it optimistically would tell someone a visit is cancelled
      // while the visitor is still expecting them.
      expect(state.upcoming.single.id, 'v-1');
      expect(state.failed, isTrue);
    },
  );

}
