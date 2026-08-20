import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AvisRsidentApi
void main() {
  final instance = ApiClient().getAvisRsidentApi();

  group(AvisRsidentApi, () {
    // The review published for this tenancy
    //
    //Future<PropertyReview> getResidentReview(String contractId) async
    test('test getResidentReview', () async {
      // TODO
    });

    // Answer it publicly, once — you cannot change or remove it (RM-M27-03)
    //
    //Future<PropertyReview> replyToResidentReview(String contractId, ReplyRequest replyRequest) async
    test('test replyToResidentReview', () async {
      // TODO
    });

    // Review living in this property — needs a signed contract of at least a month
    //
    //Future<PropertyReview> submitResidentReview(String contractId, SubmitResidentReviewRequest submitResidentReviewRequest) async
    test('test submitResidentReview', () async {
      // TODO
    });

    // Revise it — open while the tenancy runs and 30 days after it ends (RM-M27-02)
    //
    //Future<PropertyReview> updateResidentReview(String contractId, SubmitResidentReviewRequest submitResidentReviewRequest) async
    test('test updateResidentReview', () async {
      // TODO
    });

  });
}
