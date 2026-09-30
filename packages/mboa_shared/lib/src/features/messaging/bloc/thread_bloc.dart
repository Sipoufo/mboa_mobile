import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/messaging_repository.dart';
import '../models/conversation.dart';

part 'thread_event.dart';
part 'thread_state.dart';

/// One conversation (CDC M12).
///
/// Two things shape it. A message written **offline is queued and sent on
/// reconnection** (CE-M12-01), so the thread can hold bubbles the server has
/// never seen. And a thread can turn **read-only** while it is open
/// (CE-M12-02): the listing was archived, the history stays, the composer goes.
class ThreadBloc extends Bloc<ThreadEvent, ThreadState> {
  ThreadBloc({required MessagingRepository repository})
      : _repository = repository,
        super(const ThreadInitial()) {
    on<ThreadRequested>(_onRequested);
    on<ThreadMessageSent>(_onSend);
    on<ThreadQueueFlushed>(_onFlush);
  }

  final MessagingRepository _repository;

  Future<void> _onRequested(
    ThreadRequested event,
    Emitter<ThreadState> emit,
  ) async {
    emit(const ThreadLoadInProgress());
    try {
      final messages = await _repository.messages(event.conversation.id);
      emit(
        ThreadReady(
          conversation: event.conversation,
          // The endpoint answers newest first; a reader expects the latest at
          // the bottom.
          messages: messages.reversed.toList(),
          queued: _repository
              .queued(event.conversation.id)
              .map((q) => q.asMessage)
              .toList(),
        ),
      );

      // RM-M12-05 — opening the thread is what clears the other side's badge.
      // A failure here is not worth an error: the messages are on screen.
      try {
        await _repository.markRead(event.conversation.id);
      } catch (_) {}
    } catch (_) {
      emit(const ThreadFailure());
    }
  }

  Future<void> _onSend(
    ThreadMessageSent event,
    Emitter<ThreadState> emit,
  ) async {
    final current = state;
    if (current is! ThreadReady) return;

    final body = event.body.trim();
    if (body.isEmpty && event.attachmentKeys.isEmpty) return;

    // CE-M12-02 — the listing was archived: the composer should already be
    // gone, and a queued message would never leave.
    if (current.conversation.readOnly) return;

    final queued = QueuedMessage(
      localId: _localId(),
      conversationId: current.conversation.id,
      body: body,
      attachmentKeys: event.attachmentKeys,
      queuedAt: DateTime.now(),
    );

    // The bubble appears immediately, marked as sending: on a Douala 3G a
    // message that only shows up after the round trip reads as a lost one.
    emit(current.copyWith(queued: [...current.queued, queued.asMessage]));

    try {
      final sent = await _repository.send(
        current.conversation.id,
        body: body,
        attachmentKeys: event.attachmentKeys,
      );
      emit(
        current.copyWith(
          messages: [...current.messages, sent],
          queued: current.queued,
        ),
      );
    } catch (_) {
      // CE-M12-01 — kept locally and retried on reconnection, rather than lost
      // with an error the writer can do nothing about.
      await _repository.enqueue(queued);
      emit(
        current.copyWith(
          queued: [...current.queued, queued.asMessage],
          isOffline: true,
        ),
      );
    }
  }

  /// Called when the network comes back.
  Future<void> _onFlush(
    ThreadQueueFlushed event,
    Emitter<ThreadState> emit,
  ) async {
    final current = state;
    if (current is! ThreadReady) return;

    final sent = await _repository.flushQueue();
    if (sent.isEmpty) return;

    emit(
      ThreadReady(
        conversation: current.conversation,
        messages: [...current.messages, ...sent.where((m) => m.isMine)],
        queued: _repository
            .queued(current.conversation.id)
            .map((q) => q.asMessage)
            .toList(),
      ),
    );
  }

  static String _localId() {
    final random = Random();
    return 'local-${DateTime.now().microsecondsSinceEpoch}-${random.nextInt(9999)}';
  }
}
