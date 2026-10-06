part of 'write_review_bloc.dart';

/// Why the server would not take the report.
enum ReviewRefusal {
  /// RM-M07bis-01 — one report per visit, and this visit has one.
  alreadyWritten,

  /// CE-M07bis-01 — nobody confirmed being at this visit.
  notAllowed,

  /// Anything else.
  failed,
}

sealed class WriteReviewState extends Equatable {
  const WriteReviewState();

  @override
  List<Object?> get props => const [];
}

final class ReviewLoadInProgress extends WriteReviewState {
  const ReviewLoadInProgress();
}

final class ReviewLoadFailure extends WriteReviewState {
  const ReviewLoadFailure();
}

/// What the tenant has written so far.
final class ReviewDraft extends WriteReviewState {
  const ReviewDraft({
    required this.visitId,
    this.rating,
    this.perceivedCondition,
    this.comment,
    this.pros = const [],
    this.cons = const [],
    this.photoKeys = const [],
    this.isSubmitting = false,
    this.refusal,
  });

  final String visitId;

  /// The only required field (M07bis's content table).
  final int? rating;
  final int? perceivedCondition;
  final String? comment;
  final List<String> pros;
  final List<String> cons;
  final List<String> photoKeys;
  final bool isSubmitting;
  final ReviewRefusal? refusal;

  bool get canSubmit => rating != null && !isSubmitting;

  bool get canAddPhoto => photoKeys.length < WriteReviewBloc.maxPhotos;

  ReviewDraft copyWith({
    int? rating,
    int? perceivedCondition,
    String? comment,
    List<String>? pros,
    List<String>? cons,
    List<String>? photoKeys,
    bool isSubmitting = false,
    ReviewRefusal? refusal,
  }) =>
      ReviewDraft(
        visitId: visitId,
        rating: rating ?? this.rating,
        perceivedCondition: perceivedCondition ?? this.perceivedCondition,
        comment: comment ?? this.comment,
        pros: pros ?? this.pros,
        cons: cons ?? this.cons,
        photoKeys: photoKeys ?? this.photoKeys,
        isSubmitting: isSubmitting,
        // Cleared on every edit: a refusal is about the attempt that produced
        // it, and typing again is a new attempt.
        refusal: refusal,
      );

  @override
  List<Object?> get props => [
        visitId,
        rating,
        perceivedCondition,
        comment,
        pros,
        cons,
        photoKeys,
        isSubmitting,
        refusal,
      ];
}

/// RM-M07bis-03 — the published report, read-only.
///
/// Locked on purpose: a visit report describes one moment and has no reason to
/// change, unlike a resident's review which the tenant corrects as the lease
/// goes on (RM-M27-02). So this state is for reading and for taking away — the
/// PDF of RM-M07bis-06 — and never for editing.
final class ReviewPublished extends WriteReviewState {
  const ReviewPublished({
    required this.visitId,
    required this.review,
    this.isExporting = false,
    this.exportFailed = false,
  });

  final String visitId;
  final VisitReview review;
  final bool isExporting;
  final bool exportFailed;

  ReviewPublished copyWith({bool isExporting = false, bool exportFailed = false}) =>
      ReviewPublished(
        visitId: visitId,
        review: review,
        isExporting: isExporting,
        exportFailed: exportFailed,
      );

  @override
  List<Object?> get props => [visitId, review, isExporting, exportFailed];
}

/// Published just now. Separate from [ReviewPublished] because only this one
/// closes the screen and congratulates.
final class ReviewJustPublished extends WriteReviewState {
  const ReviewJustPublished(this.review);

  final VisitReview review;

  @override
  List<Object?> get props => [review];
}
