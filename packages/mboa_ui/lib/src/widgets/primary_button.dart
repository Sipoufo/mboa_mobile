import 'package:flutter/material.dart';

import '../theme/dimens.dart';
import '../theme/theme_extensions.dart';

/// The primary call-to-action button — Corail per the charte (Doc 05 §2.1:
/// Corail = action colour, "Réserver / Contacter / Payer"). Full-width with a
/// built-in busy state.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: colors.action,
        foregroundColor: colors.onBrand,
        disabledBackgroundColor: colors.actionLight,
        minimumSize: const Size.fromHeight(Dimens.buttonHeight),
      ),
      child: isLoading
          ? SizedBox.square(
              dimension: Dimens.loader,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.onBrand,
              ),
            )
          : Text(label),
    );
  }
}
