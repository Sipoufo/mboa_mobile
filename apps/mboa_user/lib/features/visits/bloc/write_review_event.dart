part of 'write_review_bloc.dart';

sealed class WriteReviewEvent extends Equatable {
  const WriteReviewEvent();

  @override
  List<Object?> get props => const [];
}

/// The screen opened: read any published report before offering a form.
final class ReviewOpened extends WriteReviewEvent {
  const ReviewOpened(this.visitId);

  final String visitId;

  @override
  List<Object?> get props => [visitId];
}

final class ReviewRatingChanged extends WriteReviewEvent {
  const ReviewRatingChanged(this.rating);

  final int rating;

  @override
  List<Object?> get props => [rating];
}

final class ReviewConditionChanged extends WriteReviewEvent {
  const ReviewConditionChanged(this.condition);

  final int condition;

  @override
  List<Object?> get props => [condition];
}

final class ReviewCommentChanged extends WriteReviewEvent {
  const ReviewCommentChanged(this.comment);

  final String comment;

  @override
  List<Object?> get props => [comment];
}

/// One bullet, on either list — the two behave identically, so they share an
/// event rather than duplicating four handlers.
final class ReviewPointAdded extends WriteReviewEvent {
  const ReviewPointAdded({required this.value, required this.isPro});

  final String value;
  final bool isPro;

  @override
  List<Object?> get props => [value, isPro];
}

final class ReviewPointRemoved extends WriteReviewEvent {
  const ReviewPointRemoved({required this.value, required this.isPro});

  final String value;
  final bool isPro;

  @override
  List<Object?> get props => [value, isPro];
}

/// An uploaded photo's object key — the upload itself is the uploader's job.
final class ReviewPhotoAdded extends WriteReviewEvent {
  const ReviewPhotoAdded(this.objectKey);

  final String objectKey;

  @override
  List<Object?> get props => [objectKey];
}

final class ReviewPhotoRemoved extends WriteReviewEvent {
  const ReviewPhotoRemoved(this.objectKey);

  final String objectKey;

  @override
  List<Object?> get props => [objectKey];
}

final class ReviewSubmitted extends WriteReviewEvent {
  const ReviewSubmitted();
}

/// RM-M07bis-06 — take the published report away as a PDF. [fileName] carries
/// the property rather than an id, because it is what the reader will see in
/// their files.
final class ReviewPdfRequested extends WriteReviewEvent {
  const ReviewPdfRequested(this.fileName);

  final String fileName;

  @override
  List<Object?> get props => [fileName];
}
