import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../profile/models/base_profile.dart';

/// One thread, attached to one listing (CDC M12).
///
/// RM-M12-02 — a conversation belongs to an **annonce**, not to a person: the
/// same two accounts talking about two properties are two threads, and the
/// title is what tells them apart.
class Conversation extends Equatable {
  const Conversation({
    required this.id,
    this.annonceId,
    this.annonceTitle,
    this.peerAccountId,
    this.peerName,
    this.peerPhotoKey,
    this.lastMessage,
    this.lastMessageAt,
    this.unreadCount = 0,
    this.readOnly = false,
  });

  final String id;
  final String? annonceId;
  final String? annonceTitle;

  /// The other party. **Never their phone number** — RM-M12-03 masks it
  /// server-side and CA-M12-02 keeps it off this screen entirely, so there is
  /// no field here to leak one.
  final String? peerAccountId;
  final String? peerName;
  final String? peerPhotoKey;

  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;

  /// CE-M12-02 — the listing was archived while the thread was live: it stays
  /// readable and the composer goes away.
  final bool readOnly;

  String? get peerPhotoUrl => BaseProfile.mediaUrl(peerPhotoKey);

  bool get hasUnread => unreadCount > 0;

  static Conversation fromResponse(ConversationResponse response) =>
      Conversation(
        id: response.id ?? '',
        annonceId: response.annonceId,
        annonceTitle: response.annonceTitle,
        peerAccountId: response.peerAccountId,
        peerName: response.peerName,
        peerPhotoKey: response.peerPhotoKey,
        lastMessage: response.lastMessage,
        lastMessageAt: response.lastMessageAt?.toLocal(),
        unreadCount: response.unreadCount ?? 0,
        readOnly: response.readOnly ?? false,
      );

  @override
  List<Object?> get props => [
        id,
        annonceId,
        annonceTitle,
        peerAccountId,
        peerName,
        peerPhotoKey,
        lastMessage,
        lastMessageAt,
        unreadCount,
        readOnly,
      ];
}

/// Where a message is in its life.
///
/// [pending] and [failed] exist only on this side of the wire: CE-M12-01 has a
/// message written offline queued locally and sent on reconnection, so the
/// thread must be able to draw one that the server has never seen.
enum MessageStatus { sent, pending, failed }

/// One message in a thread (CDC M12).
class Message extends Equatable {
  const Message({
    required this.id,
    this.senderAccountId,
    this.isMine = false,
    this.body,
    this.attachmentKeys = const [],
    this.sentAt,
    this.readAt,
    this.status = MessageStatus.sent,
  });

  /// A local id for a queued message, so the thread can replace it with the
  /// server's copy once it lands.
  const Message.pending({
    required this.id,
    required this.body,
    this.attachmentKeys = const [],
    this.sentAt,
    this.status = MessageStatus.pending,
  })  : senderAccountId = null,
        isMine = true,
        readAt = null;

  final String id;
  final String? senderAccountId;

  /// The server's own answer to "is this mine" — the app never compares
  /// account ids to decide which side of the thread a bubble sits on.
  final bool isMine;

  final String? body;
  final List<String> attachmentKeys;
  final DateTime? sentAt;
  final DateTime? readAt;
  final MessageStatus status;

  List<String> get attachmentUrls =>
      attachmentKeys.map(BaseProfile.mediaUrl).nonNulls.toList();

  bool get isRead => readAt != null;

  static Message fromResponse(MessageResponse response) => Message(
        id: response.id ?? '',
        senderAccountId: response.senderAccountId,
        isMine: response.mine ?? false,
        body: response.body,
        attachmentKeys: response.attachmentKeys?.toList() ?? const [],
        sentAt: response.sentAt?.toLocal(),
        readAt: response.readAt?.toLocal(),
      );

  Message copyWith({MessageStatus? status}) => Message(
        id: id,
        senderAccountId: senderAccountId,
        isMine: isMine,
        body: body,
        attachmentKeys: attachmentKeys,
        sentAt: sentAt,
        readAt: readAt,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        id,
        senderAccountId,
        isMine,
        body,
        attachmentKeys,
        sentAt,
        readAt,
        status,
      ];
}
