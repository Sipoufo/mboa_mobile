import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../features/kyc/logic/kyc_cubit.dart';
import '../../../features/profile/profile_types.dart';
import '../../../features/subscription/bloc/subscription_bloc.dart';

/// Hosts every authenticated route and the blocs scoped to a signed-in session.
///
/// Loading the profile and the KYC status here (rather than per screen) means
/// the home header, the KYC gate, the tier gating and the settings hub all read
/// one load each instead of one per screen.
///
/// [SubscriptionBloc] in particular is the single source of `AccessContext.tier`
/// — every RM-M14-02 decision in the app reads this instance. Both are get_it singletons, so the state survives tab switches.
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
        BlocProvider<SubscriptionBloc>.value(
          value: getIt<SubscriptionBloc>()
            ..add(const SubscriptionLoadRequested()),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
