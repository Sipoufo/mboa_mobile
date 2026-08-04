import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../app/router/app_router.gr.dart';

/// Route adapter for the shared "Paramètres" menu. App Mboa users have no
/// password, so only language + delete are offered (phone change to follow).
@RoutePage()
class SettingsMenuPage extends StatelessWidget {
  const SettingsMenuPage({super.key});

  @override
  Widget build(BuildContext context) => SettingsMenuView(
        localeController: getIt<LocaleController>(),
        onChangePhone: () => context.router.push(const ChangePhoneRoute()),
        onDeleteAccount: () => context.router.push(const DeleteAccountRoute()),
      );
}
