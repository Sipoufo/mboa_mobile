// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i51;
import 'package:flutter/material.dart' as _i52;
import 'package:mboa_pro/app/router/role_gate_page.dart' as _i43;
import 'package:mboa_pro/app/router/wrappers/authenticated_wrapper.dart'
    as _i13;
import 'package:mboa_pro/features/agent/ui/agent_availability_page.dart' as _i3;
import 'package:mboa_pro/features/agent/ui/agent_profile_page.dart' as _i6;
import 'package:mboa_pro/features/agent/ui/agent_shell_page.dart' as _i7;
import 'package:mboa_pro/features/agent/ui/agent_zones_page.dart' as _i9;
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart' as _i55;
import 'package:mboa_pro/features/annonces/ui/annonce_detail_page.dart' as _i10;
import 'package:mboa_pro/features/annonces/ui/annonce_form_page.dart' as _i11;
import 'package:mboa_pro/features/annonces/ui/annonces_list_page.dart' as _i12;
import 'package:mboa_pro/features/annonces/ui/mes_biens_page.dart' as _i29;
import 'package:mboa_pro/features/annonces/ui/residence_detail_page.dart'
    as _i40;
import 'package:mboa_pro/features/annonces/ui/residences_list_page.dart'
    as _i41;
import 'package:mboa_pro/features/assignments/models/assignment.dart' as _i54;
import 'package:mboa_pro/features/assignments/ui/agent_assignment_page.dart'
    as _i2;
import 'package:mboa_pro/features/assignments/ui/agent_detail_page.dart' as _i4;
import 'package:mboa_pro/features/assignments/ui/agent_missions_page.dart'
    as _i5;
import 'package:mboa_pro/features/assignments/ui/mes_agents_page.dart' as _i28;
import 'package:mboa_pro/features/contracts/ui/contract_detail_page.dart'
    as _i17;
import 'package:mboa_pro/features/contracts/ui/contract_form_page.dart' as _i18;
import 'package:mboa_pro/features/contracts/ui/contracts_list_page.dart'
    as _i19;
import 'package:mboa_pro/features/contracts/ui/resident_reply_page.dart'
    as _i42;
import 'package:mboa_pro/features/home/ui/home_page.dart' as _i23;
import 'package:mboa_pro/features/kyc/ui/certifications_page.dart' as _i14;
import 'package:mboa_pro/features/kyc/ui/id_document_page.dart' as _i24;
import 'package:mboa_pro/features/login/ui/login_page.dart' as _i27;
import 'package:mboa_pro/features/messaging/ui/messages_page.dart' as _i30;
import 'package:mboa_pro/features/password_reset/ui/forgot_password_page.dart'
    as _i22;
import 'package:mboa_pro/features/profile/ui/change_password_page.dart' as _i15;
import 'package:mboa_pro/features/profile/ui/change_phone_page.dart' as _i16;
import 'package:mboa_pro/features/profile/ui/delete_account_page.dart' as _i20;
import 'package:mboa_pro/features/profile/ui/edit_profile_page.dart' as _i21;
import 'package:mboa_pro/features/profile/ui/notification_preferences_page.dart'
    as _i31;
import 'package:mboa_pro/features/profile/ui/settings_menu_page.dart' as _i44;
import 'package:mboa_pro/features/profile/ui/settings_page.dart' as _i45;
import 'package:mboa_pro/features/register/ui/register_page.dart' as _i38;
import 'package:mboa_pro/features/rents/ui/received_declaration_page.dart'
    as _i36;
import 'package:mboa_pro/features/rents/ui/rents_page.dart' as _i39;
import 'package:mboa_pro/features/rents/ui/tenant_home_page.dart' as _i48;
import 'package:mboa_pro/features/reservations/ui/incoming_reservation_page.dart'
    as _i25;
import 'package:mboa_pro/features/reservations/ui/incoming_reservations_page.dart'
    as _i26;
import 'package:mboa_pro/features/shell/ui/access_restricted_page.dart' as _i1;
import 'package:mboa_pro/features/shell/ui/pro_menu_page.dart' as _i34;
import 'package:mboa_pro/features/shell/ui/pro_shell_page.dart' as _i35;
import 'package:mboa_pro/features/splash/ui/splash_page.dart' as _i46;
import 'package:mboa_pro/features/subscription/ui/plans_page.dart' as _i32;
import 'package:mboa_pro/features/subscription/ui/subscription_page.dart'
    as _i47;
