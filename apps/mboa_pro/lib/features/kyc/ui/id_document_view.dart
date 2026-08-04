import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../logic/kyc_cubit.dart';
import '../models/kyc_draft.dart';

/// ID document capture: first the document-type grid, then front/back capture.
class IdDocumentView extends StatelessWidget {
  const IdDocumentView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: BlocBuilder<KycCubit, KycState>(
          builder: (context, state) {
            if (state is! KycReady) return const SizedBox.shrink();
            final body = state.draft.docType == null
                ? _TypePicker(state: state)
                : _SideCapture(state: state);
            return Column(
              children: [
                _TopBar(title: l10n.kycItemIdDocument),
                Expanded(child: body),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TypePicker extends StatelessWidget {
  const _TypePicker({required this.state});

  final KycReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final cubit = context.read<KycCubit>();

    final types = <(KycDocType, IconData, String)>[
      (KycDocType.cni, LucideIcons.idCard, l10n.kycDocCni),
      (KycDocType.recepisse, LucideIcons.bookOpen, l10n.kycDocRecepisse),
      (KycDocType.passport, LucideIcons.bookMarked, l10n.kycDocPassport),
      (KycDocType.residencePermit, LucideIcons.creditCard, l10n.kycDocResidence),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Dimens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.kycIdDocumentPrompt,
            textAlign: TextAlign.center,
            style: context.mboaText.bodyLarge.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: Dimens.spacingLg),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: Dimens.spacing,
            crossAxisSpacing: Dimens.spacing,
            childAspectRatio: 1.2,
            children: [
              for (final (type, icon, label) in types)
                _TypeTile(icon: icon, label: label, onTap: () => cubit.selectDocType(type)),
            ],
          ),
        ],
      ),
    );
  }
}

class _TypeTile extends StatelessWidget {
  const _TypeTile({required this.icon, required this.label, required this.onTap});

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
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Dimens.avatar,
                height: Dimens.avatar,
                decoration: BoxDecoration(
                  color: colors.primaryLight.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(Dimens.radius),
                ),
                child: Icon(icon, color: colors.primaryDark, size: Dimens.iconMd),
              ),
              Text(
                label,
                style: context.mboaText.label.copyWith(color: colors.primaryDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SideCapture extends StatelessWidget {
  const _SideCapture({required this.state});

  final KycReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final cubit = context.read<KycCubit>();

    Future<void> capture(KycSlot slot) async {
      final source = await showCaptureSourceSheet(context);
      if (source != null && context.mounted) await cubit.capture(slot, source);
    }

    final bothCaptured = state.draft.has(KycSlot.idFront) && state.draft.has(KycSlot.idBack);

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(Dimens.spacingLg),
            children: [
              _SideTile(
                label: l10n.kycRecto,
                captured: state.draft.has(KycSlot.idFront),
                uploading: state.uploading == KycSlot.idFront,
                enabled: !state.busy,
                onTap: () => capture(KycSlot.idFront),
              ),
              const SizedBox(height: Dimens.spacing),
              _SideTile(
                label: l10n.kycVerso,
                captured: state.draft.has(KycSlot.idBack),
                uploading: state.uploading == KycSlot.idBack,
                enabled: !state.busy,
                onTap: () => capture(KycSlot.idBack),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          child: Button.primary(
            title: l10n.kycDone,
            onPressed: bothCaptured ? () => Navigator.of(context).maybePop() : null,
          ),
        ),
      ],
    );
  }
}

class _SideTile extends StatelessWidget {
  const _SideTile({
    required this.label,
    required this.captured,
    required this.uploading,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool captured;
  final bool uploading;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    return MboaTileCard(
      icon: captured ? LucideIcons.checkCheck : LucideIcons.image,
      title: label,
      subtitle: captured ? l10n.kycAdded : l10n.kycTakePhoto,
      subtitleColor: captured ? colors.success : null,
      enabled: enabled,
      trailing: uploading ? Loader.sm() : null,
      onTap: onTap,
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing, vertical: Dimens.spacingSm),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(LucideIcons.arrowLeft, color: colors.primary),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: context.mboaText.h3.copyWith(color: colors.primary),
            ),
          ),
          const SizedBox(width: Dimens.iconLg),
        ],
      ),
    );
  }
}
