import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../bloc/incoming_reservation_bloc.dart';
import '../../models/unit_choice.dart';

/// RM-M29-16 — accepting a request on a residence: the unit asked for, or
/// another of the residence's that the landlord assigns. The server lists
/// them (published, on the request's period), the one asked for first.
///
/// Pops the chosen unit's id; the choice itself is view state.
class UnitAssignSheet extends StatefulWidget {
  const UnitAssignSheet({super.key, required this.requestedId, this.requestedTitle});

  final String requestedId;
  final String? requestedTitle;

  @override
  State<UnitAssignSheet> createState() => _UnitAssignSheetState();
}

class _UnitAssignSheetState extends State<UnitAssignSheet> {
  late String _chosen = widget.requestedId;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return SafeArea(
      child: BlocBuilder<IncomingReservationBloc, IncomingReservationState>(
        builder: (context, state) {
          final ready = state is IncomingReservationReady ? state : null;
          final units = ready?.units;
          final chosen = units?.where((u) => u.annonceId == _chosen).firstOrNull;

          return Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.spacingLg, Dimens.spacingLg, Dimens.spacingLg, Dimens.spacing),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.proReservationAssignTitle, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
                const SizedBox(height: Dimens.spacingXs),
                Text(
                  l10n.proReservationAssignHint(widget.requestedTitle ?? l10n.reservationUntitled),
                  style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: Dimens.spacing),
                if (units == null && (ready?.unitsLoading ?? true))
                  const Padding(padding: EdgeInsets.all(Dimens.spacingLg), child: Center(child: Loader()))
                else if (units == null)
                  Center(
                    child: TextButton(
                      onPressed: () =>
                          context.read<IncomingReservationBloc>().add(const IncomingReservationUnitsRequested()),
                      child: Text(l10n.commonRetry),
                    ),
                  )
                else
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final unit in units)
                          _UnitRow(
                            unit: unit,
                            requested: unit.annonceId == widget.requestedId,
                            selected: unit.annonceId == _chosen,
                            onTap: () => setState(() => _chosen = unit.annonceId),
                          ),
                      ],
                    ),
                  ),
                const SizedBox(height: Dimens.spacing),
                Button.primary(
                  title: _chosen == widget.requestedId || chosen == null
                      ? l10n.proReservationAccept
                      : l10n.proReservationAcceptWith(chosen.title ?? l10n.reservationUntitled),
                  onPressed: units == null ? null : () => Navigator.of(context).pop(_chosen),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _UnitRow extends StatelessWidget {
  const _UnitRow({required this.unit, required this.requested, required this.selected, required this.onTap});

  final UnitChoice unit;
  final bool requested;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
      child: Material(
        color: selected ? colors.primaryPale : colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.radiusMd),
          side: BorderSide(color: selected ? colors.primary : colors.border),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimens.radiusMd),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMd),
            child: Row(
              children: [
                Icon(
                  selected ? LucideIcons.circleCheck : LucideIcons.circle,
                  size: Dimens.icon,
                  color: selected ? colors.primary : colors.textTertiary,
                ),
                const SizedBox(width: Dimens.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              unit.title ?? l10n.reservationUntitled,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.mboaText.label.copyWith(color: colors.ink),
                            ),
                          ),
                          if (requested) ...[
                            const SizedBox(width: Dimens.spacingSm),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 2),
                              decoration: BoxDecoration(
                                color: colors.primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(Dimens.radiusFull),
                              ),
                              child: Text(
                                l10n.proReservationAssignRequested,
                                style: context.mboaText.caption.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        '${unit.propertyType.label(l10n)} · ${unit.rentalPeriod.priceLabel(l10n, unit.price)}',
                        style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
