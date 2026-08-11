part of 'visit_report_bloc.dart';

sealed class VisitReportState extends Equatable {
  const VisitReportState();

  @override
  List<Object?> get props => [];
}

class ReportEditing extends VisitReportState {
  const ReportEditing({
    this.draft = const VisitReportDraft(),
    this.isUploading = false,
    this.isSubmitting = false,
    this.photoFailed = false,
    this.submitFailed = false,
  });

  final VisitReportDraft draft;
  final bool isUploading;
  final bool isSubmitting;
  final bool photoFailed;
  final bool submitFailed;

  ReportEditing copyWith({
    VisitReportDraft? draft,
    bool? isUploading,
    bool? isSubmitting,
    bool photoFailed = false,
    bool submitFailed = false,
  }) =>
      ReportEditing(
        draft: draft ?? this.draft,
        isUploading: isUploading ?? this.isUploading,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        photoFailed: photoFailed,
        submitFailed: submitFailed,
      );

  @override
  List<Object?> get props =>
      [draft, isUploading, isSubmitting, photoFailed, submitFailed];
}

/// Filed. RM-M16-03 makes this terminal — the screen closes rather than
/// offering an edit that would be refused.
class ReportSubmittedSuccessfully extends VisitReportState {
  const ReportSubmittedSuccessfully();
}
