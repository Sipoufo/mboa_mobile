import 'package:api_client/api_client.dart' as api;
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockConversationsBloc
    extends MockBloc<ConversationsEvent, ConversationsState>
    implements ConversationsBloc {}

class MockThreadBloc extends MockBloc<ThreadEvent, ThreadState>
    implements ThreadBloc {}

class MockMediaUploader extends Mock implements MediaUploader {}

/// The two messaging screens, shared by both apps (CDC M12).
///
/// **CA-M12-02 is the assertion that matters**: no phone number, and nothing
/// to call with. The module exists so a first contact does not cost anyone
/// their number, and a stray "Appeler" would undo it in one tap.
void main() {
  late MockConversationsBloc conversations;
  late MockThreadBloc thread;
  late MockMediaUploader uploader;

  Conversation conversation({bool readOnly = false, int unread = 0}) =>
      Conversation(
        id: 'c-1',
        annonceId: 'a-1',
        annonceTitle: 'Studio Bonapriso',
        peerName: 'Awa Nkeng',
        lastMessage: 'Le bien est-il toujours libre ?',
        lastMessageAt: DateTime(2026, 9, 30, 9, 15),
        unreadCount: unread,
        readOnly: readOnly,
      );

  setUp(() {
    conversations = MockConversationsBloc();
    thread = MockThreadBloc();
    uploader = MockMediaUploader();
    when(() => conversations.state)
        .thenReturn(ConversationsReady(items: [conversation(unread: 2)]));
    when(() => thread.state).thenReturn(
      ThreadReady(
        conversation: conversation(),
        messages: [
          Message(
            id: 'm-1',
            body: 'Le bien est-il toujours libre ?',
            sentAt: DateTime(2026, 9, 30, 9, 15),
          ),
          Message(
            id: 'm-2',
            isMine: true,
            body: 'Oui, il est disponible.',
            sentAt: DateTime(2026, 9, 30, 9, 20),
            readAt: DateTime(2026, 9, 30, 9, 21),
          ),
        ],
      ),
    );
  });

  Future<void> pump(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ConversationsBloc>.value(value: conversations),
            BlocProvider<ThreadBloc>.value(value: thread),
          ],
          child: Scaffold(body: child),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('RM-M12-02 — a thread is named by its listing', (tester) async {
    await pump(tester, ConversationsView(onOpen: (_) {}));

    // Two threads with the same person about two properties are two
    // conversations, and the subtitle is what tells them apart.
    expect(find.text('Studio Bonapriso'), findsOneWidget);
    expect(find.text('Awa Nkeng'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('RM-M12-01 — the empty state says who speaks first',
      (tester) async {
    when(() => conversations.state).thenReturn(const ConversationsReady());
    await pump(
      tester,
      ConversationsView(
        onOpen: (_) {},
        emptyBody: 'Les locataires t\'écriront depuis tes annonces.',
      ),
    );

    expect(find.text('Aucune conversation'), findsOneWidget);
    expect(
      find.textContaining('Les locataires t\'écriront'),
      findsOneWidget,
    );
  });

  testWidgets('CA-M12-02 — no phone number, and nothing to call with',
      (tester) async {
    await pump(tester, ThreadView(uploader: uploader));

    // The whole point of M12: a first contact costs nobody their number.
    expect(find.textContaining('+237'), findsNothing);
    expect(find.byTooltip('Appeler'), findsNothing);
  });

  testWidgets('a read receipt shows on my own message only', (tester) async {
    await pump(tester, ThreadView(uploader: uploader));

    expect(find.text('Oui, il est disponible.'), findsOneWidget);
    expect(find.byIcon(LucideIcons.checkCheck), findsOneWidget);
  });

  testWidgets('CE-M12-01 — a queued message says it is waiting, not failed',
      (tester) async {
    when(() => thread.state).thenReturn(
      ThreadReady(
        conversation: conversation(),
        queued: [
          Message.pending(
            id: 'local-1',
            body: 'Je passe demain',
            sentAt: DateTime(2026, 9, 30, 10),
          ),
        ],
      ),
    );
    await pump(tester, ThreadView(uploader: uploader));

    // "Non envoyé" would read as lost; it is queued and will go.
    expect(find.text('En attente de réseau'), findsOneWidget);
    expect(find.text('Non envoyé'), findsNothing);
  });

  testWidgets('CE-M12-02 — an archived listing locks the composer',
      (tester) async {
    when(() => thread.state)
        .thenReturn(ThreadReady(conversation: conversation(readOnly: true)));
    await pump(tester, ThreadView(uploader: uploader));

    // The history stays readable; only writing stops, and the screen says why.
    expect(find.byType(TextField), findsNothing);
    expect(find.textContaining('n\'est plus disponible'), findsOneWidget);
  });

  testWidgets('an attached image can be taken off — with a cross, not a missing glyph', (tester) async {
    when(() => uploader.captureAndUpload(source: ImageSource.camera, category: api.CreateUploadRequestCategoryEnum.MESSAGE_ATTACHMENT))
        .thenAnswer((_) async => 'messages/1.jpg');
    await pump(tester, ThreadView(uploader: uploader));

    await tester.tap(find.byTooltip('Joindre une image'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Prendre une photo'));
    await tester.pumpAndSettle();

    // The app ships no Material icons: the default delete glyph was a box.
    final chip = tester.widget<Chip>(find.byType(Chip));
    expect((chip.deleteIcon as Icon?)?.icon, LucideIcons.x);
    await tester.tap(find.byIcon(LucideIcons.x));
    await tester.pumpAndSettle();
    expect(find.byType(Chip), findsNothing);
  });

  testWidgets('writing goes through the bloc', (tester) async {
    await pump(tester, ThreadView(uploader: uploader));

    await tester.enterText(find.byType(TextField), 'Bonjour');
    await tester.tap(find.byTooltip('Envoyer'));
    await tester.pump();

    verify(() => thread.add(const ThreadMessageSent('Bonjour'))).called(1);
  });

  testWidgets('RM-M29-14 — a request opens the thread with Mboa\'s own card, on neither side', (tester) async {
    when(() => thread.state).thenReturn(
      ThreadReady(
        conversation: conversation(),
        messages: [
          Message(
            id: 's-1',
            isSystem: true,
            systemEvent: SystemEvent.reservationRequested,
            body: 'Je peux visiter samedi ?',
            sentAt: DateTime(2026, 10, 19, 9),
            reservation: ReservationSnapshot(
              reservationId: 'r-1',
              desiredStartDate: DateTime(2026, 11),
              durationUnits: 6,
            ),
          ),
        ],
      ),
    );
    await pump(tester, ThreadView(uploader: uploader));

    expect(find.text('Demande de réservation'), findsOneWidget);
    expect(find.textContaining('À partir du 1 novembre 2026'), findsOneWidget);
    expect(find.textContaining('6 mois'), findsOneWidget);
    expect(find.text('« Je peux visiter samedi ? »'), findsOneWidget);
  });

  testWidgets('RM-M29-16 — another unit assigned: Mboa\'s sentence, as it is, never as the client\'s words', (tester) async {
    when(() => thread.state).thenReturn(
      ThreadReady(
        conversation: conversation(),
        messages: [
          Message(
            id: 's-2',
            isSystem: true,
            systemEvent: SystemEvent.unitAssigned,
            body: 'Le propriétaire t\'a attribué « Chambre 4 » (au lieu de « Chambre 2 »).',
            sentAt: DateTime(2026, 10, 22, 9),
          ),
        ],
      ),
    );
    await pump(tester, ThreadView(uploader: uploader));

    expect(find.text('Unité attribuée'), findsOneWidget);
    expect(find.text('Demande de réservation'), findsNothing);
    expect(find.text('Le propriétaire t\'a attribué « Chambre 4 » (au lieu de « Chambre 2 »).'), findsOneWidget);
  });

  test('a system message says what it announces; one with a request and no event is the request', () {
    Message read(api.MessageResponseSystemEventEnum? event, {bool withRequest = false}) => Message.fromResponse(
          api.MessageResponse(
            (b) {
              b
                ..id = 'm'
                ..kind = api.MessageResponseKindEnum.SYSTEM
                ..systemEvent = event;
              if (withRequest) b.reservation.reservationRequestId = 'r-1';
            },
          ),
        );

    expect(read(api.MessageResponseSystemEventEnum.RESERVATION_UNIT_ASSIGNED).systemEvent, SystemEvent.unitAssigned);
    expect(read(api.MessageResponseSystemEventEnum.HOME_REQUEST_UPDATED).systemEvent, SystemEvent.homeRequestUpdated);
    expect(read(null, withRequest: true).systemEvent, SystemEvent.reservationRequested);
    expect(read(null).systemEvent, SystemEvent.unknown);
  });
}
