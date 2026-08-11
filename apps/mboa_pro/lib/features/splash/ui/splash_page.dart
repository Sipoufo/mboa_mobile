import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/notifications_bootstrap.dart';
import '../../../app/router/app_router.dart';
import '../../../app/router/app_router.gr.dart';
import '../logic/splash_cubit.dart';

/// Initial route for App Mboa Pro. Runs the session check and routes to Home or
/// Login; shows a retry affordance on an unexpected error.
@RoutePage()
class SplashPage extends StatelessWidget implements AutoRouteWrapper {
  const SplashPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (_) => getIt<SplashCubit>()..initialize(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listenWhen: (prev, curr) =>
          curr is SplashAuthenticated || curr is SplashUnauthenticated,
      listener: (context, state) {
        // The startup decision also seeds the snapshot the route guards read —
        // otherwise the very first navigation into /app would be denied.
        switch (state) {
          case SplashAuthenticated(:final role):
            getIt<SessionSnapshot>().markAuthenticated(role: role);
            getIt<SessionExpiryWatcher>().start();
            startNotifications(
              router: context.router.root as AppRouter,
              context: () => context,
            );
            context.router.replaceAll([const AuthenticatedRouter()]);
          case SplashUnauthenticated():
            getIt<SessionSnapshot>().markUnauthenticated();
            context.router.replaceAll([const LoginRoute()]);
          default:
            break;
        }
      },
      builder: (context, state) {
        final l10n = I18n.of(context);
        return MboaSplashView(
          showProgress: state is! SplashFailure,
          footer: state is SplashFailure
              ? _RetryFooter(
                  message: l10n.commonError,
                  retryLabel: l10n.commonRetry,
                  onRetry: () => context.read<SplashCubit>().retry(),
                )
              : null,
        );
      },
    );
  }
}

class _RetryFooter extends StatelessWidget {
  const _RetryFooter({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        TextButton(onPressed: onRetry, child: Text(retryLabel)),
      ],
    );
  }
}
