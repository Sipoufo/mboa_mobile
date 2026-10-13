import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../app/router/app_router.gr.dart';

/// One Contrat Mboa from the prestataire's side (CDC M08) — the shared view,
/// plus the one action that is his alone: redrafting the terms (RM-M08-08).
@RoutePage()
class ContractDetailPage extends StatelessWidget implements AutoRouteWrapper {
  const ContractDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider<ContractDetailBloc>(
        create: (_) => getIt<ContractDetailBloc>()..add(ContractRequested(id)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => ContractDetailView(
        id: id,
        viewer: ContractParty.prestataire,
        onReview: (contract) =>
            context.router.push(ResidentReplyRoute(contractId: contract.id)),
        onAmend: (contract) => context.router.push(
          ContractFormRoute(
            annonceId: contract.annonceId ?? '',
            contractId: contract.id,
          ),
        ),
      );
}
