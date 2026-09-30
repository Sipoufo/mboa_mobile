// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;
import 'package:mboa_shared/mboa_shared.dart' as _i21;
import 'package:mboa_user/app/router/wrappers/authenticated_wrapper.dart'
    as _i2;
import 'package:mboa_user/features/auth/ui/login_page.dart' as _i9;
import 'package:mboa_user/features/auth/ui/otp_page.dart' as _i11;
import 'package:mboa_user/features/favorites/ui/favorites_page.dart' as _i6;
import 'package:mboa_user/features/home/ui/home_page.dart' as _i7;
import 'package:mboa_user/features/listing/ui/listing_detail_page.dart' as _i8;
import 'package:mboa_user/features/listing/ui/residence_detail_page.dart'
    as _i12;
import 'package:mboa_user/features/profile/ui/change_phone_page.dart' as _i3;
import 'package:mboa_user/features/profile/ui/delete_account_page.dart' as _i4;
import 'package:mboa_user/features/profile/ui/edit_profile_page.dart' as _i5;
import 'package:mboa_user/features/profile/ui/settings_menu_page.dart' as _i14;
import 'package:mboa_user/features/profile/ui/settings_page.dart' as _i15;
import 'package:mboa_user/features/search/ui/search_page.dart' as _i13;
import 'package:mboa_user/features/shell/ui/account_page.dart' as _i1;
import 'package:mboa_user/features/shell/ui/tab_soon_page.dart' as _i10;
import 'package:mboa_user/features/shell/ui/user_shell_page.dart' as _i17;
import 'package:mboa_user/features/splash/ui/splash_page.dart' as _i16;
import 'package:mboa_user/features/welcome/ui/welcome_page.dart' as _i18;

/// generated route for
/// [_i1.AccountPage]
class AccountRoute extends _i19.PageRouteInfo<void> {
  const AccountRoute({List<_i19.PageRouteInfo>? children})
    : super(AccountRoute.name, initialChildren: children);

  static const String name = 'AccountRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountPage();
    },
  );
}

/// generated route for
/// [_i2.AuthenticatedWrapper]
class AuthenticatedRouter extends _i19.PageRouteInfo<void> {
  const AuthenticatedRouter({List<_i19.PageRouteInfo>? children})
    : super(AuthenticatedRouter.name, initialChildren: children);

  static const String name = 'AuthenticatedRouter';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i2.AuthenticatedWrapper());
    },
  );
}

/// generated route for
/// [_i3.ChangePhonePage]
class ChangePhoneRoute extends _i19.PageRouteInfo<void> {
  const ChangePhoneRoute({List<_i19.PageRouteInfo>? children})
    : super(ChangePhoneRoute.name, initialChildren: children);

  static const String name = 'ChangePhoneRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i3.ChangePhonePage();
    },
  );
}

/// generated route for
/// [_i4.DeleteAccountPage]
class DeleteAccountRoute extends _i19.PageRouteInfo<void> {
  const DeleteAccountRoute({List<_i19.PageRouteInfo>? children})
    : super(DeleteAccountRoute.name, initialChildren: children);

  static const String name = 'DeleteAccountRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i4.DeleteAccountPage();
    },
  );
}

/// generated route for
/// [_i5.EditProfilePage]
class EditProfileRoute extends _i19.PageRouteInfo<void> {
  const EditProfileRoute({List<_i19.PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i5.EditProfilePage();
    },
  );
}

/// generated route for
/// [_i6.FavoritesPage]
class FavoritesRoute extends _i19.PageRouteInfo<void> {
  const FavoritesRoute({List<_i19.PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i6.FavoritesPage();
    },
  );
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i19.PageRouteInfo<void> {
  const HomeRoute({List<_i19.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomePage();
    },
  );
}

/// generated route for
/// [_i8.ListingDetailPage]
class ListingDetailRoute extends _i19.PageRouteInfo<ListingDetailRouteArgs> {
  ListingDetailRoute({
    _i20.Key? key,
    required String id,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         ListingDetailRoute.name,
         args: ListingDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'ListingDetailRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ListingDetailRouteArgs>();
      return _i19.WrappedRoute(
        child: _i8.ListingDetailPage(key: args.key, id: args.id),
      );
    },
  );
}

class ListingDetailRouteArgs {
  const ListingDetailRouteArgs({this.key, required this.id});

