import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/evidence_compare_bloc.dart';
import '../models/evidence.dart';
import 'evidence_view.dart';

/// Before / after (CA-M31-04): room by room, the entry photos beside the
/// exit ones, each with the time Mboa received it. Shared by both apps;
/// nothing to do here, so no bar.
class EvidenceCompareView extends StatelessWidget {
  const EvidenceCompareView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<EvidenceCompareBloc, EvidenceCompareState>(
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.evidenceCompareTitle)),
        body: switch (state) {
          EvidenceCompareLoading() => const Center(child: Loader()),
          EvidenceCompareFailure(:final contractId) => Center(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingXl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LucideIcons.wifiOff, size: Dimens.iconLg, color: colors.textTertiary),
                    const SizedBox(height: Dimens.spacing),
                    Text(
                      l10n.evidenceCompareOffline,
                      textAlign: TextAlign.center,
                      style: context.mboaText.body.copyWith(color: colors.textSecondary),
                    ),
                    TextButton(
                      onPressed: () => context.read<EvidenceCompareBloc>().add(EvidenceCompareRequested(contractId)),
                      child: Text(l10n.commonRetry),
                    ),
                  ],
                ),
              ),
            ),
          EvidenceCompareReady(:final rooms) => ListView(
              padding: const EdgeInsets.fromLTRB(
                Dimens.screenMargin,
                Dimens.spacing,
                Dimens.screenMargin,
                Dimens.spacingXl,
              ),
              children: [
                Text(l10n.evidenceNotice, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                const SizedBox(height: Dimens.spacing),
                if (rooms.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
                    child: Text(
                      l10n.evidenceCompareEmpty,
                      textAlign: TextAlign.center,
                      style: context.mboaText.body.copyWith(color: colors.textSecondary),
                    ),
                  ),
                for (final room in rooms) ...[
                  _RoomCard(room: room),
                  const SizedBox(height: Dimens.spacing),
                ],
              ],
            ),
        },
      ),
    );
  }
}

/// One room: « Entrée » on the left, « Sortie » on the right, the n-th photo
/// of each side by side.
class _RoomCard extends StatelessWidget {
  const _RoomCard({required this.room});

  final EvidenceRoomPair room;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final rows = room.entry.length > room.exit.length ? room.entry.length : room.exit.length;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusLg)),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              room.roomLabel ?? evidenceRoomLabel(l10n, room.room),
              style: context.mboaText.h3.copyWith(color: colors.primaryDark),
            ),
            const SizedBox(height: Dimens.spacingSm),
            Row(
              children: [
                for (final (index, phase) in [EvidencePhase.entry, EvidencePhase.exit].indexed) ...[
                  if (index > 0) const SizedBox(width: Dimens.spacingSm),
                  Expanded(
                    child: Text(
                      evidencePhaseLabel(l10n, phase),
                      style: context.mboaText.label.copyWith(color: colors.primary, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: Dimens.spacingXs),
            for (var i = 0; i < rows; i++) ...[
              if (i > 0) const SizedBox(height: Dimens.spacingSm),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _Side(photos: room.entry, index: i)),
                  const SizedBox(width: Dimens.spacingSm),
                  Expanded(child: _Side(photos: room.exit, index: i)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// The [index]-th photo of a side — or, for a side with none at all, that
/// it has none.
class _Side extends StatelessWidget {
  const _Side({required this.photos, required this.index});

  final List<EvidencePhoto> photos;
  final int index;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();

    if (index >= photos.length) {
      if (photos.isNotEmpty || index > 0) return const SizedBox.shrink();
      return AspectRatio(
        aspectRatio: 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(Dimens.radius),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(LucideIcons.imageOff, color: colors.textTertiary, size: Dimens.iconMd),
              const SizedBox(height: Dimens.spacingXs),
              Text(l10n.evidenceCompareNone, style: context.mboaText.caption.copyWith(color: colors.textTertiary)),
            ],
          ),
        ),
      );
    }

    final photo = photos[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: photo.downloadUrl == null ? null : () => showEvidencePhoto(context, photo),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.radius),
            child: AspectRatio(aspectRatio: 1, child: MboaNetworkImage(url: photo.downloadUrl)),
          ),
        ),
        if (photo.recordedAt case final at?) ...[
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(LucideIcons.clock, size: 12, color: colors.textTertiary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  DateFormat.yMMMd(locale).add_Hm().format(at),
                  style: context.mboaText.micro.copyWith(color: colors.textSecondary),
                ),
              ),
            ],
          ),
        ],
        if (photo.comment case final comment?)
          Text(
            comment,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.mboaText.micro.copyWith(color: colors.textSecondary),
          ),
      ],
    );
  }
}
