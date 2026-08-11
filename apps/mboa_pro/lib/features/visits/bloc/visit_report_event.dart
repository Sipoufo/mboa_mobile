part of 'visit_report_bloc.dart';

sealed class VisitReportEvent extends Equatable {
  const VisitReportEvent();

  @override
  List<Object?> get props => [];
}

class ReportPhotoAdded extends VisitReportEvent {
  const ReportPhotoAdded(this.source);

  final ImageSource source;

  @override
  List<Object?> get props => [source];
}

class ReportPhotoRemoved extends VisitReportEvent {
  const ReportPhotoRemoved(this.photoKey);

  final String photoKey;

  @override
  List<Object?> get props => [photoKey];
}

class ReportConditionChanged extends VisitReportEvent {
  const ReportConditionChanged(this.condition);

  final int condition;

  @override
  List<Object?> get props => [condition];
}

class ReportConformityChanged extends VisitReportEvent {
  const ReportConformityChanged(this.conformity);

  final ListingConformity conformity;

  @override
  List<Object?> get props => [conformity];
}

class ReportCommentChanged extends VisitReportEvent {
  const ReportCommentChanged(this.comment);

  final String comment;

  @override
  List<Object?> get props => [comment];
}

/// RM-M16-03 — there is no second attempt.
class ReportSubmitted extends VisitReportEvent {
  const ReportSubmitted(this.visitId);

  final String visitId;

  @override
  List<Object?> get props => [visitId];
}
