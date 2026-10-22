import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/open_requests_bloc.dart';

/// Back from a request: what it changed shows on the home's counter.
void _countAgain() {
  if (getIt.isRegistered<OpenRequestsBloc>()) getIt<OpenRequestsBloc>().add(const OpenRequestsRequested());
}

/// The landlord's inbox of tenants' requests (CDC M30, RM-M30-09): what
/// still waits on him across his homes — sent, seen, in progress. No add-on
/// (RM-M30-15).
@RoutePage()
class ReceivedRequestsPage extends StatelessWidget implements AutoRouteWrapper {
  const ReceivedRequestsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<HomeRequestsBloc>(
        create: (_) => getIt<HomeRequestsBloc>()..add(const HomeRequestsRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => HomeRequestsView(
        showTenant: true,
        onOpen: (request) async {
          final bloc = context.read<HomeRequestsBloc>();
          await context.router.push(TenantRequestRoute(requestId: request.id));
          bloc.add(const HomeRequestsRequested());
          _countAgain();
        },
      );
}

/// One tenancy's requests, from its space — every status.
@RoutePage()
class TenantHomeRequestsPage extends StatelessWidget implements AutoRouteWrapper {
  const TenantHomeRequestsPage({super.key, @PathParam('contractId') required this.contractId});

  final String contractId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<HomeRequestsBloc>(
        create: (_) => getIt<HomeRequestsBloc>(param1: contractId)..add(const HomeRequestsRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => HomeRequestsView(
        onOpen: (request) async {
          final bloc = context.read<HomeRequestsBloc>();
          await context.router.push(TenantRequestRoute(requestId: request.id));
          bloc.add(const HomeRequestsRequested());
          _countAgain();
        },
      );
}

/// One request, the landlord's side — what N-38 opens; his first look marks
/// it seen. « Prendre en charge », then « Marquer résolue ».
@RoutePage()
class TenantRequestPage extends StatelessWidget implements AutoRouteWrapper {
  const TenantRequestPage({super.key, @PathParam('requestId') required this.requestId});

  final String requestId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<HomeRequestBloc>(
        create: (_) => getIt<HomeRequestBloc>()..add(HomeRequestOpened(requestId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const HomeRequestView();
}
