import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/contract_detail_bloc.dart';
import 'widgets/contract_bits.dart';
import 'widgets/sign_contract_sheet.dart';

/// One Contrat Mboa, and everything the prestataire may do to it (CDC M08).
///
/// The screen is organised around RM-M08-09: whose move it is, first; then the
/// terms; then the negotiation, objection by objection. Actions come from the
/// server's own verdicts — `awaiting`, `canSign`, `status` — never re-derived.
@RoutePage()
class ContractDetailPage extends StatelessWidget implements AutoRouteWrapper {
  const ContractDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider<ContractDetailBloc>(
        create: (_) =>
            getIt<ContractDetailBloc>()..add(ContractRequested(id)),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.contractDetailTitle)),
      body: BlocConsumer<ContractDetailBloc, ContractDetailState>(
        listenWhen: (prev, curr) =>
            curr is ContractWasCancelled ||
            (curr is ContractDetailReady &&
                (curr.lastActionFailed || curr.justActed || curr.pdfUrl != null)),
        listener: (context, state) {
          if (state is ContractWasCancelled) {
            context.router.maybePop();
            return;
          }
          final ready = state as ContractDetailReady;
          if (ready.lastActionFailed) {
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: l10n.contractActionFailed,
            );
            return;
          }
          if (ready.pdfUrl case final url?) {
            // CA-M08-01 — the URL is short-lived, and nothing in the app opens
            // one yet (url_launcher is unwired everywhere else), so it is
            // copied rather than half-opened.
            Clipboard.setData(ClipboardData(text: url));
            MboaToast.success(context: context, title: l10n.contractPdfCopied);
            return;
          }
          if (ready.justActed) {
            MboaToast.success(context: context, title: l10n.contractActionDone);
          }
        },
        builder: (context, state) => switch (state) {
          ContractDetailInitial() || ContractDetailLoadInProgress() =>
            const Center(child: Loader()),
          ContractWasCancelled() => const Center(child: Loader()),
          ContractDetailFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<ContractDetailBloc>()
                    .add(ContractRequested(id)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final ContractDetailReady ready => _Body(state: ready),
        },
      ),
      bottomNavigationBar: BlocBuilder<ContractDetailBloc, ContractDetailState>(
        builder: (context, state) => state is ContractDetailReady
            ? _ActionBar(state: state)
            : const SizedBox.shrink(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final ContractDetailReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final contract = state.contract;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacingXl,
      ),
      children: [
        _HeaderCard(contract: contract),
        const SizedBox(height: Dimens.spacing),
        _Card(title: l10n.contractTermsTitle, child: _Terms(contract: contract)),
        const SizedBox(height: Dimens.spacing),
        _Card(
          title: l10n.contractPartiesTitle,
          child: _Parties(contract: contract),
        ),
        if (contract.changeRequests.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacing),
          _Card(
            title: l10n.contractChangesTitle,
            child: _Changes(state: state),
          ),
        ],
        if (contract.signatures.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacing),
          _Card(
            title: l10n.contractSignaturesTitle,
            child: _Signatures(contract: contract),
          ),
        ],
      ],
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.contract});

  final Contract contract;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(Dimens.spacingLg),
      decoration: BoxDecoration(
        color: colors.primaryLight2,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  contract.annonceTitle ?? '',
                  style: context.mboaText.h3.copyWith(color: colors.primaryDark),
                ),
              ),
              ContractStatusChip(status: contract.status),
            ],
          ),
          const SizedBox(height: Dimens.spacingXs),
          Text(
            // CA-M08-02 — the exact address is withheld until both signatures
            // are in; until then the contract shows the quartier, like the
            // listing does.
            contract.exactAddress ??
                [contract.district, contract.city].nonNulls.join(' · '),
            style: context.mboaText.body.copyWith(color: colors.primaryDark),
          ),
          const SizedBox(height: Dimens.spacingSm),
          AwaitingLine(awaiting: contract.awaiting),
          if (contract.isLocked) ...[
            const SizedBox(height: Dimens.spacingSm),
            Row(
              children: [
                Icon(LucideIcons.lock, size: Dimens.iconSm, color: colors.primaryDark),
                const SizedBox(width: Dimens.spacingSm),
                Expanded(
                  child: Text(
                    l10n.contractLocked,
                    style: context.mboaText.caption
                        .copyWith(color: colors.primaryDark),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Terms extends StatelessWidget {
  const _Terms({required this.contract});

  final Contract contract;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    final rows = <(String, String)>[
      if (contract.price case final price?)
        (l10n.contractTermPrice, contract.rentalPeriod.priceLabel(l10n, price)),
      if (contract.depositAmount case final deposit?)
        (l10n.contractTermDeposit, moneyLabel(deposit)),
      (
        l10n.contractTermCharges,
        (contract.chargesIncluded ?? false)
            ? l10n.annonceDetailChargesIncluded
            : l10n.annonceDetailChargesExtra,
      ),
      if (contract.startDate case final start?)
        (l10n.contractTermStart, DateFormat.yMMMMd().format(start)),
      if (contract.durationUnits case final units?)
        (
          l10n.contractTermDuration,
          durationLabel(l10n, units, contract.rentalPeriod),
        ),
      if (contract.endDate case final end?)
        (l10n.contractTermEnd, DateFormat.yMMMMd().format(end)),
      (
        l10n.contractTermTacit,
        (contract.tacitRenewal ?? false) ? l10n.commonYes : l10n.commonNo,
      ),
    ];

    return Column(
      children: [
        for (final (label, value) in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: context.mboaText.body
                        .copyWith(color: context.mboaColors.textSecondary),
                  ),
                ),
                Text(
                  value,
                  style: context.mboaText.label
                      .copyWith(color: context.mboaColors.ink),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Parties extends StatelessWidget {
  const _Parties({required this.contract});

  final Contract contract;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Column(
      children: [
        _Party(
          role: l10n.contractPartyPrestataire,
          participant: contract.prestataire,
        ),
        const SizedBox(height: Dimens.spacingMd),
        _Party(
          role: l10n.contractPartyTenant,
          participant: contract.tenant,
          fallback: l10n.contractTenantPending,
        ),
        // RM-M08-07 — the agent who conducted the visit is carried by the
        // contract, and gets the V1 bonus from it.
        if (contract.agent case final agent?) ...[
          const SizedBox(height: Dimens.spacingMd),
          _Party(role: l10n.contractPartyAgent, participant: agent),
        ],
      ],
    );
  }
}

class _Party extends StatelessWidget {
  const _Party({required this.role, this.participant, this.fallback});

  final String role;
  final ContractParticipant? participant;
  final String? fallback;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final name = participant?.displayName ?? fallback ?? '';

    return Row(
      children: [
        MboaAvatar(
          imageUrl: participant?.photoUrl,
          initials: name.isEmpty ? '' : name[0].toUpperCase(),
          size: Dimens.avatar,
        ),
        const SizedBox(width: Dimens.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: context.mboaText.label.copyWith(color: colors.ink),
              ),
              Text(
                role,
                style: context.mboaText.caption
                    .copyWith(color: colors.textTertiary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// CE-M08-03 — every objection, and the answer it is owed.
class _Changes extends StatelessWidget {
  const _Changes({required this.state});

  final ContractDetailReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final change in state.contract.changeRequests)
          Padding(
            padding: const EdgeInsets.only(bottom: Dimens.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        change.isWithdrawn
                            ? l10n.contractChangeWithdrawn
                            : change.pending
                                ? l10n.contractChangePending
                                : l10n.contractChangeAnswered,
                        style: context.mboaText.label.copyWith(
                          color: change.pending && !change.isWithdrawn
                              ? colors.warning
                              : colors.textSecondary,
                        ),
                      ),
                    ),
                    if (change.createdAt case final at?)
                      Text(
                        DateFormat.yMMMd().format(at),
                        style: context.mboaText.caption
                            .copyWith(color: colors.textTertiary),
                      ),
                  ],
                ),
                if (change.contestedTerms.isNotEmpty) ...[
                  const SizedBox(height: Dimens.spacingXs),
                  Wrap(
                    spacing: Dimens.spacingXs,
                    runSpacing: Dimens.spacingXs,
                    children: [
                      for (final term in change.contestedTerms)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.spacingSm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colors.warning.withValues(alpha: 0.12),
                            borderRadius:
                                BorderRadius.circular(Dimens.radiusFull),
                          ),
                          child: Text(
                            _termLabel(l10n, term),
                            style: context.mboaText.caption
                                .copyWith(color: colors.warning),
                          ),
                        ),
                    ],
                  ),
                ],
                if (change.comment case final comment?) ...[
                  const SizedBox(height: Dimens.spacingSm),
                  Text(
                    comment,
                    style: context.mboaText.body.copyWith(color: colors.ink),
                  ),
                ],
                if (change.response case final response?) ...[
                  const SizedBox(height: Dimens.spacingSm),
                  Container(
                    padding: const EdgeInsets.all(Dimens.spacingMd),
                    decoration: BoxDecoration(
                      color: colors.surfaceWarm,
                      borderRadius: BorderRadius.circular(Dimens.radius),
                    ),
                    child: Text(
                      response,
                      style: context.mboaText.body
                          .copyWith(color: colors.textSecondary),
                    ),
                  ),
                ],
                if (change.pending && !change.isWithdrawn) ...[
                  const SizedBox(height: Dimens.spacingSm),
                  Button.outline(
                    title: l10n.contractChangeAnswer,
                    onPressed: state.isBusy
                        ? null
                        : () => _answer(context, change),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }

  Future<void> _answer(BuildContext context, ChangeRequest change) async {
    final l10n = I18n.of(context);
    final bloc = context.read<ContractDetailBloc>();

    final body = await showDialog<String>(
      context: context,
      builder: (_) => _AnswerDialog(title: l10n.contractChangeAnswer),
    );
    if (body == null || body.trim().isEmpty) return;

    bloc.add(ContractChangeAnswered(changeId: change.id, body: body));
  }

  static String _termLabel(I18n l10n, ContestedTerm term) => switch (term) {
        ContestedTerm.price => l10n.contractTermPrice,
        ContestedTerm.rentalPeriod => l10n.contractTermPeriod,
        ContestedTerm.depositAmount => l10n.contractTermDeposit,
        ContestedTerm.chargesIncluded => l10n.contractTermCharges,
        ContestedTerm.startDate => l10n.contractTermStart,
        ContestedTerm.durationUnits => l10n.contractTermDuration,
        ContestedTerm.tacitRenewal => l10n.contractTermTacit,
      };
}

/// Owns its controller, so the framework disposes it once the dialog is gone.
class _AnswerDialog extends StatefulWidget {
  const _AnswerDialog({required this.title});

  final String title;

  @override
  State<_AnswerDialog> createState() => _AnswerDialogState();
}

class _AnswerDialogState extends State<_AnswerDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CE-M08-03 — a refusal is a legitimate answer and belongs in the
          // file; the copy says so, or the landlord thinks he must concede.
          Text(l10n.contractChangeAnswerHelp),
          const SizedBox(height: Dimens.spacing),
          TextField(
            controller: _controller,
            autofocus: true,
            maxLines: 4,
            maxLength: 2000,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
          child: Text(l10n.contractChangeAnswerSend),
        ),
      ],
    );
  }
}

class _Signatures extends StatelessWidget {
  const _Signatures({required this.contract});

  final Contract contract;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      children: [
        for (final signature in contract.signatures)
          Padding(
            padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
            child: Row(
              children: [
                Icon(
                  LucideIcons.circleCheck,
                  size: Dimens.icon,
                  color: colors.success,
                ),
                const SizedBox(width: Dimens.spacingMd),
                Expanded(
                  child: Text(
                    signature.isMine
                        ? l10n.contractSignatureMine
                        : l10n.contractSignatureOther,
                    style: context.mboaText.body.copyWith(color: colors.ink),
                  ),
                ),
                if (signature.signedAt case final at?)
                  Text(
                    DateFormat.yMMMd().add_Hm().format(at),
                    style: context.mboaText.caption
                        .copyWith(color: colors.textTertiary),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

/// What he may do, from the server's verdicts alone.
class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.state});

  final ContractDetailReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final contract = state.contract;

    final children = <Widget>[];

    if (contract.status == ContractStatus.draft) {
      children.add(
        Button.primary(
          title: l10n.contractSend,
          isLoading: state.isBusy,
          onPressed: state.isBusy
              ? null
              : () => context.read<ContractDetailBloc>().add(const ContractSent()),
        ),
      );
    } else if (contract.canSign) {
      children.add(
        Button.primary(
          title: contract.hasSignedMyself
              ? l10n.contractSignedByYou
              : l10n.contractSign,
          isLoading: state.isBusy,
          onPressed: state.isBusy || contract.hasSignedMyself
              ? null
              : () => _sign(context, contract),
        ),
      );
    } else if (contract.isSigned) {
      children.add(
        Button.primary(
          title: l10n.contractPdf,
          isLoading: state.isBusy,
          onPressed: state.isBusy
              ? null
              : () => context
                  .read<ContractDetailBloc>()
                  .add(const ContractPdfRequested()),
        ),
      );
    }

    // RM-M08-08 — amendable only while nobody has accepted; the pending
    // objections are what he is expected to answer first.
    if (contract.status.isAmendable) {
      children.add(
        Button.outline(
          title: l10n.contractAmend,
          onPressed: state.isBusy
              ? null
              : () => context.router.push(
                    ContractFormRoute(
                      annonceId: contract.annonceId ?? '',
                      contractId: contract.id,
                    ),
                  ),
        ),
      );
    }

    if (contract.status.isOpen && !contract.isLocked) {
      children.add(
        TextButton(
          onPressed: state.isBusy ? null : () => _cancel(context),
          style: TextButton.styleFrom(foregroundColor: colors.error),
          child: Text(l10n.contractCancel),
        ),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.all(Dimens.spacing),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final child in children) ...[
              child,
              if (child != children.last) const SizedBox(height: Dimens.spacingSm),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _sign(BuildContext context, Contract contract) async {
    final bloc = context.read<ContractDetailBloc>();
    final confirmed = await showSignContractSheet(context, contract: contract);
    if (confirmed ?? false) bloc.add(const ContractSigned());
  }

  Future<void> _cancel(BuildContext context) async {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<ContractDetailBloc>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.contractCancel),
        content: Text(l10n.contractCancelConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: colors.error),
            child: Text(l10n.contractCancel),
          ),
        ],
      ),
    );

    if (confirmed ?? false) bloc.add(const ContractCancelled());
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.spacingLg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.mboaText.h3.copyWith(color: colors.primaryDark),
          ),
          const SizedBox(height: Dimens.spacing),
          child,
        ],
      ),
    );
  }
}
