part of 'annonce_form_bloc.dart';

/// What went wrong, so the UI can say something specific.
enum AnnonceFormError {
  /// All three retries of a photo upload failed (CE-M10-01).
  photoUpload,

  /// Required fields are missing.
  incomplete,

  /// The save call failed.
  save,
}

sealed class AnnonceFormState extends Equatable {
  const AnnonceFormState();

  @override
  List<Object?> get props => [];
}

final class AnnonceFormInitial extends AnnonceFormState {
  const AnnonceFormInitial();
}

final class AnnonceFormEditing extends AnnonceFormState {
  const AnnonceFormEditing(
    this.draft, {
    this.uploadingPhoto = false,
    this.error,
  });

  final AnnonceDraft draft;
  final bool uploadingPhoto;
  final AnnonceFormError? error;

  /// Enregistrer is enabled once the required fields are there. Photos are not
  /// part of this — a draft may be saved without the three, publishing is what
  /// enforces them (CE-M10-03).
  bool get canSubmit => draft.canSave && !uploadingPhoto;

  AnnonceFormEditing copyWith({
    AnnonceDraft? draft,
    bool? uploadingPhoto,
    AnnonceFormError? error,
    bool clearError = false,
  }) =>
      AnnonceFormEditing(
        draft ?? this.draft,
        uploadingPhoto: uploadingPhoto ?? this.uploadingPhoto,
        error: clearError ? null : (error ?? this.error),
      );

  @override
  List<Object?> get props => [draft, uploadingPhoto, error];
}

final class AnnonceFormSubmitting extends AnnonceFormState {
  const AnnonceFormSubmitting(this.draft);

  final AnnonceDraft draft;

  @override
  List<Object?> get props => [draft];
}

final class AnnonceFormSaved extends AnnonceFormState {
  const AnnonceFormSaved({required this.id, required this.kind});

  final String id;
  final AnnonceKind kind;

  @override
  List<Object?> get props => [id, kind];
}
