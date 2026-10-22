import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Sending photo proofs (CDC M30 lot 3, RM-M30-11): one phase, up to 20
/// photos, each with its room and a word. The photos are prepared as they
/// are picked — compressed, EXIF gone, fingerprinted on the bytes that will
/// travel — and sent together; Mboa records them with its own time.
class EvidenceSendBloc extends Bloc<EvidenceSendEvent, EvidenceSendState> {
  EvidenceSendBloc({required EvidenceRepository repository, required PhotoPreparer preparer})
      : _repository = repository,
        _preparer = preparer,
        super(const EvidenceSendState()) {
    on<EvidenceSendStarted>((event, emit) => emit(EvidenceSendState(contractId: event.contractId)));
    on<EvidencePhaseChanged>((event, emit) {
      if (!state.isSending) emit(state.copyWith(phase: event.phase));
    });
    on<EvidencePhotosPicked>(_onPicked);
    on<EvidenceShotChanged>((event, emit) {
      if (state.isSending || event.index >= state.shots.length) return;
      final shots = [...state.shots];
      shots[event.index] = shots[event.index].copyWith(room: event.room, roomLabel: event.roomLabel, comment: event.comment);
      emit(state.copyWith(shots: shots));
    });
    on<EvidenceShotRemoved>((event, emit) {
      if (state.isSending || event.index >= state.shots.length) return;
      emit(state.copyWith(shots: [...state.shots]..removeAt(event.index)));
    });
    on<EvidenceSendSubmitted>(_onSubmitted);
  }

  final EvidenceRepository _repository;
  final PhotoPreparer _preparer;

  Future<void> _onPicked(EvidencePhotosPicked event, Emitter<EvidenceSendState> emit) async {
    if (!state.hasRoom || state.isPicking || state.isSending) return;
    emit(state.copyWith(isPicking: true));
    try {
      final photos = await _preparer.pick(event.source, limit: state.room);
      // The same photo twice would be refused as already recorded.
      final known = {for (final s in state.shots) s.photo.sha256};
      emit(
        state.copyWith(
          shots: [
            ...state.shots,
            for (final photo in photos)
              if (known.add(photo.sha256)) EvidenceShot(photo: photo),
          ],
        ),
      );
    } catch (_) {
      emit(state.copyWith(pickFailed: true));
    }
  }

  Future<void> _onSubmitted(EvidenceSendSubmitted event, Emitter<EvidenceSendState> emit) async {
    final contractId = state.contractId;
    if (contractId == null || state.shots.isEmpty || state.isSending || state.isPicking) return;
    emit(state.copyWith(isSending: true, uploaded: 0));
    try {
      final batch = await _repository.send(
        contractId,
        state.phase,
        state.shots,
        onUploaded: (done, _) => emit(state.copyWith(isSending: true, uploaded: done)),
      );
      emit(state.copyWith(sent: batch));
    } on EvidenceRefused catch (refused) {
      emit(state.copyWith(refusal: refused.reason));
    } on EvidenceUploadFailed {
      // CE-M30-01 — three tries already: said, the photos kept.
      emit(state.copyWith(uploadFailed: true));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }
}

sealed class EvidenceSendEvent extends Equatable {
  const EvidenceSendEvent();

  @override
  List<Object?> get props => [];
}

final class EvidenceSendStarted extends EvidenceSendEvent {
  const EvidenceSendStarted(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

final class EvidencePhaseChanged extends EvidenceSendEvent {
  const EvidencePhaseChanged(this.phase);

  final EvidencePhase phase;

  @override
  List<Object?> get props => [phase];
}

final class EvidencePhotosPicked extends EvidenceSendEvent {
  const EvidencePhotosPicked(this.source);

  final ImageSource source;

  @override
  List<Object?> get props => [source];
}

/// What changed of one photo — the rest stays.
final class EvidenceShotChanged extends EvidenceSendEvent {
  const EvidenceShotChanged(this.index, {this.room, this.roomLabel, this.comment});

  final int index;
  final EvidenceRoom? room;
  final String? roomLabel;
  final String? comment;

  @override
  List<Object?> get props => [index, room, roomLabel, comment];
}

final class EvidenceShotRemoved extends EvidenceSendEvent {
  const EvidenceShotRemoved(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

final class EvidenceSendSubmitted extends EvidenceSendEvent {
  const EvidenceSendSubmitted();
}

class EvidenceSendState extends Equatable {
  const EvidenceSendState({
    this.contractId,
    this.phase = EvidencePhase.entry,
    this.shots = const [],
    this.isPicking = false,
    this.isSending = false,
    this.uploaded = 0,
    this.sent,
    this.refusal,
    this.failed = false,
    this.uploadFailed = false,
    this.pickFailed = false,
  });

  final String? contractId;
  final EvidencePhase phase;
  final List<EvidenceShot> shots;
  final bool isPicking;
  final bool isSending;

  /// Photos in storage so far, while sending.
  final int uploaded;

  /// The sending as Mboa recorded it — the screen closes on it.
  final EvidenceBatch? sent;
  final EvidenceRefusal? refusal;
  final bool failed;
  final bool uploadFailed;
  final bool pickFailed;

  /// How many more fit in this sending.
  int get room => EvidenceRepository.maxPerSending - shots.length;
  bool get hasRoom => room > 0;

  /// Outcomes are not carried over.
  EvidenceSendState copyWith({
    EvidencePhase? phase,
    List<EvidenceShot>? shots,
    bool isPicking = false,
    bool isSending = false,
    int? uploaded,
    EvidenceBatch? sent,
    EvidenceRefusal? refusal,
    bool failed = false,
    bool uploadFailed = false,
    bool pickFailed = false,
  }) =>
      EvidenceSendState(
        contractId: contractId,
        phase: phase ?? this.phase,
        shots: shots ?? this.shots,
        isPicking: isPicking,
        isSending: isSending,
        uploaded: uploaded ?? this.uploaded,
        sent: sent,
        refusal: refusal,
        failed: failed,
        uploadFailed: uploadFailed,
        pickFailed: pickFailed,
      );

  @override
  List<Object?> get props =>
      [contractId, phase, shots, isPicking, isSending, uploaded, sent, refusal, failed, uploadFailed, pickFailed];
}
