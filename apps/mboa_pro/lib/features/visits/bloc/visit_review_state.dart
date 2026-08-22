part of 'visit_review_bloc.dart';

sealed class VisitReviewState extends Equatable {
  const VisitReviewState();

  @override
  List<Object?> get props => [];
}

class VisitReviewInitial extends VisitReviewState {
  const VisitReviewInitial();
}

class VisitReviewLoadInProgress extends VisitReviewState {
  const VisitReviewLoadInProgress();
}

class VisitReviewReady extends VisitReviewState {
  const VisitReviewReady({
    required this.visiteId,
    this.review,
    this.isCommenting = false,
    this.isExporting = false,
    this.commentJustSent = false,
    this.lastActionFailed = false,
  });

  final String visiteId;

  /// **Null means "no review yet"**, which is the ordinary state of a visit
  /// that has just happened — not an error and not an empty review.
  final VisitReview? review;

  final bool isCommenting;
  final bool isExporting;
  final bool commentJustSent;
  final bool lastActionFailed;

  bool get hasReview => review != null;

  VisitReviewReady copyWith({
    VisitReview? review,
    bool? isCommenting,
    bool? isExporting,
    bool commentJustSent = false,
    bool lastActionFailed = false,
  }) =>
      VisitReviewReady(
        visiteId: visiteId,
        review: review ?? this.review,
        isCommenting: isCommenting ?? this.isCommenting,
        isExporting: isExporting ?? this.isExporting,
        commentJustSent: commentJustSent,
        lastActionFailed: lastActionFailed,
      );

  @override
  List<Object?> get props => [
        visiteId,
        review,
        isCommenting,
        isExporting,
        commentJustSent,
        lastActionFailed,
      ];
}

class VisitReviewFailure extends VisitReviewState {
  const VisitReviewFailure();
}
