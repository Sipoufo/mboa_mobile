import 'package:mboa_core/mboa_core.dart';

/// The professional roles a Pro account can register as. A domain enum so the
/// UI and bloc never touch the generated API enum — the repository maps it.
enum ProfessionalRole {
  prestataire,
  agent;

  /// Maps to the generated request enum used by `register/professional`.
  RegisterProfessionalRequestRoleEnum get apiValue => switch (this) {
        ProfessionalRole.prestataire => RegisterProfessionalRequestRoleEnum.PRESTATAIRE,
        ProfessionalRole.agent => RegisterProfessionalRequestRoleEnum.AGENT,
      };
}
