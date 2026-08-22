import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/review_pdf_exporter.dart';

part 'visit_review_event.dart';
part 'visit_review_state.dart';

/// The client's review of a visit, as the visitor sees it (CDC M07bis).
///
/// Read, comment, export. **Never write the review itself** — the note and the
/// text belong to the client, and the whole point of RM-M07bis-04 is that the
/// person being reviewed can only add beside them.
class VisitReviewBloc extends Bloc<VisitReviewEvent, VisitReviewState> {
  VisitReviewBloc({
    required VisitReviewRepository repository,
    ReviewPdfExporter exporter = const ReviewPdfExporter(),
  })  : _repository = repository,
        _exporter = exporter,
        super(const VisitReviewInitial()) {
    on<VisitReviewRequested>(_onRequested);
    on<VisitReviewCommented>(_onComment);
    on<VisitReviewPdfRequested>(_onPdf);
  }

  final VisitReviewRepository _repository;
  final ReviewPdfExporter _exporter;

  Future<void> _onRequested(
    VisitReviewRequested event,
    Emitter<VisitReviewState> emit,
  ) async {
    emit(const VisitReviewLoadInProgress());
    try {
      // Null is an answer, not a failure: writing a review is optional and
      // undated (RM-M07bis-02), so most visits have none for a while.
      emit(VisitReviewReady(visiteId: event.visiteId, review: await _repository.fetch(event.visiteId)));
    } catch (_) {
      emit(const VisitReviewFailure());
    }
  }

  Future<void> _onComment(
    VisitReviewCommented event,
    Emitter<VisitReviewState> emit,
  ) async {
    final current = state;
    if (current is! VisitReviewReady) return;

    final body = event.body.trim();
    if (body.isEmpty) return;

    emit(current.copyWith(isCommenting: true));
    try {
      // The answer carries the whole review back, comments included, so the
      // thread is never assembled locally.
      final review = await _repository.comment(current.visiteId, body);
      emit(current.copyWith(review: review, isCommenting: false, commentJustSent: true));
    } catch (_) {
      emit(current.copyWith(isCommenting: false, lastActionFailed: true));
    }
  }

  Future<void> _onPdf(
    VisitReviewPdfRequested event,
    Emitter<VisitReviewState> emit,
  ) async {
    final current = state;
    if (current is! VisitReviewReady || current.review == null) return;

    emit(current.copyWith(isExporting: true));
    try {
      final Uint8List bytes = await _repository.pdf(current.visiteId);
      await _exporter.share(bytes, name: event.fileName);
      emit(current.copyWith(isExporting: false));
    } catch (_) {
      emit(current.copyWith(isExporting: false, lastActionFailed: true));
    }
  }
}