import 'package:mboa_pro/features/tenant_requests/ui/tenant_requests_pages.dart'
    as _i37;
import 'package:mboa_pro/features/visits/ui/agent_visits_page.dart' as _i8;
import 'package:mboa_pro/features/visits/ui/prestataire_visits_page.dart'
    as _i33;
import 'package:mboa_pro/features/visits/ui/visit_detail_page.dart' as _i49;
import 'package:mboa_pro/features/visits/ui/visit_review_page.dart' as _i50;
import 'package:mboa_shared/mboa_shared.dart' as _i53;

/// generated route for
/// [_i1.AccessRestrictedPage]
class AccessRestrictedRoute
    extends _i51.PageRouteInfo<AccessRestrictedRouteArgs> {
  AccessRestrictedRoute({
    _i52.Key? key,
    required _i53.AccessRestriction restriction,
    _i53.SubscriptionTier? requiredTier,
    List<_i51.PageRouteInfo>? children,
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

  static _i51.PageInfo page = _i51.PageInfo(
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

  final _i52.Key? key;

  final _i53.AccessRestriction restriction;

  final _i53.SubscriptionTier? requiredTier;

  @override
  String toString() {
    return 'AccessRestrictedRouteArgs{key: $key, restriction: $restriction, requiredTier: $requiredTier}';
  }
}

/// generated route for
/// [_i2.AgentAssignmentPage]
class AgentAssignmentRoute
    extends _i51.PageRouteInfo<AgentAssignmentRouteArgs> {
  AgentAssignmentRoute({
    _i52.Key? key,
    required _i54.AssignmentTarget target,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         AgentAssignmentRoute.name,
         args: AgentAssignmentRouteArgs(key: key, target: target),
         initialChildren: children,
       );

  static const String name = 'AgentAssignmentRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AgentAssignmentRouteArgs>();
      return _i51.WrappedRoute(
        child: _i2.AgentAssignmentPage(key: args.key, target: args.target),
      );
    },
  );
}

class AgentAssignmentRouteArgs {
  const AgentAssignmentRouteArgs({this.key, required this.target});

  final _i52.Key? key;

  final _i54.AssignmentTarget target;

  @override
  String toString() {
    return 'AgentAssignmentRouteArgs{key: $key, target: $target}';
  }
}

/// generated route for
/// [_i3.AgentAvailabilityPage]
class AgentAvailabilityRoute extends _i51.PageRouteInfo<void> {
  const AgentAvailabilityRoute({List<_i51.PageRouteInfo>? children})
    : super(AgentAvailabilityRoute.name, initialChildren: children);

  static const String name = 'AgentAvailabilityRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return _i51.WrappedRoute(child: const _i3.AgentAvailabilityPage());
    },
  );
}

/// generated route for
/// [_i4.AgentDetailPage]
class AgentDetailRoute extends _i51.PageRouteInfo<AgentDetailRouteArgs> {
  AgentDetailRoute({
    _i52.Key? key,
    required String agentAccountId,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         AgentDetailRoute.name,
         args: AgentDetailRouteArgs(key: key, agentAccountId: agentAccountId),
         initialChildren: children,
       );

  static const String name = 'AgentDetailRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AgentDetailRouteArgs>();
      return _i51.WrappedRoute(
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

  final _i52.Key? key;

  final String agentAccountId;

  @override
  String toString() {
    return 'AgentDetailRouteArgs{key: $key, agentAccountId: $agentAccountId}';
  }
}

/// generated route for
/// [_i5.AgentMissionsPage]
class AgentMissionsRoute extends _i51.PageRouteInfo<void> {
  const AgentMissionsRoute({List<_i51.PageRouteInfo>? children})
    : super(AgentMissionsRoute.name, initialChildren: children);

  static const String name = 'AgentMissionsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return _i51.WrappedRoute(child: const _i5.AgentMissionsPage());
    },
  );
}

/// generated route for
/// [_i6.AgentProfilePage]
class AgentProfileRoute extends _i51.PageRouteInfo<void> {
  const AgentProfileRoute({List<_i51.PageRouteInfo>? children})
    : super(AgentProfileRoute.name, initialChildren: children);

  static const String name = 'AgentProfileRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i6.AgentProfilePage();
    },
  );
}

/// generated route for
/// [_i7.AgentShellPage]
class AgentShellRoute extends _i51.PageRouteInfo<void> {
  const AgentShellRoute({List<_i51.PageRouteInfo>? children})
    : super(AgentShellRoute.name, initialChildren: children);

