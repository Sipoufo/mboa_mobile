// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i36;
import 'package:flutter/material.dart' as _i37;
import 'package:mboa_pro/app/router/role_gate_page.dart' as _i31;
import 'package:mboa_pro/app/router/wrappers/authenticated_wrapper.dart'
    as _i12;
import 'package:mboa_pro/features/agent/ui/agent_availability_page.dart' as _i3;
import 'package:mboa_pro/features/agent/ui/agent_profile_page.dart' as _i6;
import 'package:mboa_pro/features/agent/ui/agent_shell_page.dart' as _i7;
import 'package:mboa_pro/features/agent/ui/agent_zones_page.dart' as _i8;
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart' as _i40;
import 'package:mboa_pro/features/annonces/ui/annonce_detail_page.dart' as _i9;
import 'package:mboa_pro/features/annonces/ui/annonce_form_page.dart' as _i10;
import 'package:mboa_pro/features/annonces/ui/annonces_list_page.dart' as _i11;
import 'package:mboa_pro/features/annonces/ui/mes_biens_page.dart' as _i24;
import 'package:mboa_pro/features/annonces/ui/residence_detail_page.dart'
    as _i29;
import 'package:mboa_pro/features/annonces/ui/residences_list_page.dart'
    as _i30;
import 'package:mboa_pro/features/assignments/models/assignment.dart' as _i39;
import 'package:mboa_pro/features/assignments/ui/agent_assignment_page.dart'
    as _i2;
import 'package:mboa_pro/features/assignments/ui/agent_detail_page.dart' as _i4;
import 'package:mboa_pro/features/assignments/ui/agent_missions_page.dart'
    as _i5;
import 'package:mboa_pro/features/assignments/ui/mes_agents_page.dart' as _i23;
import 'package:mboa_pro/features/home/ui/home_page.dart' as _i19;
import 'package:mboa_pro/features/kyc/ui/certifications_page.dart' as _i13;
import 'package:mboa_pro/features/kyc/ui/id_document_page.dart' as _i20;
import 'package:mboa_pro/features/login/ui/login_page.dart' as _i21;
import 'package:mboa_pro/features/profile/ui/change_password_page.dart' as _i14;
import 'package:mboa_pro/features/profile/ui/change_phone_page.dart' as _i15;
import 'package:mboa_pro/features/profile/ui/delete_account_page.dart' as _i16;
import 'package:mboa_pro/features/profile/ui/edit_profile_page.dart' as _i17;
import 'package:mboa_pro/features/profile/ui/settings_menu_page.dart' as _i32;
import 'package:mboa_pro/features/profile/ui/settings_page.dart' as _i33;
import 'package:mboa_pro/features/register/ui/register_page.dart' as _i28;
import 'package:mboa_pro/features/shell/ui/access_restricted_page.dart' as _i1;
import 'package:mboa_pro/features/shell/ui/finance_page.dart' as _i18;
import 'package:mboa_pro/features/shell/ui/manager_page.dart' as _i22;
import 'package:mboa_pro/features/shell/ui/pro_menu_page.dart' as _i26;
import 'package:mboa_pro/features/shell/ui/pro_shell_page.dart' as _i27;
import 'package:mboa_pro/features/splash/ui/splash_page.dart' as _i34;
import 'package:mboa_pro/features/subscription/ui/plans_page.dart' as _i25;
import 'package:mboa_pro/features/subscription/ui/subscription_page.dart'
    as _i35;
import 'package:mboa_shared/mboa_shared.dart' as _i38;

