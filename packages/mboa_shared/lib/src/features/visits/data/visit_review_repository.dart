import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';

import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

import '../models/visit_review.dart';

/// The client's report on a visit, read by the people who carried it out
/// (CDC M07bis).
///
/// Shared: the client writes one from App Mboa, an agent reads it from his
/// visit detail, a prestataire from his own agenda. **The note and the text
/// are the client's**: [submit] is the tenant app's, and the only thing the
/// visitor may add is a [comment] beside them (RM-M07bis-04), never into
/// them (CA-M07bis-02).
class VisitReviewRepository {
  VisitReviewRepository({required DioClient dioClient})
      : _dioClient = dioClient;

  final DioClient _dioClient;

  VisitesAvisApi get _api => _dioClient.api.getVisitesAvisApi();

  /// The review published for this visit, or **null when there is none**.
  ///
  /// Writing one is optional and undated (RM-M07bis-02), so "no review yet" is
  /// the ordinary state for a visit that has just happened — a 404 here is an
  /// answer, not a failure.
  Future<VisitReview?> fetch(String visiteId) async {
    try {
      final response = await _api.getVisiteReview(visiteId: visiteId);
      final data = response.data;
      return data == null ? null : VisitReview.fromResponse(data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  /// RM-M07bis-01 — publishes the client's report, once, for a visit both
  /// parties confirmed being at.
  ///
  /// Only [rating] is required; everything else is optional (M07bis's content
  /// table), and an empty list is sent as an empty list rather than left out,
  /// so "I had nothing good to say" and "I did not fill this in" are the same
  /// thing to the server — which they are.
  ///
  /// Refusals belong to the caller: `409` for a second report on the same
  /// visit, `403`/`409` for a visit nobody confirmed (CE-M07bis-01).
  Future<VisitReview> submit(
    String visiteId, {
    required int rating,
    int? perceivedCondition,
    String? comment,
    List<String> pros = const [],
    List<String> cons = const [],
    List<String> photoKeys = const [],
  }) async {
    final response = await _api.submitVisiteReview(
      visiteId: visiteId,
      submitReviewRequest: SubmitReviewRequest(
        (b) => b
          ..rating = rating
          ..perceivedCondition = perceivedCondition
          ..comment = (comment?.trim().isEmpty ?? true) ? null : comment!.trim()
          ..pros = ListBuilder<String>(pros)
          ..cons = ListBuilder<String>(cons)
          ..photoKeys = ListBuilder<String>(photoKeys),
      ),
    );
    final data = response.data;
    if (data == null) throw StateError('submit returned no review');
    return VisitReview.fromResponse(data);
  }

  /// RM-M07bis-04 — answers beside the client's words, never into them.
  Future<VisitReview> comment(String visiteId, String body) async {
    final response = await _api.commentVisiteReview(
      visiteId: visiteId,
      reviewCommentRequest: ReviewCommentRequest((b) => b..body = body),
    );
    final data = response.data;
    if (data == null) throw StateError('comment returned no review');
    return VisitReview.fromResponse(data);
  }

  /// RM-M07bis-06 — the review as a printable PDF, with no contractual value.
  ///
  /// **Not through the generated client**: `exportVisiteReviewPdf` types the
  /// body as `String` and leaves dio's default JSON response type in place, so
  /// an `application/pdf` payload comes back decoded as text and corrupted.
  /// The raw dio carries the same interceptors — the token still goes with it.
  Future<Uint8List> pdf(String visiteId) async {
    final response = await _dioClient.dio.get<List<int>>(
      '/api/v1/visites/$visiteId/review/pdf',
      options: Options(responseType: ResponseType.bytes),
    );
    final bytes = response.data;
    if (bytes == null || bytes.isEmpty) {
      throw StateError('empty PDF for visit $visiteId');
    }
    return Uint8List.fromList(bytes);
  }
}
