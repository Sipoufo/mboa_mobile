import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../app/router/app_router.gr.dart';

/// A tenancy's photo proofs, the landlord's side (CDC M30 lot 3,
/// RM-M30-11/12) — what N-39 opens: read only, nothing to send.
@RoutePage()
class TenantEvidencePage extends StatelessWidget implements AutoRouteWrapper {
  const TenantEvidencePage({super.key, @PathParam('contractId') required this.contractId});

  final String contractId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<EvidenceBloc>(
        create: (_) => getIt<EvidenceBloc>(param1: contractId)..add(const EvidenceRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => EvidenceView(
        onOpen: (batch) async {
          final bloc = context.read<EvidenceBloc>();
          await context.router.push(TenantEvidenceBatchRoute(contractId: contractId, batchId: batch.id));
          // Acknowledged there: said here on the way back.
          bloc.add(const EvidenceRequested());
        },
        onCompare: () => context.router.push(TenantEvidenceCompareRoute(contractId: contractId)),
      );
}

/// Before / after (CA-M31-04) — the shared view.
@RoutePage()
class TenantEvidenceComparePage extends StatelessWidget implements AutoRouteWrapper {
  const TenantEvidenceComparePage({super.key, @PathParam('contractId') required this.contractId});

  final String contractId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<EvidenceCompareBloc>(
        create: (_) => getIt<EvidenceCompareBloc>()..add(EvidenceCompareRequested(contractId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const EvidenceCompareView();
}

/// One sending — « Accuser réception », once, with a word for the tenant.
@RoutePage()
class TenantEvidenceBatchPage extends StatelessWidget implements AutoRouteWrapper {
  const TenantEvidenceBatchPage({
    super.key,
    @PathParam('contractId') required this.contractId,
    @PathParam('batchId') required this.batchId,
  });

  final String contractId;
  final String batchId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<EvidenceBatchBloc>(
        create: (_) => getIt<EvidenceBatchBloc>()..add(EvidenceBatchOpened(contractId: contractId, batchId: batchId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => EvidenceBatchView(
        onDispute: (batch) => showReportSheet(context, target: ReportTarget.evidence(batch.id), cubit: getIt<ReportCubit>()),
      );
}
