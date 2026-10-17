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
/// The payload is `{type, entityId}`, the backend's append-only `PushTarget`.
/// No id, or a type this build does not know, lands on the shell.
void _route(AppRouter router, PushMessage message) {
  final id = message.entityId;
  final isAgent = getIt<SessionSnapshot>().role?.isAgent ?? false;

  switch (message.type) {
    case PushType.paymentConfirmed:
      router.push(const SubscriptionRoute());
    case PushType.kyc:
      router.push(CertificationsRoute());
    case PushType.annonce when id != null:
      router.push(AnnonceDetailRoute(id: id));
    case PushType.contract when id != null:
      router.push(ContractDetailRoute(id: id));
    case PushType.visit when id != null && isAgent:
      router.push(VisitDetailRoute(id: id));
    case PushType.visit when isAgent:
      router.navigate(const AgentShellRoute(children: [AgentVisitsRoute()]));
    case PushType.visit:
      // The owner lands where a request is accepted or declined.
      router.navigate(
        const ProShellRoute(children: [PrestataireVisitsRoute()]),
      );
    case PushType.residence:
      router.navigate(const AgentShellRoute(children: [AgentMissionsRoute()]));
    case PushType.message:
      // No endpoint reads one conversation by id; the inbox lists it first.
      router.push(const MessagesRoute());
    case PushType.annonce:
    case PushType.contract:
    case PushType.savedSearch:
    case PushType.unknown:
      router.navigate(const AuthenticatedRouter());
  }
}
