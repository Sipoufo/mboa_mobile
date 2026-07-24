import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

/// Declarative route table for App Mboa Pro. Generated into `app_router.gr.dart`
/// by `build_runner` (run `make gen-code`).
///
/// The login screens (`LoginRoute`, `OtpRoute`) wrap the shared `mboa_shared`
/// views. Startup routing is owned by the splash feature; `AuthBloc` drives
/// runtime session changes.
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: OtpRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
