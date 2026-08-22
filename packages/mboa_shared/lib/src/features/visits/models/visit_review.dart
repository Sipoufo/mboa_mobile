import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../profile/models/base_profile.dart';

/// A reply the visitor added under a published review (RM-M07bis-04).
///
/// It **adds beside** the client's words and never into them: neither the note
/// nor the text can be edited by the person being reviewed.
class ReviewComment extends Equatable {
  const ReviewComment({this.authorName, this.body, this.createdAt});

  final String? authorName;
  final String? body;
  final DateTime? createdAt;

  static ReviewComment fromResponse(Comment response) => ReviewComment(
        authorName: response.authorName,
        body: response.body,
        createdAt: response.createdAt?.toLocal(),
      );

  @override
  List<Object?> get props => [authorName, body, createdAt];
}

/// The client's report on a visit (CDC M07bis).
///
/// Written by the **client** since the 2026-08-13 revision — the visitor reads
/// it and may only comment. It is public on the listing (RM-M07bis-05) and
/// feeds the property's rating with the "visite" weight of RG-06.
class VisitReview extends Equatable {
  const VisitReview({
    required this.id,
    this.annonceId,
    this.authorName,
    this.rating,
    this.perceivedCondition,
    this.comment,
    this.pros = const [],
    this.cons = const [],
    this.photoKeys = const [],
    this.publishedAt,
    this.comments = const [],
  });

  final String id;
  final String? annonceId;

  /// Null when the author deleted their account: the review survives, and the
  /// screen must say "Utilisateur supprimé" rather than draw a blank
  /// (RM-M07bis-08).
  final String? authorName;

  final int? rating;
  final int? perceivedCondition;
  final String? comment;
  final List<String> pros;
  final List<String> cons;
  final List<String> photoKeys;
  final DateTime? publishedAt;
  final List<ReviewComment> comments;

  bool get hasDetail =>
      (comment?.trim().isNotEmpty ?? false) ||
      pros.isNotEmpty ||
      cons.isNotEmpty ||
      photoKeys.isNotEmpty;

  List<String> get photoUrls =>
      photoKeys.map(BaseProfile.mediaUrl).nonNulls.toList();

  static VisitReview fromResponse(ReviewResponse response) => VisitReview(
        id: response.id ?? '',
        annonceId: response.annonceId,
        authorName: response.authorName,
        rating: response.rating,
        perceivedCondition: response.perceivedCondition,
        comment: response.comment,
        pros: response.pros?.toList() ?? const [],
        cons: response.cons?.toList() ?? const [],
        photoKeys: response.photoKeys?.toList() ?? const [],
        publishedAt: response.publishedAt?.toLocal(),
        comments:
            response.comments?.map(ReviewComment.fromResponse).toList() ??
                const [],
      );

  @override
  List<Object?> get props => [
        id,
        annonceId,
        authorName,
        rating,
        perceivedCondition,
        comment,
        pros,
        cons,
        photoKeys,
        publishedAt,
        comments,
      ];
}
