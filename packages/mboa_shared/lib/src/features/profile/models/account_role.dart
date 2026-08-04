import 'package:mboa_core/mboa_core.dart';

/// The account's role. Domain enum so the UI/bloc never touch the generated API
/// enum — mapped from `/me`.
enum AccountRole {
  prestataire,
  agent,
  admin,
  user;

  static AccountRole fromResponse(MeResponseRoleEnum? value) => switch (value) {
        MeResponseRoleEnum.PRESTATAIRE => AccountRole.prestataire,
        MeResponseRoleEnum.AGENT => AccountRole.agent,
        MeResponseRoleEnum.ADMIN => AccountRole.admin,
        _ => AccountRole.user,
      };

  bool get isPrestataire => this == AccountRole.prestataire;
  bool get isAgent => this == AccountRole.agent;
}
