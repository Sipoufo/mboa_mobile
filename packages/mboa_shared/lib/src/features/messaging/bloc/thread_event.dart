part of 'thread_bloc.dart';

sealed class ThreadEvent extends Equatable {
  const ThreadEvent();

  @override
  List<Object?> get props => [];
}

/// Opens a thread. Takes the conversation rather than an id: the list already
/// has the title, the peer and the read-only flag, so the screen has something
/// to draw while the messages load.
class ThreadRequested extends ThreadEvent {
  const ThreadRequested(this.conversation);

  final Conversation conversation;

  @override
  List<Object?> get props => [conversation];
}

class ThreadMessageSent extends ThreadEvent {
  const ThreadMessageSent(this.body, {this.attachmentKeys = const []});

  final String body;

  /// RM-M12-04 — images only, at most three, already compressed and uploaded.
  final List<String> attachmentKeys;

  @override
  List<Object?> get props => [body, attachmentKeys];
}

/// CE-M12-01 — the network came back.
class ThreadQueueFlushed extends ThreadEvent {
  const ThreadQueueFlushed();
}
