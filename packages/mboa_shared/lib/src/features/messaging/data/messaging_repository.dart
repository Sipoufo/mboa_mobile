import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

import '../models/conversation.dart';

/// In-app messaging between a tenant and a prestataire (CDC M12).
///
/// Shared: both apps call the same endpoints and only the entry points differ.
/// RM-M12-01 gives the tenant the first word — `POST /conversations` is refused
/// to a prestataire — so the pro app has no "new message" affordance at all
/// rather than a button that 403s.
///
/// **No phone number passes through here.** RM-M12-03 masks it server-side and
/// CA-M12-02 keeps it out of the interface; there is no field to display and no
/// call to place.
class MessagingRepository {
  MessagingRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  static const int _pageSize = 30;
  static const String _queueKey = 'queue';

  MessagerieApi get _api => _dioClient.api.getMessagerieApi();

  Future<List<Conversation>> conversations() async {
    final response = await _api.listMyConversations(
      pageable: Pageable((b) => b
        ..page = 0
        ..size = _pageSize),
    );
    return (response.data?.content ?? const <ConversationResponse>[])
        .map(Conversation.fromResponse)
        .toList();
  }

  /// Newest first, as the endpoint returns them; the thread reverses for
  /// display so the latest sits at the bottom where a reader expects it.
  Future<List<Message>> messages(String conversationId, {int page = 0}) async {
    final response = await _api.listConversationMessages(
      id: conversationId,
      pageable: Pageable((b) => b
        ..page = page
        ..size = _pageSize),
    );
    return (response.data?.content ?? const <MessageResponse>[])
        .map(Message.fromResponse)
        .toList();
  }

  Future<Message> send(
    String conversationId, {
    required String body,
    List<String> attachmentKeys = const [],
  }) async {
    final response = await _api.sendMessage(
      id: conversationId,
      sendMessageRequest: SendMessageRequest((b) => b
        ..body = body
        ..attachmentKeys = ListBuilder<String>(attachmentKeys)),
    );
    final data = response.data;
    if (data == null) throw StateError('send returned no message');
    return Message.fromResponse(data);
  }

  /// RM-M12-01 / RM-M12-02 — the tenant's first word, on a given listing.
  ///
  /// A double tap on "Contacter" answers 409: the thread already exists and
  /// the second call is not a failure, so the conversation list is re-read and
  /// the existing one returned.
  Future<Conversation> start(
    String annonceId, {
    required String body,
    List<String> attachmentKeys = const [],
  }) async {
    try {
      final response = await _api.startConversation(
        startConversationRequest: StartConversationRequest((b) => b
          ..annonceId = annonceId
          ..body = body
          ..attachmentKeys = ListBuilder<String>(attachmentKeys)),
      );
      final data = response.data;
      if (data == null) throw StateError('start returned no conversation');
      return Conversation.fromResponse(data);
    } on DioException catch (e) {
      if (e.response?.statusCode != 409) rethrow;

      final existing = (await conversations())
          .where((c) => c.annonceId == annonceId)
          .firstOrNull;
      if (existing == null) rethrow;
      return existing;
    }
  }

  /// RM-M12-05 — what clears the badge on the other side.
  Future<void> markRead(String conversationId) =>
      _api.markConversationRead(id: conversationId);

  // --- CE-M12-01: the offline queue ---------------------------------------

  /// Messages written without a connection, waiting to go.
  ///
  /// Kept per conversation so a thread can draw its own pending bubbles
  /// without loading everyone else's.
  List<QueuedMessage> queued(String conversationId) {
    final raw = _cache.get(StorageKeys.pendingMessagesBox, _queueKey);
    final items = (raw?['items'] as List?)?.whereType<Map<dynamic, dynamic>>() ??
        const <Map<dynamic, dynamic>>[];
    return [
      for (final item in items)
        if (item['conversationId'] == conversationId)
          QueuedMessage(
            localId: item['localId'] as String? ?? '',
            conversationId: conversationId,
            body: item['body'] as String? ?? '',
            attachmentKeys:
                (item['attachments'] as List?)?.whereType<String>().toList() ??
                    const [],
            queuedAt:
                DateTime.tryParse(item['queuedAt'] as String? ?? '') ??
                    DateTime.now(),
          ),
    ];
  }

  Future<void> enqueue(QueuedMessage message) async {
    final all = _allQueued()..add(message);
    await _writeQueue(all);
  }

  Future<void> dequeue(String localId) async {
    final all = _allQueued()..removeWhere((m) => m.localId == localId);
    await _writeQueue(all);
  }

  /// Tries the whole queue, oldest first, and keeps whatever still fails.
  ///
  /// Order matters: two messages typed in a tunnel must arrive in the order
  /// they were written, so this is sequential rather than a `Future.wait`.
  Future<List<Message>> flushQueue() async {
    final sent = <Message>[];
    for (final queued in _allQueued()..sort((a, b) => a.queuedAt.compareTo(b.queuedAt))) {
      try {
        sent.add(
          await send(
            queued.conversationId,
            body: queued.body,
            attachmentKeys: queued.attachmentKeys,
          ),
        );
        await dequeue(queued.localId);
      } catch (_) {
        // Still no line, or the thread is read-only now: it waits.
        break;
      }
    }
    return sent;
  }

  List<QueuedMessage> _allQueued() {
    final raw = _cache.get(StorageKeys.pendingMessagesBox, _queueKey);
    final items = (raw?['items'] as List?)?.whereType<Map<dynamic, dynamic>>() ??
        const <Map<dynamic, dynamic>>[];
    return [
      for (final item in items)
        QueuedMessage(
          localId: item['localId'] as String? ?? '',
          conversationId: item['conversationId'] as String? ?? '',
          body: item['body'] as String? ?? '',
          attachmentKeys:
              (item['attachments'] as List?)?.whereType<String>().toList() ??
                  const [],
          queuedAt: DateTime.tryParse(item['queuedAt'] as String? ?? '') ??
              DateTime.now(),
        ),
    ];
  }

  Future<void> _writeQueue(List<QueuedMessage> messages) => _cache.put(
        StorageKeys.pendingMessagesBox,
        _queueKey,
        {
          'items': [
            for (final m in messages)
              {
                'localId': m.localId,
                'conversationId': m.conversationId,
                'body': m.body,
                'attachments': m.attachmentKeys,
                'queuedAt': m.queuedAt.toIso8601String(),
              },
          ],
        },
      );
}

/// A message the app is holding until there is a line (CE-M12-01).
class QueuedMessage {
  const QueuedMessage({
    required this.localId,
    required this.conversationId,
    required this.body,
    required this.queuedAt,
    this.attachmentKeys = const [],
  });

  final String localId;
  final String conversationId;
  final String body;
  final List<String> attachmentKeys;
  final DateTime queuedAt;

  Message get asMessage => Message.pending(
        id: localId,
        body: body,
        attachmentKeys: attachmentKeys,
        sentAt: queuedAt,
      );
}
