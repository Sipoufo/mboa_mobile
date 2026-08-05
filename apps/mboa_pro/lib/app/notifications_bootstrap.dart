import 'package:flutter/widgets.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import 'router/app_router.dart';
import 'router/app_router.gr.dart';

/// Starts push intake for an authenticated session and routes taps (CDC M03).
///
/// Called from the root auth listener rather than a widget, because it must run
/// exactly once per session — not per rebuild.
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

  MboaToast.info(
    context: context,
    title: title,
    description: message.body,
  );
}

/// CA-M03-02: a tap opens the screen the notification is about, not just home.
///
/// The `{type, entityId}` payload contract is still unagreed with the backend
/// (see `docs/notifications-setup.md`), so unmapped types fall through to the
/// home rather than being dropped.
void _route(AppRouter router, PushMessage message) {
  switch (message.type) {
    case PushType.paymentConfirmed:
      // Closes the loop on M13's SubscribePendingHandoff.
      router.push(const SubscriptionRoute());
    case PushType.kyc:
      router.push(CertificationsRoute());
    case PushType.annonce:
    case PushType.message:
    case PushType.visit:
    case PushType.unknown:
      // Modules not built yet (M10/M12/M16) — land on the shell.
      router.navigate(const AuthenticatedRouter());
  }
}
