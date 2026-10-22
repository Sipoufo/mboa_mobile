import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../media/pdf_sharer.dart';
import '../data/homes_repository.dart';
import '../models/home.dart';

/// One declared payment (CDC M30), from either side: read, its proofs, and
/// — the landlord's, when the server allows it — confirmed or contested
/// (RM-M30-04, no add-on required, RM-M30-15).
///
/// Once confirmed, its receipt (slice D): the confirmation names it at once
/// and its PDF follows within seconds (CA-M30-02). Until then the
/// declaration is read again every [receiptPoll], [receiptPollTries] times
/// at most; then the screen offers to try again.
class DeclarationBloc extends Bloc<DeclarationEvent, DeclarationState> {
  DeclarationBloc({
    required HomesRepository repository,
    PdfSharer? sharer,
    this.receiptPoll = const Duration(seconds: 3),
    this.receiptPollTries = 10,
  })  : _repository = repository,
        _sharer = sharer ?? PdfSharer(),
        super(const DeclarationLoading()) {
    on<DeclarationRequested>(_onRequested);
    on<DeclarationConfirmed>((event, emit) => _answer(
          emit,
          DeclarationAnswer.confirmed,
          allowed: (d) => d.canConfirm,
          call: (d) => _repository.confirm(d.id),
        ));
    on<DeclarationContested>((event, emit) {
      final reason = event.reason.trim();
      if (reason.isEmpty) return Future.value();
      return _answer(
        emit,
        DeclarationAnswer.contested,
        allowed: (d) => d.canContest,
        call: (d) => _repository.contest(d.id, reason: reason),
      );
    });
    on<DeclarationReceiptRequested>(_onReceipt);
    on<DeclarationReceiptRefreshed>(_onReceiptRefreshed);
  }

  final HomesRepository _repository;
  final PdfSharer _sharer;
  final Duration receiptPoll;
  final int receiptPollTries;

  /// The tenant's read goes through the space; null for the landlord's.
  String? _contractId;
  Timer? _poll;
  int _tries = 0;

  Future<void> _onRequested(DeclarationRequested event, Emitter<DeclarationState> emit) async {
    _contractId = event.contractId;
    emit(const DeclarationLoading());
    final Declaration declaration;
    try {
      declaration = await _read(event.id);
    } catch (_) {
      emit(DeclarationFailure(contractId: event.contractId, id: event.id));
      return;
    }
    emit(DeclarationReady(declaration, proofUrls: await _proofs(declaration)));
    _tries = 0;
    _waitForReceipt(declaration);
  }

  // The landlord reads it from his inbox (what N-35 opens); the tenant from
  // the space.
  Future<Declaration> _read(String id) =>
      _contractId == null ? _repository.receivedDeclaration(id) : _repository.declaration(_contractId!, id);

  /// Short-lived links, best-effort: the declaration stands without them.
  Future<List<String>> _proofs(Declaration declaration) async {
    final contractId = declaration.contractId;
    if (!declaration.hasProof || contractId == null) return const [];
    try {
      return await _repository.proofUrls(contractId, declaration.id);
    } catch (_) {
      return const [];
    }
  }

  Future<void> _answer(
    Emitter<DeclarationState> emit,
    DeclarationAnswer answer, {
    required bool Function(Declaration) allowed,
    required Future<Declaration> Function(Declaration) call,
  }) async {
    final current = state;
    if (current is! DeclarationReady || current.isBusy || !allowed(current.declaration)) return;
    emit(current.copyWith(isBusy: true));
    try {
      final updated = await call(current.declaration);
      emit(current.copyWith(declaration: updated, done: answer));
      _tries = 0;
      _waitForReceipt(updated);
    } on DeclarationRefused catch (refused) {
      Declaration fresh;
      try {
        fresh = await _repository.receivedDeclaration(current.declaration.id);
      } catch (_) {
        fresh = current.declaration;
      }
      emit(current.copyWith(declaration: fresh, refusal: refused.reason));
    } catch (_) {
      emit(current.copyWith(failed: true));
    }
  }

  /// Named but not made yet: read again shortly.
  void _waitForReceipt(Declaration declaration) {
    _poll?.cancel();
    if (declaration.receiptId == null || declaration.receiptReady) return;
    _poll = Timer(receiptPoll, () {
      if (!isClosed) add(const DeclarationReceiptRefreshed());
    });
  }

  Future<void> _onReceiptRefreshed(DeclarationReceiptRefreshed event, Emitter<DeclarationState> emit) async {
    final current = state;
    if (current is! DeclarationReady) return;
    if (event.byHand) _tries = 0;
    _tries++;
    Declaration fresh;
    try {
      fresh = await _read(current.declaration.id);
    } catch (_) {
      fresh = current.declaration;
    }
    final waitOver = !fresh.receiptReady && _tries >= receiptPollTries;
    emit(current.copyWith(declaration: fresh, receiptWaitOver: waitOver));
    if (!waitOver) _waitForReceipt(fresh);
  }

