import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/finance_properties.dart';
import '../data/ledger_repository.dart';
import '../models/finance_refusal.dart';
import '../models/ledger.dart';

/// The landlord's register (CDC M25): the figures over a period and a
/// property — in, out, net, by category (RM-M25-03) —, the lines beneath,
/// and the CSV of the same (RM-M25-05). Readable offline.
class LedgerBloc extends Bloc<LedgerEvent, LedgerState> {
  LedgerBloc({required LedgerRepository repository, required FinanceProperties properties, PdfSharer? sharer})
      : _repository = repository,
        _properties = properties,
        _sharer = sharer ?? PdfSharer(),
        super(const LedgerLoading()) {
    on<LedgerStarted>(_onStarted);
    on<LedgerScopeChanged>((event, emit) => _load(emit, event.scope));
    on<LedgerRefreshed>((event, emit) {
      final current = state;
      return _load(emit, current is LedgerReady ? current.scope : const LedgerScope());
    });
    on<LedgerNextPageRequested>(_onNextPage);
    on<LedgerExportRequested>(_onExport);
  }

  final LedgerRepository _repository;
  final FinanceProperties _properties;
  final PdfSharer _sharer;

  Future<void> _onStarted(LedgerStarted event, Emitter<LedgerState> emit) async {
    await _load(emit, const LedgerScope());
    // The properties, for the filter — none offline: « Tous » still works.
    final choices = await _properties.choices();
    if (state case final LedgerReady ready) emit(ready.copyWith(properties: choices));
  }

  Future<void> _load(Emitter<LedgerState> emit, LedgerScope scope) async {
    final current = state;
    if (current is LedgerReady) emit(current.copyWith(scope: scope, isLoading: true));
    try {
      final (entries, summary) = await (_repository.entries(scope), _repository.summary(scope)).wait;
      emit(LedgerReady(
        scope: scope,
        summary: summary.value,
        entries: entries.value.entries,
        isLast: entries.value.isLast,
        isOffline: entries.fromCache || summary.fromCache,
        properties: current is LedgerReady ? current.properties : const [],
      ));
    } on FinanceRefused catch (refused) {
      emit(current is LedgerReady
          ? current.copyWith(loadFailed: true)
          : LedgerFailure(planRequired: refused.reason == FinanceRefusal.planRequired));
    } catch (_) {
      emit(current is LedgerReady ? current.copyWith(loadFailed: true) : const LedgerFailure());
    }
  }

  Future<void> _onNextPage(LedgerNextPageRequested event, Emitter<LedgerState> emit) async {
    final current = state;
    if (current is! LedgerReady || current.isLast || current.isLoadingMore || current.isOffline) return;
    emit(current.copyWith(isLoadingMore: true));
    try {
      final page = (await _repository.entries(current.scope, page: current.page + 1)).value;
      emit(current.copyWith(entries: [...current.entries, ...page.entries], page: current.page + 1, isLast: page.isLast));
    } catch (_) {
      emit(current.copyWith(loadFailed: true));
    }
  }

  /// [LedgerExportRequested.name] is the file name the user sees.
  Future<void> _onExport(LedgerExportRequested event, Emitter<LedgerState> emit) async {
    final current = state;
    if (current is! LedgerReady || current.isExporting) return;
    emit(current.copyWith(isExporting: true));
    try {
      final csv = await _repository.exportCsv(current.scope);
      await _sharer.shareFile(csv, name: event.name, extension: 'csv', mimeType: 'text/csv');
      emit(current.copyWith());
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(current.copyWith(exportFailed: true));
    }
  }
}

sealed class LedgerEvent extends Equatable {
  const LedgerEvent();

  @override
  List<Object?> get props => [];
}

final class LedgerStarted extends LedgerEvent {
  const LedgerStarted();
}

final class LedgerScopeChanged extends LedgerEvent {
  const LedgerScopeChanged(this.scope);

  final LedgerScope scope;

  @override
  List<Object?> get props => [scope];
}

/// Read again — after a line was added, changed or removed.
final class LedgerRefreshed extends LedgerEvent {
  const LedgerRefreshed();
}

final class LedgerNextPageRequested extends LedgerEvent {
  const LedgerNextPageRequested();
}

final class LedgerExportRequested extends LedgerEvent {
  const LedgerExportRequested({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

sealed class LedgerState extends Equatable {
  const LedgerState();

  @override
  List<Object?> get props => [];
}

final class LedgerLoading extends LedgerState {
  const LedgerLoading();
}

final class LedgerFailure extends LedgerState {
  const LedgerFailure({this.planRequired = false});

  /// Never held the finance tools: the server refuses even reading
  /// (`FINANCE_PLAN_REQUIRED`) — the page points at the plans, not at retry.
  final bool planRequired;

  @override
  List<Object?> get props => [planRequired];
}

final class LedgerReady extends LedgerState {
  const LedgerReady({
    required this.scope,
    this.summary = const LedgerSummary(),
    this.entries = const [],
    this.page = 0,
    this.isLast = true,
    this.isOffline = false,
    this.properties = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isExporting = false,
    this.loadFailed = false,
    this.exportFailed = false,
  });

  final LedgerScope scope;
  final LedgerSummary summary;

  /// Newest first — the server's order.
  final List<LedgerEntry> entries;
  final int page;
  final bool isLast;
  final bool isOffline;

  /// What the filter can narrow to.
  final List<LedgerProperty> properties;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isExporting;

  /// Once: a read that failed while something was on screen.
  final bool loadFailed;
  final bool exportFailed;

  /// Outcomes are not carried over.
  LedgerReady copyWith({
    LedgerScope? scope,
    List<LedgerEntry>? entries,
    int? page,
    bool? isLast,
    List<LedgerProperty>? properties,
    bool isLoading = false,
    bool isLoadingMore = false,
    bool isExporting = false,
    bool loadFailed = false,
    bool exportFailed = false,
  }) =>
      LedgerReady(
        scope: scope ?? this.scope,
        summary: summary,
        entries: entries ?? this.entries,
        page: page ?? this.page,
        isLast: isLast ?? this.isLast,
        isOffline: isOffline,
        properties: properties ?? this.properties,
        isLoading: isLoading,
        isLoadingMore: isLoadingMore,
        isExporting: isExporting,
        loadFailed: loadFailed,
        exportFailed: exportFailed,
      );

  @override
  List<Object?> get props => [
        scope,
        summary,
        entries,
        page,
        isLast,
        isOffline,
        properties,
        isLoading,
        isLoadingMore,
        isExporting,
        loadFailed,
        exportFailed,
      ];
}
