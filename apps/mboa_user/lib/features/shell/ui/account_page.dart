import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../auth/bloc/auth_bloc.dart';

/// The Compte tab — the only one that changes shape with the session.
///
/// A visitor sees what an account is for and a way in; a signed-in tenant is
/// sent to the profile hub behind `/app`. RM-M04-05 puts the wall here and on
/// the fiche's actions, never on the search itself.
@RoutePage()
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.navAccount)),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final signedIn = getIt<SessionSnapshot>().hasSession;

          return Padding(
            padding: const EdgeInsets.all(Dimens.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (signedIn) ...[
                  MboaTileCard(
                    icon: LucideIcons.squareUserRound,
                    title: l10n.settingsProfileCard,
                    onTap: () => context.router.root.push(
                      const AuthenticatedRouter(children: [SettingsRoute()]),
                    ),
                  ),
                  const SizedBox(height: Dimens.spacingMd),
                  // M07 — booked from a fiche, checked from here. Not a fifth
                  // tab: Doc 05 §6.5 allows five and the four we have are the
                  // ones used every session.
                  MboaTileCard(
                    icon: LucideIcons.calendarCheck,
                    title: l10n.visitsTitle,
                    onTap: () => context.router.root.push(
                      const AuthenticatedRouter(children: [MyVisitsRoute()]),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: Dimens.spacingXl),
                  Icon(
                    LucideIcons.userRound,
                    size: Dimens.iconLg,
                    color: colors.textTertiary,
                  ),
                  const SizedBox(height: Dimens.spacing),
                  Text(
                    l10n.accountGuestTitle,
                    textAlign: TextAlign.center,
                    style: context.mboaText.h3.copyWith(color: colors.ink),
                  ),
                  const SizedBox(height: Dimens.spacingXs),
                  Text(
                    l10n.accountGuestBody,
                    textAlign: TextAlign.center,
                    style: context.mboaText.body
                        .copyWith(color: colors.textSecondary),
                  ),
                  const SizedBox(height: Dimens.spacingLg),
                  Button.primary(
                    title: l10n.accountSignIn,
                    onPressed: () => context.router.root.push(LoginRoute()),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
