import 'package:flutter/widgets.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../features/my_home/bloc/my_homes_bloc.dart';
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
  // N-36 — a payment confirmed or contested: the next rent and the late
  // count move, so "Mon logement" is read again.
  if (message.type == PushType.home && getIt.isRegistered<MyHomesBloc>()) {
    getIt<MyHomesBloc>().add(const MyHomesRequested());
  }

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
    // N-33 / N-34 — a request's answer, or its reservation running out.
    case PushType.reservation when id != null:
      router.push(AuthenticatedRouter(children: [ReservationDetailRoute(id: id)]));
    case PushType.reservation:
      router.push(const AuthenticatedRouter(children: [MyReservationsRoute()]));
    // N-36 — a payment confirmed or contested, in its space; several merged
    // into one push carry no id, and open the list.
    case PushType.home when id != null:
      router.push(AuthenticatedRouter(children: [MyHomeRoute(contractId: id)]));
    case PushType.home:
      router.push(const AuthenticatedRouter(children: [MyHomesRoute()]));
    // N-36 for an invoice declared paid: the invoice; merged, "Mes logements".
    case PushType.invoice when id != null:
      router.push(AuthenticatedRouter(children: [InvoiceRoute(invoiceId: id)]));
    case PushType.invoice:
      router.push(const AuthenticatedRouter(children: [MyHomesRoute()]));
    case PushType.message:
      router.navigate(const UserShellRoute(children: [MessagesRoute()]));
    case PushType.annonce:
    case PushType.contract:
    case PushType.paymentConfirmed:
    case PushType.kyc:
    case PushType.residence:
    // N-39 is the landlord's.
    case PushType.homeEvidence:
    case PushType.unknown:
      router.navigate(const AuthenticatedRouter());
  }
}
