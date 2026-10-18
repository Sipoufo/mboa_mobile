import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Route adapter around the shared [NotificationPreferencesView]. One app,
/// two personas: an agent is not sent what a prestataire is (listing
/// expiry, contacts, the finance add-on), so the switches follow the role.
@RoutePage()
class NotificationPreferencesPage extends StatelessWidget {
  const NotificationPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) => NotificationPreferencesView(
        audience: (getIt<SessionSnapshot>().role?.isAgent ?? false)
            ? NotificationAudience.agent
            : NotificationAudience.prestataire,
      );
}
