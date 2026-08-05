import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for MessagerieApi
void main() {
  final instance = ApiClient().getMessagerieApi();

  group(MessagerieApi, () {
    // List a conversation's messages, newest first
    //
    //Future<PageResponseMessageResponse> listMessages(String id, Pageable pageable) async
    test('test listMessages', () async {
      // TODO
    });

    // List the authenticated participant's conversations
    //
    //Future<PageResponseConversationResponse> listMine1(Pageable pageable) async
    test('test listMine1', () async {
      // TODO
    });

    // Mark the conversation's incoming messages as read
    //
    //Future markRead(String id) async
    test('test markRead', () async {
      // TODO
    });

    // Post a message in a conversation
    //
    //Future<MessageResponse> send(String id, SendMessageRequest sendMessageRequest) async
    test('test send', () async {
      // TODO
    });

    // Contact a listing — opens (or reuses) the thread and posts the first message
    //
    //Future<ConversationResponse> start(StartConversationRequest startConversationRequest) async
    test('test start', () async {
      // TODO
    });

  });
}
