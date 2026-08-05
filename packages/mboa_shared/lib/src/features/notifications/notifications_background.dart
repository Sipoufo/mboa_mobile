import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Background/terminated data-message handler.
///
/// Runs in its own isolate, so it shares **no state** with the app: no get_it,
/// no blocs, no navigator. It must be a top-level function annotated with
/// `@pragma('vm:entry-point')` or release builds tree-shake it away.
///
/// Notification-type messages are drawn by the OS without this; it exists so
/// data-only messages still initialise Firebase and can be acted on later.
@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Nothing to do yet: the OS renders the tray entry, and the tap is handled by
  // `onMessageOpenedApp` / `getInitialMessage` back in the app isolate. Local
  // work (badge counts, cache priming) would go here.
}
