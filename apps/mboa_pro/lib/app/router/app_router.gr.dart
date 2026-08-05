// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i26;
import 'package:flutter/material.dart' as _i27;
import 'package:mboa_pro/app/router/wrappers/authenticated_wrapper.dart' as _i5;
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart' as _i29;
import 'package:mboa_pro/features/annonces/ui/annonce_detail_page.dart' as _i2;
import 'package:mboa_pro/features/annonces/ui/annonce_form_page.dart' as _i3;
import 'package:mboa_pro/features/annonces/ui/annonces_list_page.dart' as _i4;
import 'package:mboa_pro/features/annonces/ui/mes_biens_page.dart' as _i16;
import 'package:mboa_pro/features/annonces/ui/residences_list_page.dart'
    as _i21;
import 'package:mboa_pro/features/home/ui/home_page.dart' as _i12;
import 'package:mboa_pro/features/kyc/ui/certifications_page.dart' as _i6;
import 'package:mboa_pro/features/kyc/ui/id_document_page.dart' as _i13;
import 'package:mboa_pro/features/login/ui/login_page.dart' as _i14;
import 'package:mboa_pro/features/profile/ui/change_password_page.dart' as _i7;
import 'package:mboa_pro/features/profile/ui/change_phone_page.dart' as _i8;
import 'package:mboa_pro/features/profile/ui/delete_account_page.dart' as _i9;
import 'package:mboa_pro/features/profile/ui/edit_profile_page.dart' as _i10;
import 'package:mboa_pro/features/profile/ui/settings_menu_page.dart' as _i22;
import 'package:mboa_pro/features/profile/ui/settings_page.dart' as _i23;
import 'package:mboa_pro/features/register/ui/register_page.dart' as _i20;
import 'package:mboa_pro/features/shell/ui/access_restricted_page.dart' as _i1;
import 'package:mboa_pro/features/shell/ui/finance_page.dart' as _i11;
import 'package:mboa_pro/features/shell/ui/manager_page.dart' as _i15;
import 'package:mboa_pro/features/shell/ui/pro_menu_page.dart' as _i18;
import 'package:mboa_pro/features/shell/ui/pro_shell_page.dart' as _i19;
import 'package:mboa_pro/features/splash/ui/splash_page.dart' as _i24;
import 'package:mboa_pro/features/subscription/ui/plans_page.dart' as _i17;
import 'package:mboa_pro/features/subscription/ui/subscription_page.dart'
    as _i25;
import 'package:mboa_shared/mboa_shared.dart' as _i28;

/// generated route for
/// [_i1.AccessRestrictedPage]
class AccessRestrictedRoute
    extends _i26.PageRouteInfo<AccessRestrictedRouteArgs> {
  AccessRestrictedRoute({
    _i27.Key? key,
    required _i28.AccessRestriction restriction,
    _i28.SubscriptionTier? requiredTier,
    List<_i26.PageRouteInfo>? children,
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

  static _i26.PageInfo page = _i26.PageInfo(
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

  final _i27.Key? key;

  final _i28.AccessRestriction restriction;

  final _i28.SubscriptionTier? requiredTier;

  @override
  String toString() {
    return 'AccessRestrictedRouteArgs{key: $key, restriction: $restriction, requiredTier: $requiredTier}';
  }
}

/// generated route for
/// [_i2.AnnonceDetailPage]
class AnnonceDetailRoute extends _i26.PageRouteInfo<AnnonceDetailRouteArgs> {
  AnnonceDetailRoute({
    _i27.Key? key,
    required String id,
    List<_i26.PageRouteInfo>? children,
  }) : super(
         AnnonceDetailRoute.name,
         args: AnnonceDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'AnnonceDetailRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnnonceDetailRouteArgs>();
      return _i2.AnnonceDetailPage(key: args.key, id: args.id);
    },
  );
}

class AnnonceDetailRouteArgs {
  const AnnonceDetailRouteArgs({this.key, required this.id});

  final _i27.Key? key;

  final String id;

  @override
  String toString() {
    return 'AnnonceDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i3.AnnonceFormPage]
class AnnonceFormRoute extends _i26.PageRouteInfo<AnnonceFormRouteArgs> {
  AnnonceFormRoute({
    _i27.Key? key,
    required _i29.AnnonceKind kind,
    String? annonceId,
    List<_i26.PageRouteInfo>? children,
  }) : super(
         AnnonceFormRoute.name,
         args: AnnonceFormRouteArgs(key: key, kind: kind, annonceId: annonceId),
         initialChildren: children,
       );

  static const String name = 'AnnonceFormRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnnonceFormRouteArgs>();
      return _i26.WrappedRoute(
        child: _i3.AnnonceFormPage(
          key: args.key,
          kind: args.kind,
          annonceId: args.annonceId,
        ),
      );
    },
  );
}

class AnnonceFormRouteArgs {
  const AnnonceFormRouteArgs({this.key, required this.kind, this.annonceId});

  final _i27.Key? key;

  final _i29.AnnonceKind kind;

  final String? annonceId;

  @override
  String toString() {
    return 'AnnonceFormRouteArgs{key: $key, kind: $kind, annonceId: $annonceId}';
  }
}

/// generated route for
/// [_i4.AnnoncesListPage]
class AnnoncesListRoute extends _i26.PageRouteInfo<void> {
  const AnnoncesListRoute({List<_i26.PageRouteInfo>? children})
    : super(AnnoncesListRoute.name, initialChildren: children);

  static const String name = 'AnnoncesListRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return _i26.WrappedRoute(child: const _i4.AnnoncesListPage());
    },
  );
}

