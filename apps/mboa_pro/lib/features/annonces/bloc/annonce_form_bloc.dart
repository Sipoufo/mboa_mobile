import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/annonce_repository.dart';
import '../data/residence_repository.dart';
import '../models/annonce_draft.dart';

part 'annonce_form_event.dart';
part 'annonce_form_state.dart';

/// Creation and editing for both listing kinds (CDC M10).
///
/// Photos upload as they are picked rather than on submit, so saving isn't a
/// long wait and a failed photo doesn't cost the whole form. Compression is
/// handled by [MediaUploader] (RM-M10-03).
///
/// "Enregistrer" saves a **draft**; publishing is a separate action from the
/// list or detail, because the tier limit only bites on publish.
class AnnonceFormBloc extends Bloc<AnnonceFormEvent, AnnonceFormState> {
  AnnonceFormBloc({
    required AnnonceRepository annonces,
    required ResidenceRepository residences,
    required MediaUploader uploader,
    this.uploadRetries = 3,
  })  : _annonces = annonces,
        _residences = residences,
        _uploader = uploader,
        super(const AnnonceFormInitial()) {
    on<AnnonceFormStarted>(_onStarted);
    on<AnnonceFormPhotoAdded>(_onPhotoAdded);
    on<AnnonceFormPhotoRemoved>(_onPhotoRemoved);
    on<AnnonceFormChanged>(_onChanged);
    on<AnnonceFormUnitGroupAdded>(_onUnitGroupAdded);
    on<AnnonceFormUnitGroupUpdated>(_onUnitGroupUpdated);
    on<AnnonceFormUnitGroupRemoved>(_onUnitGroupRemoved);
    on<AnnonceFormSubmitted>(_onSubmitted);
  }

  final AnnonceRepository _annonces;
  final ResidenceRepository _residences;
  final MediaUploader _uploader;

  /// CE-M10-01 asks for automatic retries on a failed photo upload.
  final int uploadRetries;

  void _onStarted(AnnonceFormStarted event, Emitter<AnnonceFormState> emit) {
    emit(
      AnnonceFormEditing(
        event.draft ?? AnnonceDraft(kind: event.kind),
      ),
    );
  }

  AnnonceFormEditing? get _editing =>
      state is AnnonceFormEditing ? state as AnnonceFormEditing : null;

  Future<void> _onPhotoAdded(
    AnnonceFormPhotoAdded event,
    Emitter<AnnonceFormState> emit,
  ) async {
    final current = _editing;
    if (current == null || !current.draft.canAddPhoto) return;

    emit(current.copyWith(uploadingPhoto: true, clearError: true));

    for (var attempt = 1; attempt <= uploadRetries; attempt++) {
      try {
        final key = await _uploader.captureAndUpload(
          source: event.source,
          category: CreateUploadRequestCategoryEnum.LISTING_PHOTO,
        );

        // Null means the picker was cancelled — not a failure.
        if (key == null) {
          emit(current.copyWith(uploadingPhoto: false));
          return;
        }

        emit(
          current.copyWith(
            draft: current.draft
                .copyWith(photoKeys: [...current.draft.photoKeys, key]),
            uploadingPhoto: false,
          ),
        );
        return;
      } catch (_) {
        if (attempt == uploadRetries) {
          emit(
            current.copyWith(
              uploadingPhoto: false,
              error: AnnonceFormError.photoUpload,
            ),
          );
        }
      }
    }
  }

  void _onPhotoRemoved(
    AnnonceFormPhotoRemoved event,
    Emitter<AnnonceFormState> emit,
  ) {
    final current = _editing;
    if (current == null) return;

    emit(
      current.copyWith(
        draft: current.draft.copyWith(
          photoKeys:
              current.draft.photoKeys.where((k) => k != event.key).toList(),
        ),
      ),
    );
  }

  void _onChanged(AnnonceFormChanged event, Emitter<AnnonceFormState> emit) {
    final current = _editing;
    if (current == null) return;
    emit(current.copyWith(draft: event.apply(current.draft), clearError: true));
  }

  void _onUnitGroupAdded(
    AnnonceFormUnitGroupAdded event,
    Emitter<AnnonceFormState> emit,
  ) {
    final current = _editing;
    if (current == null) return;
    emit(
      current.copyWith(
        draft: current.draft
            .copyWith(units: [...current.draft.units, const UnitGroupDraft()]),
      ),
    );
  }

  void _onUnitGroupUpdated(
    AnnonceFormUnitGroupUpdated event,
    Emitter<AnnonceFormState> emit,
  ) {
    final current = _editing;
    if (current == null) return;

    final units = [...current.draft.units];
    if (event.index < 0 || event.index >= units.length) return;
    units[event.index] = event.group;

    emit(current.copyWith(draft: current.draft.copyWith(units: units)));
  }

  void _onUnitGroupRemoved(
    AnnonceFormUnitGroupRemoved event,
    Emitter<AnnonceFormState> emit,
  ) {
    final current = _editing;
    if (current == null) return;

    final units = [...current.draft.units]..removeAt(event.index);
    emit(current.copyWith(draft: current.draft.copyWith(units: units)));
  }

  Future<void> _onSubmitted(
    AnnonceFormSubmitted event,
    Emitter<AnnonceFormState> emit,
  ) async {
    final current = _editing;
    if (current == null) return;

    final draft = current.draft;
    if (!draft.canSave) {
      emit(current.copyWith(error: AnnonceFormError.incomplete));
      return;
    }

    emit(AnnonceFormSubmitting(draft));

    try {
      final id = switch (draft.kind) {
        AnnonceKind.single => draft.isEditing
            ? (await _annonces.update(draft)).id
            : (await _annonces.create(draft)).id,
        AnnonceKind.residence => (await _residences.create(draft)).id,
      };
      emit(AnnonceFormSaved(id: id, kind: draft.kind));
    } catch (_) {
      emit(current.copyWith(error: AnnonceFormError.save));
    }
  }
}
