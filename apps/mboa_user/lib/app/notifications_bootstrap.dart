import 'package:flutter/widgets.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import 'router/app_router.dart';
import 'router/app_router.gr.dart';

/// Starts push intake for an authenticated session and routes taps (CDC M03).
///
/// Mirrors the Pro app; only the routing table differs, because App Mboa has
/// different destinations.
Future<void> startNotifications({
  required AppRouter router,
  required BuildContext Function() context,
}) {
  return getIt<NotificationsRepository>().start(
    onForeground: (message) => _showInApp(context(), message),
    onOpened: (message) => _route(router, message),
  );
}

/// Foreground messages aren't drawn by the OS, so surface them in-app.
void _showInApp(BuildContext context, PushMessage message) {
  final title = message.title;
  if (title == null || title.isEmpty) return;

  MboaToast.info(context: context, title: title, description: message.body);
}

/// CA-M03-02: a tap opens the screen the notification is about.
///
/// The public app's modules (search, favourites, messaging, visits) aren't
/// built, so everything lands on the shell for now. The payload contract is
/// still unagreed — see `docs/notifications-setup.md`.
void _route(AppRouter router, PushMessage message) {
  router.navigate(const AuthenticatedRouter());
}
