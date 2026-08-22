part of 'visit_review_bloc.dart';

sealed class VisitReviewEvent extends Equatable {
  const VisitReviewEvent();

  @override
  List<Object?> get props => [];
}

class VisitReviewRequested extends VisitReviewEvent {
  const VisitReviewRequested(this.visiteId);

  final String visiteId;

  @override
  List<Object?> get props => [visiteId];
}

/// RM-M07bis-04 — a reply beside the client's words.
class VisitReviewCommented extends VisitReviewEvent {
  const VisitReviewCommented(this.body);

  final String body;

  @override
  List<Object?> get props => [body];
}

/// RM-M07bis-06 — export, then hand it to the OS.
class VisitReviewPdfRequested extends VisitReviewEvent {
  const VisitReviewPdfRequested({required this.fileName});

  /// What the user will see the file called.
  final String fileName;

  @override
  List<Object?> get props => [fileName];
}
