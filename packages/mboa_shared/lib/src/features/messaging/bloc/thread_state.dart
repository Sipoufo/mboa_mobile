part of 'thread_bloc.dart';

sealed class ThreadState extends Equatable {
  const ThreadState();

  @override
  List<Object?> get props => [];
}

class ThreadInitial extends ThreadState {
  const ThreadInitial();
}

class ThreadLoadInProgress extends ThreadState {
  const ThreadLoadInProgress();
}

class ThreadReady extends ThreadState {
  const ThreadReady({
    required this.conversation,
    this.messages = const [],
    this.queued = const [],
    this.isOffline = false,
  });

  final Conversation conversation;

  /// Oldest first — the latest sits at the bottom, where a reader expects it.
  final List<Message> messages;

  /// CE-M12-01 — written, not yet sent. Drawn after the rest, since they are
  /// the most recent thing the writer did.
  final List<Message> queued;

  final bool isOffline;

  /// What the thread draws, in one list.
  List<Message> get visible => [...messages, ...queued];

  /// CE-M12-02 — an archived listing locks the thread; the history stays.
  bool get canWrite => !conversation.readOnly;

  ThreadReady copyWith({
    Conversation? conversation,
    List<Message>? messages,
    List<Message>? queued,
    bool? isOffline,
  }) =>
      ThreadReady(
        conversation: conversation ?? this.conversation,
        messages: messages ?? this.messages,
        queued: queued ?? this.queued,
        isOffline: isOffline ?? this.isOffline,
      );

  @override
  List<Object?> get props => [conversation, messages, queued, isOffline];
}

class ThreadFailure extends ThreadState {
  const ThreadFailure();
}