/// generated route for
/// [_i5.AuthenticatedWrapper]
class AuthenticatedRouter extends _i26.PageRouteInfo<void> {
  const AuthenticatedRouter({List<_i26.PageRouteInfo>? children})
    : super(AuthenticatedRouter.name, initialChildren: children);

  static const String name = 'AuthenticatedRouter';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return _i26.WrappedRoute(child: const _i5.AuthenticatedWrapper());
    },
  );
}

/// generated route for
/// [_i6.CertificationsPage]
class CertificationsRoute extends _i26.PageRouteInfo<CertificationsRouteArgs> {
  CertificationsRoute({
    _i27.Key? key,
    _i28.AccountRole accountRole = _i28.AccountRole.user,
    List<_i26.PageRouteInfo>? children,
  }) : super(
         CertificationsRoute.name,
         args: CertificationsRouteArgs(key: key, accountRole: accountRole),
         initialChildren: children,
       );

  static const String name = 'CertificationsRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CertificationsRouteArgs>(
        orElse: () => const CertificationsRouteArgs(),
      );
      return _i6.CertificationsPage(
        key: args.key,
        accountRole: args.accountRole,
      );
    },
  );
}

class CertificationsRouteArgs {
  const CertificationsRouteArgs({
    this.key,
    this.accountRole = _i28.AccountRole.user,
  });

  final _i27.Key? key;

  final _i28.AccountRole accountRole;

  @override
  String toString() {
    return 'CertificationsRouteArgs{key: $key, accountRole: $accountRole}';
  }
}

/// generated route for
/// [_i7.ChangePasswordPage]
class ChangePasswordRoute extends _i26.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i26.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i7.ChangePasswordPage();
    },
  );
}

/// generated route for
/// [_i8.ChangePhonePage]
class ChangePhoneRoute extends _i26.PageRouteInfo<void> {
  const ChangePhoneRoute({List<_i26.PageRouteInfo>? children})
    : super(ChangePhoneRoute.name, initialChildren: children);

  static const String name = 'ChangePhoneRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i8.ChangePhonePage();
    },
  );
}

/// generated route for
/// [_i9.DeleteAccountPage]
class DeleteAccountRoute extends _i26.PageRouteInfo<void> {
  const DeleteAccountRoute({List<_i26.PageRouteInfo>? children})
    : super(DeleteAccountRoute.name, initialChildren: children);

  static const String name = 'DeleteAccountRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i9.DeleteAccountPage();
    },
  );
}

/// generated route for
/// [_i10.EditProfilePage]
class EditProfileRoute extends _i26.PageRouteInfo<void> {
  const EditProfileRoute({List<_i26.PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i10.EditProfilePage();
    },
  );
}

/// generated route for
/// [_i11.FinancePage]
class FinanceRoute extends _i26.PageRouteInfo<void> {
  const FinanceRoute({List<_i26.PageRouteInfo>? children})
    : super(FinanceRoute.name, initialChildren: children);

  static const String name = 'FinanceRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i11.FinancePage();
    },
  );
}

