part of 'kyc_cubit.dart';

/// Why a KYC action failed (one-shot; surfaced as a toast).
enum KycError { uploadFailed, submitFailed }

/// Observable states of the Certifications screen.
sealed class KycState extends Equatable {
  const KycState();

  @override
  List<Object?> get props => [];
}

final class KycInitial extends KycState {
  const KycInitial();
}

final class KycLoadInProgress extends KycState {
  const KycLoadInProgress();
}

final class KycLoadFailure extends KycState {
  const KycLoadFailure();
}

/// Loaded: the current [status] plus the in-progress capture [draft].
/// [uploading]/[submitting] drive progress; [error]/[justSubmitted] are
/// one-shot signals (reset on the next emit).
final class KycReady extends KycState {
  const KycReady(
    this.status,
    this.draft, {
    this.uploading,
    this.submitting = false,
    this.error,
    this.justSubmitted = false,
  });

  final KycStatusData status;
  final KycDraft draft;
  final KycSlot? uploading;
  final bool submitting;
  final KycError? error;
  final bool justSubmitted;

  bool get busy => uploading != null || submitting;

  KycReady copyWith({
    KycStatusData? status,
    KycDraft? draft,
    KycSlot? uploading,
    bool? submitting,
    KycError? error,
    bool? justSubmitted,
  }) {
    return KycReady(
      status ?? this.status,
      draft ?? this.draft,
      uploading: uploading, // transient — always set explicitly while active
      submitting: submitting ?? this.submitting,
      error: error, // one-shot
      justSubmitted: justSubmitted ?? false, // one-shot
    );
  }

  @override
  List<Object?> get props => [status, draft, uploading, submitting, error, justSubmitted];
}