  /// Fetched and offered on the share sheet; [DeclarationReceiptRequested.name]
  /// is the file name the user sees.
  Future<void> _onReceipt(DeclarationReceiptRequested event, Emitter<DeclarationState> emit) async {
    final current = state;
    if (current is! DeclarationReady || current.receiptBusy) return;
    final receiptId = current.declaration.receiptId;
    if (receiptId == null) return;
    emit(current.copyWith(receiptBusy: true));
    try {
      final url = await _repository.receiptPdfUrl(receiptId);
      await _sharer.shareLink(url, name: event.name);
      emit(current.copyWith());
    } on ReceiptNotReady {
      emit(current.copyWith(receiptNotReady: true));
    } catch (error, stackTrace) {
      // Said on screen, and reported: the link, the download or the share
      // sheet — the toast cannot tell which.
      addError(error, stackTrace);
      emit(current.copyWith(receiptFailed: true));
    }
  }

  @override
  Future<void> close() {
    _poll?.cancel();
    return super.close();
  }
}

enum DeclarationAnswer { confirmed, contested }

sealed class DeclarationEvent extends Equatable {
  const DeclarationEvent();

  @override
  List<Object?> get props => [];
}

/// [contractId] for the tenant's read; null for the landlord's.
final class DeclarationRequested extends DeclarationEvent {
  const DeclarationRequested({required this.id, this.contractId});

  final String id;
  final String? contractId;

  @override
  List<Object?> get props => [id, contractId];
}

final class DeclarationConfirmed extends DeclarationEvent {
  const DeclarationConfirmed();
}

final class DeclarationContested extends DeclarationEvent {
  const DeclarationContested(this.reason);

  final String reason;

  @override
  List<Object?> get props => [reason];
}

/// The receipt's PDF, fetched and offered as `[name].pdf`.
final class DeclarationReceiptRequested extends DeclarationEvent {
  const DeclarationReceiptRequested({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

/// Read again while the receipt is made — by the timer, or [byHand] once
/// the wait is over.
final class DeclarationReceiptRefreshed extends DeclarationEvent {
  const DeclarationReceiptRefreshed({this.byHand = false});

  final bool byHand;

  @override
  List<Object?> get props => [byHand];
}

sealed class DeclarationState extends Equatable {
  const DeclarationState();

  @override
  List<Object?> get props => [];
}

final class DeclarationLoading extends DeclarationState {
  const DeclarationLoading();
}

final class DeclarationFailure extends DeclarationState {
  const DeclarationFailure({required this.id, this.contractId});

  final String id;
  final String? contractId;

  @override
  List<Object?> get props => [id, contractId];
}

final class DeclarationReady extends DeclarationState {
  const DeclarationReady(
    this.declaration, {
    this.proofUrls = const [],
    this.isBusy = false,
    this.done,
    this.refusal,
    this.failed = false,
    this.receiptBusy = false,
    this.receiptNotReady = false,
    this.receiptFailed = false,
    this.receiptWaitOver = false,
  });

  final Declaration declaration;
  final List<String> proofUrls;
  final bool isBusy;

  /// The answer that just went through — said once.
  final DeclarationAnswer? done;
  final DeclarationRefusal? refusal;
  final bool failed;

  /// The receipt's PDF is being fetched.
  final bool receiptBusy;

  /// The server is still making it — said once.
  final bool receiptNotReady;

  /// It could not be fetched — said once.
  final bool receiptFailed;

  /// Still not made after the automatic reads: the screen offers to try
  /// again. Kept until a read finds it.
  final bool receiptWaitOver;

  /// Named, not made yet: « Quittance en préparation ».
  bool get receiptPending => declaration.receiptId != null && !declaration.receiptReady;

  /// Outcomes are said once and not carried over; the wait is.
  DeclarationReady copyWith({
    Declaration? declaration,
    bool isBusy = false,
    DeclarationAnswer? done,
    DeclarationRefusal? refusal,
    bool failed = false,
    bool receiptBusy = false,
    bool receiptNotReady = false,
    bool receiptFailed = false,
    bool? receiptWaitOver,
  }) =>
      DeclarationReady(
        declaration ?? this.declaration,
        proofUrls: proofUrls,
        isBusy: isBusy,
        done: done,
        refusal: refusal,
        failed: failed,
        receiptBusy: receiptBusy,
        receiptNotReady: receiptNotReady,
        receiptFailed: receiptFailed,
        receiptWaitOver: receiptWaitOver ?? this.receiptWaitOver,
      );

  @override
  List<Object?> get props => [
        declaration,
        proofUrls,
        isBusy,
        done,
        refusal,
        failed,
        receiptBusy,
        receiptNotReady,
        receiptFailed,
        receiptWaitOver,
      ];
}
