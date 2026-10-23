import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

/// What is being reported (CDC M23).
///
/// The wire values are written out literally rather than derived from the
/// enum's name: a guessed one looks exactly like an empty list, which is how
/// every trust badge on the fiche silently disappeared for a month.
enum ReportTargetKind {
  annonce,
  message,
  review,

  /// RM-M30-07 — a dispute over a home: its contract (= the home's id), one
  /// declaration, or one sending of photo proofs. Either party, during or
  /// after the tenancy.
  contract,
  declaration,
  evidence;

  /// A dispute rather than a report: against nobody, it costs no one a Mboa
  /// Score point, and both parties hear the ruling (N-40).
  bool get isDispute => switch (this) {
        ReportTargetKind.contract || ReportTargetKind.declaration || ReportTargetKind.evidence => true,
        _ => false,
      };

  CreateSignalementRequestTargetTypeEnum get wire => switch (this) {
        ReportTargetKind.annonce =>
          CreateSignalementRequestTargetTypeEnum.ANNONCE,
        ReportTargetKind.message =>
          CreateSignalementRequestTargetTypeEnum.MESSAGE,
        ReportTargetKind.review =>
          CreateSignalementRequestTargetTypeEnum.REVIEW,
        ReportTargetKind.contract => CreateSignalementRequestTargetTypeEnum.CONTRACT,
        ReportTargetKind.declaration => CreateSignalementRequestTargetTypeEnum.DECLARATION,
        ReportTargetKind.evidence => CreateSignalementRequestTargetTypeEnum.EVIDENCE,
      };
}

/// Why (CDC M23, RM-M23-01).
///
/// **Not every reason fits every target.** The list the API offers was drawn
/// for listings — "prix anormal" means nothing about a sentence somebody wrote
/// about their landlord — so [ReportTarget.reasons] narrows it per kind rather
/// than offering a menu where two thirds of the entries are absurd. The server
/// accepts any combination; this is the app declining to ask a nonsensical
/// question. Raised as §25 in docs/backend-requests.md.
enum ReportReason {
  fraudulentListing,
  abnormalPrice,
  inappropriateContent,
  harassment,

  /// RM-M29-09 — money asked before the Mboa Contract is signed: Mboa takes
  /// none at reservation, and nobody else should either.
  askedForMoney,

  /// RM-M30-07 — the only reason a dispute takes, and only a dispute.
  dispute;

  CreateSignalementRequestReasonEnum get wire => switch (this) {
        ReportReason.fraudulentListing =>
          CreateSignalementRequestReasonEnum.FRAUDULENT_LISTING,
        ReportReason.abnormalPrice =>
          CreateSignalementRequestReasonEnum.ABNORMAL_PRICE,
        ReportReason.inappropriateContent =>
          CreateSignalementRequestReasonEnum.INAPPROPRIATE_CONTENT,
        ReportReason.harassment => CreateSignalementRequestReasonEnum.HARASSMENT,
        ReportReason.askedForMoney => CreateSignalementRequestReasonEnum.ASKED_FOR_MONEY,
        ReportReason.dispute => CreateSignalementRequestReasonEnum.DISPUTE,
      };
}

/// One thing a signed-in user may report.
class ReportTarget extends Equatable {
  const ReportTarget({required this.kind, required this.id});

  const ReportTarget.annonce(String id)
      : this(kind: ReportTargetKind.annonce, id: id);

  const ReportTarget.review(String id)
      : this(kind: ReportTargetKind.review, id: id);

  const ReportTarget.message(String id)
      : this(kind: ReportTargetKind.message, id: id);

  /// A home, by its contract.
  const ReportTarget.contract(String id) : this(kind: ReportTargetKind.contract, id: id);

  const ReportTarget.declaration(String id) : this(kind: ReportTargetKind.declaration, id: id);

  /// One sending of photo proofs.
  const ReportTarget.evidence(String id) : this(kind: ReportTargetKind.evidence, id: id);

  final ReportTargetKind kind;
  final String id;

  /// The reasons worth offering for this kind of target.
  List<ReportReason> get reasons => switch (kind) {
        ReportTargetKind.annonce => const [
            ReportReason.fraudulentListing,
            ReportReason.abnormalPrice,
            ReportReason.askedForMoney,
            ReportReason.inappropriateContent,
          ],
        // RM-M27-06 — a review is somebody's account of living somewhere. It
        // can be abusive or untrue; it cannot be overpriced.
        ReportTargetKind.review => const [
            ReportReason.inappropriateContent,
            ReportReason.harassment,
          ],
        ReportTargetKind.message => const [
            ReportReason.askedForMoney,
            ReportReason.inappropriateContent,
            ReportReason.harassment,
          ],
        // The server takes nothing else (REASON_NOT_APPLICABLE).
        ReportTargetKind.contract ||
        ReportTargetKind.declaration ||
        ReportTargetKind.evidence =>
          const [ReportReason.dispute],
      };

  @override
  List<Object?> get props => [kind, id];
}
