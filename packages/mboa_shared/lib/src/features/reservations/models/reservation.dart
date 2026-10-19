import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../listings/models/rental_period.dart';
import '../../profile/models/base_profile.dart';

/// Where a reservation request stands (CDC M29).
enum ReservationStatus {
  /// Waiting for the prestataire, 48 h at most (RM-M29-05).
  pending,

  /// The listing is reserved for this client, 7 days (14 if extended).
  accepted,
  refused,

  /// Another client's request was accepted (RM-M29-04).
  notRetained,

  /// Unanswered after 48 h.
  expired,
  cancelled,

  /// Ran out with no signed contract (RM-M29-07).
  lapsed,

  /// Its contract was signed by both: the listing is let.
  contracted,
  unknown;

  static ReservationStatus fromWire(String? name) => switch (name) {
        'PENDING' => ReservationStatus.pending,
        'ACCEPTED' => ReservationStatus.accepted,
        'REFUSED' => ReservationStatus.refused,
        'NOT_RETAINED' => ReservationStatus.notRetained,
        'EXPIRED' => ReservationStatus.expired,
        'CANCELLED' => ReservationStatus.cancelled,
        'LAPSED' => ReservationStatus.lapsed,
        'CONTRACTED' => ReservationStatus.contracted,
        _ => ReservationStatus.unknown,
      };

  /// Still in play: waiting, or holding the listing.
  bool get isOpen => this == ReservationStatus.pending || this == ReservationStatus.accepted;
}

/// RM-M29-06 — the refusal reasons, from a fixed list. Never published.
enum RefusalReason {
  reservedElsewhere,
  profileNotRetained,
  datesIncompatible,
  other;

  static RefusalReason? fromWire(String? name) => switch (name) {
        'RESERVED_ELSEWHERE' => RefusalReason.reservedElsewhere,
        'PROFILE_NOT_RETAINED' => RefusalReason.profileNotRetained,
        'DATES_INCOMPATIBLE' => RefusalReason.datesIncompatible,
        'OTHER' => RefusalReason.other,
        _ => null,
      };

  String get wire => switch (this) {
        RefusalReason.reservedElsewhere => 'RESERVED_ELSEWHERE',
        RefusalReason.profileNotRetained => 'PROFILE_NOT_RETAINED',
        RefusalReason.datesIncompatible => 'DATES_INCOMPATIBLE',
        RefusalReason.other => 'OTHER',
      };
}

/// Who ended a reservation — `SYSTEM` when its listing left the market
/// (CE-M29-04).
enum CancelledBy { client, prestataire, system }

/// A name and a face, as the API shares them.
class ReservationParty extends Equatable {
  const ReservationParty({this.accountId, this.name, this.photoKey});

  final String? accountId;
  final String? name;
  final String? photoKey;

  String? get photoUrl => BaseProfile.mediaUrl(photoKey);

  static ReservationParty? fromResponse(ParticipantSummary? summary) => summary == null
      ? null
      : ReservationParty(accountId: summary.accountId, name: summary.displayName, photoKey: summary.photoObjectKey);

  @override
  List<Object?> get props => [accountId, name, photoKey];
}

/// A request to reserve a listing, **without any payment** (CDC M29,
/// RM-M29-09): the money is settled between the parties after the Mboa
/// Contract is signed. Read by both apps — the client's request and the
/// prestataire's incoming one are the same record.
///
/// What either party may do next is the **server's** answer (`can*`), read
/// rather than derived from [status]: the 48 h, the 7 days, the one
/// extension and the listing's state all weigh on it.
class Reservation extends Equatable {
  const Reservation({
    required this.id,
    required this.status,
    this.annonceId,
    this.annonceTitle,
    this.userAccountId,
    this.client,
    this.prestataire,
    this.desiredStartDate,
    this.durationUnits,
    this.rentalPeriod = RentalPeriod.fallback,
    this.message,
    this.expiresAt,
    this.reservedUntil,
    this.extended = false,
    this.ownerReason,
    this.ownerNote,
    this.cancelledBy,
    this.conversationId,
    this.createdAt,
    this.answeredAt,
    this.canAccept = false,
    this.canRefuse = false,
    this.canExtend = false,
    this.canCancel = false,
    this.canDraftContract = false,
  });

  final String id;
  final ReservationStatus status;
  final String? annonceId;

  /// A copy, kept if the listing goes.
  final String? annonceTitle;

  /// The client's account — what opens their Mboa Score (RM-M09-04).
  final String? userAccountId;
  final ReservationParty? client;
  final ReservationParty? prestataire;
  final DateTime? desiredStartDate;

