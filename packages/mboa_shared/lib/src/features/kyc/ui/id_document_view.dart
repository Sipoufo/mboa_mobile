import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../media/capture_source_sheet.dart';
import '../logic/kyc_cubit.dart';
import '../models/document_identity.dart';
import '../models/kyc_draft.dart';
import 'document_identity_fields.dart';

/// ID document capture: first the document-type grid, then its photos and
/// what is printed on it (§39 B).
class IdDocumentView extends StatelessWidget {
  const IdDocumentView({super.key, this.types = KycDocType.values});

  /// What this app offers: the Pro app all three, the tenant app the CNI and
  /// the passport (§39 C).
  final List<KycDocType> types;

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
                ? _TypePicker(state: state, types: types)
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
  const _TypePicker({required this.state, required this.types});

  final KycReady state;
  final List<KycDocType> types;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final cubit = context.read<KycCubit>();

    IconData icon(KycDocType type) => switch (type) {
          KycDocType.cni => LucideIcons.idCard,
          KycDocType.passport => LucideIcons.bookMarked,
          KycDocType.drivingLicence => LucideIcons.car,
        };

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
              for (final type in types)
                _TypeTile(
                  icon: icon(type),
                  label: kycDocTypeLabel(l10n, type),
                  onTap: () => cubit.selectDocType(type),
                ),
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

    final type = state.draft.docType!;
    final done = state.draft.documentDoneOn(DateTime.now());

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(Dimens.spacingLg),
            children: [
              // The type chosen, and the way back to the grid.
              Row(
                children: [
                  Expanded(
                    child: Text(
                      kycDocTypeLabel(l10n, type),
                      style: context.mboaText.label.copyWith(color: context.mboaColors.primaryDark),
                    ),
                  ),
                  TextButton(
                    onPressed: state.busy ? null : cubit.clearDocType,
                    child: Text(l10n.kycChangeDocument),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.spacingSm),
              _SideTile(
                label: l10n.kycRecto,
                captured: state.draft.has(KycSlot.idFront),
                uploading: state.uploading == KycSlot.idFront,
                enabled: !state.busy,
                onTap: () => capture(KycSlot.idFront),
              ),
              // A passport has no back (§39 B).
              if (type.hasBack) ...[
                const SizedBox(height: Dimens.spacing),
                _SideTile(
                  label: l10n.kycVerso,
                  captured: state.draft.has(KycSlot.idBack),
                  uploading: state.uploading == KycSlot.idBack,
                  enabled: !state.busy,
                  onTap: () => capture(KycSlot.idBack),
                ),
              ],
              const SizedBox(height: Dimens.spacingLg),
              Text(
                l10n.kycDocumentDetails,
                style: context.mboaText.label.copyWith(color: context.mboaColors.primaryDark),
              ),
              const SizedBox(height: Dimens.spacingSm),
              DocumentIdentityFields(value: state.draft.identity, onChanged: cubit.setIdentity),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          child: Button.primary(
            title: l10n.kycDone,
            onPressed: done ? () => Navigator.of(context).maybePop() : null,
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
