import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// One space of "Mon Logement", the tenant's side (CDC M30) — the shared
/// view, with the tenant's own action: declaring a payment made outside Mboa.
@RoutePage()
class MyHomePage extends StatelessWidget implements AutoRouteWrapper {
  const MyHomePage({super.key, @PathParam('contractId') required this.contractId});

  final String contractId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<HomeSpaceBloc>(
        create: (_) => getIt<HomeSpaceBloc>()..add(HomeSpaceRequested(contractId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const HomeSpaceView();
}