/// generated route for
/// [_i1.AccessRestrictedPage]
class AccessRestrictedRoute
    extends _i36.PageRouteInfo<AccessRestrictedRouteArgs> {
  AccessRestrictedRoute({
    _i37.Key? key,
    required _i38.AccessRestriction restriction,
    _i38.SubscriptionTier? requiredTier,
    List<_i36.PageRouteInfo>? children,
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

  static _i36.PageInfo page = _i36.PageInfo(
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

  final _i37.Key? key;

  final _i38.AccessRestriction restriction;

  final _i38.SubscriptionTier? requiredTier;

  @override
  String toString() {
    return 'AccessRestrictedRouteArgs{key: $key, restriction: $restriction, requiredTier: $requiredTier}';
  }
}

/// generated route for
/// [_i2.AgentAssignmentPage]
class AgentAssignmentRoute
    extends _i36.PageRouteInfo<AgentAssignmentRouteArgs> {
  AgentAssignmentRoute({
    _i37.Key? key,
    required _i39.AssignmentTarget target,
    List<_i36.PageRouteInfo>? children,
  }) : super(
         AgentAssignmentRoute.name,
         args: AgentAssignmentRouteArgs(key: key, target: target),
         initialChildren: children,
       );

  static const String name = 'AgentAssignmentRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AgentAssignmentRouteArgs>();
      return _i36.WrappedRoute(
        child: _i2.AgentAssignmentPage(key: args.key, target: args.target),
      );
    },
  );
}

class AgentAssignmentRouteArgs {
  const AgentAssignmentRouteArgs({this.key, required this.target});

  final _i37.Key? key;

  final _i39.AssignmentTarget target;

  @override
  String toString() {
    return 'AgentAssignmentRouteArgs{key: $key, target: $target}';
  }
}

/// generated route for
/// [_i3.AgentAvailabilityPage]
class AgentAvailabilityRoute extends _i36.PageRouteInfo<void> {
  const AgentAvailabilityRoute({List<_i36.PageRouteInfo>? children})
    : super(AgentAvailabilityRoute.name, initialChildren: children);

  static const String name = 'AgentAvailabilityRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return _i36.WrappedRoute(child: const _i3.AgentAvailabilityPage());
    },
  );
}

/// generated route for
/// [_i4.AgentDetailPage]
class AgentDetailRoute extends _i36.PageRouteInfo<AgentDetailRouteArgs> {
  AgentDetailRoute({
    _i37.Key? key,
    required String agentAccountId,
    List<_i36.PageRouteInfo>? children,
  }) : super(
         AgentDetailRoute.name,
         args: AgentDetailRouteArgs(key: key, agentAccountId: agentAccountId),
         initialChildren: children,
       );

  static const String name = 'AgentDetailRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AgentDetailRouteArgs>();
      return _i36.WrappedRoute(
        child: _i4.AgentDetailPage(
          key: args.key,
          agentAccountId: args.agentAccountId,
        ),
      );
    },
  );
}

class AgentDetailRouteArgs {
  const AgentDetailRouteArgs({this.key, required this.agentAccountId});

  final _i37.Key? key;

  final String agentAccountId;

  @override
  String toString() {
    return 'AgentDetailRouteArgs{key: $key, agentAccountId: $agentAccountId}';
  }
}

/// generated route for
/// [_i5.AgentMissionsPage]
class AgentMissionsRoute extends _i36.PageRouteInfo<void> {
  const AgentMissionsRoute({List<_i36.PageRouteInfo>? children})
    : super(AgentMissionsRoute.name, initialChildren: children);

  static const String name = 'AgentMissionsRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return _i36.WrappedRoute(child: const _i5.AgentMissionsPage());
    },
  );
}

/// generated route for
/// [_i6.AgentProfilePage]
class AgentProfileRoute extends _i36.PageRouteInfo<void> {
  const AgentProfileRoute({List<_i36.PageRouteInfo>? children})
    : super(AgentProfileRoute.name, initialChildren: children);

  static const String name = 'AgentProfileRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i6.AgentProfilePage();
    },
  );
}

/// generated route for
/// [_i7.AgentShellPage]
class AgentShellRoute extends _i36.PageRouteInfo<void> {
  const AgentShellRoute({List<_i36.PageRouteInfo>? children})
    : super(AgentShellRoute.name, initialChildren: children);

