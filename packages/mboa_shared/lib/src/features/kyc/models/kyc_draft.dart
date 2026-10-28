import 'package:equatable/equatable.dart';

import 'document_identity.dart';
import 'kyc_status.dart';

/// The R2 object keys a KYC submission carries (CDC M01bis / the API's
/// `SubmitKycRequest`).
enum KycSlot { selfie, idFront, idBack }

/// In-progress capture: the uploaded object keys, what is printed on the
/// document (§39 B), and — Pro only — the NUI and the address (§37 B).
class KycDraft extends Equatable {
  const KycDraft({
    this.selfieKey,
    this.idFrontKey,
    this.idBackKey,
    this.identity = const DocumentIdentity(),
    this.nui,
    this.address,
  });

  /// What was declared last time, kept for a resubmission after a refusal.
  factory KycDraft.of(KycStatusData status) => KycDraft(
        identity: status.identity ?? const DocumentIdentity(),
        nui: status.nui,
        address: status.address,
      );

  final String? selfieKey;
  final String? idFrontKey;
  final String? idBackKey;

  /// The document's type and what is printed on it.
  final DocumentIdentity identity;

  /// RM-M01bis-10 — as typed; [normalizeNui] gives what is sent.
  final String? nui;
  final DeclaredAddress? address;

  KycDocType? get docType => identity.type;

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

  String? keyFor(KycSlot slot) => switch (slot) {
        KycSlot.selfie => selfieKey,
        KycSlot.idFront => idFrontKey,
        KycSlot.idBack => idBackKey,
      };

  bool has(KycSlot slot) => keyFor(slot) != null;

  /// The document photographed — its back too, unless it is a passport.
  bool get documentPhotographed =>
      idFrontKey != null && (idBackKey != null || !(docType?.hasBack ?? true));

  /// The document's tile is done: photographed, and its details valid on
  /// [today].
  bool documentDoneOn(DateTime today) => docType != null && documentPhotographed && identity.isValidOn(today);

  /// The person with the document, and the document done — ready to submit.
  bool isCompleteOn(DateTime today) => selfieKey != null && documentDoneOn(today);

  bool get isComplete => isCompleteOn(DateTime.now());

  /// What may be sent: complete, a NUI that reads as one, and a NUI at all for
  /// an agence or a promoteur ([nuiRequired]).
  bool canSubmit({required bool nuiRequired}) =>
      isComplete && nuiIsValid && (!nuiRequired || normalizeNui(nui) != null);

  KycDraft _with({
    String? selfieKey,
    String? idFrontKey,
    String? idBackKey,
    bool clearBack = false,
    DocumentIdentity? identity,
    String? nui,
    bool setNui = false,
    DeclaredAddress? address,
    bool setAddress = false,
  }) =>
      KycDraft(
        selfieKey: selfieKey ?? this.selfieKey,
        idFrontKey: idFrontKey ?? this.idFrontKey,
        idBackKey: clearBack ? null : (idBackKey ?? this.idBackKey),
        identity: identity ?? this.identity,
        nui: setNui ? nui : this.nui,
        address: setAddress ? address : this.address,
      );

  KycDraft withKey(KycSlot slot, String key) => _with(
        selfieKey: slot == KycSlot.selfie ? key : null,
        idFrontKey: slot == KycSlot.idFront ? key : null,
        idBackKey: slot == KycSlot.idBack ? key : null,
      );

  /// A passport drops the back photographed for another document.
  KycDraft withDocType(KycDocType type) =>
      _with(identity: identity.copyWith(type: type), clearBack: !type.hasBack);

  KycDraft withIdentity(DocumentIdentity identity) => _with(identity: identity);

  KycDraft withNui(String? nui) => _with(nui: nui, setNui: true);

  /// Null removes it: the address is optional for everyone.
  KycDraft withAddress(DeclaredAddress? address) => _with(address: address, setAddress: true);

  @override
  List<Object?> get props => [selfieKey, idFrontKey, idBackKey, identity, nui, address];
}
