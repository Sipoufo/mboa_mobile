import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../app/router/app_router.gr.dart';

/// One Contrat Mboa from the tenant's side (CDC M08) — the shared view.
///
/// No `onAmend`: redrafting the terms is the landlord's (RM-M08-01/08), so the
/// button is absent here rather than present and refused. What the tenant does
/// instead — accept, or contest with an objection — is in the shared action
/// bar, offered on the server's own `status` and `awaiting`.
@RoutePage()
class MyContractDetailPage extends StatelessWidget implements AutoRouteWrapper {
  const MyContractDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider<ContractDetailBloc>(
        create: (_) => getIt<ContractDetailBloc>()..add(ContractRequested(id)),
        child: this,
      );

  /// §39 D / §40 F — what the KYC knows of the document starts the identity
  /// form at signing; an approved KYC without it is told how to add it.
  @override
  Widget build(BuildContext context) => BlocProvider<KycCubit>.value(
        value: getIt<KycCubit>(),
        child: BlocBuilder<KycCubit, KycState>(
          builder: (context, kyc) {
            final status = kyc is KycReady ? kyc.status : null;
            return ContractDetailView(
              id: id,
              viewer: ContractParty.tenant,
              identityPrefill: status?.identity,
              documentMissing: status?.canAddDocument ?? false,
              onReview: (contract) => context.router.push(ResidentReviewRoute(contractId: contract.id)),
            );
          },
        ),
      );
}