  static const String name = 'AgentShellRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i7.AgentShellPage();
    },
  );
}

/// generated route for
/// [_i7.AgentVisitsPage]
class AgentVisitsRoute extends _i36.PageRouteInfo<void> {
  const AgentVisitsRoute({List<_i36.PageRouteInfo>? children})
    : super(AgentVisitsRoute.name, initialChildren: children);

  static const String name = 'AgentVisitsRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i7.AgentVisitsPage();
    },
  );
}

/// generated route for
/// [_i8.AgentZonesPage]
class AgentZonesRoute extends _i36.PageRouteInfo<void> {
  const AgentZonesRoute({List<_i36.PageRouteInfo>? children})
    : super(AgentZonesRoute.name, initialChildren: children);

  static const String name = 'AgentZonesRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i8.AgentZonesPage();
    },
  );
}

/// generated route for
/// [_i9.AnnonceDetailPage]
class AnnonceDetailRoute extends _i36.PageRouteInfo<AnnonceDetailRouteArgs> {
  AnnonceDetailRoute({
    _i37.Key? key,
    required String id,
    List<_i36.PageRouteInfo>? children,
  }) : super(
         AnnonceDetailRoute.name,
         args: AnnonceDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'AnnonceDetailRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnnonceDetailRouteArgs>();
      return _i9.AnnonceDetailPage(key: args.key, id: args.id);
    },
  );
}

class AnnonceDetailRouteArgs {
  const AnnonceDetailRouteArgs({this.key, required this.id});

  final _i37.Key? key;

  final String id;

  @override
  String toString() {
    return 'AnnonceDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i10.AnnonceFormPage]
class AnnonceFormRoute extends _i36.PageRouteInfo<AnnonceFormRouteArgs> {
  AnnonceFormRoute({
    _i37.Key? key,
    required _i40.AnnonceKind kind,
    String? annonceId,
    List<_i36.PageRouteInfo>? children,
  }) : super(
         AnnonceFormRoute.name,
         args: AnnonceFormRouteArgs(key: key, kind: kind, annonceId: annonceId),
         initialChildren: children,
       );

  static const String name = 'AnnonceFormRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnnonceFormRouteArgs>();
      return _i36.WrappedRoute(
        child: _i10.AnnonceFormPage(
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

  final _i37.Key? key;

  final _i40.AnnonceKind kind;

  final String? annonceId;

  @override
  String toString() {
    return 'AnnonceFormRouteArgs{key: $key, kind: $kind, annonceId: $annonceId}';
  }
}

/// generated route for
/// [_i11.AnnoncesListPage]
class AnnoncesListRoute extends _i36.PageRouteInfo<void> {
  const AnnoncesListRoute({List<_i36.PageRouteInfo>? children})
    : super(AnnoncesListRoute.name, initialChildren: children);

  static const String name = 'AnnoncesListRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i11.AnnoncesListPage();
    },
  );
}

/// generated route for
/// [_i12.AuthenticatedWrapper]
class AuthenticatedRouter extends _i36.PageRouteInfo<void> {
  const AuthenticatedRouter({List<_i36.PageRouteInfo>? children})
    : super(AuthenticatedRouter.name, initialChildren: children);

  static const String name = 'AuthenticatedRouter';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return _i36.WrappedRoute(child: const _i12.AuthenticatedWrapper());
    },
  );
}

/// generated route for
/// [_i13.CertificationsPage]
class CertificationsRoute extends _i36.PageRouteInfo<CertificationsRouteArgs> {
  CertificationsRoute({
    _i37.Key? key,
    _i38.AccountRole accountRole = _i38.AccountRole.user,
    List<_i36.PageRouteInfo>? children,
  }) : super(
         CertificationsRoute.name,
         args: CertificationsRouteArgs(key: key, accountRole: accountRole),
         initialChildren: children,
       );

