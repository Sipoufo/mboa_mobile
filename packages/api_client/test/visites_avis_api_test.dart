import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for VisitesAvisApi
void main() {
  final instance = ApiClient().getVisitesAvisApi();

  group(VisitesAvisApi, () {
    // Answer a review; it adds beside the client's words, never into them (RM-M07bis-04)
    //
    //Future<ReviewResponse> commentVisiteReview(String visiteId, ReviewCommentRequest reviewCommentRequest) async
    test('test commentVisiteReview', () async {
      // TODO
    });

    // The review as a printable PDF; no contractual value (RM-M07bis-06)
    //
    //Future<String> exportVisiteReviewPdf(String visiteId) async
    test('test exportVisiteReviewPdf', () async {
      // TODO
    });

    // The review published for this visit
    //
    //Future<ReviewResponse> getVisiteReview(String visiteId) async
    test('test getVisiteReview', () async {
      // TODO
    });

    // Publish your review of the property; needs a visit you both confirmed (RM-M07bis-01)
    //
    //Future<ReviewResponse> submitVisiteReview(String visiteId, SubmitReviewRequest submitReviewRequest) async
    test('test submitVisiteReview', () async {
      // TODO
    });

  });
}
