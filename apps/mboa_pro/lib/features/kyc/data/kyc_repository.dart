import 'package:mboa_core/mboa_core.dart';

import '../models/kyc_status.dart';

/// Network layer for KYC (CDC M01bis). Reads the current status; the document
/// submission (media upload + `POST /kyc`) is added in the next step.
class KycRepository {
  KycRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  KYCApi get _api => _dioClient.api.getKYCApi();

  Future<KycStatusData> loadStatus() async {
    final response = await _api.getMyKycStatus();
    return _map(response.data);
  }

  /// Submits the three uploaded document keys and returns the resulting status.
  Future<KycStatusData> submit({
    required String selfieKey,
    required String idFrontKey,
    required String idBackKey,
  }) async {
    final response = await _api.submitKyc(
      submitKycRequest: SubmitKycRequest((b) => b
        ..selfieKey = selfieKey
        ..idDocumentFrontKey = idFrontKey
        ..idDocumentBackKey = idBackKey),
    );
    return _map(response.data);
  }

  KycStatusData _map(KycStatusResponse? data) => KycStatusData(
        status: KycStatusX.parse(data?.status),
        submittedAt: data?.submittedAt,
        reviewedAt: data?.reviewedAt,
        rejectionReason: data?.rejectionReason,
      );
}
