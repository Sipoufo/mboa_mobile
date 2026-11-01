import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../listings/models/rental_period.dart';
import '../../kyc/models/document_identity.dart';
import '../../kyc/ui/document_identity_fields.dart';
import '../bloc/contract_detail_bloc.dart';
import '../data/contract_repository.dart';
import '../models/contract.dart';
import 'widgets/contract_bits.dart';
import 'widgets/sign_contract_sheet.dart';
import 'widgets/tenant_rating_bits.dart';
import 'widgets/termination_bits.dart';

/// One Contrat Mboa, and everything either party may do to it (CDC M08).
///
/// The screen is organised around RM-M08-09: whose move it is, first; then the
/// terms; then the negotiation, objection by objection. Actions come from the
/// server's own verdicts — `awaiting`, `canSign`, `status` — never re-derived.
///
/// Shared between the apps, because the contract is one document and the
/// server already decides who may do what to it. The single exception is
/// [onAmend]: redrafting the terms is the landlord's (RM-M08-01/08) and routes
/// into a screen that only his app has.
class ContractDetailView extends StatelessWidget {
  const ContractDetailView({
    super.key,
    required this.id,
    this.onAmend,
    this.onReview,
    this.viewer = ContractParty.unknown,
    this.identityPrefill,
  });

  final String id;

  /// §39 D — what the app knows of the reader's document, to start the
  /// identity form from when they have to type it.
  final DocumentIdentity? identityPrefill;

  /// Opens the amendment form. Null on the tenant's side.
  final void Function(Contract contract)? onAmend;

  /// Opens the resident review (M27). Null on the landlord's side, where
  /// writing one would make no sense — he did not live there.
  final void Function(Contract contract)? onReview;