  static const String name = 'AgentShellRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i7.AgentShellPage();
    },
  );
}

/// generated route for
/// [_i8.AgentVisitsPage]
class AgentVisitsRoute extends _i51.PageRouteInfo<void> {
  const AgentVisitsRoute({List<_i51.PageRouteInfo>? children})
    : super(AgentVisitsRoute.name, initialChildren: children);

  static const String name = 'AgentVisitsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return _i51.WrappedRoute(child: const _i8.AgentVisitsPage());
    },
  );
}

/// generated route for
/// [_i9.AgentZonesPage]
class AgentZonesRoute extends _i51.PageRouteInfo<void> {
  const AgentZonesRoute({List<_i51.PageRouteInfo>? children})
    : super(AgentZonesRoute.name, initialChildren: children);

  static const String name = 'AgentZonesRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i9.AgentZonesPage();
    },
  );
}

/// generated route for
/// [_i10.AnnonceDetailPage]
class AnnonceDetailRoute extends _i51.PageRouteInfo<AnnonceDetailRouteArgs> {
  AnnonceDetailRoute({
    _i52.Key? key,
    required String id,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         AnnonceDetailRoute.name,
         args: AnnonceDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'AnnonceDetailRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnnonceDetailRouteArgs>();
      return _i10.AnnonceDetailPage(key: args.key, id: args.id);
    },
  );
}

class AnnonceDetailRouteArgs {
  const AnnonceDetailRouteArgs({this.key, required this.id});

  final _i52.Key? key;

  final String id;

  @override
  String toString() {
    return 'AnnonceDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i11.AnnonceFormPage]
class AnnonceFormRoute extends _i51.PageRouteInfo<AnnonceFormRouteArgs> {
  AnnonceFormRoute({
    _i52.Key? key,
    required _i55.AnnonceKind kind,
    String? annonceId,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         AnnonceFormRoute.name,
         args: AnnonceFormRouteArgs(key: key, kind: kind, annonceId: annonceId),
         initialChildren: children,
       );

  static const String name = 'AnnonceFormRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnnonceFormRouteArgs>();
      return _i51.WrappedRoute(
        child: _i11.AnnonceFormPage(
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

  final _i52.Key? key;

  final _i55.AnnonceKind kind;

  final String? annonceId;

  @override
  String toString() {
    return 'AnnonceFormRouteArgs{key: $key, kind: $kind, annonceId: $annonceId}';
  }
}

/// generated route for
/// [_i12.AnnoncesListPage]
class AnnoncesListRoute extends _i51.PageRouteInfo<void> {
  const AnnoncesListRoute({List<_i51.PageRouteInfo>? children})
    : super(AnnoncesListRoute.name, initialChildren: children);

  static const String name = 'AnnoncesListRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i12.AnnoncesListPage();
    },
  );
}

/// generated route for
/// [_i13.AuthenticatedWrapper]
class AuthenticatedRouter extends _i51.PageRouteInfo<void> {
  const AuthenticatedRouter({List<_i51.PageRouteInfo>? children})
    : super(AuthenticatedRouter.name, initialChildren: children);

  static const String name = 'AuthenticatedRouter';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return _i51.WrappedRoute(child: const _i13.AuthenticatedWrapper());
    },
  );
}

/// generated route for
/// [_i14.CertificationsPage]
class CertificationsRoute extends _i51.PageRouteInfo<CertificationsRouteArgs> {
  CertificationsRoute({
    _i52.Key? key,
    _i53.AccountRole accountRole = _i53.AccountRole.user,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         CertificationsRoute.name,
         args: CertificationsRouteArgs(key: key, accountRole: accountRole),
         initialChildren: children,
       );

  static const String name = 'CertificationsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CertificationsRouteArgs>(
        orElse: () => const CertificationsRouteArgs(),
      );
      return _i14.CertificationsPage(
        key: args.key,
        accountRole: args.accountRole,
      );
    },
  );
}

class CertificationsRouteArgs {
  const CertificationsRouteArgs({
    this.key,
    this.accountRole = _i53.AccountRole.user,
  });

  final _i52.Key? key;

  final _i53.AccountRole accountRole;

  @override
  String toString() {
    return 'CertificationsRouteArgs{key: $key, accountRole: $accountRole}';
  }
}

/// generated route for
/// [_i15.ChangePasswordPage]
class ChangePasswordRoute extends _i51.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i51.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i15.ChangePasswordPage();
    },
  );
}

