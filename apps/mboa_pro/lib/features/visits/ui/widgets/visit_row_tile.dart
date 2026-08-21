import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// One visit in an agenda day: the hour, the property, its status, and
/// whatever the persona may do about it.
class VisitRowTile extends StatelessWidget {
  const VisitRowTile({
    super.key,
    required this.visit,
    this.onTap,
    this.actions,
    this.isBusy = false,
  });

  final Visit visit;
  final VoidCallback? onTap;
  final Widget? actions;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final at = visit.scheduledAt;

    return Opacity(
      opacity: isBusy ? 0.5 : 1,
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimens.spacingSm),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(Dimens.radiusLg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(Dimens.spacing),
              leading: Icon(LucideIcons.calendarCheck, color: colors.primary),
              title: Text(
                visit.annonceTitle ?? '',
                style: context.mboaText.label.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(at == null ? '' : DateFormat.Hm().format(at)),
              trailing: VisitStatusChip(status: visit.status),
              onTap: isBusy ? null : onTap,
            ),
            if (actions case final actions?)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimens.spacing,
                  0,
                  Dimens.spacing,
                  Dimens.spacingSm,
                ),
                child: actions,
              ),
          ],
        ),
      ),
    );
  }
}

/// The visit's state, in one word and one colour.
class VisitStatusChip extends StatelessWidget {
  const VisitStatusChip({super.key, required this.status, this.onTint = false});

  final VisitStatus status;

  /// Set on a coloured card. The usual 12% wash is a tint over a tint there —
  /// the label came out barely readable on the detail's mint header — so the
  /// chip takes a solid surface behind it instead.
  final bool onTint;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final (label, color) = switch (status) {
      VisitStatus.requested => (l10n.visitsStatusRequested, colors.warning),
      VisitStatus.scheduled => (l10n.visitsStatusScheduled, colors.primary),
      VisitStatus.completed => (l10n.visitsStatusCompleted, colors.success),
      VisitStatus.cancelled => (l10n.visitsStatusCancelled, colors.error),
      VisitStatus.notFulfilled => (l10n.visitsStatusNotFulfilled, colors.error),
      VisitStatus.unknown => ('', colors.textTertiary),
    };

    if (label.isEmpty) return const SizedBox.shrink();

    return Chip(
      label: Text(label),
      labelStyle: context.mboaText.caption.copyWith(color: color),
      backgroundColor: onTint ? colors.surface : color.withValues(alpha: 0.12),
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }
}
