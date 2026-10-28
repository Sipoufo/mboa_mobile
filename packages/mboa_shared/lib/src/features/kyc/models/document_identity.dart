import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

/// The identity documents the server accepts (§39 B). The tenant app offers
/// the first two; the Pro app all three.
enum KycDocType {
  cni,
  passport,
  drivingLicence;

  /// A passport has no back to photograph (`ID_DOCUMENT_BACK_REQUIRED` is for
  /// the other two).
  bool get hasBack => this != KycDocType.passport;

  String get wire => switch (this) {
        KycDocType.cni => 'CNI',
        KycDocType.passport => 'PASSPORT',
        KycDocType.drivingLicence => 'DRIVING_LICENCE',
      };

  static KycDocType? fromWire(String? value) => switch (value) {
        'CNI' => KycDocType.cni,
        'PASSPORT' => KycDocType.passport,
        'DRIVING_LICENCE' => KycDocType.drivingLicence,
        _ => null,
      };
}

/// Why the details of a document cannot be sent yet.
enum DocumentIdentityProblem {
  /// A field is still empty.
  incomplete,

  /// `INVALID_ISSUE_DATE` — issued after today.
  issuedInFuture,

  /// `ID_DOCUMENT_EXPIRED` — expires today or before.
  expired,
}

/// What is printed on an identity document (§39 B / D): the KYC records it,
/// and a signer without a verified one types it at signing.
class DocumentIdentity extends Equatable {
  const DocumentIdentity({
    this.type,
    this.number = '',
    this.issuedOn,
    this.expiresOn,
    this.issuedAt = '',
  });

  final KycDocType? type;
  final String number;
  final DateTime? issuedOn;
  final DateTime? expiresOn;

  /// The place of issue — « Douala », « Yaoundé ».
  final String issuedAt;

  static const int maxNumber = 50;
  static const int maxPlace = 100;

  /// The server's checks, in Douala days: issued no later than [today],
  /// valid after it.
  DocumentIdentityProblem? problemOn(DateTime today) {
    final day = DateTime(today.year, today.month, today.day);
    final issued = issuedOn;
    final expires = expiresOn;
    if (type == null || number.trim().isEmpty || issuedAt.trim().isEmpty || issued == null || expires == null) {
      return DocumentIdentityProblem.incomplete;
    }
    if (DateTime(issued.year, issued.month, issued.day).isAfter(day)) return DocumentIdentityProblem.issuedInFuture;
    if (!DateTime(expires.year, expires.month, expires.day).isAfter(day)) return DocumentIdentityProblem.expired;
    return null;
  }

  bool isValidOn(DateTime today) => problemOn(today) == null;

  DocumentIdentity copyWith({
    KycDocType? type,
    String? number,
    DateTime? issuedOn,
    DateTime? expiresOn,
    String? issuedAt,
  }) =>
      DocumentIdentity(
        type: type ?? this.type,
        number: number ?? this.number,
        issuedOn: issuedOn ?? this.issuedOn,
        expiresOn: expiresOn ?? this.expiresOn,
        issuedAt: issuedAt ?? this.issuedAt,
      );

  /// For a request body: the fields trimmed, the dates as dates.
  ({String type, String number, Date issuedOn, Date expiresOn, String issuedAt}) get wire => (
        type: type!.wire,
        number: number.trim(),
        issuedOn: issuedOn!.toDate(),
        expiresOn: expiresOn!.toDate(),
        issuedAt: issuedAt.trim(),
      );

  @override
  List<Object?> get props => [type, number, issuedOn, expiresOn, issuedAt];
}