/// generated route for
/// [_i16.ChangePhonePage]
class ChangePhoneRoute extends _i51.PageRouteInfo<void> {
  const ChangePhoneRoute({List<_i51.PageRouteInfo>? children})
    : super(ChangePhoneRoute.name, initialChildren: children);

  static const String name = 'ChangePhoneRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i16.ChangePhonePage();
    },
  );
}

/// generated route for
/// [_i17.ContractDetailPage]
class ContractDetailRoute extends _i51.PageRouteInfo<ContractDetailRouteArgs> {
  ContractDetailRoute({
    _i52.Key? key,
    required String id,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         ContractDetailRoute.name,
         args: ContractDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'ContractDetailRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ContractDetailRouteArgs>();
      return _i51.WrappedRoute(
        child: _i17.ContractDetailPage(key: args.key, id: args.id),
      );
    },
  );
}

class ContractDetailRouteArgs {
  const ContractDetailRouteArgs({this.key, required this.id});

  final _i52.Key? key;

  final String id;

  @override
  String toString() {
    return 'ContractDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i18.ContractFormPage]
class ContractFormRoute extends _i51.PageRouteInfo<ContractFormRouteArgs> {
  ContractFormRoute({
    _i52.Key? key,
    required String annonceId,
    String? contractId,
    _i53.Reservation? reservation,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         ContractFormRoute.name,
         args: ContractFormRouteArgs(
           key: key,
           annonceId: annonceId,
           contractId: contractId,
           reservation: reservation,
         ),
         initialChildren: children,
       );

  static const String name = 'ContractFormRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ContractFormRouteArgs>();
      return _i51.WrappedRoute(
        child: _i18.ContractFormPage(
          key: args.key,
          annonceId: args.annonceId,
          contractId: args.contractId,
          reservation: args.reservation,
        ),
      );
    },
  );
}

class ContractFormRouteArgs {
  const ContractFormRouteArgs({
    this.key,
    required this.annonceId,
    this.contractId,
    this.reservation,
  });

  final _i52.Key? key;

  final String annonceId;

  final String? contractId;

  final _i53.Reservation? reservation;

  @override
  String toString() {
    return 'ContractFormRouteArgs{key: $key, annonceId: $annonceId, contractId: $contractId, reservation: $reservation}';
  }
}

/// generated route for
/// [_i19.ContractsListPage]
class ContractsListRoute extends _i51.PageRouteInfo<void> {
  const ContractsListRoute({List<_i51.PageRouteInfo>? children})
    : super(ContractsListRoute.name, initialChildren: children);

  static const String name = 'ContractsListRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return _i51.WrappedRoute(child: const _i19.ContractsListPage());
    },
  );
}

/// generated route for
/// [_i20.DeleteAccountPage]
class DeleteAccountRoute extends _i51.PageRouteInfo<void> {
  const DeleteAccountRoute({List<_i51.PageRouteInfo>? children})
    : super(DeleteAccountRoute.name, initialChildren: children);

  static const String name = 'DeleteAccountRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i20.DeleteAccountPage();
    },
  );
}

/// generated route for
/// [_i21.EditProfilePage]
class EditProfileRoute extends _i51.PageRouteInfo<void> {
  const EditProfileRoute({List<_i51.PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i21.EditProfilePage();
    },
  );
}

/// generated route for
/// [_i22.ForgotPasswordPage]
class ForgotPasswordRoute extends _i51.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    _i52.Key? key,
    String? email,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         ForgotPasswordRoute.name,
         args: ForgotPasswordRouteArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'ForgotPasswordRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>(
        orElse: () => const ForgotPasswordRouteArgs(),
      );
      return _i51.WrappedRoute(
        child: _i22.ForgotPasswordPage(key: args.key, email: args.email),
      );
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key, this.email});

  final _i52.Key? key;

  final String? email;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i23.HomePage]
class HomeRoute extends _i51.PageRouteInfo<void> {
  const HomeRoute({List<_i51.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i23.HomePage();
    },
  );
}

/// generated route for
/// [_i24.IdDocumentPage]
class IdDocumentRoute extends _i51.PageRouteInfo<void> {
  const IdDocumentRoute({List<_i51.PageRouteInfo>? children})
    : super(IdDocumentRoute.name, initialChildren: children);

  static const String name = 'IdDocumentRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i24.IdDocumentPage();
    },
  );
}

