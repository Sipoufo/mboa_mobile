import 'package:equatable/equatable.dart';

import 'kyc_status.dart';

/// The three R2 object keys a KYC submission needs (CDC M01bis / the API's
/// `SubmitKycRequest`).
enum KycSlot { selfie, idFront, idBack }

/// ID document type — cosmetic guidance for the capture flow (the API submits
/// only the front/back keys, not the type).
enum KycDocType { cni, recepisse, passport, residencePermit }

/// In-progress capture: the uploaded object keys collected before submission.
class KycDraft extends Equatable {
  const KycDraft({this.selfieKey, this.idFrontKey, this.idBackKey, this.docType, this.nui, this.address});

  /// What was declared last time, kept for a resubmission after a refusal.
  factory KycDraft.of(KycStatusData status) => KycDraft(nui: status.nui, address: status.address);

  final String? selfieKey;
  final String? idFrontKey;
  final String? idBackKey;
  final KycDocType? docType;

  /// RM-M01bis-10 — as typed; [normalizeNui] gives what is sent.
  final String? nui;
  final DeclaredAddress? address;

  /// The NUI as the DGI prints it may carry spaces; the server drops them and
  /// upper-cases the letters. Null when nothing was typed.
  static String? normalizeNui(String? raw) {
    final value = raw?.replaceAll(RegExp(r'\s'), '').toUpperCase();
    return (value == null || value.isEmpty) ? null : value;
  }

  /// 14 letters and digits (RM-M01bis-10).
  static bool isValidNui(String nui) => RegExp(r'^[A-Z0-9]{14}$').hasMatch(nui);

  /// Nothing typed, or a well-formed NUI.
  bool get nuiIsValid => switch (normalizeNui(nui)) {
        null => true,
        final value => isValidNui(value),
      };

  /// What may be sent: the documents, a NUI that reads as one, and a NUI at
  /// all for an agence or a promoteur ([nuiRequired]).
  bool canSubmit({required bool nuiRequired}) =>
      isComplete && nuiIsValid && (!nuiRequired || normalizeNui(nui) != null);

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
        nui: nui,
        address: address,
      );

  KycDraft withDocType(KycDocType type) => KycDraft(
        selfieKey: selfieKey,
        idFrontKey: idFrontKey,
        idBackKey: idBackKey,
        docType: type,
        nui: nui,
        address: address,
      );

  KycDraft withNui(String? nui) => KycDraft(
        selfieKey: selfieKey,
        idFrontKey: idFrontKey,
        idBackKey: idBackKey,
        docType: docType,
        nui: nui,
        address: address,
      );

  /// Null removes it: the address is optional for everyone.
  KycDraft withAddress(DeclaredAddress? address) => KycDraft(
        selfieKey: selfieKey,
        idFrontKey: idFrontKey,
        idBackKey: idBackKey,
        docType: docType,
        nui: nui,
        address: address,
      );

  @override
  List<Object?> get props => [selfieKey, idFrontKey, idBackKey, docType, nui, address];
}
