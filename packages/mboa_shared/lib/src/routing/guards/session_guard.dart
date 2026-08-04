import 'package:auto_route/auto_route.dart';

import '../session_snapshot.dart';

/// Blocks a route subtree when there is no session.
///
/// The redirect target is supplied by the app via [onDenied] rather than being
/// hardcoded: the generated route classes (`LoginRoute`, `WelcomeRoute`…) live
/// in each app's `app_router.gr.dart`, so a shared guard cannot name them.
class SessionGuard extends AutoRouteGuard {
  SessionGuard({
    required SessionSnapshot snapshot,
    required void Function(StackRouter router) onDenied,
  })  : _snapshot = snapshot,
        _onDenied = onDenied;

  final SessionSnapshot _snapshot;
  final void Function(StackRouter router) _onDenied;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_snapshot.hasSession) {
      resolver.next();
      return;
    }

    _onDenied(router);
    resolver.next(false);
  }
}
