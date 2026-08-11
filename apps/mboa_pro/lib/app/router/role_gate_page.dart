import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../features/profile/profile_types.dart';
import 'app_router.gr.dart';

/// What the gate should do, given everything it knows.
///
/// Pulled out of the widget so the rule can be tested without a router: it is
/// the part that was wrong, not the navigation.
@visibleForTesting
enum RoleGateDecision {
  /// Open the agent shell.
  agent,

  /// Open the prestataire shell.
  prestataire,

  /// Nothing knows the role yet. Wait — guessing is what showed an agent the
  /// prestataire dashboard.
  wait,

  /// The profile could not be loaded. Ask, rather than spin forever.
  askAgain,
}

/// [knownRole] comes from the startup `/me`; [profileState] is the fallback for
/// a fresh sign-in, where the login response carried no role.
@visibleForTesting
RoleGateDecision roleGateDecisionFor({
  required AccountRole? knownRole,
  required ProfileState profileState,
}) {
  if (knownRole != null) {
    return knownRole.isAgent
        ? RoleGateDecision.agent
        : RoleGateDecision.prestataire;
  }
  return switch (profileState) {
    // Read from the *current* state: a second sign-in emits nothing at all,
    // because ProfileBloc skips LoadInProgress when it already holds data and
    // drops an equal ProfileReady as a duplicate.
    ProProfileReady(:final data) => data.role.isAgent
        ? RoleGateDecision.agent
        : RoleGateDecision.prestataire,
    ProfileLoadFailure() => RoleGateDecision.askAgain,
    _ => RoleGateDecision.wait,
  };
}

/// What `/app` opens on, before either persona's shell.
///
/// App Mboa Pro serves two people whose apps have nothing in common, and the
/// role is not in the login response — only `/me` reports it. Opening on the
/// prestataire shell and correcting a beat later showed an agent someone
/// else's dashboard.
///
/// It decides from the **current** state, not only from a change. `ProfileBloc`
/// skips `ProfileLoadInProgress` when it already holds data, and drops a reload
/// that produces an equal `ProfileReady` as a duplicate — so waiting purely on
/// an emission hung forever whenever the profile was already loaded.
@RoutePage()
class RoleGatePage extends StatefulWidget {
  const RoleGatePage({super.key});

  @override
  State<RoleGatePage> createState() => _RoleGatePageState();
}

class _RoleGatePageState extends State<RoleGatePage> {
  bool _routed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _decide());
  }

  /// Resume knows the role already (the startup check calls `/me` anyway), so
  /// this is a single frame. Otherwise the profile is the first thing that
  /// knows, and it may already have arrived.
  void _decide() {
    if (!mounted || _routed) return;

    final decision = roleGateDecisionFor(
      knownRole: getIt<SessionSnapshot>().role,
      profileState: context.read<ProProfileBloc>().state,
    );
    switch (decision) {
      case RoleGateDecision.agent:
        _go(isAgent: true);
      case RoleGateDecision.prestataire:
        _go(isAgent: false);
      case RoleGateDecision.wait:
      case RoleGateDecision.askAgain:
        break;
    }
  }

  void _adopt(AccountRole role) {
    getIt<SessionSnapshot>().markAuthenticated(role: role);
    _go(isAgent: role.isAgent);
  }

  void _go({required bool isAgent}) {
    if (!mounted || _routed) return;
    _routed = true;
    context.router.replace(
      isAgent ? const AgentShellRoute() : const ProShellRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocConsumer<ProProfileBloc, ProfileState>(
      listenWhen: (prev, curr) => curr is ProProfileReady,
      listener: (context, state) {
        if (state is ProProfileReady) _adopt(state.data.role);
      },
      builder: (context, state) => Scaffold(
        backgroundColor: context.mboaColors.background,
        // A failed profile load used to leave this spinning forever with no
        // way out — the one state where the app cannot guess who it is talking
        // to and must ask.
        body: state is ProfileLoadFailure
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.commonErrorTitle,
                      style: context.mboaText.h3,
                    ),
                    const SizedBox(height: Dimens.spacingSm),
                    TextButton(
                      onPressed: () => context
                          .read<ProProfileBloc>()
                          .add(const ProfileLoadRequested()),
                      child: Text(l10n.commonRetry),
                    ),
                  ],
                ),
              )
            : const Center(child: Loader()),
      ),
    );
  }
}
