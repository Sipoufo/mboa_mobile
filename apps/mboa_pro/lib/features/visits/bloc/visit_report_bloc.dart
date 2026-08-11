import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/agent_visit_repository.dart';
import '../models/visit_report.dart';

part 'visit_report_event.dart';
part 'visit_report_state.dart';

/// The report an agent files after a visit (CDC M16).
///
/// Its own bloc rather than part of the detail: it is a form with an upload
/// queue and a validity gate, and it is filed **once** — RM-M16-03 locks it.
class VisitReportBloc extends Bloc<VisitReportEvent, VisitReportState> {
  VisitReportBloc({
    required AgentVisitRepository repository,
    required MediaUploader uploader,
  })  : _repository = repository,
        _uploader = uploader,
        super(const ReportEditing()) {
    on<ReportPhotoAdded>(_onPhotoAdded);
    on<ReportPhotoRemoved>(_onPhotoRemoved);
    on<ReportConditionChanged>(_onCondition);
    on<ReportConformityChanged>(_onConformity);
    on<ReportCommentChanged>(_onComment);
    on<ReportSubmitted>(_onSubmit);
  }

  final AgentVisitRepository _repository;
  final MediaUploader _uploader;

  Future<void> _onPhotoAdded(
    ReportPhotoAdded event,
    Emitter<VisitReportState> emit,
  ) async {
    final current = state;
    if (current is! ReportEditing || !current.draft.canAddPhoto) return;

    emit(current.copyWith(isUploading: true));
    try {
      final key = await _uploader.captureAndUpload(
        source: event.source,
        category: CreateUploadRequestCategoryEnum.VISIT_REPORT,
      );
      if (key == null) {
        // Picker dismissed — nothing happened, and that is not an error.
        emit(current.copyWith(isUploading: false));
        return;
      }
      emit(
        current.copyWith(
          isUploading: false,
          draft: current.draft.copyWith(
            photoKeys: [...current.draft.photoKeys, key],
          ),
        ),
      );
    } catch (_) {
      emit(current.copyWith(isUploading: false, photoFailed: true));
    }
  }

  void _onPhotoRemoved(
    ReportPhotoRemoved event,
    Emitter<VisitReportState> emit,
  ) {
    final current = state;
    if (current is! ReportEditing) return;
    emit(
      current.copyWith(
        draft: current.draft.copyWith(
          photoKeys: [...current.draft.photoKeys]..remove(event.photoKey),
        ),
      ),
    );
  }

  void _onCondition(
    ReportConditionChanged event,
    Emitter<VisitReportState> emit,
  ) {
    final current = state;
    if (current is! ReportEditing) return;
    emit(
      current.copyWith(
        draft: current.draft.copyWith(overallCondition: event.condition),
      ),
    );
  }

  void _onConformity(
    ReportConformityChanged event,
    Emitter<VisitReportState> emit,
  ) {
    final current = state;
    if (current is! ReportEditing) return;
    emit(
      current.copyWith(
        draft: current.draft.copyWith(conformity: event.conformity),
      ),
    );
  }

  void _onComment(
    ReportCommentChanged event,
    Emitter<VisitReportState> emit,
  ) {
    final current = state;
    if (current is! ReportEditing) return;
    emit(current.copyWith(draft: current.draft.copyWith(comment: event.comment)));
  }

  Future<void> _onSubmit(
    ReportSubmitted event,
    Emitter<VisitReportState> emit,
  ) async {
    final current = state;
    // The button is disabled until the draft is valid; this is the second lock,
    // because a filed report cannot be corrected (RM-M16-03).
    if (current is! ReportEditing || !current.draft.isValid) return;

    emit(current.copyWith(isSubmitting: true));
    try {
      await _repository.submitReport(event.visitId, current.draft);
      emit(const ReportSubmittedSuccessfully());
    } catch (_) {
      emit(current.copyWith(isSubmitting: false, submitFailed: true));
    }
  }
}
