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

  /// Submits the three uploaded document keys — with the NUI and the address
  /// when declared (§37 B) — and returns the resulting status.
  Future<KycStatusData> submit({
    required String selfieKey,
    required String idFrontKey,
    required String idBackKey,
    String? nui,
    DeclaredAddress? address,
  }) async {
    final response = await _api.submitKyc(
      submitKycRequest: SubmitKycRequest((b) {
        b
          ..selfieKey = selfieKey
          ..idDocumentFrontKey = idFrontKey
          ..idDocumentBackKey = idBackKey
          ..nui = nui;
        if (address != null) {
          b.address
            ..districtId = address.districtId
            ..details = (address.details?.trim().isEmpty ?? true) ? null : address.details!.trim();
        }
      }),
    );
    return _map(response.data);
  }

  /// RM-M01bis-10 — a NUI added to an approved KYC, without a new review.
  Future<KycStatusData> addNui(String nui) async {
    final response = await _api.addMyNui(addNuiRequest: AddNuiRequest((b) => b..nui = nui));
    return _map(response.data);
  }

  KycStatusData _map(KycStatusResponse? data) => KycStatusData(
        status: KycStatusX.parse(data?.status),
        submittedAt: data?.submittedAt,
        reviewedAt: data?.reviewedAt,
        rejectionReason: data?.rejectionReason,
        nui: data?.nui,
        address: switch (data?.address) {
          final address? when address.districtId != null => DeclaredAddress(
              districtId: address.districtId!,
              city: address.city,
              district: address.district,
              details: address.details,
            ),
          _ => null,
        },
      );
}