/// generated route for
/// [_i25.IncomingReservationPage]
class IncomingReservationRoute
    extends _i51.PageRouteInfo<IncomingReservationRouteArgs> {
  IncomingReservationRoute({
    _i52.Key? key,
    required String id,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         IncomingReservationRoute.name,
         args: IncomingReservationRouteArgs(key: key, id: id),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'IncomingReservationRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<IncomingReservationRouteArgs>(
        orElse: () =>
            IncomingReservationRouteArgs(id: pathParams.getString('id')),
      );
      return _i51.WrappedRoute(
        child: _i25.IncomingReservationPage(key: args.key, id: args.id),
      );
    },
  );
}

class IncomingReservationRouteArgs {
  const IncomingReservationRouteArgs({this.key, required this.id});

  final _i52.Key? key;

  final String id;

  @override
  String toString() {
    return 'IncomingReservationRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i26.IncomingReservationsPage]
class IncomingReservationsRoute
    extends _i51.PageRouteInfo<IncomingReservationsRouteArgs> {
  IncomingReservationsRoute({
    _i52.Key? key,
    String? annonceId,
    String? annonceTitle,
    String? residenceId,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         IncomingReservationsRoute.name,
         args: IncomingReservationsRouteArgs(
           key: key,
           annonceId: annonceId,
           annonceTitle: annonceTitle,
           residenceId: residenceId,
         ),
         initialChildren: children,
       );

  static const String name = 'IncomingReservationsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<IncomingReservationsRouteArgs>(
        orElse: () => const IncomingReservationsRouteArgs(),
      );
      return _i51.WrappedRoute(
        child: _i26.IncomingReservationsPage(
          key: args.key,
          annonceId: args.annonceId,
          annonceTitle: args.annonceTitle,
          residenceId: args.residenceId,
        ),
      );
    },
  );
}

class IncomingReservationsRouteArgs {
  const IncomingReservationsRouteArgs({
    this.key,
    this.annonceId,
    this.annonceTitle,
    this.residenceId,
  });

  final _i52.Key? key;

  final String? annonceId;

  final String? annonceTitle;

  final String? residenceId;

  @override
  String toString() {
    return 'IncomingReservationsRouteArgs{key: $key, annonceId: $annonceId, annonceTitle: $annonceTitle, residenceId: $residenceId}';
  }
}

/// generated route for
/// [_i27.LoginPage]
class LoginRoute extends _i51.PageRouteInfo<void> {
  const LoginRoute({List<_i51.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i27.LoginPage();
    },
  );
}

/// generated route for
/// [_i28.MesAgentsPage]
class MesAgentsRoute extends _i51.PageRouteInfo<void> {
  const MesAgentsRoute({List<_i51.PageRouteInfo>? children})
    : super(MesAgentsRoute.name, initialChildren: children);

  static const String name = 'MesAgentsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i28.MesAgentsPage();
    },
  );
}

/// generated route for
/// [_i29.MesBiensPage]
class MesBiensRoute extends _i51.PageRouteInfo<void> {
  const MesBiensRoute({List<_i51.PageRouteInfo>? children})
    : super(MesBiensRoute.name, initialChildren: children);

  static const String name = 'MesBiensRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i29.MesBiensPage();
    },
  );
}

/// generated route for
/// [_i30.MessagesPage]
class MessagesRoute extends _i51.PageRouteInfo<void> {
  const MessagesRoute({List<_i51.PageRouteInfo>? children})
    : super(MessagesRoute.name, initialChildren: children);

  static const String name = 'MessagesRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return _i51.WrappedRoute(child: const _i30.MessagesPage());
    },
  );
}

/// generated route for
/// [_i31.NotificationPreferencesPage]
class NotificationPreferencesRoute extends _i51.PageRouteInfo<void> {
  const NotificationPreferencesRoute({List<_i51.PageRouteInfo>? children})
    : super(NotificationPreferencesRoute.name, initialChildren: children);

  static const String name = 'NotificationPreferencesRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i31.NotificationPreferencesPage();
    },
  );
}

/// generated route for
/// [_i32.PlansPage]
class PlansRoute extends _i51.PageRouteInfo<void> {
  const PlansRoute({List<_i51.PageRouteInfo>? children})
    : super(PlansRoute.name, initialChildren: children);

  static const String name = 'PlansRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i32.PlansPage();
    },
  );
}

/// generated route for
/// [_i33.PrestataireVisitsPage]
class PrestataireVisitsRoute extends _i51.PageRouteInfo<void> {
  const PrestataireVisitsRoute({List<_i51.PageRouteInfo>? children})
    : super(PrestataireVisitsRoute.name, initialChildren: children);

