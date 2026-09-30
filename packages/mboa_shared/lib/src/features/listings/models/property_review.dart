import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../profile/models/base_profile.dart';

/// Where a review comes from (RG-06).
///
/// A resident lived there and counts three times a visitor's in the property's
/// average; the fiche says which is which, because "someone passed through" and
/// "someone lived here a year" are not the same testimony.
enum ReviewKind {
  visit,
  resident,
  unknown;

  static ReviewKind fromResponse(PropertyReviewTypeEnum? value) =>
      switch (value) {
        PropertyReviewTypeEnum.VISIT => ReviewKind.visit,
        PropertyReviewTypeEnum.RESIDENT => ReviewKind.resident,
        _ => ReviewKind.unknown,
      };
}

/// The owner's public answer to a resident's review (RM-M27-03), or the
/// visitor's comment on a visit report (RM-M07bis-04).
class ReviewReply extends Equatable {
  const ReviewReply({this.authorName, this.body, this.createdAt});

  final String? authorName;
  final String? body;
  final DateTime? createdAt;

  static ReviewReply fromResponse(Reply response) => ReviewReply(
        authorName: response.authorName,
        body: response.body,
        createdAt: response.createdAt?.toLocal(),
      );

  @override
  List<Object?> get props => [authorName, body, createdAt];
}

/// One entry on a property's public review feed (CDC M27, shown by M05).
///
/// Named for what it is rather than after the DTO: the generated client already
/// owns `PropertyReview`, and two types of that name in one file is how a
/// mapping ends up calling itself.
///
/// Visits and tenancies arrive in **one feed** — the endpoint's shape and Doc
/// 10's, because a reader wants the property's reputation, not two ledgers.
class ReviewEntry extends Equatable {
  const ReviewEntry({
    required this.id,
    this.kind = ReviewKind.unknown,
    this.annonceId,
    this.authorName,
    this.rating,
    this.comment,
    this.pros = const [],
    this.cons = const [],
    this.photoKeys = const [],
    this.perceivedCondition,
    this.residenceMonths,
    this.publishedAt,
    this.editedAt,
    this.replies = const [],
  });

  final String id;
  final ReviewKind kind;
  final String? annonceId;

  /// Null when the author deleted their account: the review outlives them
  /// (RM-M07bis-08), so the screen names them "Utilisateur supprimé" rather
  /// than drawing a blank.
  final String? authorName;

  final int? rating;
  final String? comment;
  final List<String> pros;
  final List<String> cons;
  final List<String> photoKeys;
  final int? perceivedCondition;

  /// How long the resident stayed — what earns RG-06's weight of three.
  final int? residenceMonths;

  final DateTime? publishedAt;

  /// RM-M27-02 — a resident may revise theirs while the tenancy runs; a visit
  /// report is locked (RM-M07bis-03). A date here means "corrigé le".
  final DateTime? editedAt;

  final List<ReviewReply> replies;

  List<String> get photoUrls =>
      photoKeys.map(BaseProfile.mediaUrl).nonNulls.toList();

  bool get hasBody =>
      (comment?.trim().isNotEmpty ?? false) ||
      pros.isNotEmpty ||
      cons.isNotEmpty;

  static ReviewEntry fromResponse(PropertyReview response) => ReviewEntry(
        id: response.id ?? '',
        kind: ReviewKind.fromResponse(response.type),
        annonceId: response.annonceId,
        authorName: response.authorName,
        rating: response.rating,
        comment: response.comment,
        pros: response.pros?.toList() ?? const [],
        cons: response.cons?.toList() ?? const [],
        photoKeys: response.photoKeys?.toList() ?? const [],
        perceivedCondition: response.perceivedCondition,
        residenceMonths: response.residenceMonths,
        publishedAt: response.publishedAt?.toLocal(),
        editedAt: response.editedAt?.toLocal(),
        replies:
            response.replies?.map(ReviewReply.fromResponse).toList() ?? const [],
      );

  @override
  List<Object?> get props => [
        id,
        kind,
        annonceId,
        authorName,
        rating,
        comment,
        pros,
        cons,
        photoKeys,
        perceivedCondition,
        residenceMonths,
        publishedAt,
        editedAt,
        replies,
      ];
}
