import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The mockup's gold, as on the fiche's rating.
const _star = Color(0xFFFFC83D);

/// What the landlord gives: 1 to 5 stars, and a word for Mboa alone.
typedef TenantRatingDraft = ({int stars, String? comment});

/// §37 A — « Comment s'est passée la location ? ». Answers the draft, or null
/// when dismissed.
Future<TenantRatingDraft?> showTenantRatingSheet(BuildContext context) => showModalBottomSheet<TenantRatingDraft>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.mboaColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
      ),
      builder: (_) => const TenantRatingSheet(),
    );

/// Public so it can be pumped on its own.
class TenantRatingSheet extends StatefulWidget {
  const TenantRatingSheet({super.key});

  static const int maxComment = 500;

  @override
  State<TenantRatingSheet> createState() => _TenantRatingSheetState();
}

class _TenantRatingSheetState extends State<TenantRatingSheet> {
  int _stars = 0;
  final _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.contractRateTenantTitle, style: context.mboaText.h3.copyWith(color: colors.ink)),
              const SizedBox(height: Dimens.spacingSm),
              Text(l10n.contractRateTenantBody, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
              const SizedBox(height: Dimens.spacingLg),
              TenantStars(stars: _stars, size: 40, onChanged: (stars) => setState(() => _stars = stars)),
              const SizedBox(height: Dimens.spacingLg),
              TextField(
                controller: _comment,
                maxLines: 4,
                minLines: 3,
                maxLength: TenantRatingSheet.maxComment,
                decoration: InputDecoration(
                  labelText: l10n.contractRateTenantComment,
                  helperText: l10n.contractRateTenantCommentNote,
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: Dimens.spacing),
              Button.primary(
                title: l10n.contractRateTenantSend,
                onPressed: _stars == 0 ? null : () => Navigator.of(context).pop((stars: _stars, comment: _comment.text)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Five stars: tapped to choose when [onChanged] is set, shown otherwise.
class TenantStars extends StatelessWidget {
  const TenantStars({super.key, required this.stars, this.onChanged, this.size = 24});

  final int stars;
  final ValueChanged<int>? onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    Widget star(int n) => Icon(
          LucideIcons.star,
          size: size,
          color: n <= stars ? _star : colors.border,
        );

    final onChanged = this.onChanged;
    return Semantics(
      label: l10n.contractRateStars(stars),
      child: Row(
        mainAxisAlignment: onChanged == null ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          for (var n = 1; n <= 5; n++)
            if (onChanged == null)
              Padding(padding: const EdgeInsets.only(right: 2), child: star(n))
            else
              IconButton(
                tooltip: l10n.contractRateStars(n),
                onPressed: () => onChanged(n),
                icon: star(n),
              ),
        ],
      ),
    );
  }
}