  static const String name = 'CertificationsRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CertificationsRouteArgs>(
        orElse: () => const CertificationsRouteArgs(),
      );
      return _i13.CertificationsPage(
        key: args.key,
        accountRole: args.accountRole,
      );
    },
  );
}

class CertificationsRouteArgs {
  const CertificationsRouteArgs({
    this.key,
    this.accountRole = _i38.AccountRole.user,
  });

  final _i37.Key? key;

  final _i38.AccountRole accountRole;

  @override
  String toString() {
    return 'CertificationsRouteArgs{key: $key, accountRole: $accountRole}';
  }
}

/// generated route for
/// [_i14.ChangePasswordPage]
class ChangePasswordRoute extends _i36.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i36.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i14.ChangePasswordPage();
    },
  );
}

/// generated route for
/// [_i15.ChangePhonePage]
class ChangePhoneRoute extends _i36.PageRouteInfo<void> {
  const ChangePhoneRoute({List<_i36.PageRouteInfo>? children})
    : super(ChangePhoneRoute.name, initialChildren: children);

  static const String name = 'ChangePhoneRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i15.ChangePhonePage();
    },
  );
}

/// generated route for
/// [_i16.DeleteAccountPage]
class DeleteAccountRoute extends _i36.PageRouteInfo<void> {
  const DeleteAccountRoute({List<_i36.PageRouteInfo>? children})
    : super(DeleteAccountRoute.name, initialChildren: children);

  static const String name = 'DeleteAccountRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i16.DeleteAccountPage();
    },
  );
}

/// generated route for
/// [_i17.EditProfilePage]
class EditProfileRoute extends _i36.PageRouteInfo<void> {
  const EditProfileRoute({List<_i36.PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i17.EditProfilePage();
    },
  );
}

/// generated route for
/// [_i18.FinancePage]
class FinanceRoute extends _i36.PageRouteInfo<void> {
  const FinanceRoute({List<_i36.PageRouteInfo>? children})
    : super(FinanceRoute.name, initialChildren: children);

  static const String name = 'FinanceRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i18.FinancePage();
    },
  );
}

/// generated route for
/// [_i19.HomePage]
class HomeRoute extends _i36.PageRouteInfo<void> {
  const HomeRoute({List<_i36.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i19.HomePage();
    },
  );
}

/// generated route for
/// [_i20.IdDocumentPage]
class IdDocumentRoute extends _i36.PageRouteInfo<void> {
  const IdDocumentRoute({List<_i36.PageRouteInfo>? children})
    : super(IdDocumentRoute.name, initialChildren: children);

  static const String name = 'IdDocumentRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i20.IdDocumentPage();
    },
  );
}

/// generated route for
/// [_i21.LoginPage]
class LoginRoute extends _i36.PageRouteInfo<void> {
  const LoginRoute({List<_i36.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i21.LoginPage();
    },
  );
}

/// generated route for
/// [_i22.ManagerPage]
class ManagerRoute extends _i36.PageRouteInfo<void> {
  const ManagerRoute({List<_i36.PageRouteInfo>? children})
    : super(ManagerRoute.name, initialChildren: children);

  static const String name = 'ManagerRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i22.ManagerPage();
    },
  );
}

/// generated route for
/// [_i23.MesAgentsPage]
class MesAgentsRoute extends _i36.PageRouteInfo<void> {
  const MesAgentsRoute({List<_i36.PageRouteInfo>? children})
    : super(MesAgentsRoute.name, initialChildren: children);

  static const String name = 'MesAgentsRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i23.MesAgentsPage();
    },
  );
}

/// generated route for
/// [_i24.MesBiensPage]
class MesBiensRoute extends _i36.PageRouteInfo<void> {
  const MesBiensRoute({List<_i36.PageRouteInfo>? children})
    : super(MesBiensRoute.name, initialChildren: children);

  static const String name = 'MesBiensRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i24.MesBiensPage();
    },
  );
}

