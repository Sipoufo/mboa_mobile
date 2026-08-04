import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';

import '../profile_types.dart';
import 'edit_profile_view.dart';

/// Route adapter for the user's Edit Profile screen. Shares the singleton
/// profile bloc with the Settings hub.
@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<UserProfileBloc>.value(
        value: getIt<UserProfileBloc>(),
        child: const EditProfileView(),
      );
}
