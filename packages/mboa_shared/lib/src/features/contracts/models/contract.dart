import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../listings/models/rental_period.dart';
import '../../profile/models/base_profile.dart';

/// Where a Contrat Mboa has got to (CDC M08).
///
/// The order is the flow: a draft is sent, the tenant accepts or contests, and
/// two signatures lock it for good (RM-M08-03).
enum ContractStatus {
  draft,
  sent,
  changesRequested,
  accepted,
  signed,
  cancelled,
  unknown;

  static ContractStatus fromResponse(ContractResponseStatusEnum? value) =>
      switch (value) {
        ContractResponseStatusEnum.DRAFT => ContractStatus.draft,
        ContractResponseStatusEnum.SENT => ContractStatus.sent,
        ContractResponseStatusEnum.CHANGES_REQUESTED =>
          ContractStatus.changesRequested,
        ContractResponseStatusEnum.ACCEPTED => ContractStatus.accepted,
        ContractResponseStatusEnum.SIGNED => ContractStatus.signed,
        ContractResponseStatusEnum.CANCELLED => ContractStatus.cancelled,
        _ => ContractStatus.unknown,
      };

  /// Still moving between the parties.
  bool get isOpen =>
      this == ContractStatus.draft ||
      this == ContractStatus.sent ||
      this == ContractStatus.changesRequested ||
      this == ContractStatus.accepted;

  /// RM-M08-03 / RM-M08-08 — the terms may only be amended while nobody has
  /// accepted them. Editing under an acceptance would make it bear on a text
  /// the tenant never read.
  bool get isAmendable =>
      this == ContractStatus.draft ||
      this == ContractStatus.sent ||
      this == ContractStatus.changesRequested;
}

/// RM-M08-09 — whose move it is. **Server-computed**: the app renders it and
/// never works it out from the status, which is exactly how a contract ends up
/// waiting on both parties at once in two different screens.
enum ContractParty {
  prestataire,
  tenant,
  both,
  nobody,
  unknown;

  static ContractParty fromResponse(ContractResponseAwaitingEnum? value) =>
      switch (value) {
        ContractResponseAwaitingEnum.PRESTATAIRE => ContractParty.prestataire,
        ContractResponseAwaitingEnum.TENANT => ContractParty.tenant,
        ContractResponseAwaitingEnum.BOTH => ContractParty.both,
        ContractResponseAwaitingEnum.NOBODY => ContractParty.nobody,
        _ => ContractParty.unknown,
      };
}

/// The seven terms a tenant may contest (CE-M08-03).
enum ContestedTerm {
  price,
  rentalPeriod,
  depositAmount,
  chargesIncluded,
  startDate,
  durationUnits,
  tacitRenewal;

  static ContestedTerm? fromResponse(ChangeRequestResponseContestedTermsEnum? v) =>
      switch (v) {
        ChangeRequestResponseContestedTermsEnum.PRICE => ContestedTerm.price,
        ChangeRequestResponseContestedTermsEnum.RENTAL_PERIOD =>
          ContestedTerm.rentalPeriod,
        ChangeRequestResponseContestedTermsEnum.DEPOSIT_AMOUNT =>
          ContestedTerm.depositAmount,
        ChangeRequestResponseContestedTermsEnum.CHARGES_INCLUDED =>
          ContestedTerm.chargesIncluded,
        ChangeRequestResponseContestedTermsEnum.START_DATE =>
          ContestedTerm.startDate,
        ChangeRequestResponseContestedTermsEnum.DURATION_UNITS =>
          ContestedTerm.durationUnits,
        ChangeRequestResponseContestedTermsEnum.TACIT_RENEWAL =>
          ContestedTerm.tacitRenewal,
        _ => null,
      };
}

/// One objection and, once given, the landlord's answer (CE-M08-03).
///
/// The answer is required **whether or not the terms move**: refusing to budge
/// on the deposit is a legitimate reply and belongs in the file.
class ChangeRequest extends Equatable {
  const ChangeRequest({
    required this.id,
    this.comment,
    this.contestedTerms = const [],
    this.createdAt,
    this.response,
    this.respondedAt,
    this.withdrawnAt,
    this.pending = false,
  });

