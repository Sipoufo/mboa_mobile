import 'package:auto_route/auto_route.dart';

import '../session_snapshot.dart';

/// Keeps authenticated users off the guest-only routes (welcome, login,
/// register) — e.g. when a deep link or a back-gesture would otherwise drop a
/// signed-in user back onto the login screen.
///
/// [onAuthenticated] is supplied by the app for the same reason as
/// [SessionGuard.onDenied]: the generated route classes are app-local.
class GuestGuard extends AutoRouteGuard {
  GuestGuard({
    required SessionSnapshot snapshot,
    required void Function(StackRouter router) onAuthenticated,
  })  : _snapshot = snapshot,
        _onAuthenticated = onAuthenticated;

  final SessionSnapshot _snapshot;
  final void Function(StackRouter router) _onAuthenticated;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (!_snapshot.hasSession) {
      resolver.next();
      return;
    }

    _onAuthenticated(router);
    resolver.next(false);
  }
}
