import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/evidence_send_bloc.dart';

/// A home's photo proofs, the tenant's side (CDC M30 lot 3, RM-M30-11):
/// the shared list, with « Envoyer des photos ».
@RoutePage()
class HomeEvidencePage extends StatelessWidget implements AutoRouteWrapper {
  const HomeEvidencePage({super.key, @PathParam('contractId') required this.contractId});

  final String contractId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<EvidenceBloc>(
        create: (_) => getIt<EvidenceBloc>(param1: contractId)..add(const EvidenceRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => EvidenceView(
        onAdd: () async {
          final bloc = context.read<EvidenceBloc>();
          final sent = await context.router.push<bool>(EvidenceSendRoute(contractId: contractId));
          if (sent ?? false) bloc.add(const EvidenceRequested());
        },
        onOpen: (batch) => context.router.push(HomeEvidenceBatchRoute(contractId: contractId, batchId: batch.id)),
      );
}

/// One sending — the shared view.
@RoutePage()
class HomeEvidenceBatchPage extends StatelessWidget implements AutoRouteWrapper {
  const HomeEvidenceBatchPage({
    super.key,
    @PathParam('contractId') required this.contractId,
    @PathParam('batchId') required this.batchId,
  });

  final String contractId;
  final String batchId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<EvidenceBatchBloc>(
        create: (_) => getIt<EvidenceBatchBloc>()..add(EvidenceBatchOpened(contractId: contractId, batchId: batchId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const EvidenceBatchView();
}

/// « Envoyer des photos ».
@RoutePage()
class EvidenceSendPage extends StatelessWidget implements AutoRouteWrapper {
  const EvidenceSendPage({super.key, @PathParam('contractId') required this.contractId});

  final String contractId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<EvidenceSendBloc>(
        create: (_) => getIt<EvidenceSendBloc>()..add(EvidenceSendStarted(contractId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const EvidenceSendView();
}

/// The sending under its bloc — public so it can be pumped with a mock one:
/// the phase, the photos (each with its room and a word), and « Envoyer ».
class EvidenceSendView extends StatelessWidget {
  const EvidenceSendView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<EvidenceSendBloc, EvidenceSendState>(
      listenWhen: (_, current) =>
          current.sent != null || current.refusal != null || current.failed || current.uploadFailed || current.pickFailed,
      listener: (context, state) {
        if (state.sent != null) {
          MboaToast.success(context: context, title: l10n.evidenceSentTitle, description: l10n.evidenceSentBody);
          context.router.maybePop(true);
          return;
        }
        MboaToast.error(
          context: context,
          title: l10n.commonErrorTitle,
          description: switch (state.refusal) {
            EvidenceRefusal.tooLarge => l10n.evidenceRefusedTooLarge,
            EvidenceRefusal.limitReached => l10n.evidenceRefusedLimit,
            EvidenceRefusal.phaseClosed => l10n.evidenceRefusedPhaseClosed,
            EvidenceRefusal.readOnly => l10n.evidenceRefusedReadOnly,
            EvidenceRefusal.notStored => l10n.evidenceRefusedNotStored,
            EvidenceRefusal.alreadyRecorded => l10n.evidenceRefusedAlready,
            null when state.uploadFailed => l10n.evidenceUploadFailed,
            null => l10n.commonError,
          },
        );
      },
      builder: (context, state) {
        final bloc = context.read<EvidenceSendBloc>();
        final busy = state.isSending || state.isPicking;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.evidenceAdd)),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
            children: [
              MboaSegmentedControl<EvidencePhase>(
                value: state.phase,
                onChanged: (phase) {
                  if (!busy) bloc.add(EvidencePhaseChanged(phase));
                },
                segments: [
                  for (final phase in EvidencePhase.values)
                    MboaSegment(value: phase, label: evidencePhaseLabel(l10n, phase)),
                ],
              ),
              const SizedBox(height: Dimens.spacingMd),
              Text(l10n.evidenceSendHint, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
              const SizedBox(height: Dimens.spacing),
              for (final (index, shot) in state.shots.indexed)
                _ShotRow(key: ValueKey(shot.photo.sha256), index: index, shot: shot, enabled: !busy),
              if (state.hasRoom)
                Row(
                  children: [
                    Expanded(
                      child: Button.outline(
                        title: l10n.evidenceCamera,
                        onPressed: busy ? null : () => bloc.add(const EvidencePhotosPicked(ImageSource.camera)),
                      ),
                    ),
                    const SizedBox(width: Dimens.spacingSm),
                    Expanded(
                      child: Button.outline(
                        title: l10n.evidenceGallery,
                        onPressed: busy ? null : () => bloc.add(const EvidencePhotosPicked(ImageSource.gallery)),
                      ),
                    ),
                  ],
                ),
              if (state.isPicking)
                const Padding(padding: EdgeInsets.all(Dimens.spacing), child: Center(child: Loader())),
            ],
          ),
          bottomNavigationBar: state.shots.isEmpty
              ? null
              : SafeArea(
                  minimum: const EdgeInsets.all(Dimens.spacing),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.isSending) ...[
                        LinearProgressIndicator(
                          value: state.shots.isEmpty ? null : state.uploaded / state.shots.length,
                          color: colors.primary,
                          backgroundColor: colors.primaryPale,
                        ),
                        const SizedBox(height: Dimens.spacingSm),
                      ],
                      Button.primary(
                        title: state.isSending
                            ? l10n.evidenceSending(state.uploaded, state.shots.length)
                            : l10n.evidenceSend(state.shots.length),
                        isLoading: state.isSending,
                        onPressed: busy ? null : () => bloc.add(const EvidenceSendSubmitted()),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

/// One photo to send: its thumbnail, its room, a label for the room if need
/// be (« Chambre 2 »), a word.
class _ShotRow extends StatelessWidget {
  const _ShotRow({super.key, required this.index, required this.shot, required this.enabled});

  final int index;
  final EvidenceShot shot;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<EvidenceSendBloc>();
    final placeholder = SizedBox.square(
      dimension: 80,
      child: ColoredBox(
        color: colors.primaryPale,
        child: Icon(LucideIcons.image, color: colors.primary, size: Dimens.icon),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingMd),
      padding: const EdgeInsets.all(Dimens.spacingSm),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusMd)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.radius),
            child: Image.memory(
              shot.photo.bytes,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              gaplessPlayback: true,
              // While it is drawn, and if the phone cannot draw it (it still
              // goes): a placeholder, never a blank or an error on screen.
              frameBuilder: (_, child, frame, _) => frame == null ? placeholder : child,
              errorBuilder: (_, _, _) => placeholder,
            ),
          ),
          const SizedBox(width: Dimens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<EvidenceRoom>(
                  value: shot.room,
                  isExpanded: true,
                  icon: Icon(LucideIcons.chevronDown, size: Dimens.iconSm, color: colors.textSecondary),
                  underline: const SizedBox.shrink(),
                  items: [
                    for (final room in EvidenceRoom.values)
                      DropdownMenuItem(value: room, child: Text(evidenceRoomLabel(l10n, room))),
                  ],
                  onChanged: enabled ? (room) => bloc.add(EvidenceShotChanged(index, room: room)) : null,
                ),
                TextFormField(
                  initialValue: shot.roomLabel,
                  enabled: enabled,
                  maxLength: 40,
                  decoration: InputDecoration(hintText: l10n.evidenceRoomLabelHint, counterText: '', isDense: true),
                  onChanged: (value) => bloc.add(EvidenceShotChanged(index, roomLabel: value)),
                ),
                const SizedBox(height: Dimens.spacingXs),
                TextFormField(
                  initialValue: shot.comment,
                  enabled: enabled,
                  maxLength: 300,
                  decoration: InputDecoration(hintText: l10n.evidenceCommentHint, counterText: '', isDense: true),
                  onChanged: (value) => bloc.add(EvidenceShotChanged(index, comment: value)),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: l10n.evidenceRemove,
            onPressed: enabled ? () => bloc.add(EvidenceShotRemoved(index)) : null,
            icon: Icon(LucideIcons.x, color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}
