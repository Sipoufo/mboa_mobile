import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../features/profile/profile_types.dart';
import 'app_router.gr.dart';

/// What `/app` opens on, before either persona's shell.
///
/// App Mboa Pro serves two people whose apps have nothing in common, and the
/// role is not in the login response — only `/me` reports it. Opening on the
/// prestataire shell and correcting a beat later showed an agent someone
/// else's dashboard, which is what this exists to stop.
///
/// On resume the role is already in [SessionSnapshot] (the startup check calls
/// `/me` anyway), so this is a single frame. After a fresh sign-in it waits for
/// the profile — showing the app's own loader, never another persona's content.
@RoutePage()
class RoleGatePage extends StatefulWidget {
  const RoleGatePage({super.key});

  @override
  State<RoleGatePage> createState() => _RoleGatePageState();
}

class _RoleGatePageState extends State<RoleGatePage> {
  @override
  void initState() {
    super.initState();
    final known = getIt<SessionSnapshot>().role;
    if (known != null) {
      // Resume: route on the first frame, no visible wait.
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _go(isAgent: known.isAgent));
    }
  }

  void _go({required bool isAgent}) {
    if (!mounted) return;
    context.router.replace(
      isAgent ? const AgentShellRoute() : const ProShellRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProProfileBloc, ProfileState>(
      listenWhen: (prev, curr) => curr is ProProfileReady,
      listener: (context, state) {
        if (state is! ProProfileReady) return;
        // Sign-in path, or an offline start where /me never ran: the profile is
        // the first thing that knows.
        getIt<SessionSnapshot>().markAuthenticated(role: state.data.role);
        _go(isAgent: state.data.role.isAgent);
      },
      child: Scaffold(
        backgroundColor: context.mboaColors.background,
        body: const Center(child: Loader()),
      ),
    );
  }
}
