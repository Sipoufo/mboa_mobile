import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

/// Declarative route table for App Mboa. Routes are generated into
/// `app_router.gr.dart` by `build_runner` (run `make gen-code`).
///
/// The login screens (`LoginRoute`, `OtpRoute`) come from the shared
/// `mboa_shared` package; auto_route resolves them across the package boundary.
///
/// Session-based redirection is driven by the root `AuthBloc` listener in
/// `MboaUserApp`, which replaces the stack on authenticate/logout — so the
/// route table itself stays declarative and guard-free.
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: OtpRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
