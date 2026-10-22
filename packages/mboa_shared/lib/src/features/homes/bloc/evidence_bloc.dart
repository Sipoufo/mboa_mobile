import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/evidence_repository.dart';
import '../models/evidence.dart';

/// A home's photo proofs (CDC M30 lot 3, RM-M30-11), either party: the
/// sendings, newest first. Offline, the last list read, marked.
class EvidenceBloc extends Bloc<EvidenceEvent, EvidenceState> {
  EvidenceBloc({required EvidenceRepository repository, required this.contractId})
      : _repository = repository,
        super(const EvidenceLoading()) {
    on<EvidenceRequested>(_onRequested);
  }

  final EvidenceRepository _repository;
  final String contractId;

  Future<void> _onRequested(EvidenceRequested event, Emitter<EvidenceState> emit) async {
    if (state is! EvidenceReady) emit(const EvidenceLoading());
    try {
      final read = await _repository.batches(contractId);
      emit(EvidenceReady(items: read.value, isOffline: read.fromCache));
    } catch (_) {
      if (state is! EvidenceReady) emit(const EvidenceFailure());
    }
  }
}

sealed class EvidenceEvent extends Equatable {
  const EvidenceEvent();

  @override
  List<Object?> get props => [];
}

final class EvidenceRequested extends EvidenceEvent {
  const EvidenceRequested();
}

sealed class EvidenceState extends Equatable {
  const EvidenceState();

  @override
  List<Object?> get props => [];
}

final class EvidenceLoading extends EvidenceState {
  const EvidenceLoading();
}

final class EvidenceFailure extends EvidenceState {
  const EvidenceFailure();
}

final class EvidenceReady extends EvidenceState {
  const EvidenceReady({this.items = const [], this.isOffline = false});

  final List<EvidenceBatch> items;
  final bool isOffline;

  @override
  List<Object?> get props => [items, isOffline];
}

/// One sending, its photos with their links — and the landlord's
/// acknowledgement, once, where the server allows it (`canAcknowledge`).
class EvidenceBatchBloc extends Bloc<EvidenceBatchEvent, EvidenceBatchState> {
  EvidenceBatchBloc({required EvidenceRepository repository})
      : _repository = repository,
        super(const EvidenceBatchLoading()) {
    on<EvidenceBatchOpened>(_onOpened);
    on<EvidenceAcknowledged>(_onAcknowledged);
  }

  final EvidenceRepository _repository;

  Future<void> _onOpened(EvidenceBatchOpened event, Emitter<EvidenceBatchState> emit) async {
    emit(const EvidenceBatchLoading());
    try {
      emit(EvidenceBatchReady(await _repository.batch(event.contractId, event.batchId)));
    } catch (_) {
      emit(EvidenceBatchFailure(contractId: event.contractId, batchId: event.batchId));
    }
  }

  Future<void> _onAcknowledged(EvidenceAcknowledged event, Emitter<EvidenceBatchState> emit) async {
    final current = state;
    if (current is! EvidenceBatchReady || current.isBusy || !current.batch.canAcknowledge) return;
    final contractId = current.batch.contractId;
    if (contractId == null) return;
    emit(EvidenceBatchReady(current.batch, isBusy: true));
    try {
      final updated = await _repository.acknowledge(contractId, current.batch.id, comment: event.comment);
      // The links are the detail's: keep them, the acknowledgement is new.
      emit(
        EvidenceBatchReady(
          EvidenceBatch(
            id: updated.id,
            contractId: updated.contractId,
            recordedAt: updated.recordedAt,
            photos: current.batch.photos,
            acknowledgedAt: updated.acknowledgedAt,
            ownerComment: updated.ownerComment,
            canAcknowledge: updated.canAcknowledge,
          ),
          acknowledged: true,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(EvidenceBatchReady(current.batch, failed: true));
    }
  }
}

sealed class EvidenceBatchEvent extends Equatable {
  const EvidenceBatchEvent();

  @override
  List<Object?> get props => [];
}

final class EvidenceBatchOpened extends EvidenceBatchEvent {
  const EvidenceBatchOpened({required this.contractId, required this.batchId});

  final String contractId;
  final String batchId;

  @override
  List<Object?> get props => [contractId, batchId];
}

final class EvidenceAcknowledged extends EvidenceBatchEvent {
  const EvidenceAcknowledged({this.comment});

  final String? comment;

  @override
  List<Object?> get props => [comment];
}

sealed class EvidenceBatchState extends Equatable {
  const EvidenceBatchState();

  @override
  List<Object?> get props => [];
}

final class EvidenceBatchLoading extends EvidenceBatchState {
  const EvidenceBatchLoading();
}

final class EvidenceBatchFailure extends EvidenceBatchState {
  const EvidenceBatchFailure({required this.contractId, required this.batchId});

  final String contractId;
  final String batchId;

  @override
  List<Object?> get props => [contractId, batchId];
}

final class EvidenceBatchReady extends EvidenceBatchState {
  const EvidenceBatchReady(this.batch, {this.isBusy = false, this.acknowledged = false, this.failed = false});

  final EvidenceBatch batch;
  final bool isBusy;

  /// Said once.
  final bool acknowledged;
  final bool failed;

  @override
  List<Object?> get props => [batch, isBusy, acknowledged, failed];
}
