import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../features/profile/profile_types.dart';

/// Hosts every authenticated route and the blocs scoped to a signed-in session.
///
/// App Mboa has no tab shell yet — the wrapper exists so both apps share one
/// routing model, and so the tab shell can slot in here later without moving
/// the rest of the table.
@RoutePage(name: 'AuthenticatedRouter')
class AuthenticatedWrapper extends StatelessWidget implements AutoRouteWrapper {
  const AuthenticatedWrapper({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<UserProfileBloc>.value(
      value: getIt<UserProfileBloc>()..add(const ProfileLoadRequested()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
