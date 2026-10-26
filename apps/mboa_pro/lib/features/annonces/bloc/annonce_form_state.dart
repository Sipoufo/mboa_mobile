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

/// Fetching the listing being edited.
final class AnnonceFormLoading extends AnnonceFormState {
  const AnnonceFormLoading();
}

/// The listing being edited could not be fetched.
final class AnnonceFormLoadFailure extends AnnonceFormState {
  const AnnonceFormLoadFailure();
}

final class AnnonceFormEditing extends AnnonceFormState {
  const AnnonceFormEditing(
    this.draft, {
    this.step = AnnonceFormStep.basics,
    this.uploadingPhoto = false,
    this.error,
    this.apiError,
  });

  final AnnonceDraft draft;
  final AnnonceFormStep step;
  final bool uploadingPhoto;
  final AnnonceFormError? error;

  /// The backend's own error, when it sent one. Lets the UI say *why* a save
  /// failed — "your plan doesn't allow that many units" beats "try again".
  final ApiError? apiError;

  /// Enregistrer is enabled once the required fields are there. Photos are not
  /// part of this — a draft may be saved without the three, publishing is what
  /// enforces them (CE-M10-03).
  bool get canSubmit => draft.canSave && !uploadingPhoto;

  AnnonceFormEditing copyWith({
    AnnonceDraft? draft,
    AnnonceFormStep? step,
    bool? uploadingPhoto,
    AnnonceFormError? error,
    ApiError? apiError,
    bool clearError = false,
  }) =>
      AnnonceFormEditing(
        draft ?? this.draft,
        step: step ?? this.step,
        uploadingPhoto: uploadingPhoto ?? this.uploadingPhoto,
        error: clearError ? null : (error ?? this.error),
        apiError: clearError ? null : (apiError ?? this.apiError),
      );

  @override
  List<Object?> get props => [draft, step, uploadingPhoto, error, apiError];
}

final class AnnonceFormSubmitting extends AnnonceFormState {
  const AnnonceFormSubmitting(this.draft, {this.step = AnnonceFormStep.basics});

  final AnnonceDraft draft;

  /// The step saved from — the screen stays on it while the save runs.
  final AnnonceFormStep step;

  @override
  List<Object?> get props => [draft, step];
}

final class AnnonceFormSaved extends AnnonceFormState {
  const AnnonceFormSaved({required this.id, required this.kind});

  final String id;
  final AnnonceKind kind;

  @override
  List<Object?> get props => [id, kind];
}
