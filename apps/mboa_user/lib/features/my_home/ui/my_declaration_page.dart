import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// One declared payment, the tenant's side — the shared view; the answer
/// is the landlord's, so no action is offered here.
@RoutePage()
class MyDeclarationPage extends StatelessWidget implements AutoRouteWrapper {
  const MyDeclarationPage({
    super.key,
    @PathParam('contractId') required this.contractId,
    @PathParam('declarationId') required this.declarationId,
  });

  final String contractId;
  final String declarationId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<DeclarationBloc>(
        create: (_) => getIt<DeclarationBloc>()..add(DeclarationRequested(id: declarationId, contractId: contractId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => DeclarationView(
        onDispute: (declaration) => showReportSheet(context, target: ReportTarget.declaration(declaration.id), cubit: getIt<ReportCubit>()),
      );
}
