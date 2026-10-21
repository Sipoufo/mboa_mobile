import 'package:flutter/widgets.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../features/rents/bloc/waiting_declarations_bloc.dart';
import '../features/reservations/bloc/pending_reservations_bloc.dart';
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
    onOpened: (message) => routeNotificationTap(router, message),
  );
}

/// Foreground messages aren't drawn by the OS, so surface them in-app.
void _showInApp(BuildContext context, PushMessage message) {
  // N-32 — a new request: the home's counter is read again, by event.
  if (message.type == PushType.reservation && getIt.isRegistered<PendingReservationsBloc>()) {
    getIt<PendingReservationsBloc>().add(const PendingReservationsRequested());
  }
  // N-35 — a payment declared: the home's counter likewise.
  if (message.type == PushType.home && getIt.isRegistered<WaitingDeclarationsBloc>()) {
    getIt<WaitingDeclarationsBloc>().add(const WaitingDeclarationsRequested());
  }

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
@visibleForTesting
void routeNotificationTap(AppRouter router, PushMessage message) {
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
      // Not the sheet, though the owner has one now (§14): he is also told
      // about the visits an agent makes on his property (N-03, N-05), whose
      // sheet is the agent's and answers 404 to him — and the payload does
      // not say which kind this is. The agenda, where requests are answered
      // and every row opens its own sheet, holds both.
      router.navigate(
        const ProShellRoute(children: [PrestataireVisitsRoute()]),
      );
    case PushType.residence:
      router.navigate(const AgentShellRoute(children: [AgentMissionsRoute()]));
    // N-32 to N-34 — a new request, its 24 h reminder, a client's
    // cancellation, a reservation running out.
    case PushType.reservation when id != null && !isAgent:
      router.push(IncomingReservationRoute(id: id));
    case PushType.reservation when !isAgent:
      router.push(IncomingReservationsRoute());
    // N-35 — a payment declared, on the declaration where it is answered;
    // several merged into one push carry no id, and open the inbox.
    case PushType.home when id != null && !isAgent:
      router.push(ReceivedDeclarationRoute(declarationId: id));
    case PushType.home when !isAgent:
      router.push(RentsRoute());
    case PushType.message:
      // No endpoint reads one conversation by id; the inbox lists it first.
      router.push(const MessagesRoute());
    case PushType.annonce:
    case PushType.contract:
    case PushType.reservation:
    case PushType.savedSearch:
    case PushType.home:
    case PushType.unknown:
      router.navigate(const AuthenticatedRouter());
  }
}
