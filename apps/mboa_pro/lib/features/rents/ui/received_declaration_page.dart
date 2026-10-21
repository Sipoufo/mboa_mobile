import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../bloc/waiting_declarations_bloc.dart';

/// One declared payment, the landlord's side (CDC M30) — what N-35 opens.
/// The shared view, read from his inbox; confirm and contest appear where the
/// server allows them (RM-M30-04).
@RoutePage()
class ReceivedDeclarationPage extends StatelessWidget implements AutoRouteWrapper {
  const ReceivedDeclarationPage({super.key, @PathParam('declarationId') required this.declarationId});

  final String declarationId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<DeclarationBloc>(
        create: (_) => getIt<DeclarationBloc>()..add(DeclarationRequested(id: declarationId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => DeclarationView(
        // Answered: one fewer on the home's counter.
        onAnswered: () {
          if (getIt.isRegistered<WaitingDeclarationsBloc>()) {
            getIt<WaitingDeclarationsBloc>().add(const WaitingDeclarationsRequested());
          }
        },
      );
}
