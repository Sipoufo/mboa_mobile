import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/visits/bloc/visit_review_bloc.dart';
import 'package:mboa_pro/features/visits/data/review_pdf_exporter.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockVisitReviewRepository extends Mock
    implements VisitReviewRepository {}

class MockReviewPdfExporter extends Mock implements ReviewPdfExporter {}

/// The client's review, as the visitor handles it (CDC M07bis).
void main() {
  late MockVisitReviewRepository repository;
  late MockReviewPdfExporter exporter;

  const review = VisitReview(
    id: 'r-1',
    authorName: 'Awa Nkeng',
    rating: 4,
    comment: 'Beau studio, quartier bruyant.',
  );

  final answered = VisitReview(
    id: 'r-1',
    authorName: 'Awa Nkeng',
    rating: 4,
    comment: 'Beau studio, quartier bruyant.',
    comments: [
      ReviewComment(
        authorName: 'Emmanuel NDJOKO',
        body: 'Merci pour votre retour.',
        createdAt: DateTime(2026, 8, 21),
      ),
    ],
  );

  setUpAll(() => registerFallbackValue(Uint8List(0)));

  setUp(() {
    repository = MockVisitReviewRepository();
    exporter = MockReviewPdfExporter();
  });

  VisitReviewBloc build() =>
      VisitReviewBloc(repository: repository, exporter: exporter);

  blocTest<VisitReviewBloc, VisitReviewState>(
    'RM-M07bis-02 — no review yet is an answer, not a failure',
    setUp: () =>
        when(() => repository.fetch('v-1')).thenAnswer((_) async => null),
    build: build,
    act: (bloc) => bloc.add(const VisitReviewRequested('v-1')),
    verify: (bloc) {
      // Writing one is optional and undated, so most visits have none for a
      // while — rendering that as an error would accuse the client of nothing.
      final state = bloc.state as VisitReviewReady;
      expect(state.hasReview, isFalse);
    },
  );

  blocTest<VisitReviewBloc, VisitReviewState>(
    'an unreachable review is a failure, which is a different screen',
    setUp: () =>
        when(() => repository.fetch('v-1')).thenThrow(Exception('offline')),
    build: build,
    act: (bloc) => bloc.add(const VisitReviewRequested('v-1')),
    verify: (bloc) => expect(bloc.state, isA<VisitReviewFailure>()),
  );

  blocTest<VisitReviewBloc, VisitReviewState>(
    'RM-M07bis-04 — a comment comes back inside the review it answers',
    setUp: () => when(() => repository.comment('v-1', 'Merci pour votre retour.'))
        .thenAnswer((_) async => answered),
    build: build,
    seed: () => const VisitReviewReady(visiteId: 'v-1', review: review),
    act: (bloc) =>
        bloc.add(const VisitReviewCommented('  Merci pour votre retour.  ')),
    verify: (bloc) {
      final state = bloc.state as VisitReviewReady;
      // The server returns the whole review, so the thread is never assembled
      // locally — and the note and text are untouched, which is the point.
      expect(state.review!.comments, hasLength(1));
      expect(state.review!.rating, 4);
      expect(state.commentJustSent, isTrue);
    },
  );

  blocTest<VisitReviewBloc, VisitReviewState>(
    'an empty comment is not sent',
    build: build,
    seed: () => const VisitReviewReady(visiteId: 'v-1', review: review),
    act: (bloc) => bloc.add(const VisitReviewCommented('   ')),
    verify: (_) => verifyNever(() => repository.comment(any(), any())),
  );

  blocTest<VisitReviewBloc, VisitReviewState>(
    'a refused comment says so and keeps what is on screen',
    setUp: () => when(() => repository.comment(any(), any()))
        .thenThrow(Exception('403')),
    build: build,
    seed: () => const VisitReviewReady(visiteId: 'v-1', review: review),
    act: (bloc) => bloc.add(const VisitReviewCommented('Merci')),
    verify: (bloc) {
      final state = bloc.state as VisitReviewReady;
      expect(state.lastActionFailed, isTrue);
      expect(state.review, review);
    },
  );

  blocTest<VisitReviewBloc, VisitReviewState>(
    'RM-M07bis-06 — the PDF is fetched and handed to the OS',
    setUp: () {
      when(() => repository.pdf('v-1'))
          .thenAnswer((_) async => Uint8List.fromList([37, 80, 68, 70]));
      when(() => exporter.share(any(), name: any(named: 'name')))
          .thenAnswer((_) async {});
    },
    build: build,
    seed: () => const VisitReviewReady(visiteId: 'v-1', review: review),
    act: (bloc) =>
        bloc.add(const VisitReviewPdfRequested(fileName: 'Avis - Studio')),
    verify: (bloc) {
      verify(() => exporter.share(any(), name: 'Avis - Studio')).called(1);
      expect((bloc.state as VisitReviewReady).isExporting, isFalse);
    },
  );

  blocTest<VisitReviewBloc, VisitReviewState>(
    'nothing to export when there is no review',
    build: build,
    seed: () => const VisitReviewReady(visiteId: 'v-1'),
    act: (bloc) =>
        bloc.add(const VisitReviewPdfRequested(fileName: 'Avis - Studio')),
    verify: (_) => verifyNever(() => repository.pdf(any())),
  );

  blocTest<VisitReviewBloc, VisitReviewState>(
    'a failed export stops spinning and says so',
    setUp: () => when(() => repository.pdf('v-1')).thenThrow(Exception('500')),
    build: build,
    seed: () => const VisitReviewReady(visiteId: 'v-1', review: review),
    act: (bloc) =>
        bloc.add(const VisitReviewPdfRequested(fileName: 'Avis - Studio')),
    verify: (bloc) {
      final state = bloc.state as VisitReviewReady;
      expect(state.isExporting, isFalse);
      expect(state.lastActionFailed, isTrue);
    },
  );
}
