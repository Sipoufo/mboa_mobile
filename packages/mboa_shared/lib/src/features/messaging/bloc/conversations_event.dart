part of 'conversations_bloc.dart';

sealed class ConversationsEvent extends Equatable {
  const ConversationsEvent();

  @override
  List<Object?> get props => [];
}

class ConversationsLoadRequested extends ConversationsEvent {
  const ConversationsLoadRequested();
}

class ConversationsRefreshed extends ConversationsEvent {
  const ConversationsRefreshed();
}

/// On sign-out.
class ConversationsCleared extends ConversationsEvent {
  const ConversationsCleared();
}