  /// Which side of the document the reader is on.
  ///
  /// Not a permission — the server decides those (`canSign`, `canAccept`). It
  /// survives only to word the M27 entry point: the tenant is offered "laisser
  /// mon avis", the landlord "voir l'avis du locataire", and nothing in the
  /// contract itself says which app is running. Each app passes its own side.
  final ContractParty viewer;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: MboaHeaderBackButton.leading(context),
        title: Text(l10n.contractDetailTitle),
        actions: [_PendingMoreButton(onAmend: onAmend)],
      ),
      body: BlocConsumer<ContractDetailBloc, ContractDetailState>(
        listenWhen: (prev, curr) =>
            curr is ContractWasCancelled ||
            (curr is ContractDetailReady &&
                (curr.lastActionFailed || curr.justActed || curr.terminationRefusal != null)),
        listener: (context, state) {
          if (state is ContractWasCancelled) {
            MboaHeaderBackButton.pop(context);
            return;
          }
          final ready = state as ContractDetailReady;
          if (ready.terminationRefusal case final refusal?) {
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: switch (refusal) {
                TerminationRefusal.noticeTooShort => l10n.contractTerminationNoticeTooShort,
                TerminationRefusal.datePast => l10n.contractTerminationDatePast,
                TerminationRefusal.afterTerm => l10n.contractTerminationAfterTerm,
                TerminationRefusal.pending => l10n.contractTerminationPending,
                TerminationRefusal.alreadyTerminated => l10n.contractTerminationAlready,
                TerminationRefusal.ended => l10n.contractTerminationEnded,
                TerminationRefusal.closed => l10n.contractTerminationClosed,
              },
            );
            return;
          }
          if (ready.lastActionFailed) {
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: l10n.contractActionFailed,
            );
            return;
          }
          if (ready.justActed) {
            MboaToast.success(context: context, title: l10n.contractActionDone);
          }
        },
        builder: (context, state) => switch (state) {
          ContractDetailInitial() || ContractDetailLoadInProgress() => const Center(child: Loader()),
          ContractWasCancelled() => const Center(child: Loader()),
          ContractDetailFailure() => Center(
            child: TextButton(
              onPressed: () => context.read<ContractDetailBloc>().add(ContractRequested(id)),
              child: Text(l10n.commonRetry),
            ),
          ),
          final ContractDetailReady ready => _Body(state: ready, viewer: viewer),
        },
      ),
      bottomNavigationBar: BlocBuilder<ContractDetailBloc, ContractDetailState>(
        builder: (context, state) => state is ContractDetailReady
            ? _ActionBar(
                state: state,
                onAmend: onAmend,
                onReview: onReview,
                viewer: viewer,
                identityPrefill: identityPrefill,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state, this.viewer = ContractParty.unknown});

  final ContractDetailReady state;
  final ContractParty viewer;

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
        // RM-M08-11 / RM-M08-12 — once signed, the tenancy and how it ends.
        if (contract.tenancy != null) ...[
          _Card(
            title: l10n.contractTenancyTitle,
            child: TenancyCard(contract: contract, viewer: viewer, isBusy: state.isBusy),
          ),
          const SizedBox(height: Dimens.spacing),
        ],
        // §37 A — the landlord's own rating of the tenant, once given. The
        // server sends it to the landlord only.
        if (contract.tenantRating case final stars?) ...[
          _Card(
            title: l10n.contractTenantRatingTitle,
            child: TenantStars(stars: stars),
          ),
          const SizedBox(height: Dimens.spacing),
        ],
        _Card(
          title: l10n.contractTermsTitle,
          child: _Terms(contract: contract),
        ),
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
            child: _Signatures(contract: contract, viewer: viewer),
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
          // A Wrap, not a Row: the title and the status are both as long as
          // their content, and at 390 px "Modifications demandées" beside a
          // two-line title overflowed the row by a third of a pixel. Making
          // the chip flexible instead only moved the damage — it truncated the
          // status, and a status nobody can read is worse than a hairline of
          // debug stripes. Here the chip drops to its own line and stays whole.
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: Dimens.spacingSm,
            runSpacing: Dimens.spacingSm,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
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
            contract.exactAddress ?? [contract.district, contract.city].nonNulls.join(' · '),
            style: context.mboaText.body.copyWith(color: colors.primaryDark),
          ),
          // RM-M08-09 speaks of the signing; once signed it can only say
          // "Rien à faire" — wrong beside a termination waiting for an answer.
          // The "Location" card says what is left to do.
          if (contract.tenancy == null) ...[
            const SizedBox(height: Dimens.spacingSm),
            AwaitingLine(awaiting: contract.awaiting),
          ],
          if (contract.isLocked) ...[
            const SizedBox(height: Dimens.spacingSm),
            Row(
              children: [
                Icon(LucideIcons.lock, size: Dimens.iconSm, color: colors.primaryDark),
                const SizedBox(width: Dimens.spacingSm),
                Expanded(
                  child: Text(
                    l10n.contractLocked,
                    style: context.mboaText.caption.copyWith(color: colors.primaryDark),
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
      if (contract.price case final price?) (l10n.contractTermPrice, contract.rentalPeriod.priceLabel(l10n, price)),
      if (contract.depositAmount case final deposit?) (l10n.contractTermDeposit, moneyLabel(l10n, deposit)),
      (
        l10n.contractTermCharges,
        (contract.chargesIncluded ?? false) ? l10n.annonceDetailChargesIncluded : l10n.annonceDetailChargesExtra,
      ),
      if (contract.startDate case final start?) (l10n.contractTermStart, DateFormat.yMMMMd().format(start)),
      if (contract.durationUnits case final units?)
        (
          l10n.contractTermDuration,
          durationLabel(l10n, units, contract.rentalPeriod),
        ),
      if (contract.endDate case final end?) (l10n.contractTermEnd, DateFormat.yMMMMd().format(end)),
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
                    style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
                  ),
                ),
                Text(
                  value,
                  style: context.mboaText.label.copyWith(color: context.mboaColors.ink),
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
                style: context.mboaText.caption.copyWith(color: colors.textTertiary),
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
                          color: change.pending && !change.isWithdrawn ? colors.warning : colors.textSecondary,
                        ),
                      ),
                    ),
                    if (change.createdAt case final at?)
                      Text(
                        DateFormat.yMMMd().format(at),
                        style: context.mboaText.caption.copyWith(color: colors.textTertiary),
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
                            borderRadius: BorderRadius.circular(Dimens.radiusFull),
                          ),
                          child: Text(
                            _termLabel(l10n, term),
                            style: context.mboaText.caption.copyWith(color: colors.warning),
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
                      style: context.mboaText.body.copyWith(color: colors.textSecondary),
                    ),
                  ),
                ],
                if (change.pending && !change.isWithdrawn) ...[
                  const SizedBox(height: Dimens.spacingSm),
                  Button.outline(
                    title: l10n.contractChangeAnswer,
                    onPressed: state.isBusy ? null : () => _answer(context, change),
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
  const _Signatures({required this.contract, this.viewer = ContractParty.unknown});

  final Contract contract;

  /// Which side the reader is on — "Ta signature" is theirs.
  final ContractParty viewer;

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
                  signature.coversCurrentTerms ? LucideIcons.circleCheck : LucideIcons.circleAlert,
                  size: Dimens.icon,
                  color: signature.coversCurrentTerms ? colors.success : colors.warning,
                ),
                const SizedBox(width: Dimens.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        switch (contract.signerOf(signature)) {
                          final party when party == viewer && viewer != ContractParty.unknown =>
                            l10n.contractSignatureMine,
                          ContractParty.prestataire => l10n.contractSignatureProvider,
                          _ => l10n.contractSignatureOther,
                        },
                        style: context.mboaText.body.copyWith(color: colors.ink),
                      ),
                      if (!signature.coversCurrentTerms)
                        Text(
                          l10n.contractSignatureSuperseded,
                          style: context.mboaText.caption.copyWith(color: colors.warning),
                        ),
                      // §39 D — the document signed with, and who vouches for
                      // it. The other party's number comes masked.
                      if (signature.identity case final identity?)
                        Text(
                          [
                            if (identity.document.type case final type?) kycDocTypeLabel(l10n, type),
                            identity.document.number,
                            identity.verified ? l10n.contractSignatureVerified : l10n.contractSignatureDeclared,
                          ].join(' · '),
                          style: context.mboaText.caption.copyWith(
                            color: identity.verified ? colors.success : colors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),
                if (signature.signedAt case final at?)
                  Text(
                    DateFormat.yMMMd().add_Hm().format(at),
                    style: context.mboaText.caption.copyWith(color: colors.textTertiary),
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
  const _ActionBar({
    required this.state,
    this.onAmend,
    this.onReview,
    this.viewer = ContractParty.unknown,
    this.identityPrefill,
  });

  final ContractDetailReady state;
  final void Function(Contract contract)? onAmend;
  final void Function(Contract contract)? onReview;
  final ContractParty viewer;
  final DocumentIdentity? identityPrefill;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final contract = state.contract;

    if (_PendingActions.of(contract, canAmend: onAmend != null) case final pending?) {
      final main = pending.main;
      // Nothing expected of the reader: no bar; the rare actions wait behind
      // the app bar's "⋯" ([_PendingMoreButton]).
      if (main == null) return const SizedBox.shrink();

      void act(_Pending action) => switch (action) {
        _Pending.accept => context.read<ContractDetailBloc>().add(const ContractAccepted()),
        _Pending.send => context.read<ContractDetailBloc>().add(const ContractSent()),
        _Pending.sign => _sign(context, contract),
        _Pending.amend => onAmend!(contract),
        _Pending.contest => _contest(context),
        _Pending.cancel => _cancelContract(context),
      };

      return Container(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.all(Dimens.spacing),
          child: Row(
            children: [
              Expanded(
                child: Button.primary(
                  title: main.label(l10n),
                  isLoading: state.isBusy,
                  onPressed: state.isBusy ? null : () => act(main),
                ),
              ),
              if (pending.more.isNotEmpty) ...[
                const SizedBox(width: Dimens.spacingSm),
                SizedBox.square(
                  dimension: Dimens.buttonHeight,
                  child: IconButton(
                    tooltip: l10n.listingMoreActions,
                    onPressed: state.isBusy
                        ? null
                        : () async {
                            final choice = await _showPendingMore(context, pending.more);
                            if (choice != null && context.mounted) act(choice);
                          },
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimens.radius),
                        side: BorderSide(color: colors.primary),
                      ),
                    ),
                    icon: Icon(LucideIcons.ellipsis, color: colors.primary),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    // Signed: one main action — the PDF — and "⋯" for the review and the
    // termination (the founder's call: never a column of buttons).
    if (contract.isSigned) return _SignedBar(state: state, onReview: onReview, viewer: viewer);
    return const SizedBox.shrink();
  }

  Future<void> _sign(BuildContext context, Contract contract) async {
    final bloc = context.read<ContractDetailBloc>();
    final confirmed = await showSignContractSheet(
      context,
      contract: contract,
      // The tenant app offers the CNI and the passport, as for its KYC.
      identityTypes: viewer == ContractParty.tenant ? const [KycDocType.cni, KycDocType.passport] : KycDocType.values,
      identityPrefill: identityPrefill,
    );
    if (confirmed != null) bloc.add(ContractSigned(identity: confirmed.identity));
  }

  /// CE-M08-03 / RM-M08-07 — contesting names the terms and says why.
  ///
  /// The terms are optional: an objection that only says "the rent is too
  /// high" is still an objection, and the server keeps the text either way.
  /// What it must not be is empty, so the bloc drops a blank one.
  Future<void> _contest(BuildContext context) async {
    final bloc = context.read<ContractDetailBloc>();

    final result = await showModalBottomSheet<({String comment, List<ContestedTerm> terms})>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _ContestSheet(),
    );

    if (result != null) {
      bloc.add(
        ContractChangesRequested(comment: result.comment, terms: result.terms),
      );
    }
  }
}

/// What a contract not yet signed can ask of its reader.
enum _Pending {
  accept,
  send,
  sign,
  amend,
  contest,
  cancel
  ;

  String label(I18n l10n) => switch (this) {
    _Pending.accept => l10n.contractAccept,
    _Pending.send => l10n.contractSend,
    _Pending.sign => l10n.contractSign,
    _Pending.amend => l10n.contractAmend,
    _Pending.contest => l10n.contractContest,
    _Pending.cancel => l10n.contractCancel,
  };

  IconData get icon => switch (this) {
    _Pending.accept => LucideIcons.check,
    _Pending.send => LucideIcons.send,
    _Pending.sign => LucideIcons.penLine,
    _Pending.amend => LucideIcons.pencil,
    _Pending.contest => LucideIcons.messageSquareWarning,
    _Pending.cancel => LucideIcons.circleX,
  };
}

/// Before signature, the one action the screen expects of its reader — and
/// the others behind "⋯", cancelling in red (Doc05 §6.1: never a column of
/// buttons). Who may do what is the server's (`canAccept`, `canSign`); the
/// only thing read here is the status, as before.
class _PendingActions {
  const _PendingActions({required this.main, required this.more});

  /// Null for a signed contract, which has its own bar ([_SignedBar]).
  static _PendingActions? of(Contract contract, {required bool canAmend}) {
    final draft = contract.status == ContractStatus.draft;
    if (contract.isSigned && !contract.canAccept && !draft && !contract.canSign) return null;

    // RM-M08-08 — amendable only while nobody has accepted, and only by the
    // party who drew it up: [canAmend] is false on the tenant's side.
    final amend = contract.status.isAmendable && canAmend;
    final main = switch (contract) {
      // RM-M08-02 / CE-M08-03 — the tenant takes the terms or contests them,
      // while the ball is theirs (`canAccept`).
      Contract(canAccept: true) => _Pending.accept,
      _ when draft => _Pending.send,
      // Accepted, and this reader has not signed yet.
      Contract(canSign: true) => _Pending.sign,
      // CE-M08-03 — an objection to answer: redrafting is what is expected.
      // Sent and unanswered, it is only possible: the landlord waits.
      _ when amend && contract.status == ContractStatus.changesRequested => _Pending.amend,
      _ => null,
    };

    return _PendingActions(
      main: main,
      more: [
        if (contract.canAccept) _Pending.contest,
        if (amend && main != _Pending.amend) _Pending.amend,
        if (contract.status.isOpen && !contract.isLocked) _Pending.cancel,
      ],
    );
  }

  /// Null: the screen expects nothing of its reader — no bar at all.
  final _Pending? main;
  final List<_Pending> more;
}

Future<_Pending?> _showPendingMore(BuildContext context, List<_Pending> actions) {
  final colors = context.mboaColors;

  return showModalBottomSheet<_Pending>(
    context: context,
    backgroundColor: colors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
    ),
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final action in actions)
              ListTile(
                leading: Icon(action.icon, color: action == _Pending.cancel ? colors.error : colors.primary),
                title: Text(
                  action.label(I18n.of(context)),
                  style: context.mboaText.label.copyWith(
                    color: action == _Pending.cancel ? colors.error : colors.ink,
                  ),
                ),
                onTap: () => Navigator.of(sheetContext).pop(action),
              ),
          ],
        ),
      ),
    ),
  );
}

