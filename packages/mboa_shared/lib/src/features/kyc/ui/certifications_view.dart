import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../media/capture_source_sheet.dart';
import '../../profile/models/account_role.dart';
import '../logic/kyc_cubit.dart';
import '../models/document_identity.dart';
import '../models/kyc_draft.dart';
import '../models/kyc_status.dart';
import 'kyc_declarations.dart';

/// Certifications (CDC M01bis): a Statut tab (account verification state) and an
/// Identification tab (documents to provide). Adapts to the loaded [KycStatus];
/// captures the selfie inline and delegates the ID document to its own screen.
///
/// Both apps (§39 C): the tenant's has no NUI and no address
/// ([withDeclarations] off), and each app opens its own ID document route.
class CertificationsView extends StatefulWidget {
  const CertificationsView({
    super.key,
    this.accountRole = AccountRole.user,
    required this.onOpenIdDocument,
    this.withDeclarations = false,
    this.nuiRequired = false,
    this.documentTypes = KycDocType.values,
  });

  final AccountRole accountRole;
  final VoidCallback onOpenIdDocument;

  /// §37 B — the NUI and the address: a prestataire's or an agent's only.
  final bool withDeclarations;

  /// RM-M01bis-10 — an agence or a promoteur owes a NUI; the app knows which
  /// it is. The server holds the rule (`NUI_REQUIRED`) either way.
  final bool nuiRequired;

  /// What this app offers as a document (the tenant's: CNI and passport).
  final List<KycDocType> documentTypes;

  @override
  State<CertificationsView> createState() => _CertificationsViewState();
}

class _CertificationsViewState extends State<CertificationsView> {
  int _tab = 1; // Identification, matching the design's default.

