import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_l10n/mboa_l10n.dart';

/// Authentication entry — the shared entry point of the authentication flow.
///
/// This is a plain widget (no routing annotations): each app embeds it in its
/// own `@RoutePage` adapter, so routing stays app-specific while the flow's UI
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
    return Scaffold(
      backgroundColor: context.mboaColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                top: -600,
                child: OverflowBox(
                  minWidth: 0.0,
                  maxWidth: double.infinity,
                  minHeight: 0.0,
                  maxHeight: double.infinity,
                  // 3. On centre l'élément dans cet espace
                  alignment: Alignment.center,
                  child: MboaIllustrations.illustration1(size: 800),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 100,),
                  const MboaLogo(size: 50,),
                  const Spacer(),

                  Column(
                    spacing: Dimens.spacing,
                    children: [
                      Button.outline(onPressed: widget.toLogin, title: I18n.of(context).welcome_inscriptionButton),
                      Button.primary(onPressed: widget.toRegistration, title: I18n.of(context).welcome_loginButton),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
