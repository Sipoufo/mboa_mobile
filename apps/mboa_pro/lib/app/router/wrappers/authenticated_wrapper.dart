import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../features/agent/bloc/agent_profile_bloc.dart';
import '../../../features/assignments/bloc/my_agents_bloc.dart';
import '../../../features/annonces/bloc/annonces_bloc.dart';
import '../../../features/annonces/bloc/residences_bloc.dart';
import '../../../features/home/bloc/home_bloc.dart';
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
        BlocProvider<HomeBloc>.value(
          value: getIt<HomeBloc>()..add(const HomeLoadRequested()),
        ),
        // Provided but deliberately not loaded here: the list screens fetch on
        // open, so a session that never visits Mes biens costs no requests.
        BlocProvider<AnnoncesBloc>.value(value: getIt<AnnoncesBloc>()),
        BlocProvider<ResidencesBloc>.value(value: getIt<ResidencesBloc>()),
        // The agent's own profile. Provided here rather than inside the agent
        // shell so the zones screen — pushed as a sibling of the shell, not a
        // child — can read it; a bloc provided by one route is invisible to its
        // siblings, which has bitten this app twice. Loaded by the agent
        // profile screen, so a prestataire session never calls /agents/me.
        BlocProvider<AgentProfileBloc>.value(value: getIt<AgentProfileBloc>()),
        // Read by Mes agents and by the agent detail, which are siblings under
        // `/app` — so it cannot live on either one's route.
        BlocProvider<MyAgentsBloc>.value(value: getIt<MyAgentsBloc>()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
