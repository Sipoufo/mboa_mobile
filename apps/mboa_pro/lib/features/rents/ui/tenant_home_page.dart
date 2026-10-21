import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../app/router/app_router.gr.dart';

/// A tenant's space, the landlord's side (CDC M30) — the same space the
/// tenant reads, without "Déclarer": declaring is the tenant's. A declaration
/// opens where it is answered.
@RoutePage()
class TenantHomePage extends StatelessWidget implements AutoRouteWrapper {
  const TenantHomePage({super.key, @PathParam('contractId') required this.contractId});

  final String contractId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<HomeSpaceBloc>(
        create: (_) => getIt<HomeSpaceBloc>()..add(HomeSpaceRequested(contractId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => HomeSpaceView(
        onOpenDeclaration: (declaration) async {
          final space = context.read<HomeSpaceBloc>();
          await context.router.push(ReceivedDeclarationRoute(declarationId: declaration.id));
          // An answer given there shows here: statuses and totals.
          space.add(HomeSpaceRequested(contractId));
        },
      );
}
