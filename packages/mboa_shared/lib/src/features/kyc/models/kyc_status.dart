import 'package:equatable/equatable.dart';

import 'document_identity.dart';

/// Overall KYC state (CDC M01bis). The backend returns a free-form status
/// string; [KycStatusX.parse] maps it defensively.
enum KycStatus { notSubmitted, pending, approved, rejected }

extension KycStatusX on KycStatus {
  /// Maps a backend status string to a [KycStatus], tolerant of casing and of
  /// the exact vocabulary the backend settles on.
  static KycStatus parse(String? raw) {
    final value = (raw ?? '').toUpperCase().trim();
    if (value.isEmpty || value.contains('NOT') || value == 'NONE') {
      return KycStatus.notSubmitted;
    }
    if (value.contains('APPROV') || value.contains('VALID') || value.contains('VERIFI')) {
      return KycStatus.approved;
    }
    if (value.contains('REJECT') || value.contains('REFUS')) {
      return KycStatus.rejected;
    }
    if (value.contains('PENDING') || value.contains('REVIEW') || value.contains('SUBMIT')) {
      return KycStatus.pending;
    }
    return KycStatus.notSubmitted;
  }
}

/// RM-M01bis-11 — where the prestataire is: a district of the catalogue and a
/// landmark. Seen by the admin alone.
class DeclaredAddress extends Equatable {
  const DeclaredAddress({required this.districtId, this.city, this.district, this.details});

  final String districtId;
  final String? city;
  final String? district;

  /// « derrière la pharmacie du marché » — 200 characters at most.
  final String? details;

  static const int maxDetails = 200;

  /// « Akwa, Douala ».
  String get label => [district, city].nonNulls.join(', ');

  @override
  List<Object?> get props => [districtId, city, district, details];
}

/// The KYC status view: overall [status] plus review metadata, and what the
/// prestataire declared beside the documents (§37 B).
class KycStatusData extends Equatable {
  const KycStatusData({
    required this.status,
    this.submittedAt,
    this.reviewedAt,
    this.rejectionReason,
    this.nui,
    this.address,
    this.identity,
  });

  final KycStatus status;
  final DateTime? submittedAt;
  final DateTime? reviewedAt;
  final String? rejectionReason;

  /// RM-M01bis-10 — declared, not verified; normalised by the server.
  final String? nui;
  final DeclaredAddress? address;

  /// §39 B — what is printed on the document, as typed (and corrected by the
  /// admin when approving). Absent on a KYC submitted before 2026-10-28.
  final DocumentIdentity? identity;

  /// An approved KYC without a NUI may still receive one, without a new
  /// review (`PUT /kyc/me/nui`).
  bool get canAddNui => status == KycStatus.approved && nui == null;

  @override
  List<Object?> get props => [status, submittedAt, reviewedAt, rejectionReason, nui, address, identity];
}
