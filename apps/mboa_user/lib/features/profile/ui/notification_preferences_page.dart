import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Route adapter around the shared [NotificationPreferencesView]. App Mboa is
/// read by tenants only.
@RoutePage()
class NotificationPreferencesPage extends StatelessWidget {
  const NotificationPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) =>
      const NotificationPreferencesView(audience: NotificationAudience.tenant);
}