  final _i20.Key? key;

  final String id;

  @override
  String toString() {
    return 'ListingDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i9.LoginPage]
class LoginRoute extends _i19.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i20.Key? key,
    _i21.AuthMode mode = _i21.AuthMode.login,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, mode: mode),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i9.LoginPage(key: args.key, mode: args.mode);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.mode = _i21.AuthMode.login});

  final _i20.Key? key;

  final _i21.AuthMode mode;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, mode: $mode}';
  }
}

/// generated route for
/// [_i10.MessagesPage]
class MessagesRoute extends _i19.PageRouteInfo<void> {
  const MessagesRoute({List<_i19.PageRouteInfo>? children})
    : super(MessagesRoute.name, initialChildren: children);

  static const String name = 'MessagesRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i10.MessagesPage();
    },
  );
}

/// generated route for
/// [_i11.OtpPage]
class OtpRoute extends _i19.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    required _i21.OtpSession session,
    _i20.Key? key,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         OtpRoute.name,
         args: OtpRouteArgs(session: session, key: key),
         initialChildren: children,
       );

  static const String name = 'OtpRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>();
      return _i11.OtpPage(session: args.session, key: args.key);
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({required this.session, this.key});

  final _i21.OtpSession session;

  final _i20.Key? key;

  @override
  String toString() {
    return 'OtpRouteArgs{session: $session, key: $key}';
  }
}

/// generated route for
/// [_i12.ResidenceDetailPage]
class ResidenceDetailRoute
    extends _i19.PageRouteInfo<ResidenceDetailRouteArgs> {
  ResidenceDetailRoute({
    _i20.Key? key,
    required String id,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         ResidenceDetailRoute.name,
         args: ResidenceDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'ResidenceDetailRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResidenceDetailRouteArgs>();
      return _i12.ResidenceDetailPage(key: args.key, id: args.id);
    },
  );
}

class ResidenceDetailRouteArgs {
  const ResidenceDetailRouteArgs({this.key, required this.id});

  final _i20.Key? key;

  final String id;

  @override
  String toString() {
    return 'ResidenceDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i13.SearchPage]
class SearchRoute extends _i19.PageRouteInfo<void> {
  const SearchRoute({List<_i19.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i13.SearchPage());
    },
  );
}

/// generated route for
/// [_i14.SettingsMenuPage]
class SettingsMenuRoute extends _i19.PageRouteInfo<void> {
  const SettingsMenuRoute({List<_i19.PageRouteInfo>? children})
    : super(SettingsMenuRoute.name, initialChildren: children);

  static const String name = 'SettingsMenuRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i14.SettingsMenuPage();
    },
  );
}

/// generated route for
/// [_i15.SettingsPage]
class SettingsRoute extends _i19.PageRouteInfo<void> {
  const SettingsRoute({List<_i19.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i15.SettingsPage();
    },
  );
}

/// generated route for
/// [_i16.SplashPage]
class SplashRoute extends _i19.PageRouteInfo<void> {
  const SplashRoute({List<_i19.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i16.SplashPage());
    },
  );
}

/// generated route for
/// [_i17.UserShellPage]
class UserShellRoute extends _i19.PageRouteInfo<void> {
  const UserShellRoute({List<_i19.PageRouteInfo>? children})
    : super(UserShellRoute.name, initialChildren: children);

  static const String name = 'UserShellRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i17.UserShellPage());
    },
  );
}

/// generated route for
/// [_i18.WelcomePage]
class WelcomeRoute extends _i19.PageRouteInfo<void> {
  const WelcomeRoute({List<_i19.PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i18.WelcomePage();
    },
  );
}
