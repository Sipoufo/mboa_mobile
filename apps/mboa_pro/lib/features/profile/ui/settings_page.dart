import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';

import '../profile_types.dart';
import 'settings_view.dart';

/// Post-authentication landing for App Mboa Pro (temporary, while the profile /
/// KYC surfaces are built). Hosts the shared profile bloc.
@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<ProProfileBloc>.value(
        value: getIt<ProProfileBloc>(),
        child: const SettingsView(),
      );
}
