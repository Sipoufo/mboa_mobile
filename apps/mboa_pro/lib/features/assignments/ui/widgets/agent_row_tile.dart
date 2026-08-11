import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The person row shared by Mes agents and the candidate picker: square avatar,
/// name, one line of context, one trailing action.
///
/// The design's second line is a job title; agents have no such field, so it
/// carries the property (or the visit count) instead — the useful thing the API
/// actually knows.
class AgentRowTile extends StatelessWidget {
  const AgentRowTile({
    super.key,
    required this.name,
    this.subtitle,
    this.photoUrl,
    this.initials,
    this.trailing,
    this.onTap,
    this.isBusy = false,
  });

  final String name;
  final String? subtitle;
  final String? photoUrl;
  final String? initials;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Opacity(
      opacity: isBusy ? 0.5 : 1,
      child: InkWell(
        onTap: isBusy ? null : onTap,
        borderRadius: BorderRadius.circular(Dimens.radius),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.radius),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: photoUrl == null
                      ? ColoredBox(
                          color: colors.primaryPale,
                          child: Center(
                            child: Text(
                              initials ?? '',
                              style: context.mboaText.label
                                  .copyWith(color: colors.primary),
                            ),
                          ),
                        )
                      : Image.network(
                          photoUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) => ColoredBox(
                            color: colors.primaryPale,
                            child: Center(child: Text(initials ?? '')),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: Dimens.spacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: context.mboaText.label
                          .copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle case final subtitle?) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: context.mboaText.caption
                            .copyWith(color: colors.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (isBusy)
                const SizedBox(width: 24, height: 24, child: Loader())
              else
                ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}

/// The alphabetical section header from the Annuaire design.
class AgentSectionHeader extends StatelessWidget {
  const AgentSectionHeader({super.key, required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
      child: Row(
        children: [
          Text(
            letter,
            style: context.mboaText.caption.copyWith(color: colors.textTertiary),
          ),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(child: Divider(color: colors.border, height: 1)),
        ],
      ),
    );
  }
}
