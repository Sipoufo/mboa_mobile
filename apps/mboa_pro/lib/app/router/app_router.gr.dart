// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i21;
import 'package:flutter/material.dart' as _i22;
import 'package:mboa_pro/app/router/wrappers/authenticated_wrapper.dart' as _i2;
import 'package:mboa_pro/features/home/ui/home_page.dart' as _i9;
import 'package:mboa_pro/features/kyc/ui/certifications_page.dart' as _i3;
import 'package:mboa_pro/features/kyc/ui/id_document_page.dart' as _i10;
import 'package:mboa_pro/features/login/ui/login_page.dart' as _i11;
import 'package:mboa_pro/features/profile/ui/change_password_page.dart' as _i4;
import 'package:mboa_pro/features/profile/ui/change_phone_page.dart' as _i5;
import 'package:mboa_pro/features/profile/ui/delete_account_page.dart' as _i6;
import 'package:mboa_pro/features/profile/ui/edit_profile_page.dart' as _i7;
import 'package:mboa_pro/features/profile/ui/settings_menu_page.dart' as _i17;
import 'package:mboa_pro/features/profile/ui/settings_page.dart' as _i18;
import 'package:mboa_pro/features/register/ui/register_page.dart' as _i16;
import 'package:mboa_pro/features/shell/ui/access_restricted_page.dart' as _i1;
import 'package:mboa_pro/features/shell/ui/finance_page.dart' as _i8;
import 'package:mboa_pro/features/shell/ui/manager_page.dart' as _i12;
import 'package:mboa_pro/features/shell/ui/pro_menu_page.dart' as _i14;
import 'package:mboa_pro/features/shell/ui/pro_shell_page.dart' as _i15;
import 'package:mboa_pro/features/splash/ui/splash_page.dart' as _i19;
import 'package:mboa_pro/features/subscription/ui/plans_page.dart' as _i13;
import 'package:mboa_pro/features/subscription/ui/subscription_page.dart'
    as _i20;
import 'package:mboa_shared/mboa_shared.dart' as _i23;

/// generated route for
/// [_i1.AccessRestrictedPage]
class AccessRestrictedRoute
    extends _i21.PageRouteInfo<AccessRestrictedRouteArgs> {
  AccessRestrictedRoute({
    _i22.Key? key,
    required _i23.AccessRestriction restriction,
    _i23.SubscriptionTier? requiredTier,
    List<_i21.PageRouteInfo>? children,
  }) : super(
         AccessRestrictedRoute.name,
         args: AccessRestrictedRouteArgs(
           key: key,
           restriction: restriction,
           requiredTier: requiredTier,
         ),
         initialChildren: children,
       );

  static const String name = 'AccessRestrictedRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AccessRestrictedRouteArgs>();
      return _i1.AccessRestrictedPage(
        key: args.key,
        restriction: args.restriction,
        requiredTier: args.requiredTier,
      );
    },
  );
}

class AccessRestrictedRouteArgs {
  const AccessRestrictedRouteArgs({
    this.key,
    required this.restriction,
    this.requiredTier,
  });

  final _i22.Key? key;

  final _i23.AccessRestriction restriction;

  final _i23.SubscriptionTier? requiredTier;

  @override
  String toString() {
    return 'AccessRestrictedRouteArgs{key: $key, restriction: $restriction, requiredTier: $requiredTier}';
  }
}

/// generated route for
/// [_i2.AuthenticatedWrapper]
class AuthenticatedRouter extends _i21.PageRouteInfo<void> {
  const AuthenticatedRouter({List<_i21.PageRouteInfo>? children})
    : super(AuthenticatedRouter.name, initialChildren: children);

  static const String name = 'AuthenticatedRouter';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return _i21.WrappedRoute(child: const _i2.AuthenticatedWrapper());
    },
  );
}

/// generated route for
/// [_i3.CertificationsPage]
class CertificationsRoute extends _i21.PageRouteInfo<CertificationsRouteArgs> {
  CertificationsRoute({
    _i22.Key? key,
    _i23.AccountRole accountRole = _i23.AccountRole.user,
    List<_i21.PageRouteInfo>? children,
  }) : super(
         CertificationsRoute.name,
         args: CertificationsRouteArgs(key: key, accountRole: accountRole),
         initialChildren: children,
       );

  static const String name = 'CertificationsRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CertificationsRouteArgs>(
        orElse: () => const CertificationsRouteArgs(),
      );
      return _i3.CertificationsPage(
        key: args.key,
        accountRole: args.accountRole,
      );
    },
  );
}

class CertificationsRouteArgs {
  const CertificationsRouteArgs({
    this.key,
    this.accountRole = _i23.AccountRole.user,
  });

  final _i22.Key? key;

  final _i23.AccountRole accountRole;

  @override
  String toString() {
    return 'CertificationsRouteArgs{key: $key, accountRole: $accountRole}';
  }
}

/// generated route for
/// [_i4.ChangePasswordPage]
class ChangePasswordRoute extends _i21.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i21.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i4.ChangePasswordPage();
    },
  );
}