  final String id;
  final String? comment;
  final List<ContestedTerm> contestedTerms;
  final DateTime? createdAt;
  final String? response;
  final DateTime? respondedAt;
  final DateTime? withdrawnAt;

  /// Server-computed: an objection nobody has answered yet.
  final bool pending;

  bool get isWithdrawn => withdrawnAt != null;

  static ChangeRequest fromResponse(ChangeRequestResponse response) =>
      ChangeRequest(
        id: response.id ?? '',
        comment: response.comment,
        contestedTerms: response.contestedTerms
                ?.map(ContestedTerm.fromResponse)
                .nonNulls
                .toList() ??
            const [],
        createdAt: response.createdAt?.toLocal(),
        response: response.response,
        respondedAt: response.respondedAt?.toLocal(),
        withdrawnAt: response.withdrawnAt?.toLocal(),
        pending: response.pending ?? false,
      );

  @override
  List<Object?> get props => [
        id,
        comment,
        contestedTerms,
        createdAt,
        response,
        respondedAt,
        withdrawnAt,
        pending,
      ];
}

/// One party's signature. [isMine] is the server's `current` flag — the app
/// never compares account ids to decide whose it is.
class ContractSignature extends Equatable {
  const ContractSignature({this.signerAccountId, this.signedAt, this.isMine = false});

  final String? signerAccountId;
  final DateTime? signedAt;
  final bool isMine;

  static ContractSignature fromResponse(SignatureResponse response) =>
      ContractSignature(
        signerAccountId: response.signerAccountId,
        signedAt: response.signedAt?.toLocal(),
        isMine: response.current ?? false,
      );

  @override
  List<Object?> get props => [signerAccountId, signedAt, isMine];
}

/// A party to the contract, as the other side sees them.
class ContractParticipant extends Equatable {
  const ContractParticipant({this.accountId, this.displayName, this.photoObjectKey});

  final String? accountId;
  final String? displayName;
  final String? photoObjectKey;

  String? get photoUrl => BaseProfile.mediaUrl(photoObjectKey);

  static ContractParticipant fromResponse(ParticipantSummary response) =>
      ContractParticipant(
        accountId: response.accountId,
        displayName: response.displayName,
        photoObjectKey: response.photoObjectKey,
      );

  @override
  List<Object?> get props => [accountId, displayName, photoObjectKey];
}

/// Where the tenancy of a signed contract stands today (RM-M08-12).
enum TenancyState {
  upcoming,
  running,
  ended,
  unknown;

  static TenancyState fromResponse(ContractTenancyResponseStateEnum? value) => switch (value) {
        ContractTenancyResponseStateEnum.UPCOMING => TenancyState.upcoming,
        ContractTenancyResponseStateEnum.RUNNING => TenancyState.running,
        ContractTenancyResponseStateEnum.ENDED => TenancyState.ended,
        _ => TenancyState.unknown,
      };
}

/// What became of a termination (RM-M08-11).
enum TerminationStatus {
  /// Proposed to the other party, who confirms or declines; its author may
  /// withdraw it until then.
  proposed,

  /// Notified alone: binding at once, never withdrawn.
  notified,

  /// A proposal the other party agreed to: binding.
  confirmed,
  declined,
  withdrawn,
  unknown;

  static TerminationStatus fromResponse(TerminationResponseStatusEnum? value) => switch (value) {
        TerminationResponseStatusEnum.PROPOSED => TerminationStatus.proposed,
        TerminationResponseStatusEnum.NOTIFIED => TerminationStatus.notified,
        TerminationResponseStatusEnum.CONFIRMED => TerminationStatus.confirmed,
        TerminationResponseStatusEnum.DECLINED => TerminationStatus.declined,
        TerminationResponseStatusEnum.WITHDRAWN => TerminationStatus.withdrawn,
        _ => TerminationStatus.unknown,
      };

  /// The tenancy now ends on its date.
  bool get isBinding => this == TerminationStatus.notified || this == TerminationStatus.confirmed;
}