/// generated route for
/// [_i25.PlansPage]
class PlansRoute extends _i36.PageRouteInfo<void> {
  const PlansRoute({List<_i36.PageRouteInfo>? children})
    : super(PlansRoute.name, initialChildren: children);

  static const String name = 'PlansRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i25.PlansPage();
    },
  );
}

/// generated route for
/// [_i26.ProMenuPage]
class ProMenuRoute extends _i36.PageRouteInfo<void> {
  const ProMenuRoute({List<_i36.PageRouteInfo>? children})
    : super(ProMenuRoute.name, initialChildren: children);

  static const String name = 'ProMenuRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i26.ProMenuPage();
    },
  );
}

/// generated route for
/// [_i27.ProShellPage]
class ProShellRoute extends _i36.PageRouteInfo<void> {
  const ProShellRoute({List<_i36.PageRouteInfo>? children})
    : super(ProShellRoute.name, initialChildren: children);

  static const String name = 'ProShellRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i27.ProShellPage();
    },
  );
}

/// generated route for
/// [_i28.RegisterPage]
class RegisterRoute extends _i36.PageRouteInfo<void> {
  const RegisterRoute({List<_i36.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i28.RegisterPage();
    },
  );
}

/// generated route for
/// [_i29.ResidenceDetailPage]
class ResidenceDetailRoute
    extends _i36.PageRouteInfo<ResidenceDetailRouteArgs> {
  ResidenceDetailRoute({
    _i37.Key? key,
    required String id,
    List<_i36.PageRouteInfo>? children,
  }) : super(
         ResidenceDetailRoute.name,
         args: ResidenceDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'ResidenceDetailRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResidenceDetailRouteArgs>();
      return _i29.ResidenceDetailPage(key: args.key, id: args.id);
    },
  );
}

class ResidenceDetailRouteArgs {
  const ResidenceDetailRouteArgs({this.key, required this.id});

  final _i37.Key? key;

  final String id;

  @override
  String toString() {
    return 'ResidenceDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i30.ResidencesListPage]
class ResidencesListRoute extends _i36.PageRouteInfo<void> {
  const ResidencesListRoute({List<_i36.PageRouteInfo>? children})
    : super(ResidencesListRoute.name, initialChildren: children);

  static const String name = 'ResidencesListRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i30.ResidencesListPage();
    },
  );
}

/// generated route for
/// [_i31.RoleGatePage]
class RoleGateRoute extends _i36.PageRouteInfo<void> {
  const RoleGateRoute({List<_i36.PageRouteInfo>? children})
    : super(RoleGateRoute.name, initialChildren: children);

  static const String name = 'RoleGateRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i31.RoleGatePage();
    },
  );
}

/// generated route for
/// [_i32.SettingsMenuPage]
class SettingsMenuRoute extends _i36.PageRouteInfo<void> {
  const SettingsMenuRoute({List<_i36.PageRouteInfo>? children})
    : super(SettingsMenuRoute.name, initialChildren: children);

  static const String name = 'SettingsMenuRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i32.SettingsMenuPage();
    },
  );
}

/// generated route for
/// [_i33.SettingsPage]
class SettingsRoute extends _i36.PageRouteInfo<void> {
  const SettingsRoute({List<_i36.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i33.SettingsPage();
    },
  );
}

/// generated route for
/// [_i34.SplashPage]
class SplashRoute extends _i36.PageRouteInfo<void> {
  const SplashRoute({List<_i36.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return _i36.WrappedRoute(child: const _i34.SplashPage());
    },
  );
}

/// generated route for
/// [_i35.SubscriptionPage]
class SubscriptionRoute extends _i36.PageRouteInfo<void> {
  const SubscriptionRoute({List<_i36.PageRouteInfo>? children})
    : super(SubscriptionRoute.name, initialChildren: children);

  static const String name = 'SubscriptionRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i35.SubscriptionPage();
    },
  );
}
