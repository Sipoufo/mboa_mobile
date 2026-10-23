import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/evidence_repository.dart';
import '../models/evidence.dart';

/// Before / after (CA-M31-04): a home's entry and exit photos, room by
/// room — either party, during the tenancy or after it. The links are
/// short-lived, so nothing is kept offline: offline, it says so.
class EvidenceCompareBloc extends Bloc<EvidenceCompareEvent, EvidenceCompareState> {
  EvidenceCompareBloc({required EvidenceRepository repository})
      : _repository = repository,
        super(const EvidenceCompareLoading()) {
    on<EvidenceCompareRequested>(_onRequested);
  }

  final EvidenceRepository _repository;

  Future<void> _onRequested(EvidenceCompareRequested event, Emitter<EvidenceCompareState> emit) async {
    emit(const EvidenceCompareLoading());
    try {
      emit(EvidenceCompareReady(await _repository.compare(event.contractId)));
    } catch (_) {
      emit(EvidenceCompareFailure(event.contractId));
    }
  }
}

sealed class EvidenceCompareEvent extends Equatable {
  const EvidenceCompareEvent();

  @override
  List<Object?> get props => [];
}

final class EvidenceCompareRequested extends EvidenceCompareEvent {
  const EvidenceCompareRequested(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

sealed class EvidenceCompareState extends Equatable {
  const EvidenceCompareState();

  @override
  List<Object?> get props => [];
}

final class EvidenceCompareLoading extends EvidenceCompareState {
  const EvidenceCompareLoading();
}

/// Mostly offline: the photos' links are asked each time.
final class EvidenceCompareFailure extends EvidenceCompareState {
  const EvidenceCompareFailure(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

final class EvidenceCompareReady extends EvidenceCompareState {
  const EvidenceCompareReady(this.rooms);

  /// In the order the rooms were first photographed.
  final List<EvidenceRoomPair> rooms;

  @override
  List<Object?> get props => [rooms];
}
