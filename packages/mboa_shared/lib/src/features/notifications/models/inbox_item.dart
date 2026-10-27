import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import 'push_message.dart';

/// One notification as the page lists it (§38): the push, kept 30 days.
class InboxItem extends Equatable {
  const InboxItem({
    required this.id,
    this.type = PushType.unknown,
    this.title,
    this.body,
    this.entityId,
    this.createdAt,
    this.readAt,
  });

  final String id;

  /// The push's routing type: an item opens where its push opens (CA-M03-02).
  final PushType type;
  final String? title;
  final String? body;
  final String? entityId;
  final DateTime? createdAt;
  final DateTime? readAt;

  bool get isRead => readAt != null;

  /// The same message a tap on the push would hand the app's router.
  PushMessage get asPush => PushMessage(type: type, entityId: entityId, title: title, body: body);

  InboxItem readOn(DateTime at) => InboxItem(
        id: id,
        type: type,
        title: title,
        body: body,
        entityId: entityId,
        createdAt: createdAt,
        readAt: readAt ?? at,
      );

  static InboxItem fromResponse(NotificationItem response) => InboxItem(
        id: response.id ?? '',
        // The enum's names are the wire's: `MESSAGE`, `HOME`…
        type: PushType.parse(response.type?.name),
        title: response.title,
        body: response.body,
        entityId: response.entityId,
        createdAt: response.createdAt?.toLocal(),
        readAt: response.readAt?.toLocal(),
      );

  Map<String, Object?> toCache() => {
        'id': id,
        'type': type.name,
        'title': title,
        'body': body,
        'entityId': entityId,
        'createdAt': createdAt?.toIso8601String(),
        'readAt': readAt?.toIso8601String(),
      };

  static InboxItem? fromCache(Object? raw) {
    if (raw is! Map) return null;
    final id = raw['id'];
    if (id is! String) return null;
    return InboxItem(
      id: id,
      type: PushType.values.where((t) => t.name == raw['type']).firstOrNull ?? PushType.unknown,
      title: raw['title'] as String?,
      body: raw['body'] as String?,
      entityId: raw['entityId'] as String?,
      createdAt: DateTime.tryParse(raw['createdAt'] as String? ?? ''),
      readAt: DateTime.tryParse(raw['readAt'] as String? ?? ''),
    );
  }

  @override
  List<Object?> get props => [id, type, title, body, entityId, createdAt, readAt];
}