/// "⋯" in the app bar when the screen expects nothing of its reader but the
/// contract can still be cancelled — the landlord waiting on the tenant, say.
class _PendingMoreButton extends StatelessWidget {
  const _PendingMoreButton({this.onAmend});

  final void Function(Contract contract)? onAmend;

  @override
  Widget build(BuildContext context) => BlocBuilder<ContractDetailBloc, ContractDetailState>(
    builder: (context, state) {
      if (state is! ContractDetailReady) return const SizedBox.shrink();
      final pending = _PendingActions.of(state.contract, canAmend: onAmend != null);
      if (pending == null || pending.main != null || pending.more.isEmpty) return const SizedBox.shrink();

      return IconButton(
        tooltip: I18n.of(context).listingMoreActions,
        icon: Icon(LucideIcons.ellipsis, color: context.mboaColors.primary),
        onPressed: state.isBusy
            ? null
            : () async {
                final choice = await _showPendingMore(context, pending.more);
                if (!context.mounted) return;
                // With nothing expected, only redrafting and cancelling
                // can be left: accepting, sending and signing are always
                // the main button.
                switch (choice) {
                  case _Pending.amend:
                    onAmend!(state.contract);
                  case _Pending.cancel:
                    await _cancelContract(context);
                  default:
                    break;
                }
              },
      );
    },
  );
}

