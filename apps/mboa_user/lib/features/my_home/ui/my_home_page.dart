import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/my_homes_bloc.dart';
import '../models/declaration_form.dart';

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

  /// Declared: the space and the list are read again (statuses, totals).
  Future<void> _declare(BuildContext context, DeclarationForm form) async {
    final space = context.read<HomeSpaceBloc>();
    final sent = await context.router.push<bool>(DeclarePaymentRoute(contractId: contractId, form: form));
    if (sent ?? false) {
      space.add(HomeSpaceRequested(contractId));
      getIt<MyHomesBloc>().add(const MyHomesRequested());
    }
  }

  @override
  Widget build(BuildContext context) => HomeSpaceView(
        onDeclare: (state, due) => _declare(
          context,
          DeclarationForm.rent(state.schedule.dues, preselected: due, today: DateTime.now()),
        ),
        onDeclareDeposit: (state) => _declare(context, DeclarationForm.deposit(state.home.deposit, today: DateTime.now())),
        onOpenDeclaration: (declaration) => context.router.push(
          MyDeclarationRoute(contractId: contractId, declarationId: declaration.id),
        ),
      );
}
