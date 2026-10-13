part of 'resident_review_bloc.dart';

sealed class ResidentReviewState extends Equatable {
  const ResidentReviewState();

  @override
  List<Object?> get props => [];
}

class ResidentReviewInitial extends ResidentReviewState {
  const ResidentReviewInitial();
}

class ResidentReviewLoadInProgress extends ResidentReviewState {
  const ResidentReviewLoadInProgress();
}

/// The form, whether it is being written for the first time or corrected.
class ResidentReviewEditing extends ResidentReviewState {
  const ResidentReviewEditing({
    this.rating = 0,
    this.comment = '',
    this.pros = const [],
    this.cons = const [],
    this.isRevision = false,
    this.isSaving = false,
    this.saveFailed = false,
  });

  /// 1–5. Zero means "not chosen yet", which is why it cannot be sent: RM-M27
  /// makes the rating the one required field.
  final int rating;

  final String comment;
  final List<String> pros;
  final List<String> cons;

  /// True when a review already existed — the screen says "modifier", and the
  /// bloc calls PUT rather than POST.
  final bool isRevision;

  final bool isSaving;
  final bool saveFailed;

  bool get canSubmit => rating > 0 && !isSaving;

  ResidentReviewEditing copyWith({
    int? rating,
    String? comment,
    List<String>? pros,
    List<String>? cons,
    bool? isRevision,
    bool? isSaving,
    bool saveFailed = false,
  }) =>
      ResidentReviewEditing(
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
        pros: pros ?? this.pros,
        cons: cons ?? this.cons,
        isRevision: isRevision ?? this.isRevision,
        isSaving: isSaving ?? this.isSaving,
        saveFailed: saveFailed,
      );

  @override
  List<Object?> get props =>
      [rating, comment, pros, cons, isRevision, isSaving, saveFailed];
}

/// Published, or corrected. The screen shows it back and stops offering a form.
class ResidentReviewPublished extends ResidentReviewState {
  const ResidentReviewPublished(this.review);

  final ReviewEntry review;

  @override
  List<Object?> get props => [review];
}

/// RM-M27-02 — the window has closed: the tenancy ended more than 30 days ago
/// and no edit restarted the clock.
///
/// **Not a failure.** The review is still the tenant's and still on the fiche;
/// it is simply finished, so it is shown read-only rather than behind a retry
/// button.
class ResidentReviewLocked extends ResidentReviewState {
  const ResidentReviewLocked(this.review);

  final ReviewEntry review;

  @override
  List<Object?> get props => [review];
}

/// The read failed. Distinct from [ResidentReviewLocked], which is an answer.
class ResidentReviewFailure extends ResidentReviewState {
  const ResidentReviewFailure();
}
