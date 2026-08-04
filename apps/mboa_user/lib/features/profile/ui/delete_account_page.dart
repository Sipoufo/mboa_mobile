import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../auth/bloc/auth_bloc.dart';

/// Route adapter around the shared [DeleteAccountView]. On success it clears the
/// session, which routes back to the login flow.
@RoutePage()
class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) => DeleteAccountView(
        onDeleted: () => context.read<AuthBloc>().add(const AuthLogoutRequested()),
      );
}