/// generated route for
/// [_i5.ChangePhonePage]
class ChangePhoneRoute extends _i21.PageRouteInfo<void> {
  const ChangePhoneRoute({List<_i21.PageRouteInfo>? children})
    : super(ChangePhoneRoute.name, initialChildren: children);

  static const String name = 'ChangePhoneRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i5.ChangePhonePage();
    },
  );
}

/// generated route for
/// [_i6.DeleteAccountPage]
class DeleteAccountRoute extends _i21.PageRouteInfo<void> {
  const DeleteAccountRoute({List<_i21.PageRouteInfo>? children})
    : super(DeleteAccountRoute.name, initialChildren: children);

  static const String name = 'DeleteAccountRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i6.DeleteAccountPage();
    },
  );
}

/// generated route for
/// [_i7.EditProfilePage]
class EditProfileRoute extends _i21.PageRouteInfo<void> {
  const EditProfileRoute({List<_i21.PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i7.EditProfilePage();
    },
  );
}

/// generated route for
/// [_i8.FinancePage]
class FinanceRoute extends _i21.PageRouteInfo<void> {
  const FinanceRoute({List<_i21.PageRouteInfo>? children})
    : super(FinanceRoute.name, initialChildren: children);

  static const String name = 'FinanceRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i8.FinancePage();
    },
  );
}

/// generated route for
/// [_i9.HomePage]
class HomeRoute extends _i21.PageRouteInfo<void> {
  const HomeRoute({List<_i21.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return _i21.WrappedRoute(child: const _i9.HomePage());
    },
  );
}

/// generated route for
/// [_i10.IdDocumentPage]
class IdDocumentRoute extends _i21.PageRouteInfo<void> {
  const IdDocumentRoute({List<_i21.PageRouteInfo>? children})
    : super(IdDocumentRoute.name, initialChildren: children);

  static const String name = 'IdDocumentRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i10.IdDocumentPage();
    },
  );
}

/// generated route for
/// [_i11.LoginPage]
class LoginRoute extends _i21.PageRouteInfo<void> {
  const LoginRoute({List<_i21.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i11.LoginPage();
    },
  );
}

/// generated route for
/// [_i12.ManagerPage]
class ManagerRoute extends _i21.PageRouteInfo<void> {
  const ManagerRoute({List<_i21.PageRouteInfo>? children})
    : super(ManagerRoute.name, initialChildren: children);

  static const String name = 'ManagerRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i12.ManagerPage();
    },
  );
}

/// generated route for
/// [_i13.PlansPage]
class PlansRoute extends _i21.PageRouteInfo<void> {
  const PlansRoute({List<_i21.PageRouteInfo>? children})
    : super(PlansRoute.name, initialChildren: children);

  static const String name = 'PlansRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i13.PlansPage();
    },
  );
}

/// generated route for
/// [_i14.ProMenuPage]
class ProMenuRoute extends _i21.PageRouteInfo<void> {
  const ProMenuRoute({List<_i21.PageRouteInfo>? children})
    : super(ProMenuRoute.name, initialChildren: children);

  static const String name = 'ProMenuRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i14.ProMenuPage();
    },
  );
}

/// generated route for
/// [_i15.ProShellPage]
class ProShellRoute extends _i21.PageRouteInfo<void> {
  const ProShellRoute({List<_i21.PageRouteInfo>? children})
    : super(ProShellRoute.name, initialChildren: children);

  static const String name = 'ProShellRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i15.ProShellPage();
    },
  );
}

/// generated route for
/// [_i16.RegisterPage]
class RegisterRoute extends _i21.PageRouteInfo<void> {
  const RegisterRoute({List<_i21.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i16.RegisterPage();
    },
  );
}

/// generated route for
/// [_i17.SettingsMenuPage]
class SettingsMenuRoute extends _i21.PageRouteInfo<void> {
  const SettingsMenuRoute({List<_i21.PageRouteInfo>? children})
    : super(SettingsMenuRoute.name, initialChildren: children);

  static const String name = 'SettingsMenuRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i17.SettingsMenuPage();
    },
  );
}

/// generated route for
/// [_i18.SettingsPage]
class SettingsRoute extends _i21.PageRouteInfo<void> {
  const SettingsRoute({List<_i21.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i18.SettingsPage();
    },
  );
}

/// generated route for
/// [_i19.SplashPage]
class SplashRoute extends _i21.PageRouteInfo<void> {
  const SplashRoute({List<_i21.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return _i21.WrappedRoute(child: const _i19.SplashPage());
    },
  );
}

/// generated route for
/// [_i20.SubscriptionPage]
class SubscriptionRoute extends _i21.PageRouteInfo<void> {
  const SubscriptionRoute({List<_i21.PageRouteInfo>? children})
    : super(SubscriptionRoute.name, initialChildren: children);

  static const String name = 'SubscriptionRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i20.SubscriptionPage();
    },
  );
}
