import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../listings/models/property_review.dart';

/// The tenant's review of a place they lived in (CDC M27).
///
/// Hung off the **contract**, not the listing: the contract is the
/// entitlement (RM-M27-01) and the unit of "one review each" (RM-M27-02), so
/// a tenant who rents the same flat twice writes two reviews and nothing has
/// to tell them apart (RM-M27-04).
///
/// Shared, like [VisitReviewRepository] and for the same reason: the tenant
/// writes one from App Mboa and the landlord answers it from App Mboa Pro.
/// **The note and the text are the tenant's** — [reply] adds beside them,
/// once, and can neither edit nor remove them (RM-M27-03). A right of reply is
/// not a right of veto.
///
/// Who may write one is the server's call, read off `residentReviewEligible`
/// on the contract. Nothing here re-derives it.
class ResidentReviewRepository {
  ResidentReviewRepository({required DioClient dioClient})
      : _dioClient = dioClient;

  final DioClient _dioClient;

  AvisRsidentApi get _api => _dioClient.api.getAvisRsidentApi();

  /// The review published for this tenancy, or **null when there is none**.
  ///
  /// A tenancy that has not been reviewed is the ordinary case, so a 404 is an
  /// answer rather than a failure — and it is what tells the screen to offer
  /// "écrire" instead of "modifier".
  Future<ReviewEntry?> fetch(String contractId) async {
    try {
      final response = await _api.getResidentReview(contractId: contractId);
      final data = response.data;
      return data == null ? null : ReviewEntry.fromResponse(data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  /// RM-M27-01 — publishes the tenant's review of the property.
  ///
  /// Only [rating] is required. There are no photos and no "perceived
  /// condition" here, unlike a visit report: a resident is describing a year
  /// of living somewhere, not inspecting it for an afternoon.
  ///
  /// Refusals belong to the caller: `409` for a second review on the same
  /// contract, and — until docs/backend-requests.md §24.1 is settled —
  /// `409 TENANCY_TOO_SHORT` for a let the server considers too brief.
  Future<ReviewEntry> submit(
    String contractId, {
    required int rating,
    String? comment,
    List<String> pros = const [],
    List<String> cons = const [],
  }) async =>
      _unwrap(
        await _api.submitResidentReview(
          contractId: contractId,
          submitResidentReviewRequest: _body(
            rating: rating,
            comment: comment,
            pros: pros,
            cons: cons,
          ),
        ),
        'submit',
      );

  /// RM-M27-02 — revises it, while the window is open.
  ///
  /// Open for the whole tenancy and 30 days after it ends, and **each edit
  /// restarts those 30 days**. Past that the server answers
  /// `409 REVIEW_LOCKED`, which the screen turns into read-only rather than an
  /// error: the review is still theirs, it is simply finished.
  ///
  /// The asymmetry with a visit report, which locks on publication
  /// (RM-M07bis-03), is deliberate — a report describes one afternoon, a
  /// resident's review describes something that goes on changing.
  Future<ReviewEntry> revise(
    String contractId, {
    required int rating,
    String? comment,
    List<String> pros = const [],
    List<String> cons = const [],
  }) async =>
      _unwrap(
        await _api.updateResidentReview(
          contractId: contractId,
          submitResidentReviewRequest: _body(
            rating: rating,
            comment: comment,
            pros: pros,
            cons: cons,
          ),
        ),
        'revise',
      );

  /// RM-M27-03 — the landlord's public answer, **once**.
  ///
  /// A second one is refused by the server. The reply changes nothing about
  /// the review: not the rating, not the words.
  Future<ReviewEntry> reply(String contractId, String body) async => _unwrap(
        await _api.replyToResidentReview(
          contractId: contractId,
          replyRequest: ReplyRequest((b) => b..body = body.trim()),
        ),
        'reply',
      );

  /// An empty comment is sent as null and empty lists as empty lists, so
  /// "I had nothing to add" and "I did not fill this in" reach the server as
  /// the same thing — which they are.
  SubmitResidentReviewRequest _body({
    required int rating,
    String? comment,
    required List<String> pros,
    required List<String> cons,
  }) =>
      SubmitResidentReviewRequest(
        (b) => b
          ..rating = rating
          ..comment = (comment?.trim().isEmpty ?? true) ? null : comment!.trim()
          ..pros = ListBuilder<String>(pros)
          ..cons = ListBuilder<String>(cons),
      );

  ReviewEntry _unwrap(Response<PropertyReview> response, String action) {
    final data = response.data;
    if (data == null) throw StateError('$action returned no review');
    return ReviewEntry.fromResponse(data);
  }
}
