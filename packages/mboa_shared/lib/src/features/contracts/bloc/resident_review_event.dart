part of 'resident_review_bloc.dart';

sealed class ResidentReviewEvent extends Equatable {
  const ResidentReviewEvent();

  @override
  List<Object?> get props => [];
}

/// Reads whatever is already there. A 404 is the ordinary answer for a tenancy
/// nobody has reviewed yet, and it is what decides "écrire" or "modifier".
class ResidentReviewOpened extends ResidentReviewEvent {
  const ResidentReviewOpened(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

class ResidentReviewRatingChanged extends ResidentReviewEvent {
  const ResidentReviewRatingChanged(this.rating);

  final int rating;

  @override
  List<Object?> get props => [rating];
}

class ResidentReviewCommentChanged extends ResidentReviewEvent {
  const ResidentReviewCommentChanged(this.comment);

  final String comment;

  @override
  List<Object?> get props => [comment];
}

/// One bullet, on the good side or the bad one.
class ResidentReviewPointAdded extends ResidentReviewEvent {
  const ResidentReviewPointAdded({required this.label, required this.isPro});

  final String label;
  final bool isPro;

  @override
  List<Object?> get props => [label, isPro];
}

class ResidentReviewPointRemoved extends ResidentReviewEvent {
  const ResidentReviewPointRemoved({required this.label, required this.isPro});

  final String label;
  final bool isPro;

  @override
  List<Object?> get props => [label, isPro];
}

/// Publishes a first review, or revises the one already there — the bloc knows
/// which from what [ResidentReviewOpened] found, so the screen does not have
/// to decide.
class ResidentReviewSubmitted extends ResidentReviewEvent {
  const ResidentReviewSubmitted();
}
