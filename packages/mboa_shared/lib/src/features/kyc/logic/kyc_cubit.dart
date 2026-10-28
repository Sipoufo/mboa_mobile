import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../../api/api_error.dart';
import '../../media/media_uploader.dart';
import '../data/kyc_repository.dart';
import '../models/document_identity.dart';
import '../models/kyc_draft.dart';
import '../models/kyc_status.dart';

part 'kyc_state.dart';

/// Drives the identity screens of both apps (CDC M01bis, §39 C): loads the KYC
/// status, collects the photos and what the document says into a [KycDraft],
/// and submits them.
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

  /// §39 B — what is printed on the document, as typed.
  void setIdentity(DocumentIdentity identity) {
    final s = state;
    if (s is KycReady) emit(s.copyWith(draft: s.draft.withIdentity(identity)));
  }

  /// Back to the grid of types; the photos and details stay until replaced.
  void clearDocType() {
    final s = state;
    if (s is KycReady) {
      final identity = s.draft.identity;
      emit(s.copyWith(
        draft: s.draft.withIdentity(DocumentIdentity(
          number: identity.number,
          issuedOn: identity.issuedOn,
          expiresOn: identity.expiresOn,
          issuedAt: identity.issuedAt,
        )),
      ));
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
        // A passport has no back; one photographed for another type is dropped.
        idBackKey: (start.draft.docType?.hasBack ?? true) ? start.draft.idBackKey : null,
        identity: start.draft.identity,
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
    if (api.hasCode('ID_DOCUMENT_EXPIRED')) return KycError.documentExpired;
    if (api.hasCode('INVALID_ISSUE_DATE')) return KycError.issuedInFuture;
    if (api.hasCode('ID_DOCUMENT_BACK_REQUIRED')) return KycError.backRequired;
    return KycError.submitFailed;
  }
}
