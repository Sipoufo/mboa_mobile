import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/inbox_repository.dart';
import '../models/inbox_item.dart';

/// The notifications page and the bell's count (§38) — one instance per
/// session, so the bell and the page never disagree. Dropped at sign-out.
class InboxBloc extends Bloc<InboxEvent, InboxState> {
  InboxBloc({required InboxRepository repository, DateTime Function()? now})
      : _repository = repository,
        _now = now ?? DateTime.now,
        super(const InboxInitial()) {
    on<InboxUnreadCountRequested>(_onCountRequested);
    on<InboxRequested>(_onRequested);
    on<InboxNextPageRequested>(_onNextPage);
    on<InboxItemOpened>(_onItemOpened);
    on<InboxAllReadRequested>(_onAllRead);
  }

  final InboxRepository _repository;
  final DateTime Function() _now;

  Future<void> _onCountRequested(InboxUnreadCountRequested event, Emitter<InboxState> emit) async {
    try {
      final count = await _repository.unreadCount();
      emit(state.withUnread(count));
    } catch (_) {
      // Offline: the bell keeps what it showed.
    }
  }

  Future<void> _onRequested(InboxRequested event, Emitter<InboxState> emit) async {
    final current = state;
    // A refresh keeps the list on screen; only the first read shows a loader.
    if (current is! InboxReady) emit(InboxLoading(unread: current.unread));
    try {
      final read = await _repository.page(0);
      final items = read.value.items;
      emit(InboxReady(
        items: items,
        isLast: read.value.isLast,
        isOffline: read.fromCache,
        // Online, the server's count; offline, what the kept page says.
        unread: read.fromCache ? items.where((i) => !i.isRead).length : await _countOr(items),
      ));
    } catch (_) {
      if (current is! InboxReady) emit(InboxFailure(unread: current.unread));
    }
  }

  /// The count covers the 30 days, not only the first page.
  Future<int> _countOr(List<InboxItem> items) async {
    try {
      return await _repository.unreadCount();
    } catch (_) {
      return items.where((i) => !i.isRead).length;
    }
  }

  Future<void> _onNextPage(InboxNextPageRequested event, Emitter<InboxState> emit) async {
    final current = state;
    if (current is! InboxReady || current.isLast || current.isLoadingMore || current.isOffline) return;
    emit(current.copyWith(isLoadingMore: true));
    try {
      final read = await _repository.page(current.page + 1);
      final latest = state is InboxReady ? state as InboxReady : current;
      emit(latest.copyWith(
        items: [...latest.items, ...read.value.items],
        page: current.page + 1,
        isLast: read.value.isLast,
        isLoadingMore: false,
      ));
    } catch (_) {
      final latest = state is InboxReady ? state as InboxReady : current;
      emit(latest.copyWith(isLoadingMore: false));
    }
  }

  /// Opened: read at once on screen; the server is told after. Telling it is
  /// idempotent, and a failure is corrected by the next read.
  Future<void> _onItemOpened(InboxItemOpened event, Emitter<InboxState> emit) async {
    final current = state;
    if (current is InboxReady) {
      final item = current.items.where((i) => i.id == event.id).firstOrNull;
      if (item == null || item.isRead) return;
      emit(current.copyWith(
        items: [for (final i in current.items) i.id == event.id ? i.readOn(_now()) : i],
        unread: current.unread > 0 ? current.unread - 1 : 0,
      ));
    }
    try {
      await _repository.markRead(event.id);
    } catch (_) {}
  }

  /// « Tout marquer comme lu ». Offline or refused, nothing changed, and the
  /// screen says so.
  Future<void> _onAllRead(InboxAllReadRequested event, Emitter<InboxState> emit) async {
    final current = state;
    if (current is! InboxReady || current.unread == 0) return;
    final at = _now();
    emit(current.copyWith(items: [for (final i in current.items) i.readOn(at)], unread: 0));
    try {
      await _repository.markAllRead();
    } catch (_) {
      final latest = state is InboxReady ? state as InboxReady : current;
      emit(latest.copyWith(items: current.items, unread: current.unread, allReadFailed: true));
    }
  }
}

sealed class InboxEvent extends Equatable {
  const InboxEvent();

  @override
  List<Object?> get props => [];
}

/// The bell's count — on each return to the home screen, and when a push
/// lands with the app open.
final class InboxUnreadCountRequested extends InboxEvent {
  const InboxUnreadCountRequested();
}

/// The page opened, or pulled to refresh.
final class InboxRequested extends InboxEvent {
  const InboxRequested();
}

final class InboxNextPageRequested extends InboxEvent {
  const InboxNextPageRequested();
}

final class InboxItemOpened extends InboxEvent {
  const InboxItemOpened(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class InboxAllReadRequested extends InboxEvent {
  const InboxAllReadRequested();
}

/// Every state carries the bell's count, so the bell reads the one bloc
/// whether or not the page was ever opened.
sealed class InboxState extends Equatable {
  const InboxState({this.unread = 0});

  final int unread;

  InboxState withUnread(int unread) => switch (this) {
        InboxInitial() => InboxInitial(unread: unread),
        InboxLoading() => InboxLoading(unread: unread),
        InboxFailure() => InboxFailure(unread: unread),
        final InboxReady ready => ready.copyWith(unread: unread),
      };

  @override
  List<Object?> get props => [unread];
}

final class InboxInitial extends InboxState {
  const InboxInitial({super.unread});
}

final class InboxLoading extends InboxState {
  const InboxLoading({super.unread});
}

final class InboxFailure extends InboxState {
  const InboxFailure({super.unread});
}

final class InboxReady extends InboxState {
  const InboxReady({
    required this.items,
    super.unread,
    this.page = 0,
    this.isLast = true,
    this.isLoadingMore = false,
    this.isOffline = false,
    this.allReadFailed = false,
  });

  /// Newest first.
  final List<InboxItem> items;
  final int page;
  final bool isLast;
  final bool isLoadingMore;

  /// The kept first page: no paging, and the screen says it is not live.
  final bool isOffline;

  /// Once: « Tout marquer comme lu » did not go through.
  final bool allReadFailed;

  /// The items day by day, newest day first — each day's order kept.
  List<(DateTime, List<InboxItem>)> get byDay {
    final days = <DateTime, List<InboxItem>>{};
    for (final item in items) {
      final at = item.createdAt;
      final day = at == null ? DateTime(0) : DateTime(at.year, at.month, at.day);
      (days[day] ??= []).add(item);
    }
    return [for (final MapEntry(:key, :value) in days.entries) (key, value)];
  }

  InboxReady copyWith({
    List<InboxItem>? items,
    int? unread,
    int? page,
    bool? isLast,
    bool? isLoadingMore,
    bool allReadFailed = false,
  }) =>
      InboxReady(
        items: items ?? this.items,
        unread: unread ?? this.unread,
        page: page ?? this.page,
        isLast: isLast ?? this.isLast,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        isOffline: isOffline,
        allReadFailed: allReadFailed,
      );

  @override
  List<Object?> get props => [items, unread, page, isLast, isLoadingMore, isOffline, allReadFailed];
}
