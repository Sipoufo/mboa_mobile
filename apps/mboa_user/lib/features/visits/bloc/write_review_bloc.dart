import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:mboa_shared/mboa_shared.dart';

part 'write_review_event.dart';
part 'write_review_state.dart';

/// Writing the report on a visit (CDC M07bis).
///
/// The client writes it, not the visitor — that is the 2026-08-13 revision of
/// M07. The bloc holds the draft because it is a form with six fields and two
/// lists, and `setState` on API-sourced data is exactly what the project's
/// rules forbid: the photo keys come back from an upload.
///
/// **One report per visit (RM-M07bis-01).** Opening the screen reads any
/// published one first; the server refuses a second with a 409, and the screen
/// says so rather than losing what was typed.
class WriteReviewBloc extends Bloc<WriteReviewEvent, WriteReviewState> {
  WriteReviewBloc({required VisitReviewRepository repository})
      : _repository = repository,
        super(const ReviewLoadInProgress()) {
    on<ReviewOpened>(_onOpened);
    on<ReviewRatingChanged>(_onRatingChanged);
    on<ReviewConditionChanged>(_onConditionChanged);
    on<ReviewCommentChanged>(_onCommentChanged);
    on<ReviewPointAdded>(_onPointAdded);
    on<ReviewPointRemoved>(_onPointRemoved);
    on<ReviewPhotoAdded>(_onPhotoAdded);
    on<ReviewPhotoRemoved>(_onPhotoRemoved);
    on<ReviewSubmitted>(_onSubmitted);
  }

  final VisitReviewRepository _repository;

  /// M07bis's content table caps the photos at ten.
  static const maxPhotos = 10;

  Future<void> _onOpened(
    ReviewOpened event,
    Emitter<WriteReviewState> emit,
  ) async {
    emit(const ReviewLoadInProgress());
    try {
      final existing = await _repository.fetch(event.visitId);
      if (existing != null) {
        // RM-M07bis-03 — published is locked. The screen shows it, read-only,
        // rather than offering a form that cannot be sent.
        emit(ReviewAlreadyPublished(existing));
        return;
      }
      emit(ReviewDraft(visitId: event.visitId));
    } catch (_) {
      emit(const ReviewLoadFailure());
    }
  }

  void _onRatingChanged(
    ReviewRatingChanged event,
    Emitter<WriteReviewState> emit,
  ) {
    if (state case final ReviewDraft draft) {
      emit(draft.copyWith(rating: event.rating));
    }
  }

  void _onConditionChanged(
    ReviewConditionChanged event,
    Emitter<WriteReviewState> emit,
  ) {
    if (state case final ReviewDraft draft) {
      emit(draft.copyWith(perceivedCondition: event.condition));
    }
  }

  void _onCommentChanged(
    ReviewCommentChanged event,
    Emitter<WriteReviewState> emit,
  ) {
    if (state case final ReviewDraft draft) {
      emit(draft.copyWith(comment: event.comment));
    }
  }

  void _onPointAdded(ReviewPointAdded event, Emitter<WriteReviewState> emit) {
    if (state case final ReviewDraft draft) {
      final value = event.value.trim();
      // A blank bullet is not an opinion, and the same one twice is one.
      if (value.isEmpty) return;
      final points = event.isPro ? [...draft.pros] : [...draft.cons];
      if (points.contains(value)) return;
      points.add(value);
      emit(
        event.isPro ? draft.copyWith(pros: points) : draft.copyWith(cons: points),
      );
    }
  }

  void _onPointRemoved(
    ReviewPointRemoved event,
    Emitter<WriteReviewState> emit,
  ) {
    if (state case final ReviewDraft draft) {
      final points = event.isPro ? [...draft.pros] : [...draft.cons];
      points.remove(event.value);
      emit(
        event.isPro ? draft.copyWith(pros: points) : draft.copyWith(cons: points),
      );
    }
  }

  void _onPhotoAdded(ReviewPhotoAdded event, Emitter<WriteReviewState> emit) {
    if (state case final ReviewDraft draft) {
      if (draft.photoKeys.length >= maxPhotos) return;
      emit(draft.copyWith(photoKeys: [...draft.photoKeys, event.objectKey]));
    }
  }

  void _onPhotoRemoved(
    ReviewPhotoRemoved event,
    Emitter<WriteReviewState> emit,
  ) {
    if (state case final ReviewDraft draft) {
      emit(
        draft.copyWith(
          photoKeys: draft.photoKeys.where((k) => k != event.objectKey).toList(),
        ),
      );
    }
  }

  Future<void> _onSubmitted(
    ReviewSubmitted event,
    Emitter<WriteReviewState> emit,
  ) async {
    if (state case final ReviewDraft draft) {
      final rating = draft.rating;
      if (rating == null) return;

      emit(draft.copyWith(isSubmitting: true));
      try {
        final published = await _repository.submit(
          draft.visitId,
          rating: rating,
          perceivedCondition: draft.perceivedCondition,
          comment: draft.comment,
          pros: draft.pros,
          cons: draft.cons,
          photoKeys: draft.photoKeys,
        );
        emit(ReviewJustPublished(published));
      } on DioException catch (error) {
        // 409: a report already exists. 403: no mutual confirmation
        // (CE-M07bis-01). Both are facts about the visit, not failures of the
        // form — and the draft stays on screen either way.
        emit(
          draft.copyWith(
            isSubmitting: false,
            refusal: switch (error.response?.statusCode) {
              409 => ReviewRefusal.alreadyWritten,
              403 => ReviewRefusal.notAllowed,
              _ => ReviewRefusal.failed,
            },
          ),
        );
      } catch (_) {
        emit(draft.copyWith(isSubmitting: false, refusal: ReviewRefusal.failed));
      }
    }
  }
}
