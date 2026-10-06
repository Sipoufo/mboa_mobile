import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/visits/bloc/write_review_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockVisitReviewRepository extends Mock implements VisitReviewRepository {}

/// Writing the report on a visit (CDC M07bis).
void main() {
  late MockVisitReviewRepository repository;

  const published = VisitReview(id: 'r-1', rating: 4);

  DioException refusal(int status) => DioException(
        requestOptions: RequestOptions(),
        response: Response<void>(requestOptions: RequestOptions(), statusCode: status),
      );

  setUp(() {
    repository = MockVisitReviewRepository();
    when(() => repository.fetch(any())).thenAnswer((_) async => null);
    when(
      () => repository.submit(
        any(),
        rating: any(named: 'rating'),
        perceivedCondition: any(named: 'perceivedCondition'),
        comment: any(named: 'comment'),
        pros: any(named: 'pros'),
        cons: any(named: 'cons'),
        photoKeys: any(named: 'photoKeys'),
      ),
    ).thenAnswer((_) async => published);
  });

  WriteReviewBloc build() => WriteReviewBloc(repository: repository);

  blocTest<WriteReviewBloc, WriteReviewState>(
    'RM-M07bis-01 — a visit already reviewed opens read-only, not as a form',
    setUp: () =>
        when(() => repository.fetch('v-1')).thenAnswer((_) async => published),
    build: build,
    act: (bloc) => bloc.add(const ReviewOpened('v-1')),
    // Offering a form that cannot be sent is worse than showing what was said.
    verify: (bloc) => expect(bloc.state, isA<ReviewPublished>()),
  );

  blocTest<WriteReviewBloc, WriteReviewState>(
    'only the rating is required',
    build: build,
    act: (bloc) => bloc.add(const ReviewOpened('v-1')),
    verify: (bloc) {
      final draft = bloc.state as ReviewDraft;
      expect(draft.canSubmit, isFalse);
    },
  );

  blocTest<WriteReviewBloc, WriteReviewState>(
    'a rating alone is a publishable report',
    build: build,
    act: (bloc) => bloc
      ..add(const ReviewOpened('v-1'))
      ..add(const ReviewRatingChanged(4)),
    verify: (bloc) => expect((bloc.state as ReviewDraft).canSubmit, isTrue),
  );

  group('the two lists', () {
    blocTest<WriteReviewBloc, WriteReviewState>(
      'a blank bullet is not an opinion, and the same one twice is one',
      build: build,
      act: (bloc) => bloc
        ..add(const ReviewOpened('v-1'))
        ..add(const ReviewPointAdded(value: '  ', isPro: true))
        ..add(const ReviewPointAdded(value: 'Quartier calme', isPro: true))
        ..add(const ReviewPointAdded(value: 'Quartier calme', isPro: true)),
      verify: (bloc) =>
          expect((bloc.state as ReviewDraft).pros, ['Quartier calme']),
    );

    blocTest<WriteReviewBloc, WriteReviewState>(
      'the two lists do not touch each other',
      build: build,
      act: (bloc) => bloc
        ..add(const ReviewOpened('v-1'))
        ..add(const ReviewPointAdded(value: 'Lumineux', isPro: true))
        ..add(const ReviewPointAdded(value: 'Humide', isPro: false))
        ..add(const ReviewPointRemoved(value: 'Lumineux', isPro: true)),
      verify: (bloc) {
        final draft = bloc.state as ReviewDraft;
        expect(draft.pros, isEmpty);
        expect(draft.cons, ['Humide']);
      },
    );
  });

  blocTest<WriteReviewBloc, WriteReviewState>(
    'the eleventh photo is refused — the table caps it at ten',
    build: build,
    act: (bloc) {
      bloc.add(const ReviewOpened('v-1'));
      for (var i = 0; i < 12; i++) {
        bloc.add(ReviewPhotoAdded('key-$i'));
      }
    },
    verify: (bloc) {
      final draft = bloc.state as ReviewDraft;
      expect(draft.photoKeys, hasLength(10));
      expect(draft.canAddPhoto, isFalse);
    },
  );

  blocTest<WriteReviewBloc, WriteReviewState>(
    'what was written is sent, lists and all',
    build: build,
    act: (bloc) => bloc
      ..add(const ReviewOpened('v-1'))
      ..add(const ReviewRatingChanged(5))
      ..add(const ReviewConditionChanged(3))
      ..add(const ReviewCommentChanged('Rien à signaler'))
      ..add(const ReviewPointAdded(value: 'Lumineux', isPro: true))
      ..add(const ReviewPointAdded(value: 'Humide', isPro: false))
      ..add(const ReviewPhotoAdded('photo-1'))
      ..add(const ReviewSubmitted()),
    verify: (_) => verify(
      () => repository.submit(
        'v-1',
        rating: 5,
        perceivedCondition: 3,
        comment: 'Rien à signaler',
        pros: ['Lumineux'],
        cons: ['Humide'],
        photoKeys: ['photo-1'],
      ),
    ).called(1),
  );

  group('a refusal is a fact about the visit, not a broken form', () {
    blocTest<WriteReviewBloc, WriteReviewState>(
      'RM-M07bis-01 — 409 means a report is already there',
      setUp: () => when(
        () => repository.submit(
          any(),
          rating: any(named: 'rating'),
          perceivedCondition: any(named: 'perceivedCondition'),
          comment: any(named: 'comment'),
          pros: any(named: 'pros'),
          cons: any(named: 'cons'),
          photoKeys: any(named: 'photoKeys'),
        ),
      ).thenThrow(refusal(409)),
      build: build,
      act: (bloc) => bloc
        ..add(const ReviewOpened('v-1'))
        ..add(const ReviewRatingChanged(4))
        ..add(const ReviewSubmitted()),
      verify: (bloc) {
        final draft = bloc.state as ReviewDraft;
        expect(draft.refusal, ReviewRefusal.alreadyWritten);
        // What was typed stays: losing it would be the app's fault, not the
        // server's.
        expect(draft.rating, 4);
      },
    );

    blocTest<WriteReviewBloc, WriteReviewState>(
      'CE-M07bis-01 — 403 means nobody confirmed the visit',
      setUp: () => when(
        () => repository.submit(
          any(),
          rating: any(named: 'rating'),
          perceivedCondition: any(named: 'perceivedCondition'),
          comment: any(named: 'comment'),
          pros: any(named: 'pros'),
          cons: any(named: 'cons'),
          photoKeys: any(named: 'photoKeys'),
        ),
      ).thenThrow(refusal(403)),
      build: build,
      act: (bloc) => bloc
        ..add(const ReviewOpened('v-1'))
        ..add(const ReviewRatingChanged(4))
        ..add(const ReviewSubmitted()),
      verify: (bloc) => expect(
        (bloc.state as ReviewDraft).refusal,
        ReviewRefusal.notAllowed,
      ),
    );

    blocTest<WriteReviewBloc, WriteReviewState>(
      'editing after a refusal clears it',
      setUp: () => when(
        () => repository.submit(
          any(),
          rating: any(named: 'rating'),
          perceivedCondition: any(named: 'perceivedCondition'),
          comment: any(named: 'comment'),
          pros: any(named: 'pros'),
          cons: any(named: 'cons'),
          photoKeys: any(named: 'photoKeys'),
        ),
      ).thenThrow(refusal(500)),
      build: build,
      act: (bloc) => bloc
        ..add(const ReviewOpened('v-1'))
        ..add(const ReviewRatingChanged(4))
        ..add(const ReviewSubmitted())
        ..add(const ReviewRatingChanged(5)),
      // A message about the last attempt must not hang over the next one.
      verify: (bloc) => expect((bloc.state as ReviewDraft).refusal, isNull),
    );
  });
}
