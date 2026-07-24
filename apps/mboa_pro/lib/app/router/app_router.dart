import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

/// Declarative route table for App Mboa Pro. Generated into
/// `app_router.gr.dart` by `build_runner` (run `make gen-code`).
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
      ];
}
