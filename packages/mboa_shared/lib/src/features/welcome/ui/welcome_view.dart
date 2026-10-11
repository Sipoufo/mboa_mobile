import 'package:flutter/material.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Authentication entry — the shared entry point of the authentication flow.
///
/// This is a plain widget (no routing annotations): each app embeds it in its
/// own `@RoutePage` adapter, so routing stays app-specific while the flow's UI
/// stays shared.
///
/// Onboarding is one of the three places §05 allows an illustration, so it
/// gets one: a neighbourhood of gables standing on the buttons. It also says
/// something at last — the screen used to be a logo and two buttons, with an
/// abstract wash pushed 600px off the top of the viewport.
class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key, this.toLogin, this.toRegistration});

  final void Function()? toLogin;
  final void Function()? toRegistration;

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Stack(
        children: [
          // Behind everything, standing on the bottom edge.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.18,
              child: MboaIllustrations.skyline(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.screenMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Dimens.spacingXl),
                  const MboaLogo(height: 36),
                  const Spacer(),
                  Text(
                    // §07, verbatim: "Bienvenue chez toi", never "Bienvenue
                    // sur notre plateforme".
                    l10n.welcomeHeadline,
                    style: context.mboaText.display.copyWith(color: colors.ink),
                  ),
                  const SizedBox(height: Dimens.spacingSm),
                  Text(
                    l10n.welcomeBody,
                    style: context.mboaText.bodyLarge
                        .copyWith(color: colors.textSecondary),
                  ),
                  const SizedBox(height: Dimens.spacingXl),
                  SizedBox(
                    width: double.infinity,
                    child: Button.primary(
                      onPressed: widget.toLogin,
                      title: l10n.welcome_loginButton,
                    ),
                  ),
                  const SizedBox(height: Dimens.spacingMd),
                  SizedBox(
                    width: double.infinity,
                    child: Button.outline(
                      onPressed: widget.toRegistration,
                      title: l10n.welcome_inscriptionButton,
                    ),
                  ),
                  const SizedBox(height: Dimens.spacingLg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