  static const String name = 'PrestataireVisitsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return _i51.WrappedRoute(child: const _i33.PrestataireVisitsPage());
    },
  );
}

/// generated route for
/// [_i34.ProMenuPage]
class ProMenuRoute extends _i51.PageRouteInfo<void> {
  const ProMenuRoute({List<_i51.PageRouteInfo>? children})
    : super(ProMenuRoute.name, initialChildren: children);

  static const String name = 'ProMenuRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i34.ProMenuPage();
    },
  );
}

/// generated route for
/// [_i35.ProShellPage]
class ProShellRoute extends _i51.PageRouteInfo<void> {
  const ProShellRoute({List<_i51.PageRouteInfo>? children})
    : super(ProShellRoute.name, initialChildren: children);

  static const String name = 'ProShellRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i35.ProShellPage();
    },
  );
}

/// generated route for
/// [_i36.ReceivedDeclarationPage]
class ReceivedDeclarationRoute
    extends _i51.PageRouteInfo<ReceivedDeclarationRouteArgs> {
  ReceivedDeclarationRoute({
    _i52.Key? key,
    required String declarationId,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         ReceivedDeclarationRoute.name,
         args: ReceivedDeclarationRouteArgs(
           key: key,
           declarationId: declarationId,
         ),
         rawPathParams: {'declarationId': declarationId},
         initialChildren: children,
       );

  static const String name = 'ReceivedDeclarationRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ReceivedDeclarationRouteArgs>(
        orElse: () => ReceivedDeclarationRouteArgs(
          declarationId: pathParams.getString('declarationId'),
        ),
      );
      return _i51.WrappedRoute(
        child: _i36.ReceivedDeclarationPage(
          key: args.key,
          declarationId: args.declarationId,
        ),
      );
    },
  );
}

class ReceivedDeclarationRouteArgs {
  const ReceivedDeclarationRouteArgs({this.key, required this.declarationId});

  final _i52.Key? key;

  final String declarationId;

  @override
  String toString() {
    return 'ReceivedDeclarationRouteArgs{key: $key, declarationId: $declarationId}';
  }
}

/// generated route for
/// [_i37.ReceivedRequestsPage]
class ReceivedRequestsRoute extends _i51.PageRouteInfo<void> {
  const ReceivedRequestsRoute({List<_i51.PageRouteInfo>? children})
    : super(ReceivedRequestsRoute.name, initialChildren: children);

  static const String name = 'ReceivedRequestsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return _i51.WrappedRoute(child: const _i37.ReceivedRequestsPage());
    },
  );
}

/// generated route for
/// [_i38.RegisterPage]
class RegisterRoute extends _i51.PageRouteInfo<void> {
  const RegisterRoute({List<_i51.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i38.RegisterPage();
    },
  );
}

/// generated route for
/// [_i39.RentsPage]
class RentsRoute extends _i51.PageRouteInfo<RentsRouteArgs> {
  RentsRoute({
    _i52.Key? key,
    String? annonceId,
    String? annonceTitle,
    String? residenceId,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         RentsRoute.name,
         args: RentsRouteArgs(
           key: key,
           annonceId: annonceId,
           annonceTitle: annonceTitle,
           residenceId: residenceId,
         ),
         initialChildren: children,
       );

  static const String name = 'RentsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RentsRouteArgs>(
        orElse: () => const RentsRouteArgs(),
      );
      return _i51.WrappedRoute(
        child: _i39.RentsPage(
          key: args.key,
          annonceId: args.annonceId,
          annonceTitle: args.annonceTitle,
          residenceId: args.residenceId,
        ),
      );
    },
  );
}

class RentsRouteArgs {
  const RentsRouteArgs({
    this.key,
    this.annonceId,
    this.annonceTitle,
    this.residenceId,
  });

  final _i52.Key? key;

  final String? annonceId;

  final String? annonceTitle;

  final String? residenceId;

  @override
  String toString() {
    return 'RentsRouteArgs{key: $key, annonceId: $annonceId, annonceTitle: $annonceTitle, residenceId: $residenceId}';
  }
}

/// generated route for
/// [_i40.ResidenceDetailPage]
class ResidenceDetailRoute
    extends _i51.PageRouteInfo<ResidenceDetailRouteArgs> {
  ResidenceDetailRoute({
    _i52.Key? key,
    required String id,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         ResidenceDetailRoute.name,
         args: ResidenceDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'ResidenceDetailRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResidenceDetailRouteArgs>();
      return _i40.ResidenceDetailPage(key: args.key, id: args.id);
    },
  );
}

