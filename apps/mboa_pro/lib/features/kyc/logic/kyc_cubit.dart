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
      final status = await _repository.loadStatus();
      emit(KycReady(status, KycDraft.of(status)));
    } catch (_) {
      if (state is! KycReady) emit(const KycLoadFailure());
    }
  }

  /// §37 B — as typed; checked on submit.
  void setNui(String nui) {
    final s = state;
    if (s is KycReady) emit(s.copyWith(draft: s.draft.withNui(nui)));
  }

  /// §37 B — the address, or none.
  void setAddress(DeclaredAddress? address) {
    final s = state;
    if (s is KycReady) emit(s.copyWith(draft: s.draft.withAddress(address)));
  }

  /// RM-M01bis-10 — a NUI added to an approved KYC; the status read back.
  Future<void> addNui(String raw) async {
    final start = state;
    final nui = KycDraft.normalizeNui(raw);
    if (start is! KycReady || start.busy || nui == null) return;
    if (!KycDraft.isValidNui(nui)) {
      emit(start.copyWith(error: KycError.invalidNui));
      return;
    }
    emit(start.copyWith(submitting: true));
    try {
      final status = await _repository.addNui(nui);
      emit(KycReady(status, KycDraft.of(status), justSubmitted: true));
    } catch (error) {
      final s = state;
      if (s is KycReady) emit(s.copyWith(submitting: false, error: _errorOf(error)));
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

  /// Submits the completed draft. A malformed NUI is said before asking; an
  /// agence or a promoteur without one is the server's to refuse.
  Future<void> submit() async {
    final start = state;
    if (start is! KycReady || !start.draft.isComplete || start.busy) return;
    if (!start.draft.nuiIsValid) {
      emit(start.copyWith(error: KycError.invalidNui));
      return;
    }
    emit(start.copyWith(submitting: true));
    try {
      final status = await _repository.submit(
        selfieKey: start.draft.selfieKey!,
        idFrontKey: start.draft.idFrontKey!,
        idBackKey: start.draft.idBackKey!,
        nui: KycDraft.normalizeNui(start.draft.nui),
        address: start.draft.address,
      );
      emit(KycReady(status, KycDraft.of(status), justSubmitted: true));
    } catch (error) {
      final s = state;
      if (s is KycReady) emit(s.copyWith(submitting: false, error: _errorOf(error)));
    }
  }

  static KycError _errorOf(Object error) {
    final api = ApiError.from(error);
    if (api.hasCode('INVALID_NUI')) return KycError.invalidNui;
    if (api.hasCode('NUI_REQUIRED')) return KycError.nuiRequired;
    if (api.hasCode('UNKNOWN_DISTRICT')) return KycError.unknownDistrict;
    return KycError.submitFailed;
  }
}
