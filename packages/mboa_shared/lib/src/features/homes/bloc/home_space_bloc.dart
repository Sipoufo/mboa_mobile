import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/homes_repository.dart';
import '../models/home.dart';

/// One space of "Mon Logement" (CDC M30), read by either party: the home,
/// a window of its schedule, the declarations, the totals.
///
/// Shared by both apps — the tenant declares from it, the landlord answers
/// from it — so it only reads; what each side may do is the screen's, from
/// the server's own verdicts.
class HomeSpaceBloc extends Bloc<HomeSpaceEvent, HomeSpaceState> {
  HomeSpaceBloc({required HomesRepository repository})
      : _repository = repository,
        super(const HomeSpaceLoading()) {
    on<HomeSpaceRequested>(_onRequested);
    on<HomeSpaceOlderRequested>(_onOlder);
  }

  final HomesRepository _repository;

  Future<void> _onRequested(HomeSpaceRequested event, Emitter<HomeSpaceState> emit) async {
    // A refresh keeps the space on screen rather than blanking it.
    if (state is! HomeSpaceReady) emit(const HomeSpaceLoading());
    try {
      final read = await _repository.bundle(event.contractId);
      emit(
        HomeSpaceReady(
          home: read.value.home,
          schedule: read.value.schedule,
          declarations: read.value.declarations,
          totals: read.value.totals,
          receipts: read.value.receipts,
          isOffline: read.fromCache,
        ),
      );
    } catch (_) {
      if (state is! HomeSpaceReady) emit(HomeSpaceFailure(event.contractId));
    }
  }

  /// Paging back through an old lease (`moreBefore`).
  Future<void> _onOlder(HomeSpaceOlderRequested event, Emitter<HomeSpaceState> emit) async {
    final current = state;
    if (current is! HomeSpaceReady || current.loadingOlder || !current.schedule.moreBefore || current.isOffline) {
      return;
    }
    final first = current.schedule.dues.firstOrNull?.dueDate;
    if (first == null) return;
    emit(current.copyWith(loadingOlder: true));
    try {
      final older = await _repository.scheduleBefore(current.home.contractId, first);
      emit(current.copyWith(schedule: current.schedule.prepend(older)));
    } catch (_) {
      emit(current.copyWith(olderFailed: true));
    }
  }
}

sealed class HomeSpaceEvent extends Equatable {
  const HomeSpaceEvent();

  @override
  List<Object?> get props => [];
}

/// Read (or read again) a space.
final class HomeSpaceRequested extends HomeSpaceEvent {
  const HomeSpaceRequested(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

final class HomeSpaceOlderRequested extends HomeSpaceEvent {
  const HomeSpaceOlderRequested();
}

sealed class HomeSpaceState extends Equatable {
  const HomeSpaceState();

  @override
  List<Object?> get props => [];
}

final class HomeSpaceLoading extends HomeSpaceState {
  const HomeSpaceLoading();
}

/// Not read, and nothing kept.
final class HomeSpaceFailure extends HomeSpaceState {
  const HomeSpaceFailure(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

final class HomeSpaceReady extends HomeSpaceState {
  const HomeSpaceReady({
    required this.home,
    required this.schedule,
    this.declarations = const [],
    this.totals,
    this.receipts = const [],
    this.isOffline = false,
    this.loadingOlder = false,
    this.olderFailed = false,
  });

  final Home home;
  final RentSchedule schedule;
  final List<Declaration> declarations;
  final HomeTotals? totals;

  /// Newest first — each opens its declaration, where its PDF is.
  final List<HomeReceipt> receipts;

  /// The device's copy: shown, marked, nothing declared from it.
  final bool isOffline;
  final bool loadingOlder;

  /// The older échéances did not come — said once.
  final bool olderFailed;

  /// The declarations naming [due], oldest first (the server's ids).
  List<Declaration> declarationsOf(RentDue due) =>
      [for (final d in declarations) if (due.declarationIds.contains(d.id)) d];

  HomeSpaceReady copyWith({RentSchedule? schedule, bool loadingOlder = false, bool olderFailed = false}) =>
      HomeSpaceReady(
        home: home,
        schedule: schedule ?? this.schedule,
        declarations: declarations,
        totals: totals,
        receipts: receipts,
        isOffline: isOffline,
        loadingOlder: loadingOlder,
        olderFailed: olderFailed,
      );

  @override
  List<Object?> get props => [home, schedule, declarations, totals, receipts, isOffline, loadingOlder, olderFailed];
}
