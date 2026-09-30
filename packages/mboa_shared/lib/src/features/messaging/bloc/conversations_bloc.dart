import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/messaging_repository.dart';
import '../models/conversation.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

/// The list of threads (CDC M12).
///
/// Shared by both apps: a tenant and a prestataire see the same list, sorted by
/// the server, and the only difference is that one of them may start a new one
/// (RM-M12-01). Held as a single instance per session so the unread badge on a
/// tab and the list itself cannot disagree.
class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  ConversationsBloc({required MessagingRepository repository})
      : _repository = repository,
        super(const ConversationsInitial()) {
    on<ConversationsLoadRequested>(_onLoad);
    on<ConversationsRefreshed>(_onRefresh);
    on<ConversationsCleared>(_onCleared);
  }

  final MessagingRepository _repository;

  Future<void> _onLoad(
    ConversationsLoadRequested event,
    Emitter<ConversationsState> emit,
  ) async {
    emit(const ConversationsLoadInProgress());
    await _read(emit);
  }

  Future<void> _onRefresh(
    ConversationsRefreshed event,
    Emitter<ConversationsState> emit,
  ) =>
      _read(emit);

  /// Threads belong to an account; the next person to open the app must not
  /// see the last one's.
  void _onCleared(
    ConversationsCleared event,
    Emitter<ConversationsState> emit,
  ) =>
      emit(const ConversationsInitial());

  Future<void> _read(Emitter<ConversationsState> emit) async {
    try {
      emit(ConversationsReady(items: await _repository.conversations()));
    } catch (_) {
      // A failed refresh keeps whatever is on screen.
      if (state is! ConversationsReady) emit(const ConversationsFailure());
    }
  }
}
