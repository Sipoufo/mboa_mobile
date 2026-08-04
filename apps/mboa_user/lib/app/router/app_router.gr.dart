// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:mboa_shared/mboa_shared.dart' as _i14;
import 'package:mboa_user/app/router/wrappers/authenticated_wrapper.dart'
    as _i1;
import 'package:mboa_user/features/auth/ui/login_page.dart' as _i6;
import 'package:mboa_user/features/auth/ui/otp_page.dart' as _i7;
import 'package:mboa_user/features/home/ui/home_page.dart' as _i5;
import 'package:mboa_user/features/profile/ui/change_phone_page.dart' as _i2;
import 'package:mboa_user/features/profile/ui/delete_account_page.dart' as _i3;
import 'package:mboa_user/features/profile/ui/edit_profile_page.dart' as _i4;
import 'package:mboa_user/features/profile/ui/settings_menu_page.dart' as _i8;
import 'package:mboa_user/features/profile/ui/settings_page.dart' as _i9;
import 'package:mboa_user/features/splash/ui/splash_page.dart' as _i10;
import 'package:mboa_user/features/welcome/ui/welcome_page.dart' as _i11;

/// generated route for
/// [_i1.AuthenticatedWrapper]
class AuthenticatedRouter extends _i12.PageRouteInfo<void> {
  const AuthenticatedRouter({List<_i12.PageRouteInfo>? children})
    : super(AuthenticatedRouter.name, initialChildren: children);

  static const String name = 'AuthenticatedRouter';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i12.WrappedRoute(child: const _i1.AuthenticatedWrapper());
    },
  );
}

/// generated route for
/// [_i2.ChangePhonePage]
class ChangePhoneRoute extends _i12.PageRouteInfo<void> {
  const ChangePhoneRoute({List<_i12.PageRouteInfo>? children})
    : super(ChangePhoneRoute.name, initialChildren: children);

  static const String name = 'ChangePhoneRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.ChangePhonePage();
    },
  );
}

/// generated route for
/// [_i3.DeleteAccountPage]
class DeleteAccountRoute extends _i12.PageRouteInfo<void> {
  const DeleteAccountRoute({List<_i12.PageRouteInfo>? children})
    : super(DeleteAccountRoute.name, initialChildren: children);

  static const String name = 'DeleteAccountRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.DeleteAccountPage();
    },
  );
}

/// generated route for
/// [_i4.EditProfilePage]
class EditProfileRoute extends _i12.PageRouteInfo<void> {
  const EditProfileRoute({List<_i12.PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.EditProfilePage();
    },
  );
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomePage();
    },
  );
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i12.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i13.Key? key,
    _i14.AuthMode mode = _i14.AuthMode.login,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, mode: mode),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i6.LoginPage(key: args.key, mode: args.mode);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.mode = _i14.AuthMode.login});

  final _i13.Key? key;

  final _i14.AuthMode mode;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, mode: $mode}';
  }
}

/// generated route for
/// [_i7.OtpPage]
class OtpRoute extends _i12.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    required _i14.OtpSession session,
    _i13.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         OtpRoute.name,
         args: OtpRouteArgs(session: session, key: key),
         initialChildren: children,
       );

  static const String name = 'OtpRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>();
      return _i7.OtpPage(session: args.session, key: args.key);
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({required this.session, this.key});

  final _i14.OtpSession session;

  final _i13.Key? key;

  @override
  String toString() {
    return 'OtpRouteArgs{session: $session, key: $key}';
  }
}

/// generated route for
/// [_i8.SettingsMenuPage]
class SettingsMenuRoute extends _i12.PageRouteInfo<void> {
  const SettingsMenuRoute({List<_i12.PageRouteInfo>? children})
    : super(SettingsMenuRoute.name, initialChildren: children);

  static const String name = 'SettingsMenuRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.SettingsMenuPage();
    },
  );
}

/// generated route for
/// [_i9.SettingsPage]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute({List<_i12.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.SettingsPage();
    },
  );
}

/// generated route for
/// [_i10.SplashPage]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute({List<_i12.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i12.WrappedRoute(child: const _i10.SplashPage());
    },
  );
}

/// generated route for
/// [_i11.WelcomePage]
class WelcomeRoute extends _i12.PageRouteInfo<void> {
  const WelcomeRoute({List<_i12.PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.WelcomePage();
    },
  );
}
