import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../listings/models/property_review.dart';
import '../data/resident_review_repository.dart';

part 'resident_review_event.dart';
part 'resident_review_state.dart';

/// The tenant's review of a place they lived in (CDC M27).
///
/// One bloc for both halves of the job, because they are the same form: a
/// first review and a correction differ only in the verb the repository uses,
/// and the bloc knows which from what the initial read found. Asking the
/// screen to decide would mean asking it to remember.
///
/// Who may write one at all is not decided here — it is
/// `residentReviewEligible` on the contract, the server's own verdict, and the
/// screen is only reached from a contract that carries it.
class ResidentReviewBloc
    extends Bloc<ResidentReviewEvent, ResidentReviewState> {
  ResidentReviewBloc({required ResidentReviewRepository repository})
      : _repository = repository,
        super(const ResidentReviewInitial()) {
    on<ResidentReviewOpened>(_onOpened);
    on<ResidentReviewRatingChanged>(_onRating);
    on<ResidentReviewCommentChanged>(_onComment);
    on<ResidentReviewPointAdded>(_onPointAdded);
    on<ResidentReviewPointRemoved>(_onPointRemoved);
    on<ResidentReviewSubmitted>(_onSubmitted);
  }

  final ResidentReviewRepository _repository;

  late String _contractId;

  Future<void> _onOpened(
    ResidentReviewOpened event,
    Emitter<ResidentReviewState> emit,
  ) async {
    _contractId = event.contractId;
    emit(const ResidentReviewLoadInProgress());

    try {
      final existing = await _repository.fetch(event.contractId);
      if (existing == null) {
        emit(const ResidentReviewEditing());
        return;
      }
      // There is one, and the window is still open as far as we know: the
      // server only says REVIEW_LOCKED when a write is attempted, so the
      // screen opens as a correction and finds out on submit.
      emit(
        ResidentReviewEditing(
          rating: existing.rating ?? 0,
          comment: existing.comment ?? '',
          pros: existing.pros,
          cons: existing.cons,
          isRevision: true,
        ),
      );
    } catch (_) {
      emit(const ResidentReviewFailure());
    }
  }

  void _onRating(
    ResidentReviewRatingChanged event,
    Emitter<ResidentReviewState> emit,
  ) {
    if (state case final ResidentReviewEditing current) {
      emit(current.copyWith(rating: event.rating));
    }
  }

  void _onComment(
    ResidentReviewCommentChanged event,
    Emitter<ResidentReviewState> emit,
  ) {
    if (state case final ResidentReviewEditing current) {
      emit(current.copyWith(comment: event.comment));
    }
  }

  void _onPointAdded(
    ResidentReviewPointAdded event,
    Emitter<ResidentReviewState> emit,
  ) {
    if (state case final ResidentReviewEditing current) {
      final label = event.label.trim();
      if (label.isEmpty) return;

      final list = event.isPro ? current.pros : current.cons;
      if (list.contains(label)) return;

      final grown = [...list, label];
      emit(
        event.isPro
            ? current.copyWith(pros: grown)
            : current.copyWith(cons: grown),
      );
    }
  }

  void _onPointRemoved(
    ResidentReviewPointRemoved event,
    Emitter<ResidentReviewState> emit,
  ) {
    if (state case final ResidentReviewEditing current) {
      final list = event.isPro ? current.pros : current.cons;
      final shrunk = list.where((p) => p != event.label).toList();
      emit(
        event.isPro
            ? current.copyWith(pros: shrunk)
            : current.copyWith(cons: shrunk),
      );
    }
  }

  Future<void> _onSubmitted(
    ResidentReviewSubmitted event,
    Emitter<ResidentReviewState> emit,
  ) async {
    if (state case final ResidentReviewEditing current) {
      // RM-M27 makes the rating the one required field, so a form without one
      // is not sent at all rather than sent and refused.
      if (!current.canSubmit) return;

      emit(current.copyWith(isSaving: true));

      try {
        final saved = current.isRevision
            ? await _repository.revise(
                _contractId,
                rating: current.rating,
                comment: current.comment,
                pros: current.pros,
                cons: current.cons,
              )
            : await _repository.submit(
                _contractId,
                rating: current.rating,
                comment: current.comment,
                pros: current.pros,
                cons: current.cons,
              );
        emit(ResidentReviewPublished(saved));
      } on DioException catch (e) {
        // RM-M27-02 — the window closed while the form was open. That is an
        // answer, not an error: the review stands, it can simply no longer be
        // touched, so the screen goes read-only instead of offering a retry
        // that would fail the same way.
        if (e.response?.statusCode == 409 && _isLocked(e)) {
          final existing = await _safeFetch();
          if (existing != null) {
            emit(ResidentReviewLocked(existing));
            return;
          }
        }
        emit(current.copyWith(isSaving: false, saveFailed: true));
      } catch (_) {
        emit(current.copyWith(isSaving: false, saveFailed: true));
      }
    }
  }

  /// The server distinguishes its 409s by an `error` code; a locked review is
  /// the only one that is not worth retrying.
  bool _isLocked(DioException e) {
    final body = e.response?.data;
    return body is Map && body['error'] == 'REVIEW_LOCKED';
  }

  /// Re-reading must not turn a handled refusal into an unhandled one.
  Future<ReviewEntry?> _safeFetch() async {
    try {
      return await _repository.fetch(_contractId);
    } catch (_) {
      return null;
    }
  }
}