/// Asked once more, in red: cancelling cannot be undone.
Future<void> _cancelContract(BuildContext context) async {
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

enum _SignedMore { pdf, review, terminate }

/// A signed contract's bar: the PDF, and "⋯" for the M27 review and the
/// termination (RM-M08-11) — each where the server allows it.
///
/// §37 A — while the landlord may rate the tenant, that is what the screen
/// expects (N-41 opens it): « Noter le locataire » takes the main place and
/// the PDF moves behind "⋯".
class _SignedBar extends StatelessWidget {
  const _SignedBar({required this.state, this.onReview, this.viewer = ContractParty.unknown});

  final ContractDetailReady state;
  final void Function(Contract contract)? onReview;
  final ContractParty viewer;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final contract = state.contract;

    // M27 — the same door, opening on two different things. For the tenant,
    // `residentReviewEligible` is the server's verdict that they may write
    // one. For the landlord there is no such flag, and there should not be:
    // he may read what was written about him and answer once (RM-M27-03), so
    // the door opens on any signed contract and says "pas encore d'avis"
    // when there is none.
    final reviewLabel = onReview == null
        ? null
        : switch (viewer) {
            ContractParty.tenant when contract.residentReviewEligible => l10n.residentReviewCta,
            ContractParty.prestataire => l10n.residentReviewSeeCta,
            _ => null,
          };
    final canTerminate = contract.tenancy?.canTerminate ?? false;
    final rate = contract.canRateTenant;
    final hasMore = rate || reviewLabel != null || canTerminate;

    void pdf() => context.read<ContractDetailBloc>().add(
      ContractPdfRequested(name: [l10n.contractPdfFileName, ?contract.annonceTitle].join(' — ')),
    );

    Future<void> rateTenant() async {
      final bloc = context.read<ContractDetailBloc>();
      final draft = await showTenantRatingSheet(context);
      if (draft != null) bloc.add(ContractTenantRated(stars: draft.stars, comment: draft.comment));
    }

    Future<void> more() async {
      final bloc = context.read<ContractDetailBloc>();
      final choice = await showModalBottomSheet<_SignedMore>(
        context: context,
        backgroundColor: colors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
        ),
        builder: (sheetContext) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (rate)
                  ListTile(
                    leading: Icon(LucideIcons.fileDown, color: colors.primary),
                    title: Text(l10n.contractPdf, style: context.mboaText.label.copyWith(color: colors.ink)),
                    onTap: () => Navigator.of(sheetContext).pop(_SignedMore.pdf),
                  ),
                if (reviewLabel != null)
                  ListTile(
                    leading: Icon(LucideIcons.star, color: colors.primary),
                    title: Text(reviewLabel, style: context.mboaText.label.copyWith(color: colors.ink)),
                    onTap: () => Navigator.of(sheetContext).pop(_SignedMore.review),
                  ),
                if (canTerminate)
                  ListTile(
                    leading: Icon(LucideIcons.calendarX, color: colors.error),
                    title: Text(l10n.contractTerminate, style: context.mboaText.label.copyWith(color: colors.error)),
                    onTap: () => Navigator.of(sheetContext).pop(_SignedMore.terminate),
                  ),
              ],
            ),
          ),
        ),
      );
      if (choice == null || !context.mounted) return;
      switch (choice) {
        case _SignedMore.pdf:
          pdf();
        case _SignedMore.review:
          onReview!(contract);
        case _SignedMore.terminate:
          final draft = await showTerminationSheet(context, contract: contract);
          if (draft != null) {
            bloc.add(ContractTerminationRequested(lastDay: draft.lastDay, reason: draft.reason, mutual: draft.mutual));
          }
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.all(Dimens.spacing),
        child: Row(
          children: [
            Expanded(
              child: Button.primary(
                title: rate ? l10n.contractRateTenant : l10n.contractPdf,
                isLoading: state.isBusy,
                onPressed: state.isBusy ? null : (rate ? rateTenant : pdf),
              ),
            ),
            if (hasMore) ...[
              const SizedBox(width: Dimens.spacingSm),
              SizedBox.square(
                dimension: Dimens.buttonHeight,
                child: IconButton(
                  tooltip: l10n.listingMoreActions,
                  onPressed: state.isBusy ? null : more,
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.radius),
                      side: BorderSide(color: colors.primary),
                    ),
                  ),
                  icon: Icon(LucideIcons.ellipsis, color: colors.primary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
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

/// The tenant's objection (CE-M08-03): which terms, and why.
///
/// Owns its controller, so the framework disposes it with the sheet.
class _ContestSheet extends StatefulWidget {
  const _ContestSheet();

  @override
  State<_ContestSheet> createState() => _ContestSheetState();
}

class _ContestSheetState extends State<_ContestSheet> {
  final _controller = TextEditingController();
  final _terms = <ContestedTerm>{};

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _label(I18n l10n, ContestedTerm term) => switch (term) {
    ContestedTerm.price => l10n.contractTermPrice,
    ContestedTerm.rentalPeriod => l10n.contractTermPeriod,
    ContestedTerm.depositAmount => l10n.contractTermDeposit,
    ContestedTerm.chargesIncluded => l10n.contractTermCharges,
    ContestedTerm.startDate => l10n.contractTermStart,
    ContestedTerm.durationUnits => l10n.contractTermDuration,
    ContestedTerm.tacitRenewal => l10n.contractTermTacit,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final canSend = _controller.text.trim().isNotEmpty;

    return Container(
      padding: EdgeInsets.only(
        left: Dimens.screenMargin,
        right: Dimens.screenMargin,
        top: Dimens.spacingLg,
        bottom: MediaQuery.viewInsetsOf(context).bottom + Dimens.spacingLg,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Dimens.radiusXl),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.contractContest,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.contractContestHelp,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: Dimens.spacing),
            Wrap(
              spacing: Dimens.spacingSm,
              runSpacing: Dimens.spacingSm,
              children: [
                for (final term in ContestedTerm.values)
                  FilterChip(
                    label: Text(_label(l10n, term)),
                    selected: _terms.contains(term),
                    onSelected: (on) => setState(
                      () => on ? _terms.add(term) : _terms.remove(term),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Dimens.spacing),
            TextField(
              controller: _controller,
              autofocus: true,
              maxLines: 4,
              maxLength: 2000,
              decoration: InputDecoration(hintText: l10n.contractContestHint),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: Dimens.spacingSm),
            SizedBox(
              width: double.infinity,
              child: Button.primary(
                title: l10n.contractContestSend,
                onPressed: canSend
                    ? () => Navigator.of(context).pop(
                        (
                          comment: _controller.text.trim(),
                          terms: _terms.toList(),
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
