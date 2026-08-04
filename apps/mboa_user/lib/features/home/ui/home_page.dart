import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';

/// Placeholder authenticated landing screen. Real feature modules (listings,
/// search, favorites…) plug in here following the same feature structure.
@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    return Scaffold(
      backgroundColor: context.mboaColors.surface,
      appBar: AppBar(
        title: Text(l10n.appName),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () => context.router.push(const SettingsRoute()),
          ),
        ],
      ),
      body: Center(child: Text(l10n.homeUserWelcome)),
    );
  }
}
