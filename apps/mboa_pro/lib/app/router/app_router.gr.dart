// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:mboa_pro/features/home/ui/home_page.dart' as _i6;
import 'package:mboa_pro/features/kyc/ui/certifications_page.dart' as _i1;
import 'package:mboa_pro/features/kyc/ui/id_document_page.dart' as _i7;
import 'package:mboa_pro/features/login/ui/login_page.dart' as _i8;
import 'package:mboa_pro/features/profile/ui/change_password_page.dart' as _i2;
import 'package:mboa_pro/features/profile/ui/change_phone_page.dart' as _i3;
import 'package:mboa_pro/features/profile/ui/delete_account_page.dart' as _i4;
import 'package:mboa_pro/features/profile/ui/edit_profile_page.dart' as _i5;
import 'package:mboa_pro/features/profile/ui/settings_menu_page.dart' as _i10;
import 'package:mboa_pro/features/profile/ui/settings_page.dart' as _i11;
import 'package:mboa_pro/features/register/ui/register_page.dart' as _i9;
import 'package:mboa_pro/features/splash/ui/splash_page.dart' as _i12;
import 'package:mboa_shared/mboa_shared.dart' as _i15;

/// generated route for
/// [_i1.CertificationsPage]
class CertificationsRoute extends _i13.PageRouteInfo<CertificationsRouteArgs> {
  CertificationsRoute({
    _i14.Key? key,
    _i15.AccountRole accountRole = _i15.AccountRole.user,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         CertificationsRoute.name,
         args: CertificationsRouteArgs(key: key, accountRole: accountRole),
         initialChildren: children,
       );

  static const String name = 'CertificationsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CertificationsRouteArgs>(
        orElse: () => const CertificationsRouteArgs(),
      );
      return _i1.CertificationsPage(
        key: args.key,
        accountRole: args.accountRole,
      );
    },
  );
}

class CertificationsRouteArgs {
  const CertificationsRouteArgs({
    this.key,
    this.accountRole = _i15.AccountRole.user,
  });

  final _i14.Key? key;

  final _i15.AccountRole accountRole;

  @override
  String toString() {
    return 'CertificationsRouteArgs{key: $key, accountRole: $accountRole}';
  }
}

/// generated route for
/// [_i2.ChangePasswordPage]
class ChangePasswordRoute extends _i13.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i13.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i2.ChangePasswordPage();
    },
  );
}

/// generated route for
/// [_i3.ChangePhonePage]
class ChangePhoneRoute extends _i13.PageRouteInfo<void> {
  const ChangePhoneRoute({List<_i13.PageRouteInfo>? children})
    : super(ChangePhoneRoute.name, initialChildren: children);

  static const String name = 'ChangePhoneRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i3.ChangePhonePage();
    },
  );
}

/// generated route for
/// [_i4.DeleteAccountPage]
class DeleteAccountRoute extends _i13.PageRouteInfo<void> {
  const DeleteAccountRoute({List<_i13.PageRouteInfo>? children})
    : super(DeleteAccountRoute.name, initialChildren: children);

  static const String name = 'DeleteAccountRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i4.DeleteAccountPage();
    },
  );
}

/// generated route for
/// [_i5.EditProfilePage]
class EditProfileRoute extends _i13.PageRouteInfo<void> {
  const EditProfileRoute({List<_i13.PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i5.EditProfilePage();
    },
  );
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomePage();
    },
  );
}

/// generated route for
/// [_i7.IdDocumentPage]
class IdDocumentRoute extends _i13.PageRouteInfo<void> {
  const IdDocumentRoute({List<_i13.PageRouteInfo>? children})
    : super(IdDocumentRoute.name, initialChildren: children);

  static const String name = 'IdDocumentRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i7.IdDocumentPage();
    },
  );
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i8.LoginPage();
    },
  );
}

/// generated route for
/// [_i9.RegisterPage]
class RegisterRoute extends _i13.PageRouteInfo<void> {
  const RegisterRoute({List<_i13.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i9.RegisterPage();
    },
  );
}

/// generated route for
/// [_i10.SettingsMenuPage]
class SettingsMenuRoute extends _i13.PageRouteInfo<void> {
  const SettingsMenuRoute({List<_i13.PageRouteInfo>? children})
    : super(SettingsMenuRoute.name, initialChildren: children);

  static const String name = 'SettingsMenuRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i10.SettingsMenuPage();
    },
  );
}

/// generated route for
/// [_i11.SettingsPage]
class SettingsRoute extends _i13.PageRouteInfo<void> {
  const SettingsRoute({List<_i13.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i11.SettingsPage();
    },
  );
}

/// generated route for
/// [_i12.SplashPage]
class SplashRoute extends _i13.PageRouteInfo<void> {
  const SplashRoute({List<_i13.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return _i13.WrappedRoute(child: const _i12.SplashPage());
    },
  );
}
