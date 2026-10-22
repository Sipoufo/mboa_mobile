import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../messaging/data/messaging_repository.dart';
import '../../messaging/models/conversation.dart';
import '../data/home_requests_repository.dart';
import '../models/home_request.dart';

/// One request to the landlord (CDC M30, RM-M30-09) — what N-38 opens:
/// the request, its history, and its exchanges in the property's thread
/// (Mboa's steps and the replies attached to it), from either side.
///
/// The steps are the server's to allow (`canStart`, `canResolve`,
/// `canClose`, `canReopen`); a refusal reads the request again, as it now
/// stands. The exchanges are best-effort: the request stands without them.
class HomeRequestBloc extends Bloc<HomeRequestEvent, HomeRequestState> {
  HomeRequestBloc({required HomeRequestsRepository repository, required MessagingRepository messaging})
      : _repository = repository,
        _messaging = messaging,
        super(const HomeRequestLoading()) {
    on<HomeRequestOpened>(_onOpened);
    on<HomeRequestMoved>((event, emit) => _step(
          emit,
          allowed: (r) => event.status == HomeRequestStatus.inProgress ? r.canStart : r.canResolve,
          call: (r) => _repository.move(r.id, event.status, note: event.note),
        ));
    on<HomeRequestClosed>((event, emit) => _step(
          emit,
          allowed: (r) => r.canClose,
          call: (r) => _repository.close(r.id, note: event.note),
        ));
    on<HomeRequestReopened>((event, emit) => _step(
          emit,
          allowed: (r) => r.canReopen,
          call: (r) => _repository.reopen(r.id, note: event.note),
        ));
    on<HomeRequestReplySent>(_onReply);
  }

  final HomeRequestsRepository _repository;
  final MessagingRepository _messaging;

  Future<void> _onOpened(HomeRequestOpened event, Emitter<HomeRequestState> emit) async {
    emit(const HomeRequestLoading());
    final HomeRequest request;
    try {
      request = await _repository.get(event.id);
    } catch (_) {
      emit(HomeRequestFailure(event.id));
      return;
    }
    emit(HomeRequestReady(request, messages: await _exchanges(request)));
  }

  /// Oldest first, for reading top to bottom.
  Future<List<Message>> _exchanges(HomeRequest request) async {
    final conversationId = request.conversationId;
    if (conversationId == null) return const [];
    try {
      final newestFirst = await _messaging.messages(conversationId, homeRequestId: request.id);
      return newestFirst.reversed.toList();
    } catch (_) {
      return const [];
    }
  }

  Future<void> _step(
    Emitter<HomeRequestState> emit, {
    required bool Function(HomeRequest) allowed,
    required Future<HomeRequest> Function(HomeRequest) call,
  }) async {
    final current = state;
    if (current is! HomeRequestReady || current.isBusy || !allowed(current.request)) return;
    emit(current.copyWith(isBusy: true));
    try {
      final updated = await call(current.request);
      // The step is in the thread too: read it again.
      emit(current.copyWith(request: updated, messages: await _exchanges(updated), moved: true));
    } on HomeRequestRefused catch (refused) {
      HomeRequest fresh;
      try {
        fresh = await _repository.get(current.request.id);
      } catch (_) {
        fresh = current.request;
      }
      emit(current.copyWith(request: fresh, refusal: refused.reason));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(current.copyWith(failed: true));
    }
  }

  /// A reply attached to the request (N-38 to the other party, not N-02).
  Future<void> _onReply(HomeRequestReplySent event, Emitter<HomeRequestState> emit) async {
    final current = state;
    final body = event.body.trim();
    final conversationId = current is HomeRequestReady ? current.request.conversationId : null;
    if (current is! HomeRequestReady || body.isEmpty || conversationId == null || current.isSending) return;
    emit(current.copyWith(isSending: true));
    try {
      final sent = await _messaging.send(conversationId, body: body, homeRequestId: current.request.id);
      emit(current.copyWith(messages: [...current.messages, sent], replied: true));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(current.copyWith(replyFailed: true));
    }
  }
}

sealed class HomeRequestEvent extends Equatable {
  const HomeRequestEvent();

  @override
  List<Object?> get props => [];
}

final class HomeRequestOpened extends HomeRequestEvent {
  const HomeRequestOpened(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// The landlord's: in hand ([HomeRequestStatus.inProgress]) or resolved.
final class HomeRequestMoved extends HomeRequestEvent {
  const HomeRequestMoved(this.status, {this.note});

  final HomeRequestStatus status;
  final String? note;

  @override
  List<Object?> get props => [status, note];
}

/// The tenant's: closed for good.
final class HomeRequestClosed extends HomeRequestEvent {
  const HomeRequestClosed({this.note});

  final String? note;

  @override
  List<Object?> get props => [note];
}

/// The tenant's: resolved, but the problem is still there.
final class HomeRequestReopened extends HomeRequestEvent {
  const HomeRequestReopened({this.note});

  final String? note;

  @override
  List<Object?> get props => [note];
}

final class HomeRequestReplySent extends HomeRequestEvent {
  const HomeRequestReplySent(this.body);

  final String body;

  @override
  List<Object?> get props => [body];
}

sealed class HomeRequestState extends Equatable {
  const HomeRequestState();

  @override
  List<Object?> get props => [];
}

final class HomeRequestLoading extends HomeRequestState {
  const HomeRequestLoading();
}

final class HomeRequestFailure extends HomeRequestState {
  const HomeRequestFailure(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class HomeRequestReady extends HomeRequestState {
  const HomeRequestReady(
    this.request, {
    this.messages = const [],
    this.isBusy = false,
    this.isSending = false,
    this.moved = false,
    this.replied = false,
    this.refusal,
    this.failed = false,
    this.replyFailed = false,
  });

  final HomeRequest request;

  /// Its exchanges, oldest first: Mboa's steps and the replies.
  final List<Message> messages;
  final bool isBusy;
  final bool isSending;

  /// Outcomes, said once.
  final bool moved;
  final bool replied;
  final HomeRequestRefusal? refusal;
  final bool failed;
  final bool replyFailed;

  /// Still open to replies: neither closed nor read only.
  bool get canReply => request.status != HomeRequestStatus.closed && request.conversationId != null;

  HomeRequestReady copyWith({
    HomeRequest? request,
    List<Message>? messages,
    bool isBusy = false,
    bool isSending = false,
    bool moved = false,
    bool replied = false,
    HomeRequestRefusal? refusal,
    bool failed = false,
    bool replyFailed = false,
  }) =>
      HomeRequestReady(
        request ?? this.request,
        messages: messages ?? this.messages,
        isBusy: isBusy,
        isSending: isSending,
        moved: moved,
        replied: replied,
        refusal: refusal,
        failed: failed,
        replyFailed: replyFailed,
      );

  @override
  List<Object?> get props =>
      [request, messages, isBusy, isSending, moved, replied, refusal, failed, replyFailed];
}
