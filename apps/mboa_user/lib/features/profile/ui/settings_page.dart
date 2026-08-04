import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';

import '../profile_types.dart';
import 'settings_view.dart';

/// Route adapter for the user's Settings hub. Provides the singleton profile
/// bloc so the hub and edit screen share one instance.
@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<UserProfileBloc>.value(
        value: getIt<UserProfileBloc>(),
        child: const SettingsView(),
      );
}
