import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/app/router/app_router.dart';
import 'package:mboa_pro/app/router/app_router.gr.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Every authenticated screen must be reachable from somewhere.
///
/// The profile hub (`SettingsRoute`) was orphaned once the tab shell replaced
/// it as the post-auth landing: it stayed in the route table but nothing
/// navigated to it, so the Profil design was unreachable in the running app.
/// A route table entry is not proof of reachability — hence this test.
void main() {
  final router = AppRouter(snapshot: SessionSnapshot());

  List<AutoRoute> appChildren() => router.routes
      .firstWhere((r) => r.name == AuthenticatedRouter.name)
      .children!
      .routes
      .whereType<AutoRoute>()
      .where((r) => r is! RedirectRoute)
      .toList();

  test('the profile hub is declared under /app', () {
    expect(
      appChildren().map((r) => r.name),
      contains(SettingsRoute.name),
    );
  });

  test('every authenticated route has a navigation source in lib/', () {
    // Routes reached by the router itself rather than by a `push` call.
    const entryPoints = {
      RoleGateRoute.name, // /app landing
      HomeRoute.name, // shell tab
      PrestataireVisitsRoute.name, // shell tab
      FinanceRoute.name, // shell tab
      AgentVisitsRoute.name, // agent shell tab
      AgentMissionsRoute.name, // agent shell tab
      AgentProfileRoute.name, // agent shell tab
    };

    final unreachable = <String>[];
    for (final route in appChildren()) {
      if (entryPoints.contains(route.name)) continue;
      if (!_isNavigatedToInSource(route.name)) unreachable.add(route.name);
    }

    expect(
      unreachable,
      isEmpty,
      reason: 'declared in the route table but never navigated to: $unreachable',
    );
  });

  /// The check above is **role-blind**: it passes as long as *some* file
  /// navigates to a route. The prestataire's slide menu reaches settings, KYC
  /// and logout, so those all looked reachable — while an agent, whose shell has
  /// no slide menu, could sign in and never sign out.
  ///
  /// A second persona needs its own reachability check, from its own entry
  /// point. Add one here for every shell that is not the prestataire's.
  group('the agent shell reaches the account surfaces from its own screens', () {
    final agentSources = _dartSourcesUnder('lib/features/agent');

    bool reachedFromAgentUi(String needle) {
      final pattern = RegExp('\\b$needle\\s*\\(');
      return agentSources.any((path) => pattern.hasMatch(_read(path)));
    }

    test('signing out is possible at all', () {
      // The only way out of the app for an agent. Without it they are stuck in
      // a session with no exit.
      expect(
        reachedFromAgentUi('AuthLogoutRequested'),
        isTrue,
        reason: 'no logout anywhere in the agent UI',
      );
    });

    test('the account surfaces are reachable', () {
      for (final route in [
        SettingsMenuRoute.name,
        CertificationsRoute.name,
        // Notifications is a coming-soon stub for both personas, but it must
        // still be *reachable* — the hub is the product's map.
        AccessRestrictedRoute.name,
      ]) {
        expect(
          reachedFromAgentUi(route),
          isTrue,
          reason: '$route is unreachable for an agent',
        );
      }
    });

    test('M15 own screens are reachable', () {
      for (final route in [AgentZonesRoute.name, AgentAvailabilityRoute.name]) {
        expect(reachedFromAgentUi(route), isTrue, reason: route);
      }
    });
  });
}

/// Greps the app sources for a construction of [routeName], ignoring the
/// generated router and the route table itself.
bool _isNavigatedToInSource(String routeName) {
  final sources = _dartSourcesUnder('lib')
      .where((path) => !path.endsWith('app_router.gr.dart'))
      .where((path) => !path.endsWith('app_router.dart'));

  final pattern = RegExp('\\b$routeName\\s*\\(');
  return sources.any((path) => pattern.hasMatch(_read(path)));
}

List<String> _dartSourcesUnder(String directory) {
  final dir = Directory(directory);
  if (!dir.existsSync()) return const [];
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .map((f) => f.path)
      .where((p) => p.endsWith('.dart'))
      .toList();
}

String _read(String path) => File(path).readAsStringSync();
