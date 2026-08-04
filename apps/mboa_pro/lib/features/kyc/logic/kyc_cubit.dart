import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/kyc_repository.dart';
import '../models/kyc_draft.dart';
import '../models/kyc_status.dart';

part 'kyc_state.dart';

/// Drives the Certifications screen (CDC M01bis): loads the KYC status, collects
/// the three document uploads into a [KycDraft], and submits them.
class KycCubit extends Cubit<KycState> {
  KycCubit({required KycRepository repository, required MediaUploader uploader})
      : _repository = repository,
        _uploader = uploader,
        super(const KycInitial());

  final KycRepository _repository;
  final MediaUploader _uploader;

  Future<void> load() async {
    if (state is! KycReady) emit(const KycLoadInProgress());
    try {
      emit(KycReady(await _repository.loadStatus(), const KycDraft()));
    } catch (_) {
      if (state is! KycReady) emit(const KycLoadFailure());
    }
  }

  void selectDocType(KycDocType type) {
    final s = state;
    if (s is KycReady) emit(s.copyWith(draft: s.draft.withDocType(type)));
  }

  /// Captures [slot] from [source], uploads it, and stores the object key.
  Future<void> capture(KycSlot slot, ImageSource source) async {
    final start = state;
    if (start is! KycReady || start.busy) return;
    emit(start.copyWith(uploading: slot));
    try {
      final key = await _uploader.captureAndUpload(
        source: source,
        category: CreateUploadRequestCategoryEnum.KYC_DOCUMENT,
      );
      final s = state;
      if (s is! KycReady) return;
      if (key == null) {
        emit(s.copyWith(uploading: null)); // user cancelled
      } else {
        emit(s.copyWith(draft: s.draft.withKey(slot, key), uploading: null));
      }
    } catch (_) {
      final s = state;
      if (s is KycReady) emit(s.copyWith(uploading: null, error: KycError.uploadFailed));
    }
  }

  /// Submits the completed draft.
  Future<void> submit() async {
    final start = state;
    if (start is! KycReady || !start.draft.isComplete || start.busy) return;
    emit(start.copyWith(submitting: true));
    try {
      final status = await _repository.submit(
        selfieKey: start.draft.selfieKey!,
        idFrontKey: start.draft.idFrontKey!,
        idBackKey: start.draft.idBackKey!,
      );
      emit(KycReady(status, const KycDraft(), justSubmitted: true));
    } catch (_) {
      final s = state;
      if (s is KycReady) emit(s.copyWith(submitting: false, error: KycError.submitFailed));
    }
  }
}