class ResidenceDetailRouteArgs {
  const ResidenceDetailRouteArgs({this.key, required this.id});

  final _i52.Key? key;

  final String id;

  @override
  String toString() {
    return 'ResidenceDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i41.ResidencesListPage]
class ResidencesListRoute extends _i51.PageRouteInfo<void> {
  const ResidencesListRoute({List<_i51.PageRouteInfo>? children})
    : super(ResidencesListRoute.name, initialChildren: children);

  static const String name = 'ResidencesListRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i41.ResidencesListPage();
    },
  );
}

/// generated route for
/// [_i42.ResidentReplyPage]
class ResidentReplyRoute extends _i51.PageRouteInfo<ResidentReplyRouteArgs> {
  ResidentReplyRoute({
    _i52.Key? key,
    required String contractId,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         ResidentReplyRoute.name,
         args: ResidentReplyRouteArgs(key: key, contractId: contractId),
         initialChildren: children,
       );

  static const String name = 'ResidentReplyRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResidentReplyRouteArgs>();
      return _i51.WrappedRoute(
        child: _i42.ResidentReplyPage(
          key: args.key,
          contractId: args.contractId,
        ),
      );
    },
  );
}

class ResidentReplyRouteArgs {
  const ResidentReplyRouteArgs({this.key, required this.contractId});

  final _i52.Key? key;

  final String contractId;

  @override
  String toString() {
    return 'ResidentReplyRouteArgs{key: $key, contractId: $contractId}';
  }
}

/// generated route for
/// [_i43.RoleGatePage]
class RoleGateRoute extends _i51.PageRouteInfo<void> {
  const RoleGateRoute({List<_i51.PageRouteInfo>? children})
    : super(RoleGateRoute.name, initialChildren: children);

  static const String name = 'RoleGateRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i43.RoleGatePage();
    },
  );
}

/// generated route for
/// [_i44.SettingsMenuPage]
class SettingsMenuRoute extends _i51.PageRouteInfo<void> {
  const SettingsMenuRoute({List<_i51.PageRouteInfo>? children})
    : super(SettingsMenuRoute.name, initialChildren: children);

  static const String name = 'SettingsMenuRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i44.SettingsMenuPage();
    },
  );
}

/// generated route for
/// [_i45.SettingsPage]
class SettingsRoute extends _i51.PageRouteInfo<void> {
  const SettingsRoute({List<_i51.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i45.SettingsPage();
    },
  );
}

/// generated route for
/// [_i46.SplashPage]
class SplashRoute extends _i51.PageRouteInfo<void> {
  const SplashRoute({List<_i51.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return _i51.WrappedRoute(child: const _i46.SplashPage());
    },
  );
}

/// generated route for
/// [_i47.SubscriptionPage]
class SubscriptionRoute extends _i51.PageRouteInfo<void> {
  const SubscriptionRoute({List<_i51.PageRouteInfo>? children})
    : super(SubscriptionRoute.name, initialChildren: children);

  static const String name = 'SubscriptionRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i47.SubscriptionPage();
    },
  );
}

/// generated route for
/// [_i48.TenantHomePage]
class TenantHomeRoute extends _i51.PageRouteInfo<TenantHomeRouteArgs> {
  TenantHomeRoute({
    _i52.Key? key,
    required String contractId,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         TenantHomeRoute.name,
         args: TenantHomeRouteArgs(key: key, contractId: contractId),
         rawPathParams: {'contractId': contractId},
         initialChildren: children,
       );

  static const String name = 'TenantHomeRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TenantHomeRouteArgs>(
        orElse: () =>
            TenantHomeRouteArgs(contractId: pathParams.getString('contractId')),
      );
      return _i51.WrappedRoute(
        child: _i48.TenantHomePage(key: args.key, contractId: args.contractId),
      );
    },
  );
}

class TenantHomeRouteArgs {
  const TenantHomeRouteArgs({this.key, required this.contractId});

  final _i52.Key? key;

  final String contractId;

  @override
  String toString() {
    return 'TenantHomeRouteArgs{key: $key, contractId: $contractId}';
  }
}

