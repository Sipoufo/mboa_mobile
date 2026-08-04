import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

/// Declarative route table for App Mboa Pro. Generated into `app_router.gr.dart`
/// by `build_runner` (run `make gen-code`).
///
/// `LoginRoute` is the Pro credential login (email + password + email OTP, all
/// in one screen). Startup routing is owned by the splash feature; `AuthBloc`
/// drives runtime session changes.
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: CertificationsRoute.page),
        AutoRoute(page: IdDocumentRoute.page),
        AutoRoute(page: SettingsMenuRoute.page),
        AutoRoute(page: ChangePhoneRoute.page),
        AutoRoute(page: ChangePasswordRoute.page),
        AutoRoute(page: DeleteAccountRoute.page),
      ];
}
