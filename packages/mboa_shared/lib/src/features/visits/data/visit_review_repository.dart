import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

import '../models/visit_review.dart';

/// The client's report on a visit, read by the people who carried it out
/// (CDC M07bis).
///
/// Shared: an agent reads it from his visit detail, a prestataire from his own
/// agenda, and the client's app will read the same shape back when it writes
/// one. **Nothing here writes the review itself** — the note and the text are
/// the client's, and only a comment may be added beside them (RM-M07bis-04).
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
