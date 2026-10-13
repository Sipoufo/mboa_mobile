import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// The landlord reading his tenant's review and answering it (CDC M27) —
/// the shared view, routed here.
///
/// Only the pro app mounts it: writing a resident review is the tenant's
/// (RM-M27-01), answering it is his (RM-M27-03).
@RoutePage()
class ResidentReplyPage extends StatelessWidget implements AutoRouteWrapper {
  const ResidentReplyPage({super.key, required this.contractId});

  final String contractId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ResidentReplyBloc>(
        create: (_) =>
            getIt<ResidentReplyBloc>()..add(ResidentReplyOpened(contractId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) =>
      ResidentReplyView(contractId: contractId);
}
