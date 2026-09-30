import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockMessagingRepository extends Mock implements MessagingRepository {}

Conversation conversation({
  String id = 'c-1',
  int unread = 0,
  bool readOnly = false,
}) =>
    Conversation(
      id: id,
      annonceId: 'a-1',
      annonceTitle: 'Studio Bonapriso',
      peerName: 'Awa Nkeng',
      unreadCount: unread,
      readOnly: readOnly,
    );

Message message(String id, {bool mine = true}) => Message(
      id: id,
      isMine: mine,
      body: 'Bonjour',
      sentAt: DateTime(2026, 9, 30, 10),
    );

/// In-app messaging (CDC M12).
void main() {
  late MockMessagingRepository repository;

  // `registerFallbackValue` belongs in setUpAll: mocktail wants it before the
  // first stub that mentions the type, not on each run.
  setUpAll(
    () => registerFallbackValue(
      QueuedMessage(
        localId: 'x',
        conversationId: 'c-1',
        body: 'x',
        queuedAt: DateTime(2026),
      ),
    ),
  );

  setUp(() {
    repository = MockMessagingRepository();
    when(() => repository.queued(any())).thenReturn([]);
    when(() => repository.markRead(any())).thenAnswer((_) async {});
    when(() => repository.enqueue(any())).thenAnswer((_) async {});
    when(repository.flushQueue).thenAnswer((_) async => []);
  });

  group('the list', () {
    ConversationsBloc build() => ConversationsBloc(repository: repository);

    blocTest<ConversationsBloc, ConversationsState>(
      'the unread badge is the sum of the threads, not a flag',
      setUp: () => when(repository.conversations).thenAnswer(
        (_) async => [
          conversation(unread: 2),
          conversation(id: 'c-2', unread: 3),
          conversation(id: 'c-3'),
        ],
      ),
      build: build,
      act: (bloc) => bloc.add(const ConversationsLoadRequested()),
      verify: (bloc) => expect(bloc.state.unreadTotal, 5),
    );

    blocTest<ConversationsBloc, ConversationsState>(
      'a failed refresh keeps what is on screen',
      setUp: () => when(repository.conversations).thenThrow(Exception('offline')),
      build: build,
      seed: () => ConversationsReady(items: [conversation()]),
      act: (bloc) => bloc.add(const ConversationsRefreshed()),
      verify: (bloc) =>
          expect((bloc.state as ConversationsReady).items, hasLength(1)),
    );

    blocTest<ConversationsBloc, ConversationsState>(
      'signing out empties the list',
      build: build,
      seed: () => ConversationsReady(items: [conversation()]),
      act: (bloc) => bloc.add(const ConversationsCleared()),
      // Threads belong to an account; the next person must not see the last
      // one's.
      verify: (bloc) => expect(bloc.state.unreadTotal, 0),
    );
  });

  group('a thread', () {
    ThreadBloc build() => ThreadBloc(repository: repository);

    blocTest<ThreadBloc, ThreadState>(
      'the newest message ends up at the bottom',
      setUp: () => when(() => repository.messages('c-1')).thenAnswer(
        // The endpoint answers newest first.
        (_) async => [message('newest'), message('oldest')],
      ),
      build: build,
      act: (bloc) => bloc.add(ThreadRequested(conversation())),
      verify: (bloc) {
        final state = bloc.state as ThreadReady;
        expect(state.visible.map((m) => m.id), ['oldest', 'newest']);
      },
    );

    blocTest<ThreadBloc, ThreadState>(
      'RM-M12-05 — opening a thread marks it read',
      setUp: () =>
          when(() => repository.messages('c-1')).thenAnswer((_) async => []),
      build: build,
      act: (bloc) => bloc.add(ThreadRequested(conversation(unread: 3))),
      wait: const Duration(milliseconds: 10),
      verify: (_) => verify(() => repository.markRead('c-1')).called(1),
    );

    blocTest<ThreadBloc, ThreadState>(
      'CE-M12-01 — a message that cannot leave is queued, not lost',
      setUp: () => when(
        () => repository.send(
          any(),
          body: any(named: 'body'),
          attachmentKeys: any(named: 'attachmentKeys'),
        ),
      ).thenThrow(Exception('offline')),
      build: build,
      seed: () => ThreadReady(conversation: conversation()),
      act: (bloc) => bloc.add(const ThreadMessageSent('Bonjour')),
      verify: (bloc) {
        final state = bloc.state as ThreadReady;
        // It shows in the thread, marked as waiting — an error the writer can
        // do nothing about would just lose their words.
        expect(state.visible.single.status, MessageStatus.pending);
        verify(() => repository.enqueue(any())).called(1);
      },
    );

    blocTest<ThreadBloc, ThreadState>(
      'a sent message replaces its pending bubble',
      setUp: () => when(
        () => repository.send(
          'c-1',
          body: 'Bonjour',
          attachmentKeys: any(named: 'attachmentKeys'),
        ),
      ).thenAnswer((_) async => message('server-1')),
      build: build,
      seed: () => ThreadReady(conversation: conversation()),
      act: (bloc) => bloc.add(const ThreadMessageSent('  Bonjour  ')),
      verify: (bloc) {
        final state = bloc.state as ThreadReady;
        expect(state.visible.map((m) => m.id), ['server-1']);
        expect(state.visible.single.status, MessageStatus.sent);
      },
    );

    blocTest<ThreadBloc, ThreadState>(
      'CE-M12-02 — a read-only thread sends nothing',
      build: build,
      seed: () => ThreadReady(conversation: conversation(readOnly: true)),
      act: (bloc) => bloc.add(const ThreadMessageSent('Bonjour')),
      verify: (_) => verifyNever(
        () => repository.send(
          any(),
          body: any(named: 'body'),
          attachmentKeys: any(named: 'attachmentKeys'),
        ),
      ),
    );

    blocTest<ThreadBloc, ThreadState>(
      'an empty message with no attachment is not sent',
      build: build,
      seed: () => ThreadReady(conversation: conversation()),
      act: (bloc) => bloc.add(const ThreadMessageSent('   ')),
      verify: (_) => verifyNever(
        () => repository.send(
          any(),
          body: any(named: 'body'),
          attachmentKeys: any(named: 'attachmentKeys'),
        ),
      ),
    );

    blocTest<ThreadBloc, ThreadState>(
      'CE-M12-01 — the queue goes out when the line comes back',
      setUp: () {
        when(repository.flushQueue).thenAnswer((_) async => [message('sent-1')]);
        when(() => repository.queued('c-1')).thenReturn([]);
      },
      build: build,
      seed: () => ThreadReady(conversation: conversation()),
      act: (bloc) => bloc.add(const ThreadQueueFlushed()),
      verify: (bloc) {
        final state = bloc.state as ThreadReady;
        expect(state.messages.map((m) => m.id), ['sent-1']);
        expect(state.queued, isEmpty);
      },
    );
  });
}
