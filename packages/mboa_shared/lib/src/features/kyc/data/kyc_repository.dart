import 'package:mboa_core/mboa_core.dart';

import '../models/document_identity.dart';
import '../models/kyc_status.dart';

/// Network layer for KYC (CDC M01bis): the status, the submission, and the
/// NUI added afterwards. Both apps — a prestataire, an agent, and since §39 C a
/// tenant, with the same routes.
class KycRepository {
  KycRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  KYCApi get _api => _dioClient.api.getKYCApi();

  Future<KycStatusData> loadStatus() async {
    final response = await _api.getMyKycStatus();
    return _map(response.data);
  }

  /// Submits the uploaded keys, what the document says (§39 B), and — a
  /// prestataire's — the NUI and the address (§37 B); returns the new status.
  /// A passport goes without a back.
  Future<KycStatusData> submit({
    required String selfieKey,
    required String idFrontKey,
    String? idBackKey,
    required DocumentIdentity identity,
    String? nui,
    DeclaredAddress? address,
  }) async {
    final document = identity.wire;
    final response = await _api.submitKyc(
      submitKycRequest: SubmitKycRequest((b) {
        b
          ..selfieKey = selfieKey
          ..idDocumentFrontKey = idFrontKey
          ..idDocumentBackKey = idBackKey
          ..idDocumentType = SubmitKycRequestIdDocumentTypeEnum.valueOf(document.type)
          ..idNumber = document.number
          ..issuedOn = document.issuedOn
          ..expiresOn = document.expiresOn
          ..issuedAt = document.issuedAt
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
        identity: switch (data) {
          final data? when data.idDocumentType != null => DocumentIdentity(
              type: KycDocType.fromWire(data.idDocumentType!.name),
              number: data.idNumber ?? '',
              issuedOn: data.issuedOn?.toDateTime(),
              expiresOn: data.expiresOn?.toDateTime(),
              issuedAt: data.issuedAt ?? '',
            ),
          _ => null,
        },
      );
}
