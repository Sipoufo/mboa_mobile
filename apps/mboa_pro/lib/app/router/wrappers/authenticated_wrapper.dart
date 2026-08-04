import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../features/kyc/logic/kyc_cubit.dart';
import '../../../features/profile/profile_types.dart';

/// Hosts every authenticated route and the blocs scoped to a signed-in session.
///
/// Loading the profile and the KYC status here (rather than per screen) means
/// the home header, the KYC gate and the settings hub all read one load instead
/// of three. Both are get_it singletons, so the state survives tab switches.
@RoutePage(name: 'AuthenticatedRouter')
class AuthenticatedWrapper extends StatelessWidget implements AutoRouteWrapper {
  const AuthenticatedWrapper({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProProfileBloc>.value(
          value: getIt<ProProfileBloc>()..add(const ProfileLoadRequested()),
        ),
        BlocProvider<KycCubit>.value(value: getIt<KycCubit>()..load()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
