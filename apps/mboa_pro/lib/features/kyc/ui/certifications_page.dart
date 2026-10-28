import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../app/router/app_router.gr.dart';
import '../../profile/models/prestataire_type.dart';
import '../../profile/profile_types.dart';

/// Route adapter for the Certifications (KYC) screen. Shares the singleton
/// [KycCubit] so the ID-document screen sees the same capture draft.
@RoutePage()
class CertificationsPage extends StatelessWidget {
  const CertificationsPage({super.key, this.accountRole = AccountRole.user});

  final AccountRole accountRole;

  @override
  Widget build(BuildContext context) {
    // RM-M01bis-10 — an agence or a promoteur owes a NUI; the profile says
    // which they are.
    final profile = getIt.isRegistered<ProProfileBloc>() ? getIt<ProProfileBloc>().state : null;
    final type = profile is ProProfileReady ? profile.data.type : null;

    return BlocProvider<KycCubit>.value(
      value: getIt<KycCubit>()..load(),
      child: CertificationsView(
        accountRole: accountRole,
        onOpenIdDocument: () => context.router.push(const IdDocumentRoute()),
        // §37 B — the NUI and the address are a prestataire's and an agent's.
        withDeclarations: true,
        nuiRequired: type == PrestataireType.agence || type == PrestataireType.promoteur,
      ),
    );
  }
}
