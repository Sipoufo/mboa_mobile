import 'package:equatable/equatable.dart';

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

/// The KYC status view: overall [status] plus review metadata.
class KycStatusData extends Equatable {
  const KycStatusData({
    required this.status,
    this.submittedAt,
    this.reviewedAt,
    this.rejectionReason,
  });

  final KycStatus status;
  final DateTime? submittedAt;
  final DateTime? reviewedAt;
  final String? rejectionReason;

  @override
  List<Object?> get props => [status, submittedAt, reviewedAt, rejectionReason];
}