/// generated route for
/// [_i12.HomePage]
class HomeRoute extends _i26.PageRouteInfo<void> {
  const HomeRoute({List<_i26.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i12.HomePage();
    },
  );
}

/// generated route for
/// [_i13.IdDocumentPage]
class IdDocumentRoute extends _i26.PageRouteInfo<void> {
  const IdDocumentRoute({List<_i26.PageRouteInfo>? children})
    : super(IdDocumentRoute.name, initialChildren: children);

  static const String name = 'IdDocumentRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i13.IdDocumentPage();
    },
  );
}

/// generated route for
/// [_i14.LoginPage]
class LoginRoute extends _i26.PageRouteInfo<void> {
  const LoginRoute({List<_i26.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i14.LoginPage();
    },
  );
}

/// generated route for
/// [_i15.ManagerPage]
class ManagerRoute extends _i26.PageRouteInfo<void> {
  const ManagerRoute({List<_i26.PageRouteInfo>? children})
    : super(ManagerRoute.name, initialChildren: children);

  static const String name = 'ManagerRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i15.ManagerPage();
    },
  );
}

/// generated route for
/// [_i16.MesBiensPage]
class MesBiensRoute extends _i26.PageRouteInfo<void> {
  const MesBiensRoute({List<_i26.PageRouteInfo>? children})
    : super(MesBiensRoute.name, initialChildren: children);

  static const String name = 'MesBiensRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i16.MesBiensPage();
    },
  );
}

/// generated route for
/// [_i17.PlansPage]
class PlansRoute extends _i26.PageRouteInfo<void> {
  const PlansRoute({List<_i26.PageRouteInfo>? children})
    : super(PlansRoute.name, initialChildren: children);

  static const String name = 'PlansRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i17.PlansPage();
    },
  );
}

/// generated route for
/// [_i18.ProMenuPage]
class ProMenuRoute extends _i26.PageRouteInfo<void> {
  const ProMenuRoute({List<_i26.PageRouteInfo>? children})
    : super(ProMenuRoute.name, initialChildren: children);

  static const String name = 'ProMenuRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i18.ProMenuPage();
    },
  );
}

/// generated route for
/// [_i19.ProShellPage]
class ProShellRoute extends _i26.PageRouteInfo<void> {
  const ProShellRoute({List<_i26.PageRouteInfo>? children})
    : super(ProShellRoute.name, initialChildren: children);

  static const String name = 'ProShellRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i19.ProShellPage();
    },
  );
}

/// generated route for
/// [_i20.RegisterPage]
class RegisterRoute extends _i26.PageRouteInfo<void> {
  const RegisterRoute({List<_i26.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i20.RegisterPage();
    },
  );
}

/// generated route for
/// [_i21.ResidencesListPage]
class ResidencesListRoute extends _i26.PageRouteInfo<void> {
  const ResidencesListRoute({List<_i26.PageRouteInfo>? children})
    : super(ResidencesListRoute.name, initialChildren: children);

  static const String name = 'ResidencesListRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return _i26.WrappedRoute(child: const _i21.ResidencesListPage());
    },
  );
}

/// generated route for
/// [_i22.SettingsMenuPage]
class SettingsMenuRoute extends _i26.PageRouteInfo<void> {
  const SettingsMenuRoute({List<_i26.PageRouteInfo>? children})
    : super(SettingsMenuRoute.name, initialChildren: children);

  static const String name = 'SettingsMenuRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i22.SettingsMenuPage();
    },
  );
}

/// generated route for
/// [_i23.SettingsPage]
class SettingsRoute extends _i26.PageRouteInfo<void> {
  const SettingsRoute({List<_i26.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i23.SettingsPage();
    },
  );
}

/// generated route for
/// [_i24.SplashPage]
class SplashRoute extends _i26.PageRouteInfo<void> {
  const SplashRoute({List<_i26.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return _i26.WrappedRoute(child: const _i24.SplashPage());
    },
  );
}

/// generated route for
/// [_i25.SubscriptionPage]
class SubscriptionRoute extends _i26.PageRouteInfo<void> {
  const SubscriptionRoute({List<_i26.PageRouteInfo>? children})
    : super(SubscriptionRoute.name, initialChildren: children);

  static const String name = 'SubscriptionRoute';

  static _i26.PageInfo page = _i26.PageInfo(
    name,
    builder: (data) {
      return const _i25.SubscriptionPage();
    },
  );
}
