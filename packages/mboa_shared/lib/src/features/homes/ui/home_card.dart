import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../contracts/models/contract.dart';
import '../models/home.dart';
import 'home_bits.dart';

/// A space in a list: the place, and what is due next — or late.
///
/// The landlord ([viewer] prestataire) has several tenants: the card says
/// whose space it is before where it is.
class HomeCard extends StatelessWidget {
  const HomeCard({super.key, required this.home, required this.onTap, this.viewer = ContractParty.tenant});

  final Home home;
  final VoidCallback onTap;
  final ContractParty viewer;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final next = home.nextDue;

    final (String line, Color tone) = switch (home) {
      _ when home.state == HomeStage.readOnly => (
          home.endDate == null ? l10n.myHomeEnded : l10n.myHomeEndedOn(DateFormat.yMMMd(locale).format(home.endDate!)),
          colors.textSecondary,
        ),
      _ when home.isOverdue => (l10n.myHomeOverdueCount(home.overdueCount), colors.error),
      _ when next?.dueDate != null => (
          '${l10n.myHomeNextRent} · ${fcfaOf(context, next!.remaining)} · ${DateFormat.MMMd(locale).format(next.dueDate!)}',
          colors.primary,
        ),
      _ => (l10n.myHomeUpToDate, colors.success),
    };

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.radiusMd),
                child: SizedBox.square(
                  dimension: 64,
                  child: switch (home.coverUrl) {
                    final url? => MboaNetworkImage(url: url),
                    null => ColoredBox(
                        color: colors.primary,
                        child: MboaBrandPattern(color: colors.onBrand, opacity: 0.12, scale: 0.5),
                      ),
                  },
                ),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // A unit names its residence (§32): « Chambre 3 · Résidence Deido ».
                      home.placeTitle ?? l10n.reservationUntitled,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.label.copyWith(color: colors.ink),
                    ),
                    if ([
                      if (viewer == ContractParty.prestataire) home.tenant?.displayName,
                      home.district,
                      home.city,
                    ].nonNulls.join(' · ') case final place when place.isNotEmpty)
                      Text(
                        place,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                      ),
                    const SizedBox(height: Dimens.spacingXs),
                    Text(line, style: context.mboaText.caption.copyWith(color: tone, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}
