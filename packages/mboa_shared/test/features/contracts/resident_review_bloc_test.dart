import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockResidentReviewRepository extends Mock
    implements ResidentReviewRepository {}

/// The tenant's review of a tenancy (CDC M27).
void main() {
  late MockResidentReviewRepository repository;

  ReviewEntry review({
    int rating = 4,
    String comment = 'Quartier calme, eau régulière.',
  }) =>
      ReviewEntry(
        id: 'r-1',
        kind: ReviewKind.resident,
        rating: rating,
        comment: comment,
        residenceMonths: 12,
      );

  DioException conflict(String code) => DioException(
        requestOptions: RequestOptions(path: '/contracts/c-1/review'),
        response: Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/contracts/c-1/review'),
          statusCode: 409,
          data: {'error': code},
        ),
      );

  setUp(() => repository = MockResidentReviewRepository());

  ResidentReviewBloc build() =>
      ResidentReviewBloc(repository: repository);

  group('opening it', () {
    blocTest<ResidentReviewBloc, ResidentReviewState>(
      'a tenancy nobody has reviewed opens an empty form',
      setUp: () =>
          when(() => repository.fetch('c-1')).thenAnswer((_) async => null),
      build: build,
      act: (bloc) => bloc.add(const ResidentReviewOpened('c-1')),
      verify: (bloc) {
        final state = bloc.state as ResidentReviewEditing;
        expect(state.isRevision, isFalse);
        // RM-M27 makes the rating the one required field, so an untouched
        // form cannot be sent.
        expect(state.canSubmit, isFalse);
      },
    );

    blocTest<ResidentReviewBloc, ResidentReviewState>(
      'RM-M27-02 — an existing review opens as a correction, already filled',
      setUp: () => when(() => repository.fetch('c-1'))
          .thenAnswer((_) async => review()),
      build: build,
      act: (bloc) => bloc.add(const ResidentReviewOpened('c-1')),
      verify: (bloc) {
        final state = bloc.state as ResidentReviewEditing;
        expect(state.isRevision, isTrue);
        expect(state.rating, 4);
        expect(state.comment, 'Quartier calme, eau régulière.');
      },
    );

    blocTest<ResidentReviewBloc, ResidentReviewState>(
      'a failed read is a failure, not an empty form',
      setUp: () =>
          when(() => repository.fetch('c-1')).thenThrow(Exception('500')),
      build: build,
      act: (bloc) => bloc.add(const ResidentReviewOpened('c-1')),
      // An empty form here would invite a tenant to write a review that is
      // about to collide with the one already on the server.
      expect: () => [
        const ResidentReviewLoadInProgress(),
        const ResidentReviewFailure(),
      ],
    );
  });

  group('writing it', () {
    blocTest<ResidentReviewBloc, ResidentReviewState>(
      'a form with no rating is not sent',
      setUp: () =>
          when(() => repository.fetch('c-1')).thenAnswer((_) async => null),
      build: build,
      act: (bloc) => bloc
        ..add(const ResidentReviewOpened('c-1'))
        ..add(const ResidentReviewCommentChanged('Bien situé.'))
        ..add(const ResidentReviewSubmitted()),
      verify: (_) => verifyNever(
        () => repository.submit(
          any(),
          rating: any(named: 'rating'),
          comment: any(named: 'comment'),
          pros: any(named: 'pros'),
          cons: any(named: 'cons'),
        ),
      ),
    );

    blocTest<ResidentReviewBloc, ResidentReviewState>(
      'a first review is published, not revised',
      setUp: () {
        when(() => repository.fetch('c-1')).thenAnswer((_) async => null);
        when(
          () => repository.submit(
            'c-1',
            rating: 5,
            comment: 'Rien à redire.',
            pros: const ['Eau régulière'],
            cons: const [],
          ),
        ).thenAnswer((_) async => review(rating: 5));
      },
      build: build,
      act: (bloc) => bloc
        ..add(const ResidentReviewOpened('c-1'))
        ..add(const ResidentReviewRatingChanged(5))
        ..add(const ResidentReviewCommentChanged('Rien à redire.'))
        ..add(
          const ResidentReviewPointAdded(label: 'Eau régulière', isPro: true),
        )
        ..add(const ResidentReviewSubmitted()),
      verify: (bloc) {
        verify(
          () => repository.submit(
            'c-1',
            rating: 5,
            comment: 'Rien à redire.',
            pros: const ['Eau régulière'],
            cons: const [],
          ),
        ).called(1);
        expect(bloc.state, isA<ResidentReviewPublished>());
      },
    );

    blocTest<ResidentReviewBloc, ResidentReviewState>(
      'RM-M27-02 — a second pass revises rather than publishing again',
      setUp: () {
        when(() => repository.fetch('c-1'))
            .thenAnswer((_) async => review(rating: 4));
        when(
          () => repository.revise(
            'c-1',
            rating: 2,
            comment: any(named: 'comment'),
            pros: any(named: 'pros'),
            cons: any(named: 'cons'),
          ),
        ).thenAnswer((_) async => review(rating: 2));
      },
      build: build,
      act: (bloc) => bloc
        ..add(const ResidentReviewOpened('c-1'))
        ..add(const ResidentReviewRatingChanged(2))
        ..add(const ResidentReviewSubmitted()),
      verify: (_) {
        // POST on an already-reviewed contract is a 409; the bloc knows which
        // verb to use from the read, so the screen never has to.
        verifyNever(
          () => repository.submit(
            any(),
            rating: any(named: 'rating'),
            comment: any(named: 'comment'),
            pros: any(named: 'pros'),
            cons: any(named: 'cons'),
          ),
        );
      },
    );

    blocTest<ResidentReviewBloc, ResidentReviewState>(
      'the same point cannot be added twice',
      setUp: () =>
          when(() => repository.fetch('c-1')).thenAnswer((_) async => null),
      build: build,
      act: (bloc) => bloc
        ..add(const ResidentReviewOpened('c-1'))
        ..add(const ResidentReviewPointAdded(label: 'Calme', isPro: true))
        ..add(const ResidentReviewPointAdded(label: 'Calme', isPro: true))
        ..add(const ResidentReviewPointAdded(label: '   ', isPro: true)),
      verify: (bloc) =>
          expect((bloc.state as ResidentReviewEditing).pros, ['Calme']),
    );
  });

  group('the window closing', () {
    blocTest<ResidentReviewBloc, ResidentReviewState>(
      'RM-M27-02 — REVIEW_LOCKED is an ending, not an error',
      setUp: () {
        when(() => repository.fetch('c-1'))
            .thenAnswer((_) async => review(rating: 4));
        when(
          () => repository.revise(
            any(),
            rating: any(named: 'rating'),
            comment: any(named: 'comment'),
            pros: any(named: 'pros'),
            cons: any(named: 'cons'),
          ),
        ).thenThrow(conflict('REVIEW_LOCKED'));
      },
      build: build,
      act: (bloc) => bloc
        ..add(const ResidentReviewOpened('c-1'))
        ..add(const ResidentReviewRatingChanged(2))
        ..add(const ResidentReviewSubmitted()),
      verify: (bloc) {
        // The review still stands and is still on the fiche; it simply cannot
        // be touched. A retry button here would fail the same way every time.
        expect(bloc.state, isA<ResidentReviewLocked>());
        expect((bloc.state as ResidentReviewLocked).review.rating, 4);
      },
    );

    blocTest<ResidentReviewBloc, ResidentReviewState>(
      'any other 409 stays a failure the tenant can retry',
      setUp: () {
        when(() => repository.fetch('c-1'))
            .thenAnswer((_) async => review(rating: 4));
        when(
          () => repository.revise(
            any(),
            rating: any(named: 'rating'),
            comment: any(named: 'comment'),
            pros: any(named: 'pros'),
            cons: any(named: 'cons'),
          ),
        ).thenThrow(conflict('TENANCY_TOO_SHORT'));
      },
      build: build,
      act: (bloc) => bloc
        ..add(const ResidentReviewOpened('c-1'))
        ..add(const ResidentReviewRatingChanged(2))
        ..add(const ResidentReviewSubmitted()),
      verify: (bloc) {
        final state = bloc.state as ResidentReviewEditing;
        expect(state.saveFailed, isTrue);
        // The words survive the refusal: nobody retypes a year of living
        // somewhere because a request came back 409.
        expect(state.rating, 2);
      },
    );
  });
}
