import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for MessagerieApi
void main() {
  final instance = ApiClient().getMessagerieApi();

  group(MessagerieApi, () {
    // List a conversation's messages, newest first
    //
    //Future<PageResponseMessageResponse> listConversationMessages(String id, Pageable pageable) async
    test('test listConversationMessages', () async {
      // TODO
    });

    // List the authenticated participant's conversations
    //
    //Future<PageResponseConversationResponse> listMyConversations(Pageable pageable) async
    test('test listMyConversations', () async {
      // TODO
    });

    // Mark the conversation's incoming messages as read
    //
    //Future markConversationRead(String id) async
    test('test markConversationRead', () async {
      // TODO
    });

    // Post a message in a conversation
    //
    //Future<MessageResponse> sendMessage(String id, SendMessageRequest sendMessageRequest) async
    test('test sendMessage', () async {
      // TODO
    });

    // Contact a listing — opens (or reuses) the thread and posts the first message
    //
    //Future<ConversationResponse> startConversation(StartConversationRequest startConversationRequest) async
    test('test startConversation', () async {
      // TODO
    });

  });
}
