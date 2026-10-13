part of 'resident_reply_bloc.dart';

sealed class ResidentReplyEvent extends Equatable {
  const ResidentReplyEvent();

  @override
  List<Object?> get props => [];
}

/// Reads the tenant's review, if there is one. A 404 is the ordinary answer
/// for a tenancy nobody has reviewed yet.
class ResidentReplyOpened extends ResidentReplyEvent {
  const ResidentReplyOpened(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

/// RM-M27-03 — the landlord's public answer, once.
class ResidentReplySent extends ResidentReplyEvent {
  const ResidentReplySent(this.body);

  final String body;

  @override
  List<Object?> get props => [body];
}
