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

/// What a notification is about. Extend as the backend contract firms up.
enum PushType {
  /// A subscription payment was confirmed (M13) — this is what closes the loop
  /// on `SubscribePendingHandoff`.
  paymentConfirmed,
  message,
  annonce,
  visit,
  kyc,
  unknown;

  static PushType parse(String? raw) {
    final value = (raw ?? '').toUpperCase().trim();
    if (value.isEmpty) return PushType.unknown;
    if (value.contains('PAYMENT') || value.contains('SUBSCRIPTION')) {
      return PushType.paymentConfirmed;
    }
    if (value.contains('MESSAGE') || value.contains('CHAT')) {
      return PushType.message;
    }
    if (value.contains('ANNONCE') || value.contains('LISTING')) {
      return PushType.annonce;
    }
    if (value.contains('VISIT')) return PushType.visit;
    if (value.contains('KYC')) return PushType.kyc;
    return PushType.unknown;
  }
}
