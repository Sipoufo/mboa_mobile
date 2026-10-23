import 'package:equatable/equatable.dart';

/// A push payload, normalised into something the app can route on.
///
/// **The `{type, entityId}` contract is not yet agreed with the backend**
/// (see `docs/notifications-setup.md`). Parsing is therefore deliberately
/// lenient: unknown types resolve to [PushType.unknown] and route to the
/// notifications list rather than being dropped, so a payload change can't make
/// notifications silently stop working.
class PushMessage extends Equatable {
  const PushMessage({
    required this.type,
    this.entityId,
    this.title,
    this.body,
    this.raw = const {},
  });

  final PushType type;
  final String? entityId;
  final String? title;
  final String? body;

  /// The untouched data map, so a handler can read a field the domain model
  /// doesn't model yet.
  final Map<String, String> raw;

  static PushMessage fromData(
    Map<String, dynamic> data, {
    String? title,
    String? body,
  }) {
    final raw = <String, String>{
      for (final entry in data.entries)
        if (entry.value != null) entry.key: '${entry.value}',
    };

    return PushMessage(
      type: PushType.parse(raw['type']),
      // Tolerate the obvious spellings rather than betting on one.
      entityId: raw['entityId'] ?? raw['entity_id'] ?? raw['id'],
      title: title,
      body: body,
      raw: raw,
    );
  }

  @override
  List<Object?> get props => [type, entityId, title, body, raw];
}

/// What a notification is about — the backend's `PushTarget`.
///
/// Matched **exactly** against the published values. The first version of
/// this matched substrings ("contains VISIT") because the contract did not
/// exist yet; it does now, is append-only, and treats a renamed constant as a
/// breaking change. Substring matching would quietly mis-route the next value
/// that happens to contain an old one.
///
/// A value this build does not know is [unknown], and lands on the shell —
/// the backend asked for exactly that fallback when it added `RESIDENCE`.
enum PushType {
  /// A subscription payment settled, confirmed or failed (M13).
  paymentConfirmed,

  /// `entityId` = the conversation (M12).
  message,

  /// `entityId` = the listing — expiry (N-10), moderation, and the answer to
  /// a resident review (N-21), whose reviews live on the fiche.
  annonce,

  /// `entityId` = the visit (M07 / M16). Not proof of confirmation: the
  /// screen it opens reads the status.
  visit,

  kyc,

  /// `entityId` = the contract (M08).
  contract,

  /// `entityId` = the residence — an agent's residence-level offer (M11).
  residence,

  /// `entityId` = the saved search (M04, N-01).
  savedSearch,

  /// `entityId` = the reservation request (M29: N-32, N-33, N-34).
  reservation,

  /// M30 — `entityId` = the declaration for the landlord (N-35), the
  /// contract (the space) for the tenant (N-36, N-37). Absent on a merged
  /// push: the list opens.
  home,

  /// Slice E — `entityId` = the invoice: N-36 for an invoice declared paid,
  /// confirmed or contested (the tenant's).
  invoice,

  /// §31.3 — N-39, photo proofs added: `entityId` = the contract (the
  /// landlord's).
  homeEvidence,

  /// M30 lot 3 — N-38, a request to the landlord created, moved on or
  /// answered: `entityId` = the request, for either party.
  homeRequest,

  /// M24–M26 — N-26, about the « Gestion financière » add-on (its period).
  financeAddon,

  unknown;

  static PushType parse(String? raw) =>
      switch ((raw ?? '').toUpperCase().trim()) {
        'PAYMENT_CONFIRMED' => PushType.paymentConfirmed,
        'MESSAGE' => PushType.message,
        'ANNONCE' => PushType.annonce,
        'VISIT' => PushType.visit,
        'KYC' => PushType.kyc,
        'CONTRACT' => PushType.contract,
        'RESIDENCE' => PushType.residence,
        'SAVED_SEARCH' => PushType.savedSearch,
        'HOME' => PushType.home,
        'RESERVATION' => PushType.reservation,
        'INVOICE' => PushType.invoice,
        'HOME_EVIDENCE' => PushType.homeEvidence,
        'HOME_REQUEST' => PushType.homeRequest,
        'FINANCE_ADDON' => PushType.financeAddon,
        _ => PushType.unknown,
      };
}