/// generated route for
/// [_i37.TenantHomeRequestsPage]
class TenantHomeRequestsRoute
    extends _i51.PageRouteInfo<TenantHomeRequestsRouteArgs> {
  TenantHomeRequestsRoute({
    _i52.Key? key,
    required String contractId,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         TenantHomeRequestsRoute.name,
         args: TenantHomeRequestsRouteArgs(key: key, contractId: contractId),
         rawPathParams: {'contractId': contractId},
         initialChildren: children,
       );

  static const String name = 'TenantHomeRequestsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TenantHomeRequestsRouteArgs>(
        orElse: () => TenantHomeRequestsRouteArgs(
          contractId: pathParams.getString('contractId'),
        ),
      );
      return _i51.WrappedRoute(
        child: _i37.TenantHomeRequestsPage(
          key: args.key,
          contractId: args.contractId,
        ),
      );
    },
  );
}

class TenantHomeRequestsRouteArgs {
  const TenantHomeRequestsRouteArgs({this.key, required this.contractId});

  final _i52.Key? key;

  final String contractId;

  @override
  String toString() {
    return 'TenantHomeRequestsRouteArgs{key: $key, contractId: $contractId}';
  }
}

/// generated route for
/// [_i37.TenantRequestPage]
class TenantRequestRoute extends _i51.PageRouteInfo<TenantRequestRouteArgs> {
  TenantRequestRoute({
    _i52.Key? key,
    required String requestId,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         TenantRequestRoute.name,
         args: TenantRequestRouteArgs(key: key, requestId: requestId),
         rawPathParams: {'requestId': requestId},
         initialChildren: children,
       );

  static const String name = 'TenantRequestRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TenantRequestRouteArgs>(
        orElse: () => TenantRequestRouteArgs(
          requestId: pathParams.getString('requestId'),
        ),
      );
      return _i51.WrappedRoute(
        child: _i37.TenantRequestPage(key: args.key, requestId: args.requestId),
      );
    },
  );
}

class TenantRequestRouteArgs {
  const TenantRequestRouteArgs({this.key, required this.requestId});

  final _i52.Key? key;

  final String requestId;

  @override
  String toString() {
    return 'TenantRequestRouteArgs{key: $key, requestId: $requestId}';
  }
}

/// generated route for
/// [_i30.ThreadPage]
class ThreadRoute extends _i51.PageRouteInfo<ThreadRouteArgs> {
  ThreadRoute({
    _i52.Key? key,
    required _i53.Conversation conversation,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         ThreadRoute.name,
         args: ThreadRouteArgs(key: key, conversation: conversation),
         initialChildren: children,
       );

  static const String name = 'ThreadRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ThreadRouteArgs>();
      return _i51.WrappedRoute(
        child: _i30.ThreadPage(key: args.key, conversation: args.conversation),
      );
    },
  );
}

class ThreadRouteArgs {
  const ThreadRouteArgs({this.key, required this.conversation});

  final _i52.Key? key;

  final _i53.Conversation conversation;

  @override
  String toString() {
    return 'ThreadRouteArgs{key: $key, conversation: $conversation}';
  }
}

/// generated route for
/// [_i49.VisitDetailPage]
class VisitDetailRoute extends _i51.PageRouteInfo<VisitDetailRouteArgs> {
  VisitDetailRoute({
    _i52.Key? key,
    required String id,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         VisitDetailRoute.name,
         args: VisitDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'VisitDetailRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VisitDetailRouteArgs>();
      return _i51.WrappedRoute(
        child: _i49.VisitDetailPage(key: args.key, id: args.id),
      );
    },
  );
}

class VisitDetailRouteArgs {
  const VisitDetailRouteArgs({this.key, required this.id});

  final _i52.Key? key;

  final String id;

  @override
  String toString() {
    return 'VisitDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i50.VisitReviewPage]
class VisitReviewRoute extends _i51.PageRouteInfo<VisitReviewRouteArgs> {
  VisitReviewRoute({
    _i52.Key? key,
    required String id,
    String? propertyTitle,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         VisitReviewRoute.name,
         args: VisitReviewRouteArgs(
           key: key,
           id: id,
           propertyTitle: propertyTitle,
         ),
         initialChildren: children,
       );

  static const String name = 'VisitReviewRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VisitReviewRouteArgs>();
      return _i51.WrappedRoute(
        child: _i50.VisitReviewPage(
          key: args.key,
          id: args.id,
          propertyTitle: args.propertyTitle,
        ),
      );
    },
  );
}

class VisitReviewRouteArgs {
  const VisitReviewRouteArgs({this.key, required this.id, this.propertyTitle});

  final _i52.Key? key;

  final String id;

  final String? propertyTitle;

  @override
  String toString() {
    return 'VisitReviewRouteArgs{key: $key, id: $id, propertyTitle: $propertyTitle}';
  }
}
