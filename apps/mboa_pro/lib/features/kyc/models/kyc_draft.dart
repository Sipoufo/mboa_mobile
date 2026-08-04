import 'package:equatable/equatable.dart';

/// The three R2 object keys a KYC submission needs (CDC M01bis / the API's
/// `SubmitKycRequest`).
enum KycSlot { selfie, idFront, idBack }

/// ID document type — cosmetic guidance for the capture flow (the API submits
/// only the front/back keys, not the type).
enum KycDocType { cni, recepisse, passport, residencePermit }

/// In-progress capture: the uploaded object keys collected before submission.
class KycDraft extends Equatable {
  const KycDraft({this.selfieKey, this.idFrontKey, this.idBackKey, this.docType});

  final String? selfieKey;
  final String? idFrontKey;
  final String? idBackKey;
  final KycDocType? docType;

  String? keyFor(KycSlot slot) => switch (slot) {
        KycSlot.selfie => selfieKey,
        KycSlot.idFront => idFrontKey,
        KycSlot.idBack => idBackKey,
      };

  bool has(KycSlot slot) => keyFor(slot) != null;

  /// All three documents captured — ready to submit.
  bool get isComplete => selfieKey != null && idFrontKey != null && idBackKey != null;

  KycDraft withKey(KycSlot slot, String key) => KycDraft(
        selfieKey: slot == KycSlot.selfie ? key : selfieKey,
        idFrontKey: slot == KycSlot.idFront ? key : idFrontKey,
        idBackKey: slot == KycSlot.idBack ? key : idBackKey,
        docType: docType,
      );

  KycDraft withDocType(KycDocType type) => KycDraft(
        selfieKey: selfieKey,
        idFrontKey: idFrontKey,
        idBackKey: idBackKey,
        docType: type,
      );

  @override
  List<Object?> get props => [selfieKey, idFrontKey, idBackKey, docType];
}
