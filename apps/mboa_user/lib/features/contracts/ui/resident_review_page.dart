import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// The tenant's review of a tenancy (CDC M27) — the shared view, routed here.
///
/// Only the tenant app mounts it: the landlord answers a review (RM-M27-03)
/// but never writes one.
@RoutePage()
class ResidentReviewPage extends StatelessWidget implements AutoRouteWrapper {
  const ResidentReviewPage({super.key, required this.contractId});

  final String contractId;

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider<ResidentReviewBloc>(
        create: (_) => getIt<ResidentReviewBloc>()
          ..add(ResidentReviewOpened(contractId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) =>
      ResidentReviewView(contractId: contractId);
}
