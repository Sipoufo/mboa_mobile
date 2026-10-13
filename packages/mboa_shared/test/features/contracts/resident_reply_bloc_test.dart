import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockResidentReviewRepository extends Mock
    implements ResidentReviewRepository {}

/// The landlord's answer to a resident's review (CDC M27, RM-M27-03).
void main() {
  late MockResidentReviewRepository repository;

  ReviewEntry review({List<ReviewReply> replies = const []}) => ReviewEntry(
        id: 'r-1',
        kind: ReviewKind.resident,
        rating: 2,
        comment: 'Coupures d’eau fréquentes.',
        residenceMonths: 12,
        replies: replies,
      );

  setUp(() => repository = MockResidentReviewRepository());

  ResidentReplyBloc build() => ResidentReplyBloc(repository: repository);

  group('opening it', () {
    blocTest<ResidentReplyBloc, ResidentReplyState>(
      'a tenancy nobody has reviewed is a waiting room, not a failure',
      setUp: () =>
          when(() => repository.fetch('c-1')).thenAnswer((_) async => null),
      build: build,
      act: (bloc) => bloc.add(const ResidentReplyOpened('c-1')),
      verify: (bloc) {
        final state = bloc.state as ResidentReplyReady;
        // RM-M27-02 lets the tenant write whenever they like, so most
        // contracts sit here most of the time.
        expect(state.hasReview, isFalse);
        expect(state.canReply, isFalse);
      },
    );

    blocTest<ResidentReplyBloc, ResidentReplyState>(
      'a read failure is a failure — it is not "no review"',
      setUp: () =>
          when(() => repository.fetch('c-1')).thenThrow(Exception('500')),
      build: build,
      act: (bloc) => bloc.add(const ResidentReplyOpened('c-1')),
      expect: () => [
        const ResidentReplyLoadInProgress(),
        const ResidentReplyFailure(),
      ],
    );
  });

  group('answering it', () {
    blocTest<ResidentReplyBloc, ResidentReplyState>(
      'the answer goes through trimmed, and the review comes back with it',
      setUp: () {
        when(() => repository.fetch('c-1'))
            .thenAnswer((_) async => review());
        when(() => repository.reply('c-1', 'Le forage est réparé.')).thenAnswer(
          (_) async => review(
            replies: const [
              ReviewReply(authorName: 'Agence Deido', body: 'Le forage est réparé.'),
            ],
          ),
        );
      },
      build: build,
      act: (bloc) => bloc
        ..add(const ResidentReplyOpened('c-1'))
        ..add(const ResidentReplySent('  Le forage est réparé.  ')),
      verify: (bloc) {
        verify(() => repository.reply('c-1', 'Le forage est réparé.')).called(1);
        final state = bloc.state as ResidentReplyReady;
        expect(state.justSent, isTrue);
        // RM-M27-03 — the rating and the words are untouched by the answer.
        expect(state.review!.rating, 2);
        expect(state.review!.comment, 'Coupures d’eau fréquentes.');
      },
    );

    blocTest<ResidentReplyBloc, ResidentReplyState>(
      'RM-M27-03 — a second answer is never sent',
      setUp: () => when(() => repository.fetch('c-1')).thenAnswer(
        (_) async => review(
          replies: const [ReviewReply(authorName: 'Agence Deido', body: 'Noté.')],
        ),
      ),
      build: build,
      act: (bloc) => bloc
        ..add(const ResidentReplyOpened('c-1'))
        ..add(const ResidentReplySent('En fait, je voulais ajouter…')),
      verify: (bloc) {
        // One answer per review. The server refuses a second too, but a
        // request that is going to be refused should not leave the phone.
        verifyNever(() => repository.reply(any(), any()));
        expect((bloc.state as ResidentReplyReady).canReply, isFalse);
      },
    );

    blocTest<ResidentReplyBloc, ResidentReplyState>(
      'an empty answer is not an answer',
      setUp: () =>
          when(() => repository.fetch('c-1')).thenAnswer((_) async => review()),
      build: build,
      act: (bloc) => bloc
        ..add(const ResidentReplyOpened('c-1'))
        ..add(const ResidentReplySent('   ')),
      verify: (_) => verifyNever(() => repository.reply(any(), any())),
    );

    blocTest<ResidentReplyBloc, ResidentReplyState>(
      'a refused answer keeps the review on screen and stays retryable',
      setUp: () {
        when(() => repository.fetch('c-1'))
            .thenAnswer((_) async => review());
        when(() => repository.reply(any(), any())).thenThrow(Exception('500'));
      },
      build: build,
      act: (bloc) => bloc
        ..add(const ResidentReplyOpened('c-1'))
        ..add(const ResidentReplySent('Le forage est réparé.')),
      verify: (bloc) {
        final state = bloc.state as ResidentReplyReady;
        expect(state.sendFailed, isTrue);
        expect(state.isSending, isFalse);
        // Still answerable: nothing was written, so the right of reply stands.
        expect(state.canReply, isTrue);
      },
    );
  });
}
