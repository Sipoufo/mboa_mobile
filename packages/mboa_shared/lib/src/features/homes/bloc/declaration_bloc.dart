import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/homes_repository.dart';
import '../models/home.dart';

/// One declared payment (CDC M30), from either side: read, its proofs, and
/// — the landlord's, when the server allows it — confirmed or contested
/// (RM-M30-04, no add-on required, RM-M30-15).
class DeclarationBloc extends Bloc<DeclarationEvent, DeclarationState> {
  DeclarationBloc({required HomesRepository repository})
      : _repository = repository,
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
  }

  final HomesRepository _repository;

  Future<void> _onRequested(DeclarationRequested event, Emitter<DeclarationState> emit) async {
    emit(const DeclarationLoading());
    final Declaration declaration;
    try {
      // The landlord reads it from his inbox (what N-35 opens); the tenant
      // from the space.
      declaration = event.contractId == null
          ? await _repository.receivedDeclaration(event.id)
          : await _repository.declaration(event.contractId!, event.id);
    } catch (_) {
      emit(DeclarationFailure(contractId: event.contractId, id: event.id));
      return;
    }
    emit(DeclarationReady(declaration, proofUrls: await _proofs(declaration)));
  }

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
  });

  final Declaration declaration;
  final List<String> proofUrls;
  final bool isBusy;

  /// The answer that just went through — said once.
  final DeclarationAnswer? done;
  final DeclarationRefusal? refusal;
  final bool failed;

  DeclarationReady copyWith({
    Declaration? declaration,
    bool isBusy = false,
    DeclarationAnswer? done,
    DeclarationRefusal? refusal,
    bool failed = false,
  }) =>
      DeclarationReady(
        declaration ?? this.declaration,
        proofUrls: proofUrls,
        isBusy: isBusy,
        done: done,
        refusal: refusal,
        failed: failed,
      );

  @override
  List<Object?> get props => [declaration, proofUrls, isBusy, done, refusal, failed];
}
