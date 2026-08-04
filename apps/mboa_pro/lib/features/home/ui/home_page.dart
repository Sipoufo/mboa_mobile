import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';

import '../../auth/bloc/auth_bloc.dart';

/// Placeholder authenticated landing screen for App Mboa Pro. Provider/agent
/// feature modules (visit reports, listings management, geolocation…) plug in
/// here following the same feature structure.
@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appNamePro),
        actions: [
          IconButton(
            tooltip: l10n.authLogout,
            icon: const Icon(LucideIcons.logOut),
            onPressed: () => context.read<AuthBloc>().add(const AuthLogoutRequested()),
          ),
        ],
      ),
      body: Center(child: Text(l10n.homeProWelcome)),
    );
  }
}
