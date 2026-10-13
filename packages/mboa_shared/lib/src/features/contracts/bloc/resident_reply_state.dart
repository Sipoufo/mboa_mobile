part of 'resident_reply_bloc.dart';

sealed class ResidentReplyState extends Equatable {
  const ResidentReplyState();

  @override
  List<Object?> get props => [];
}

class ResidentReplyInitial extends ResidentReplyState {
  const ResidentReplyInitial();
}

class ResidentReplyLoadInProgress extends ResidentReplyState {
  const ResidentReplyLoadInProgress();
}

class ResidentReplyReady extends ResidentReplyState {
  const ResidentReplyReady({
    this.review,
    this.isSending = false,
    this.justSent = false,
    this.sendFailed = false,
  });

  /// **Null means "no review yet"** — the ordinary state of a tenancy the
  /// tenant has not written about. RM-M27-02 lets them do it whenever they
  /// like, so this is a waiting room, not an error.
  final ReviewEntry? review;

  final bool isSending;
  final bool justSent;
  final bool sendFailed;

  bool get hasReview => review != null;

  /// RM-M27-03 — **one answer per review**.
  ///
  /// Read off the review itself rather than guessed: the replies come from the
  /// server, so "already answered" is a fact on the page and not a flag to
  /// keep in step. The server refuses a second one regardless, which is what
  /// makes this safe against two devices at once.
  bool get canReply => review != null && review!.replies.isEmpty;

  ResidentReplyReady copyWith({
    ReviewEntry? review,
    bool? isSending,
    bool justSent = false,
    bool sendFailed = false,
  }) =>
      ResidentReplyReady(
        review: review ?? this.review,
        isSending: isSending ?? this.isSending,
        justSent: justSent,
        sendFailed: sendFailed,
      );

  @override
  List<Object?> get props => [review, isSending, justSent, sendFailed];
}

class ResidentReplyFailure extends ResidentReplyState {
  const ResidentReplyFailure();
}
