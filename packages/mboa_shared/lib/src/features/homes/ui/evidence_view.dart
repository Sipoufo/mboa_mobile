import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/evidence_bloc.dart';
import '../models/evidence.dart';

String evidenceRoomLabel(I18n l10n, EvidenceRoom room) => switch (room) {
      EvidenceRoom.livingRoom => l10n.evidenceRoomLivingRoom,
      EvidenceRoom.bedroom => l10n.evidenceRoomBedroom,
      EvidenceRoom.kitchen => l10n.evidenceRoomKitchen,
      EvidenceRoom.bathroom => l10n.evidenceRoomBathroom,
      EvidenceRoom.toilet => l10n.evidenceRoomToilet,
      EvidenceRoom.outdoor => l10n.evidenceRoomOutdoor,
      EvidenceRoom.other => l10n.evidenceRoomOther,
    };

String evidencePhaseLabel(I18n l10n, EvidencePhase phase) => switch (phase) {
      EvidencePhase.entry => l10n.evidencePhaseEntry,
      EvidencePhase.stay => l10n.evidencePhaseStay,
      EvidencePhase.exit => l10n.evidencePhaseExit,
    };

/// One photo, full screen, to zoom into.
Future<void> showEvidencePhoto(BuildContext context, EvidencePhoto photo) => showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog.fullscreen(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Center(child: InteractiveViewer(child: MboaNetworkImage(url: photo.downloadUrl))),
            Positioned(
              top: Dimens.spacingLg,
              right: Dimens.spacing,
              child: IconButton(
                tooltip: I18n.of(context).commonClose,
                onPressed: () => Navigator.of(dialogContext).pop(),
                icon: const Icon(LucideIcons.x, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );

/// A home's photo proofs (CDC M30 lot 3, RM-M30-11/12): each sending as
/// Mboa recorded it — its time, its phase, how many photos, whether the
/// landlord saw it. The tenant's one main action is « Envoyer des photos »
/// ([onAdd]). Once entry and exit photos both exist, « Avant / après »
/// ([onCompare], CA-M31-04) sets them side by side.
class EvidenceView extends StatelessWidget {
  const EvidenceView({super.key, required this.onOpen, this.onAdd, this.onCompare});

  final ValueChanged<EvidenceBatch> onOpen;
  final VoidCallback? onAdd;
  final VoidCallback? onCompare;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<EvidenceBloc, EvidenceState>(
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.evidenceTitle)),
        body: switch (state) {
          EvidenceLoading() => const Center(child: Loader()),
          EvidenceFailure() => Center(
              child: TextButton(
                onPressed: () => context.read<EvidenceBloc>().add(const EvidenceRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          final EvidenceReady ready => RefreshIndicator(
              onRefresh: () async => context.read<EvidenceBloc>().add(const EvidenceRequested()),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
                children: [
                  if (ready.isOffline) ...[
                    Text(l10n.myHomeOffline, style: context.mboaText.caption.copyWith(color: colors.warning)),
                    const SizedBox(height: Dimens.spacingMd),
                  ],
                  _Notice(text: l10n.evidenceNotice),
                  const SizedBox(height: Dimens.spacing),
                  if (onCompare != null && ready.canCompare) ...[
                    _CompareCard(onTap: onCompare!),
                    const SizedBox(height: Dimens.spacing),
                  ],
                  if (ready.items.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
                      child: Text(
                        onAdd == null ? l10n.evidenceEmptyLandlord : l10n.evidenceEmptyTenant,
                        textAlign: TextAlign.center,
                        style: context.mboaText.body.copyWith(color: colors.textSecondary),
                      ),
                    )
                  else
                    for (final batch in ready.items) _BatchRow(batch: batch, onTap: () => onOpen(batch)),
                ],
              ),
            ),
        },
        bottomNavigationBar: onAdd == null
            ? null
            : Container(
                decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
                child: SafeArea(
                  minimum: const EdgeInsets.all(Dimens.spacing),
                  child: Button.primary(title: l10n.evidenceAdd, onPressed: onAdd),
                ),
              ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(LucideIcons.shieldCheck, size: Dimens.iconSm, color: colors.primary),
        const SizedBox(width: Dimens.spacingSm),
        Expanded(child: Text(text, style: context.mboaText.caption.copyWith(color: colors.textSecondary))),
      ],
    );
  }
}

/// « Avant / après » — on the brand colour, the way into the comparison.
class _CompareCard extends StatelessWidget {
  const _CompareCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Material(
      color: colors.primary,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned.fill(child: MboaBrandPattern(color: colors.onBrand, opacity: 0.08, scale: 0.6)),
            Padding(
              padding: const EdgeInsets.all(Dimens.spacing),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: colors.onBrand.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(Dimens.radius),
                    ),
                    child: Icon(LucideIcons.columns2, color: colors.onBrand, size: Dimens.icon),
                  ),
                  const SizedBox(width: Dimens.spacingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.evidenceCompareTitle,
                          style: context.mboaText.label.copyWith(color: colors.onBrand, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          l10n.evidenceCompareHint,
                          style: context.mboaText.caption.copyWith(color: colors.onBrand.withValues(alpha: 0.85)),
                        ),
                      ],
                    ),
                  ),
                  Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.onBrand),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BatchRow extends StatelessWidget {
  const _BatchRow({required this.batch, required this.onTap});

  final EvidenceBatch batch;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final at = batch.recordedAt;

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimens.radiusMd),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMd),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: colors.primaryPale, borderRadius: BorderRadius.circular(Dimens.radius)),
                  child: Icon(LucideIcons.camera, color: colors.primary, size: Dimens.icon),
                ),
                const SizedBox(width: Dimens.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        [
                          for (final phase in batch.phases) evidencePhaseLabel(l10n, phase),
                          l10n.evidencePhotoCount(batch.photos.length),
                        ].join(' · '),
                        style: context.mboaText.label.copyWith(color: colors.ink),
                      ),
                      if (at != null)
                        Text(
                          l10n.evidenceRecordedOn(DateFormat.yMMMd(locale).add_Hm().format(at)),
                          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                        ),
                      Text(
                        batch.isAcknowledged ? l10n.evidenceSeen : l10n.evidenceNotSeen,
                        style: context.mboaText.caption.copyWith(
                          color: batch.isAcknowledged ? colors.success : colors.warning,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One sending (RM-M30-12): its photos by room, each with its phase and the
/// tenant's word; full screen on a tap. The landlord acknowledges it, once,
/// with a word the tenant reads — he can neither contest nor delete.
class EvidenceBatchView extends StatelessWidget {
  const EvidenceBatchView({super.key});

  Future<void> _acknowledge(BuildContext context) async {
    final l10n = I18n.of(context);
    final bloc = context.read<EvidenceBatchBloc>();
    final comment = await showDialog<String>(context: context, builder: (_) => _AckDialog(l10n: l10n));
    if (comment != null) bloc.add(EvidenceAcknowledged(comment: comment));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return BlocConsumer<EvidenceBatchBloc, EvidenceBatchState>(
      listenWhen: (_, current) => current is EvidenceBatchReady && (current.acknowledged || current.failed),
      listener: (context, state) {
        if (state is EvidenceBatchReady && state.acknowledged) {
          MboaToast.success(context: context, title: l10n.evidenceAckToast);
        } else {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.evidenceTitle)),
        body: switch (state) {
          EvidenceBatchLoading() => const Center(child: Loader()),
          EvidenceBatchFailure(:final contractId, :final batchId) => Center(
              child: TextButton(
                onPressed: () =>
                    context.read<EvidenceBatchBloc>().add(EvidenceBatchOpened(contractId: contractId, batchId: batchId)),
                child: Text(l10n.commonRetry),
              ),
            ),
          EvidenceBatchReady(:final batch) => ListView(
              padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
              children: [
                if (batch.recordedAt case final at?)
                  Text(
                    l10n.evidenceRecordedOn(DateFormat.yMMMMd(locale).add_Hm().format(at)),
                    style: context.mboaText.label.copyWith(color: colors.ink),
                  ),
                const SizedBox(height: Dimens.spacingSm),
                Container(
                  padding: const EdgeInsets.all(Dimens.spacingMd),
                  decoration: BoxDecoration(
                    color: (batch.isAcknowledged ? colors.success : colors.warning).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(Dimens.radiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        batch.acknowledgedAt == null
                            ? l10n.evidenceNotSeen
                            : l10n.evidenceSeenOn(DateFormat.yMMMd(locale).format(batch.acknowledgedAt!)),
                        style: context.mboaText.label.copyWith(
                          color: batch.isAcknowledged ? colors.success : colors.warning,
                        ),
                      ),
                      if (batch.ownerComment case final comment?)
                        Text('« $comment »', style: context.mboaText.body.copyWith(color: colors.ink)),
                    ],
                  ),
                ),
                for (final room in {for (final p in batch.photos) (p.room, p.roomLabel)}) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: Dimens.spacingLg, bottom: Dimens.spacingSm),
                    child: Text(
                      room.$2 ?? evidenceRoomLabel(l10n, room.$1),
                      style: context.mboaText.h3.copyWith(color: colors.primaryDark),
                    ),
                  ),
                  Wrap(
                    spacing: Dimens.spacingSm,
                    runSpacing: Dimens.spacingSm,
                    children: [
                      for (final photo in batch.photos)
                        if (photo.room == room.$1 && photo.roomLabel == room.$2) _PhotoTile(photo: photo),
                    ],
                  ),
                ],
              ],
            ),
        },
        // Once, and only where the server allows it (Doc05 §6.1: no bar
        // otherwise).
        bottomNavigationBar: state is EvidenceBatchReady && state.batch.canAcknowledge
            ? Container(
                decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
                child: SafeArea(
                  minimum: const EdgeInsets.all(Dimens.spacing),
                  child: Button.primary(
                    title: l10n.evidenceAcknowledge,
                    isLoading: state.isBusy,
                    onPressed: state.isBusy ? null : () => _acknowledge(context),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.photo});

  final EvidencePhoto photo;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return SizedBox(
      width: 104,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: photo.downloadUrl == null ? null : () => showEvidencePhoto(context, photo),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.radius),
              child: SizedBox.square(dimension: 104, child: MboaNetworkImage(url: photo.downloadUrl)),
            ),
          ),
          Text(
            evidencePhaseLabel(l10n, photo.phase),
            style: context.mboaText.micro.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
          ),
          if (photo.comment case final comment?)
            Text(
              comment,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.mboaText.micro.copyWith(color: colors.textSecondary),
            ),
        ],
      ),
    );
  }
}

class _AckDialog extends StatefulWidget {
  const _AckDialog({required this.l10n});

  final I18n l10n;

  @override
  State<_AckDialog> createState() => _AckDialogState();
}

class _AckDialogState extends State<_AckDialog> {
  final _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return AlertDialog(
      title: Text(l10n.evidenceAckTitle),
      content: TextField(
        controller: _comment,
        maxLines: 3,
        maxLength: 500,
        decoration: InputDecoration(hintText: l10n.evidenceAckHint),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
        TextButton(onPressed: () => Navigator.of(context).pop(_comment.text.trim()), child: Text(l10n.evidenceAcknowledge)),
      ],
    );
  }
}