/// The latest termination asked of a contract, whatever became of it
/// (RM-M08-11). What the reader may do with it is the server's `can*`.
class Termination extends Equatable {
  const Termination({
    required this.status,
    this.id,
    this.requestedBy = ContractParty.unknown,
    this.mutual = false,
    this.reason,
    this.effectiveDate,
    this.requestedAt,
    this.answeredAt,
    this.canAnswer = false,
    this.canWithdraw = false,
  });

  final String? id;
  final TerminationStatus status;
  final ContractParty requestedBy;

  /// Proposed to the other party (true) or notified alone (false).
  final bool mutual;
  final String? reason;

  /// The tenancy's last day it sets, or proposes.
  final DateTime? effectiveDate;
  final DateTime? requestedAt;
  final DateTime? answeredAt;

  /// The reader is the other party, on a proposal.
  final bool canAnswer;

  /// The reader is its author, on a proposal.
  final bool canWithdraw;

  static Termination fromResponse(TerminationResponse response) => Termination(
        id: response.id,
        status: TerminationStatus.fromResponse(response.status),
        requestedBy: switch (response.requestedBy) {
          TerminationResponseRequestedByEnum.PRESTATAIRE => ContractParty.prestataire,
          TerminationResponseRequestedByEnum.TENANT => ContractParty.tenant,
          _ => ContractParty.unknown,
        },
        mutual: response.mutual ?? false,
        reason: response.reason,
        effectiveDate: response.effectiveDate?.toDateTime(),
        requestedAt: response.requestedAt?.toLocal(),
        answeredAt: response.answeredAt?.toLocal(),
        canAnswer: response.canAnswer ?? false,
        canWithdraw: response.canWithdraw ?? false,
      );

  @override
  List<Object?> get props =>
      [id, status, requestedBy, mutual, reason, effectiveDate, requestedAt, answeredAt, canAnswer, canWithdraw];
}

/// How the tenancy of a signed contract stands, and how it can end
/// (RM-M08-11, RM-M08-12). Only on a signed contract.
class Tenancy extends Equatable {
  const Tenancy({
    this.state = TenancyState.unknown,
    this.endsOn,
    this.canTerminate = false,
    this.earliestNoticeDate,
    this.termination,
  });

  final TenancyState state;

  /// Its last day — a binding termination's, else the term's. Null while it
  /// renews itself tacitly.
  final DateTime? endsOn;

  /// Not ended, and no termination pending or binding.
  final bool canTerminate;

  /// The earliest last day a termination notified alone may set; a mutual
  /// one may set any day from today.
  final DateTime? earliestNoticeDate;
  final Termination? termination;

  static Tenancy fromResponse(ContractTenancyResponse response) => Tenancy(
        state: TenancyState.fromResponse(response.state),
        endsOn: response.endsOn?.toDateTime(),
        canTerminate: response.canTerminate ?? false,
        earliestNoticeDate: response.earliestNoticeDate?.toDateTime(),
        termination: response.termination == null ? null : Termination.fromResponse(response.termination!),
      );

  @override
  List<Object?> get props => [state, endsOn, canTerminate, earliestNoticeDate, termination];
}

