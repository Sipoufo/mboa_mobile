import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// One ended tenancy (CDC M31): the sheet, and its expenses statement —
/// made by the server from confirmed payments only (RM-M31-03), offered on
/// the share sheet. The sheet reads offline; the statement needs the
/// network.
class PastHomeBloc extends Bloc<PastHomeEvent, PastHomeState> {
  PastHomeBloc({required PastHomesRepository repository, PdfSharer? sharer})
      : _repository = repository,
        _sharer = sharer ?? PdfSharer(),
        super(const PastHomeLoading()) {
    on<PastHomeRequested>(_onRequested);
    on<PastHomeStatementRequested>(_onStatement);
  }

  final PastHomesRepository _repository;
  final PdfSharer _sharer;

  Future<void> _onRequested(PastHomeRequested event, Emitter<PastHomeState> emit) async {
    if (state is! PastHomeReady) emit(const PastHomeLoading());
    try {
      final read = await _repository.get(event.contractId);
      emit(PastHomeReady(past: read.value, isOffline: read.fromCache));
    } catch (_) {
      if (state is! PastHomeReady) emit(PastHomeFailure(event.contractId));
    }
  }

  /// [PastHomeStatementRequested.name] is the file name the user sees.
  Future<void> _onStatement(PastHomeStatementRequested event, Emitter<PastHomeState> emit) async {
    final current = state;
    if (current is! PastHomeReady || current.statementBusy) return;
    emit(current.copyWith(statementBusy: true));
    try {
      final bytes = await _repository.expensesPdf(current.past.home.contractId);
      await _sharer.shareBytes(bytes, name: event.name);
      emit(current.copyWith());
    } catch (error, stackTrace) {
      // Said on screen, and reported: offline, the server or the share sheet.
      addError(error, stackTrace);
      emit(current.copyWith(statementFailed: true));
    }
  }
}

sealed class PastHomeEvent extends Equatable {
  const PastHomeEvent();

  @override
  List<Object?> get props => [];
}

final class PastHomeRequested extends PastHomeEvent {
  const PastHomeRequested(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

final class PastHomeStatementRequested extends PastHomeEvent {
  const PastHomeStatementRequested({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

sealed class PastHomeState extends Equatable {
  const PastHomeState();

  @override
  List<Object?> get props => [];
}

final class PastHomeLoading extends PastHomeState {
  const PastHomeLoading();
}

final class PastHomeFailure extends PastHomeState {
  const PastHomeFailure(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

final class PastHomeReady extends PastHomeState {
  const PastHomeReady({
    required this.past,
    this.isOffline = false,
    this.statementBusy = false,
    this.statementFailed = false,
  });

  final PastHome past;
  final bool isOffline;
  final bool statementBusy;
  final bool statementFailed;

  /// Outcomes are not carried over.
  PastHomeReady copyWith({bool statementBusy = false, bool statementFailed = false}) => PastHomeReady(
        past: past,
        isOffline: isOffline,
        statementBusy: statementBusy,
        statementFailed: statementFailed,
      );

  @override
  List<Object?> get props => [past, isOffline, statementBusy, statementFailed];
}