  /// §40 F — the document's details, typed once on an approved KYC.
  Future<void> _addDocument(BuildContext context, KycReady state) async {
    final cubit = context.read<KycCubit>();
    final identity = await showDocumentSheet(context, types: widget.documentTypes, initial: state.status.identity);
    if (identity != null) await cubit.addDocument(identity);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(I18n.of(context).settingsCertificationsTitle),
        automaticallyImplyLeading: false,
        leading: MboaHeaderBackButton.leading(context),
      ),
      body: SafeArea(
        child: BlocConsumer<KycCubit, KycState>(
          listenWhen: (prev, curr) =>
              curr is KycReady && (curr.error != null || curr.justSubmitted || curr.addedDocument),
          listener: (context, state) {
            if (state is! KycReady) return;
            if (state.addedDocument) {
              MboaToast.success(context: context, title: l10n.kycDocumentAdded);
            } else if (state.justSubmitted) {
              MboaToast.success(context: context, title: l10n.kycSubmitted);
            } else if (state.error != null) {
              MboaToast.error(
                context: context,
                title: l10n.commonErrorTitle,
                description: switch (state.error!) {
                  KycError.uploadFailed => l10n.kycUploadError,
                  KycError.invalidNui => l10n.kycNuiInvalid,
                  KycError.nuiRequired => l10n.kycNuiRequiredError,
                  KycError.unknownDistrict => l10n.kycUnknownDistrict,
                  KycError.documentExpired => l10n.kycDocumentExpired,
                  KycError.issuedInFuture => l10n.kycIssuedInFuture,
                  KycError.backRequired => l10n.kycBackRequired,
                  KycError.submitFailed => l10n.commonError,
                },
              );
            }
          },
          builder: (context, state) {
            final loading = state is KycInitial ||
                state is KycLoadInProgress ||
                (state is KycReady && state.submitting);
            return StackedLoaderView(
              isLoading: loading,
              child: Column(
                children: [
                  const SizedBox(height: Dimens.spacing,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingLg),
                    child: MboaSegmentedControl<int>(
                      value: _tab,
                      backgroundColor: colors.primaryLight2,
                      selectedColor: colors.surface,
                      selectedTextColor: colors.primaryDark,
                      unselectedTextColor: colors.primaryDark,
                      onChanged: (i) => setState(() => _tab = i),
                      segments: [
                        MboaSegment(value: 0, label: l10n.kycTabStatut),
                        MboaSegment(value: 1, label: l10n.kycTabIdentification),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimens.spacingLg),
                  Expanded(
                    child: switch (state) {
                      KycReady() => IndexedStack(
                          index: _tab,
                          sizing: StackFit.expand,
                          children: [
                            _StatutTab(
                              state: state,
                              accountRole: widget.accountRole,
                              onAddDocument: () => _addDocument(context, state),
                            ),
                            _IdentificationTab(
                              state: state,
                              onOpenIdDocument: widget.onOpenIdDocument,
                              onAddDocument: () => _addDocument(context, state),
                              withDeclarations: widget.withDeclarations,
                              nuiRequired: widget.nuiRequired,
                            ),
                          ],
                        ),
                      KycLoadFailure() => _ErrorRetry(onRetry: () => context.read<KycCubit>().load()),
                      _ => const SizedBox.shrink(),
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Maps a [KycStatus] to its localised label + accent colour.
({String label, Color color}) _statusChip(BuildContext context, I18n l10n, KycStatus status) {
  final colors = context.mboaColors;
  return switch (status) {
    KycStatus.notSubmitted => (label: l10n.kycStatusNotSubmitted, color: colors.textSecondary),
    KycStatus.pending => (label: l10n.kycStatusPending, color: colors.primary),
    KycStatus.approved => (label: l10n.kycStatusApproved, color: colors.success),
    KycStatus.rejected => (label: l10n.kycStatusRejected, color: colors.error),
  };
}

class _StatutTab extends StatelessWidget {
  const _StatutTab({required this.state, required this.accountRole, required this.onAddDocument});

  final KycReady state;
  final AccountRole accountRole;
  final VoidCallback onAddDocument;

  String _accountLabel(I18n l10n) => switch (accountRole) {
        AccountRole.agent => l10n.kycAccountAgent,
        AccountRole.prestataire => l10n.kycAccountPrestataire,
        _ => l10n.kycAccountStandard,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final chip = _statusChip(context, l10n, state.status.status);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingLg),
      child: Column(
        children: [
          if (state.status.status == KycStatus.rejected) ...[
            _RefusalCard(status: state.status),
            const SizedBox(height: Dimens.spacing),
          ],
          if (state.status.canAddDocument) ...[
            _DocumentMissingCard(onComplete: onAddDocument),
            const SizedBox(height: Dimens.spacing),
          ],
          MboaTileCard(
            icon: LucideIcons.userRound,
            title: _accountLabel(l10n),
            subtitle: chip.label,
            subtitleColor: chip.color,
            enabled: true,
            trailing: Icon(
              switch (state.status.status) {
                KycStatus.approved => LucideIcons.badgeCheck,
                // A refusal is not a wait: it used to show the same clock.
                KycStatus.rejected => LucideIcons.shieldX,
                _ => LucideIcons.clock,
              },
              color: chip.color,
              size: Dimens.iconLg,
            ),
          ),
        ],
      ),
    );
  }
}

class _IdentificationTab extends StatelessWidget {
  const _IdentificationTab({
    required this.state,
    required this.onOpenIdDocument,
    required this.onAddDocument,
    required this.withDeclarations,
    required this.nuiRequired,
  });

  final KycReady state;
  final VoidCallback onOpenIdDocument;
  final VoidCallback onAddDocument;
  final bool withDeclarations;
  final bool nuiRequired;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final status = state.status.status;
    final chip = _statusChip(context, l10n, status);
    // Editable only before submission (or after a rejection).
    final editable = status == KycStatus.notSubmitted || status == KycStatus.rejected;

    // After a refusal every piece is taken again — « À reprendre », not a
    // « Refusé » on each, when the admin may have pointed at one.
    ({String label, Color color}) rowChip(bool captured) => switch ((captured, status)) {
          (true, _) => (label: l10n.kycAdded, color: colors.success),
          (false, KycStatus.rejected) => (label: l10n.kycToRedo, color: colors.warning),
          _ => chip,
        };

    final selfie = rowChip(state.draft.has(KycSlot.selfie));
    // Photographed, and what it says filled in (§39 B).
    final idDone = state.draft.documentDoneOn(DateTime.now());
    final idChip = rowChip(idDone);

    final nui = KycDraft.normalizeNui(state.draft.nui);

    Future<void> editNui() async {
      final cubit = context.read<KycCubit>();
      final adding = state.status.canAddNui;
      final typed = await showNuiSheet(context, initial: state.draft.nui, required: nuiRequired, isAddition: adding);
      if (typed == null) return;
      adding ? await cubit.addNui(typed) : cubit.setNui(typed);
    }

    Future<void> editAddress() async {
      final cubit = context.read<KycCubit>();
      final choice = await showAddressSheet(context, initial: state.draft.address);
      if (choice != null) cubit.setAddress(choice.address);
    }

    Future<void> captureSelfie() async {
      final source = await showCaptureSourceSheet(context);
      if (source != null && context.mounted) {
        await context.read<KycCubit>().capture(KycSlot.selfie, source);
      }
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              Dimens.spacingLg,
              0,
              Dimens.spacingLg,
              Dimens.spacingLg,
            ),
            children: [
              if (status == KycStatus.rejected) ...[
                _RefusalCard(status: state.status),
                const SizedBox(height: Dimens.spacing),
              ],
              if (state.status.canAddDocument) ...[
                _DocumentMissingCard(onComplete: onAddDocument),
                const SizedBox(height: Dimens.spacing),
              ],
              MboaTileCard(
                icon: LucideIcons.smile,
                title: l10n.kycItemSelfie,
                subtitle: selfie.label,
                subtitleColor: selfie.color,
                enabled: editable && !state.busy,
                trailing: state.uploading == KycSlot.selfie ? Loader.sm() : null,
                onTap: captureSelfie,
              ),
              const SizedBox(height: Dimens.spacing),
              // §40 F — approved without its details: they are added here,
              // the photos stay as verified.
              if (state.status.canAddDocument)
                MboaTileCard(
                  icon: LucideIcons.fileCheck,
                  title: l10n.kycItemIdDocument,
                  subtitle: l10n.kycToComplete,
                  subtitleColor: colors.warning,
                  enabled: !state.busy,
                  onTap: onAddDocument,
                )
              else
                MboaTileCard(
                  icon: LucideIcons.fileCheck,
                  title: l10n.kycItemIdDocument,
                  subtitle: idChip.label,
                  subtitleColor: idChip.color,
                  enabled: editable && !state.busy,
                  onTap: onOpenIdDocument,
                ),
              // §37 B — declared beside the documents, seen by the admin alone.
              if (withDeclarations) ...[
              const SizedBox(height: Dimens.spacing),
              MboaTileCard(
                icon: LucideIcons.hash,
                title: l10n.kycItemNui,
                subtitle: nui ?? (nuiRequired ? l10n.kycNuiRequiredHint : l10n.kycOptional),
                subtitleColor: nui == null && nuiRequired ? colors.warning : null,
                // RM-M01bis-10 — an approved KYC may still receive one.
                enabled: (editable || state.status.canAddNui) && !state.busy,
                trailing: state.status.canAddNui ? Text(l10n.kycAddNui, style: context.mboaText.caption.copyWith(color: colors.primary)) : null,
                onTap: () => editNui(),
              ),
              const SizedBox(height: Dimens.spacing),
              MboaTileCard(
                icon: LucideIcons.mapPin,
                title: l10n.kycItemAddress,
                subtitle: state.draft.address?.label ?? l10n.kycOptional,
                enabled: editable && !state.busy,
                onTap: () => editAddress(),
              ),
              ],
            ],
          ),
        ),
        if (editable)
          Padding(
            padding: const EdgeInsets.all(Dimens.spacingLg),
            child: Button.primary(
              title: status == KycStatus.rejected ? l10n.kycResubmit : l10n.kycSubmit,
              isLoading: state.submitting,
              onPressed: state.draft.canSubmit(nuiRequired: withDeclarations && nuiRequired) && !state.busy
                  ? () => context.read<KycCubit>().submit()
                  : null,
            ),
          ),
      ],
    );
  }
}

/// §40 F — approved before the document's details were asked: say so, and
/// the way to add them, in the invitation banner's pale face.
class _DocumentMissingCard extends StatelessWidget {
  const _DocumentMissingCard({required this.onComplete});

  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Material(
      color: colors.primaryPale,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onComplete,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.idCard, color: colors.primary),
                  const SizedBox(width: Dimens.spacingMd),
                  Expanded(
                    child: Text(
                      l10n.kycDocumentMissingTitle,
                      style: context.mboaText.label.copyWith(color: colors.primaryDark),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.spacingSm),
              Text(l10n.kycDocumentMissingBody, style: context.mboaText.caption.copyWith(color: colors.ink)),
              const SizedBox(height: Dimens.spacingSm),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  l10n.kycDocumentMissingAction,
                  style: context.mboaText.label.copyWith(color: colors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A refused KYC, said once at the top of either tab — in the invitation
/// banner's shape: when, the admin's reason in full, and what to do.
class _RefusalCard extends StatelessWidget {
  const _RefusalCard({required this.status});

  final KycStatusData status;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final reason = status.rejectionReason?.trim();
    final on = status.reviewedAt;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.shieldX, color: colors.error),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.kycRefusalTitle, style: context.mboaText.label.copyWith(color: colors.error)),
                    if (on != null)
                      Text(
                        l10n.kycRefusalOn(DateFormat.yMMMMd(locale).format(on.toLocal())),
                        style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (reason != null && reason.isNotEmpty) ...[
            const SizedBox(height: Dimens.spacingMd),
            // The admin's words, quoted whole: they say what to fix.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(Dimens.spacingMd, Dimens.spacingSm, Dimens.spacingSm, Dimens.spacingSm),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(Dimens.radiusSm),
                border: Border(left: BorderSide(color: colors.error, width: 3)),
              ),
              child: Text(reason, style: context.mboaText.body.copyWith(color: colors.ink)),
            ),
          ],
          const SizedBox(height: Dimens.spacingMd),
          Text(l10n.kycRefusalHelp, style: context.mboaText.caption.copyWith(color: colors.ink)),
        ],
      ),
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.commonError, style: context.mboaText.body),
          const SizedBox(height: Dimens.spacingSm),
          TextButton(onPressed: onRetry, child: Text(l10n.commonRetry)),
        ],
      ),
    );
  }
}