  /// Counted in [rentalPeriod], the listing's own (RM-M10-09).
  final int? durationUnits;
  final RentalPeriod rentalPeriod;
  final String? message;

  /// The 48 h to answer, while pending.
  final DateTime? expiresAt;

  /// The end of the 7 (or 14) days, once accepted.
  final DateTime? reservedUntil;
  final bool extended;
  final RefusalReason? ownerReason;
  final String? ownerNote;
  final CancelledBy? cancelledBy;

  /// The listing's thread the request opened (RM-M29-14) — « Répondre ».
  final String? conversationId;
  final DateTime? createdAt;
  final DateTime? answeredAt;

  final bool canAccept;
  final bool canRefuse;
  final bool canExtend;
  final bool canCancel;
  final bool canDraftContract;

  /// The stay's last day, indicative — the contract's end is the server's.
  DateTime? get lastDay {
    final start = desiredStartDate;
    final units = durationUnits;
    if (start == null || units == null || units <= 0) return null;
    return rentalPeriod.lastDay(start, units);
  }

  /// A short reference, for the confirmation card.
  String get reference => id.length <= 8 ? id.toUpperCase() : id.substring(0, 8).toUpperCase();

  static Reservation fromResponse(ReservationResponse response) => Reservation(
        id: response.id ?? '',
        status: ReservationStatus.fromWire(response.status?.name),
        annonceId: response.annonceId,
        annonceTitle: response.annonceTitle,
        userAccountId: response.userAccountId,
        client: ReservationParty.fromResponse(response.client),
        prestataire: ReservationParty.fromResponse(response.prestataire),
        desiredStartDate: response.desiredStartDate?.toDateTime(),
        durationUnits: response.durationUnits,
        rentalPeriod: RentalPeriod.fromWire(response.rentalPeriod?.name),
        message: (response.message?.trim().isEmpty ?? true) ? null : response.message!.trim(),
        expiresAt: response.expiresAt?.toLocal(),
        reservedUntil: response.reservedUntil?.toLocal(),
        extended: response.extended ?? false,
        ownerReason: RefusalReason.fromWire(response.ownerReason?.name),
        ownerNote: response.ownerNote,
        cancelledBy: switch (response.cancelledBy?.name) {
          'CLIENT' => CancelledBy.client,
          'PRESTATAIRE' => CancelledBy.prestataire,
          'SYSTEM' => CancelledBy.system,
          _ => null,
        },
        conversationId: response.conversationId,
        createdAt: response.createdAt?.toLocal(),
        answeredAt: response.answeredAt?.toLocal(),
        canAccept: response.canAccept ?? false,
        canRefuse: response.canRefuse ?? false,
        canExtend: response.canExtend ?? false,
        canCancel: response.canCancel ?? false,
        canDraftContract: response.canDraftContract ?? false,
      );

  /// Only what a list row draws, for the offline copy of either list.
  Map<String, dynamic> toCache() => {
        'id': id,
        'client': client?.name,
        'createdAt': createdAt?.toIso8601String(),
        'status': status.name,
        'annonceId': annonceId,
        'title': annonceTitle,
        'start': desiredStartDate?.toIso8601String(),
        'units': durationUnits,
        'period': rentalPeriod.name,
        'reservedUntil': reservedUntil?.toIso8601String(),
        'expiresAt': expiresAt?.toIso8601String(),
      };

  static Reservation? fromCache(Map<String, dynamic> json) {
    final id = json['id'];
    if (id is! String) return null;
    DateTime? date(Object? raw) => raw is String ? DateTime.tryParse(raw) : null;
    return Reservation(
      id: id,
      status: ReservationStatus.values.where((s) => s.name == json['status']).firstOrNull ?? ReservationStatus.unknown,
      annonceId: json['annonceId'] as String?,
      annonceTitle: json['title'] as String?,
      client: json['client'] is String ? ReservationParty(name: json['client'] as String) : null,
      createdAt: date(json['createdAt']),
      desiredStartDate: date(json['start']),
      durationUnits: json['units'] as int?,
      rentalPeriod: RentalPeriod.values.where((p) => p.name == json['period']).firstOrNull ?? RentalPeriod.fallback,
      reservedUntil: date(json['reservedUntil']),
      expiresAt: date(json['expiresAt']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        status,
        annonceId,
        annonceTitle,
        userAccountId,
        client,
        prestataire,
        desiredStartDate,
        durationUnits,
        rentalPeriod,
        message,
        expiresAt,
        reservedUntil,
        extended,
        ownerReason,
        ownerNote,
        cancelledBy,
        conversationId,
        createdAt,
        answeredAt,
        canAccept,
        canRefuse,
        canExtend,
        canCancel,
        canDraftContract,
      ];
}
