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
    onOpened: (message) => routeNotificationTap(router, message),
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
/// The payload is `{type, entityId}`, the backend's append-only `PushTarget`.
/// No id, or a type this build does not know, lands on the shell.
@visibleForTesting
void routeNotificationTap(AppRouter router, PushMessage message) {
  final id = message.entityId;

  switch (message.type) {
    case PushType.visit when id != null:
      router.push(AuthenticatedRouter(children: [VisitDetailRoute(visitId: id)]));
    case PushType.visit:
      router.push(const AuthenticatedRouter(children: [MyVisitsRoute()]));
    case PushType.annonce when id != null:
      router.push(ListingDetailRoute(id: id));
    case PushType.contract when id != null:
      router.push(AuthenticatedRouter(children: [MyContractDetailRoute(id: id)]));
    case PushType.savedSearch when id != null:
      // N-01 — straight to what the search found.
      router.push(AuthenticatedRouter(children: [SavedSearchResultsRoute(id: id)]));
    case PushType.savedSearch:
      router.push(const AuthenticatedRouter(children: [SavedSearchesRoute()]));
    case PushType.message:
      router.navigate(const UserShellRoute(children: [MessagesRoute()]));
    case PushType.annonce:
    case PushType.contract:
    case PushType.paymentConfirmed:
    case PushType.kyc:
    // Routed to its screen with the reservation screens (M29 lot 1).
    case PushType.reservation:
    case PushType.residence:
    case PushType.unknown:
      router.navigate(const AuthenticatedRouter());
  }
}
