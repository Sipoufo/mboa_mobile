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
import '../../profile/profile_types.dart';

/// The Compte tab — the only one that changes shape with the session.
///
/// A visitor sees what an account is for and a way in; a signed-in tenant sees
/// **themselves**: their photo, their name, and the four places an account
/// leads. It used to show two tiles and never said who was signed in, which
/// made "Compte" the one tab that told you nothing.
///
/// RM-M04-05 puts the wall here and on the fiche's actions, never on the
/// search itself.
@RoutePage()
class AccountPage extends StatelessWidget implements AutoRouteWrapper {
  const AccountPage({super.key});

  /// The profile bloc is a singleton shared with the hub and the edit form, so
  /// the name under the avatar and the name in the form are never two answers.
  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<UserProfileBloc>.value(
        value: getIt<UserProfileBloc>(),
        child: this,
      );

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        // The shell survives a sign-in, so this page is never rebuilt by the
        // navigation — it has to listen for the session itself.
        listenable: getIt<SessionSnapshot>(),
        builder: (context, _) => _build(context),
      );

  Widget _build(BuildContext context) {
    final colors = context.mboaColors;

    if (!getIt<SessionSnapshot>().hasSession) {
      return Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(title: Text(I18n.of(context).navAccount)),
        body: const _SignInPrompt(),
      );
    }

    return Scaffold(
      backgroundColor: colors.background,
      body: _SignedIn(),
    );
  }
}

class _SignedIn extends StatefulWidget {
  @override
  State<_SignedIn> createState() => _SignedInState();
}

class _SignedInState extends State<_SignedIn> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<UserProfileBloc>();
    if (bloc.state is ProfileInitial) bloc.add(const ProfileLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<UserProfileBloc, ProfileState>(
      builder: (context, state) {
        final data = state is UserProfileReady ? state.data : null;

        return ListView(
          padding: EdgeInsets.zero,
          children: [
            _Identity(data: data),
            const SizedBox(height: Dimens.spacingLg),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.screenMargin,
              ),
              child: Column(
                children: [
                  MboaTileCard(
                    icon: LucideIcons.squareUserRound,
                    title: l10n.settingsProfileCard,
                    subtitle: data?.email,
                    onTap: () => context.router.root.push(
                      const AuthenticatedRouter(children: [SettingsRoute()]),
                    ),
                  ),
                  const SizedBox(height: Dimens.spacingMd),
                  MboaTileCard(
                    icon: LucideIcons.calendarCheck,
                    title: l10n.visitsTitle,
                    onTap: () => context.router.root.push(
                      const AuthenticatedRouter(children: [MyVisitsRoute()]),
                    ),
                  ),
                  const SizedBox(height: Dimens.spacingMd),
                  // M08 — where a tenancy is read, signed or contested, and
                  // where M27's resident review starts from.
                  MboaTileCard(
                    icon: LucideIcons.fileText,
                    title: l10n.contractsTitle,
                    onTap: () => context.router.root.push(
                      const AuthenticatedRouter(children: [MyContractsRoute()]),
                    ),
                  ),
                  const SizedBox(height: Dimens.spacingMd),
                  MboaTileCard(
                    icon: LucideIcons.settings,
                    title: l10n.settingsMenuTitle,
                    onTap: () => context.router.root.push(
                      const AuthenticatedRouter(children: [SettingsMenuRoute()]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimens.spacingXl),
            Center(
              child: TextButton.icon(
                onPressed: () =>
                    context.read<AuthBloc>().add(const AuthLogoutRequested()),
                icon: const Icon(LucideIcons.logOut, size: Dimens.icon),
                label: Text(l10n.settingsLogout),
                style: TextButton.styleFrom(foregroundColor: colors.textSecondary),
              ),
            ),
            const SizedBox(height: Dimens.spacingXl),
          ],
        );
      },
    );
  }
}

/// Who is signed in: the photo, the name, the number — on the brand's own
/// ground, which is the one place in the app the tenant sees themselves.
class _Identity extends StatelessWidget {
  const _Identity({this.data});

  final BaseProfile? data;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(Dimens.radiusLg),
            ),
            child: ColoredBox(
              color: colors.primary,
              child: Image.asset(
                'assets/images/illustrations/brand_pattern.png',
                package: 'mboa_ui',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimens.screenMargin,
              Dimens.spacingLg,
              Dimens.screenMargin,
              Dimens.spacingXl,
            ),
            child: Row(
              children: [
                MboaAvatar(
                  imageUrl: data?.photoUrl,
                  initials: data?.initials,
                  size: 72,
                ),
                const SizedBox(width: Dimens.spacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        // H2, not Display: a name is a heading, and 32px of
                        // ExtraBold green is a headline about a person.
                        data?.fullName ?? '',
                        style: context.mboaText.h2.copyWith(color: colors.onBrand),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (data?.phoneNumber case final phone?) ...[
                        const SizedBox(height: Dimens.spacingXs),
                        Text(
                          phone,
                          style: context.mboaText.body.copyWith(
                            color: colors.onBrand.withValues(alpha: 0.75),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SignInPrompt extends StatelessWidget {
  const _SignInPrompt();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: Dimens.spacingLg),
            Button.primary(
              title: l10n.accountSignIn,
              onPressed: () => context.router.root.push(LoginRoute()),
            ),
          ],
        ),
      ),
    );
  }
}
