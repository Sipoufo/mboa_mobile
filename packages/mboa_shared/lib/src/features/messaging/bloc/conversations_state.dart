part of 'conversations_bloc.dart';

sealed class ConversationsState extends Equatable {
  const ConversationsState();

  @override
  List<Object?> get props => [];

  /// Asked by the tab badge before the list has loaded, so it lives here and
  /// answers zero rather than making every caller pattern-match.
  int get unreadTotal => 0;
}

class ConversationsInitial extends ConversationsState {
  const ConversationsInitial();
}

class ConversationsLoadInProgress extends ConversationsState {
  const ConversationsLoadInProgress();
}

class ConversationsReady extends ConversationsState {
  const ConversationsReady({this.items = const []});

  /// In the server's order — most recent exchange first.
  final List<Conversation> items;

  @override
  int get unreadTotal =>
      items.fold(0, (total, conversation) => total + conversation.unreadCount);

  @override
  List<Object?> get props => [items];
}

class ConversationsFailure extends ConversationsState {
  const ConversationsFailure();
}
