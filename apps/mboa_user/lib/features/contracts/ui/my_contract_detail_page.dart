import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

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

  @override
  Widget build(BuildContext context) =>
      ContractDetailView(id: id, viewer: ContractParty.tenant);
}
