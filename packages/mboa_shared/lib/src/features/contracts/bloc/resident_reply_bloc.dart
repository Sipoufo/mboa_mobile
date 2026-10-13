import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../listings/models/property_review.dart';
import '../data/resident_review_repository.dart';

part 'resident_reply_event.dart';
part 'resident_reply_state.dart';

/// The landlord reading a resident's review, and answering it once (CDC M27).
///
/// Separate from [ResidentReviewBloc], which is a form: the two sides of a
/// review are not the same job. The tenant writes a rating and text and may
/// correct them for as long as the window is open; the landlord may add one
/// paragraph beside them and can never touch them (RM-M27-03). A right of
/// reply is not a right of veto, and one bloc trying to be both would have to
/// carry an editing state the landlord must never reach.
class ResidentReplyBloc extends Bloc<ResidentReplyEvent, ResidentReplyState> {
  ResidentReplyBloc({required ResidentReviewRepository repository})
      : _repository = repository,
        super(const ResidentReplyInitial()) {
    on<ResidentReplyOpened>(_onOpened);
    on<ResidentReplySent>(_onSent);
  }

  final ResidentReviewRepository _repository;

  late String _contractId;

  Future<void> _onOpened(
    ResidentReplyOpened event,
    Emitter<ResidentReplyState> emit,
  ) async {
    _contractId = event.contractId;
    emit(const ResidentReplyLoadInProgress());

    try {
      // A null review is a ready state, not a failure: the tenant may write
      // one at any point in the tenancy, so "nothing yet" is the answer for
      // most contracts most of the time.
      emit(ResidentReplyReady(review: await _repository.fetch(_contractId)));
    } catch (_) {
      emit(const ResidentReplyFailure());
    }
  }

  Future<void> _onSent(
    ResidentReplySent event,
    Emitter<ResidentReplyState> emit,
  ) async {
    if (state case final ResidentReplyReady current) {
      final body = event.body.trim();
      // An empty answer is not an answer; it would also be refused, so it is
      // not sent.
      if (body.isEmpty || !current.canReply || current.isSending) return;

      emit(current.copyWith(isSending: true));

      try {
        final updated = await _repository.reply(_contractId, body);
        // The server answers with the review as it now holds it, replies
        // included — so `canReply` goes false from its data rather than from a
        // local flag.
        emit(ResidentReplyReady(review: updated, justSent: true));
      } catch (_) {
        emit(current.copyWith(isSending: false, sendFailed: true));
      }
    }
  }
}