/// A Contrat Mboa (CDC M08).
///
/// It **copies the property it carries** (title, city, district, address) so it
/// survives the deletion of either party's account (RM-M08-05) — which is why
/// nothing here is looked up from the listing.
class Contract extends Equatable {
  const Contract({
    required this.id,
    required this.status,
    this.annonceId,
    this.annonceTitle,
    this.city,
    this.district,
    this.exactAddress,
    this.prestataire,
    this.tenant,
    this.agent,
    this.price,
    this.rentalPeriod = RentalPeriod.fallback,
    this.monthlyRent,
    this.depositAmount,
    this.chargesIncluded,
    this.startDate,
    this.endDate,
    this.durationUnits,
    this.tacitRenewal,
    this.signatures = const [],
    this.changeRequests = const [],
    this.awaiting = ContractParty.unknown,
    this.canSign = false,
    this.canAccept = false,
    this.residentReviewEligible = false,
    this.tenancy,
    this.reservationRequestId,
    this.lockedAt,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final ContractStatus status;
  final String? annonceId;
  final String? annonceTitle;
  final String? city;
  final String? district;

  /// CA-M08-02 — the exact address appears **only once the contract is
  /// signed**, and the server withholds it until then. Null is the rule
  /// working, not missing data.
  final String? exactAddress;

  final ContractParticipant? prestataire;
  final ContractParticipant? tenant;

  /// RM-M08-07 — the agent who conducted the visit that led here, if any.
  final ContractParticipant? agent;

  final int? price;
  final RentalPeriod rentalPeriod;

  /// The server's comparison figure, as on a listing: never billed, never
  /// printed on the contract.
  final int? monthlyRent;

  final int? depositAmount;
  final bool? chargesIncluded;
  final DateTime? startDate;
  final DateTime? endDate;

  /// RM-M08-08 — expressed in units of [rentalPeriod]; the end date follows.
  final int? durationUnits;
  final bool? tacitRenewal;

  final List<ContractSignature> signatures;
  final List<ChangeRequest> changeRequests;

  /// RM-M08-09, server-computed.
  final ContractParty awaiting;

  /// Server-computed: RM-M08-02 (both accounts verified) and the acceptance
  /// are its business, not the app's.
  final bool canSign;

  /// Server-computed (RM-M08-02 / CE-M08-03): true for the tenant while the
  /// contract is SENT or CHANGES_REQUESTED — the window to accept or contest.
  /// The landlord never gets it. Gates both tenant actions, so the screen
  /// does not work out whose move it is.
  final bool canAccept;

  final bool residentReviewEligible;

  /// RM-M08-11 / RM-M08-12 — once signed: where the tenancy stands, and how
  /// it can end. Null before the signatures.
  final Tenancy? tenancy;

  /// RM-M08-10 — the reservation request it was drawn up from, if any.
  final String? reservationRequestId;

  final DateTime? lockedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  bool get isSigned => status == ContractStatus.signed;

  /// RM-M08-03 — locked for good; not even an admin may change it.
  bool get isLocked => lockedAt != null || isSigned;

  bool get hasSignedMyself => signatures.any((s) => s.isMine);

  /// CE-M08-03 — objections still owed an answer. The landlord cannot move on
  /// while one stands.
  List<ChangeRequest> get pendingChanges =>
      changeRequests.where((c) => c.pending && !c.isWithdrawn).toList();

  static Contract fromResponse(ContractResponse response) => Contract(
        id: response.id ?? '',
        status: ContractStatus.fromResponse(response.status),
        annonceId: response.annonceId,
        annonceTitle: response.annonceTitle,
        city: response.city,
        district: response.district,
        exactAddress: response.exactAddress,
        prestataire: response.prestataire == null
            ? null
            : ContractParticipant.fromResponse(response.prestataire!),
        tenant: response.tenant == null
            ? null
            : ContractParticipant.fromResponse(response.tenant!),
        agent: response.agent == null
            ? null
            : ContractParticipant.fromResponse(response.agent!),
        price: response.price,
        rentalPeriod: RentalPeriod.fromContract(response.rentalPeriod),
        monthlyRent: response.monthlyRent,
        depositAmount: response.depositAmount,
        chargesIncluded: response.chargesIncluded,
        startDate: response.startDate?.toDateTime(),
        endDate: response.endDate?.toDateTime(),
        durationUnits: response.durationUnits,
        tacitRenewal: response.tacitRenewal,
        signatures:
            response.signatures?.map(ContractSignature.fromResponse).toList() ??
                const [],
        changeRequests:
            response.changeRequests?.map(ChangeRequest.fromResponse).toList() ??
                const [],
        awaiting: ContractParty.fromResponse(response.awaiting),
        canSign: response.canSign ?? false,
        canAccept: response.canAccept ?? false,
        residentReviewEligible: response.residentReviewEligible ?? false,
        tenancy: response.tenancy == null ? null : Tenancy.fromResponse(response.tenancy!),
        reservationRequestId: response.reservationRequestId,
        lockedAt: response.lockedAt?.toLocal(),
        createdAt: response.createdAt?.toLocal(),
        updatedAt: response.updatedAt?.toLocal(),
      );

  // Every field: a partial props list makes bloc drop an emission and the
  // screen silently not update.
  @override
  List<Object?> get props => [
        id,
        status,
        annonceId,
        annonceTitle,
        city,
        district,
        exactAddress,
        prestataire,
        tenant,
        agent,
        price,
        rentalPeriod,
        monthlyRent,
        depositAmount,
        chargesIncluded,
        startDate,
        endDate,
        durationUnits,
        tacitRenewal,
        signatures,
        changeRequests,
        awaiting,
        canSign,
        canAccept,
        residentReviewEligible,
        tenancy,
        reservationRequestId,
        lockedAt,
        createdAt,
        updatedAt,
      ];
}

/// The terms as a form holds them, for a creation or an amendment.
class ContractTerms extends Equatable {
  const ContractTerms({
    this.annonceId,
    this.tenantAccountId,
    this.tenantPhone,
    this.price,
    this.rentalPeriod = RentalPeriod.month,
    this.depositAmount,
    this.chargesIncluded = false,
    this.startDate,
    this.durationUnits,
    this.tacitRenewal = false,
    this.reservationRequestId,
  });

  final String? annonceId;
  final String? tenantAccountId;

  /// CE-M08-01 — a tenant with no Mboa account gets an SMS invitation and the
  /// contract is **not** created; the screen has to say so rather than retry.
  final String? tenantPhone;

  final int? price;
  final RentalPeriod rentalPeriod;
  final int? depositAmount;
  final bool chargesIncluded;
  final DateTime? startDate;
  final int? durationUnits;
  final bool tacitRenewal;

  /// RM-M08-10 — drawn up from an accepted reservation request: the tenant is
  /// the request's client, so none is named (the server refuses one,
  /// `TENANT_FROM_RESERVATION`).
  final String? reservationRequestId;

  /// What `POST /contracts` requires, before the server is asked.
  bool get isComplete =>
      annonceId != null &&
      (reservationRequestId != null || tenantAccountId != null || (tenantPhone?.isNotEmpty ?? false)) &&
      (price ?? 0) > 0 &&
      depositAmount != null &&
      startDate != null &&
      (durationUnits ?? 0) > 0;

  static ContractTerms of(Contract contract) => ContractTerms(
        annonceId: contract.annonceId,
        tenantAccountId: contract.tenant?.accountId,
        price: contract.price,
        rentalPeriod: contract.rentalPeriod,
        depositAmount: contract.depositAmount,
        chargesIncluded: contract.chargesIncluded ?? false,
        startDate: contract.startDate,
        durationUnits: contract.durationUnits,
        tacitRenewal: contract.tacitRenewal ?? false,
      );

  ContractTerms copyWith({
    String? annonceId,
    String? tenantAccountId,
    String? tenantPhone,
    int? price,
    RentalPeriod? rentalPeriod,
    int? depositAmount,
    bool? chargesIncluded,
    DateTime? startDate,
    int? durationUnits,
    bool? tacitRenewal,
  }) =>
      ContractTerms(
        annonceId: annonceId ?? this.annonceId,
        tenantAccountId: tenantAccountId ?? this.tenantAccountId,
        tenantPhone: tenantPhone ?? this.tenantPhone,
        price: price ?? this.price,
        rentalPeriod: rentalPeriod ?? this.rentalPeriod,
        depositAmount: depositAmount ?? this.depositAmount,
        chargesIncluded: chargesIncluded ?? this.chargesIncluded,
        startDate: startDate ?? this.startDate,
        durationUnits: durationUnits ?? this.durationUnits,
        tacitRenewal: tacitRenewal ?? this.tacitRenewal,
        reservationRequestId: reservationRequestId,
      );

  @override
  List<Object?> get props => [
        annonceId,
        tenantAccountId,
        tenantPhone,
        price,
        rentalPeriod,
        depositAmount,
        chargesIncluded,
        startDate,
        durationUnits,
        tacitRenewal,
        reservationRequestId,
      ];
}
