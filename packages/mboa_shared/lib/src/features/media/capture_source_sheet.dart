import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Bottom sheet offering the two capture sources (camera / gallery), matching
/// the "Prendre une photo" / "Importer" design. Resolves to the chosen
/// [ImageSource], or null if dismissed. Shared across media-capture flows.
Future<ImageSource?> showCaptureSourceSheet(BuildContext context) {
  final l10n = I18n.of(context);
  final colors = context.mboaColors;

  return showModalBottomSheet<ImageSource>(
    context: context,
    backgroundColor: colors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
    ),
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SourceCard(
              icon: LucideIcons.camera,
              label: l10n.mediaTakePhoto,
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            const SizedBox(height: Dimens.spacing),
            _SourceCard(
              icon: LucideIcons.download,
              label: l10n.mediaImport,
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    ),
  );
}

class _SourceCard extends StatelessWidget {
  const _SourceCard({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Material(
      color: colors.primaryLight2,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
          child: Column(
            children: [
              Icon(icon, color: colors.primary, size: Dimens.iconLg),
              const SizedBox(height: Dimens.spacingSm),
              Text(
                label,
                style: context.mboaText.label.copyWith(color: colors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
