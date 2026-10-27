import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/notifications_bootstrap.dart';
import '../../../app/router/app_router.dart';

/// The notifications page (§38) — the shared list, opened through this app's
/// own push router, so an item lands where its push would.
@RoutePage()
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.menuNotifications)),
      body: BlocProvider<InboxBloc>.value(
        // The session's one instance: the bell reads it too.
        value: getIt<InboxBloc>()..add(const InboxRequested()),
        child: NotificationsView(
          onOpen: (message) => routeNotificationTap(context.router.root as AppRouter, message),
        ),
      ),
    );
  }
}
