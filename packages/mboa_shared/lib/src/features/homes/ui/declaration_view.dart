import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/declaration_bloc.dart';
import '../data/homes_repository.dart';
import '../models/home.dart';
import 'home_bits.dart';

/// The server's refusals of a declaration or an answer, in words.
String declarationRefusalText(I18n l10n, DeclarationRefusal reason) => switch (reason) {
      DeclarationRefusal.amountInvalid => l10n.declRefusedAmount,
      DeclarationRefusal.dateInvalid => l10n.declRefusedDate,
      DeclarationRefusal.duesInvalid => l10n.declRefusedDues,
      DeclarationRefusal.dueAlreadyConfirmed => l10n.declRefusedDueConfirmed,
      DeclarationRefusal.noDeposit => l10n.declRefusedNoDeposit,
      DeclarationRefusal.depositAlreadyConfirmed => l10n.declRefusedDepositConfirmed,
      DeclarationRefusal.proofLimit => l10n.declRefusedProofLimit,
      DeclarationRefusal.invalidAttachment => l10n.declRefusedAttachment,
      DeclarationRefusal.readOnly => l10n.declRefusedReadOnly,
      DeclarationRefusal.answered => l10n.declRefusedAnswered,
      DeclarationRefusal.contestReasonRequired => l10n.declRefusedReason,
      DeclarationRefusal.invoiceSettled => l10n.declRefusedInvoiceSettled,
    };

/// One declared payment (CDC M30), after the founder's "Historique" card:
/// the amount, who paid and how — outside Mboa, always — then where it
/// stands, what it covers, and the proofs (never public, RM-M30-12).
///
/// Shared by both apps. The landlord's answer — confirm as the one main
/// action, contest behind "⋯" — appears only where the server says he may
/// (`canConfirm` / `canContest`), so the tenant never sees it.
class DeclarationView extends StatelessWidget {
  const DeclarationView({super.key, this.onAnswered});

  /// Told once an answer went through — the Pro app refreshes its counter.
  final VoidCallback? onAnswered;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<DeclarationBloc, DeclarationState>(
      listenWhen: (_, current) =>
          current is DeclarationReady &&
          (current.done != null ||
              current.refusal != null ||
              current.failed ||
              current.receiptNotReady ||
              current.receiptFailed),
      listener: (context, state) {
        final ready = state as DeclarationReady;
        if (ready.receiptNotReady) {
          MboaToast.info(context: context, title: l10n.receiptPreparing);
        } else if (ready.receiptFailed) {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.receiptFailed);
        } else if (ready.done case final done?) {
          MboaToast.success(
            context: context,
            title: done == DeclarationAnswer.confirmed ? l10n.declarationConfirmedToast : l10n.declarationContestedToast,
          );
          onAnswered?.call();
        } else {
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: ready.refusal == null ? l10n.commonError : declarationRefusalText(l10n, ready.refusal!),
          );
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.declarationTitle)),
        body: switch (state) {
          DeclarationLoading() => const Center(child: Loader()),
          DeclarationFailure(:final id, :final contractId) => Center(
              child: TextButton(
                onPressed: () => context.read<DeclarationBloc>().add(DeclarationRequested(id: id, contractId: contractId)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final DeclarationReady ready => _Body(state: ready),
        },
        bottomNavigationBar: switch (state) {
          // The landlord's answer while it waits; once confirmed, the receipt
          // — for either party. Nothing while it is made: the card says so.
          final DeclarationReady ready when ready.declaration.canConfirm || ready.declaration.canContest =>
            _AnswerBar(state: ready),
          final DeclarationReady ready when ready.declaration.receiptId != null && !ready.receiptPending =>
            _ReceiptBar(state: ready),
          _ => null,
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final DeclarationReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final d = state.declaration;
    String date(DateTime value) => DateFormat.yMMMMd(locale).format(value);

    final (statusText, tone) = switch (d.status) {
      // The one it waits on is told what to do; the other, what is awaited.
      DeclarationStatus.declared when d.canConfirm => (l10n.declarationWaitingYou, colors.warning),
      DeclarationStatus.declared => (l10n.declarationWaiting, colors.warning),
      DeclarationStatus.unconfirmed => (l10n.declarationUnconfirmedBody, colors.warning),
      // The chip says the status; the line says who did what, and when.
      DeclarationStatus.confirmed => (
          d.answeredAt == null ? l10n.declarationConfirmedBody : l10n.declarationConfirmedOn(date(d.answeredAt!)),
          colors.success,
        ),
      DeclarationStatus.contested => (l10n.declarationContestedBody, colors.error),
      DeclarationStatus.unknown => (l10n.reservationStatusUnknown, colors.textSecondary),
    };

    Widget field(String label, String value) => Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXs),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 136,
                child: Text(label, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
              ),
              const SizedBox(width: Dimens.spacingSm),
              Expanded(child: Text(value, style: context.mboaText.label.copyWith(color: colors.ink))),
            ],
          ),
        );

    return ListView(
      padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
      children: [
        // The mockup's card: the amount, and from whom to what.
        Container(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(Dimens.radiusLg),
            boxShadow: MboaShadows.card,
          ),
          child: Column(
            children: [
              Text(
                declarationWhat(l10n, d),
                style: context.mboaText.body.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: Dimens.spacingXs),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(fcfaOf(context, d.amount), style: context.mboaText.h1.copyWith(color: colors.ink)),
              ),
              const SizedBox(height: Dimens.spacingLg),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        MboaAvatar(
                          imageUrl: d.tenant?.photoUrl,
                          initials: _initials(d.tenant?.displayName ?? l10n.declarationTenant),
                          size: 56,
                        ),
                        const SizedBox(height: Dimens.spacingSm),
                        Text(
                          d.tenant?.displayName ?? l10n.declarationTenant,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  Icon(LucideIcons.arrowRight, color: colors.primary, size: Dimens.iconMd),
                  Expanded(
                    child: Column(
                      children: [
                        MethodTile(method: d.method, size: 56),
                        const SizedBox(height: Dimens.spacingSm),
                        Text(
                          '${methodLabel(l10n, d.method)}\n${l10n.declarationOutside}',
                          textAlign: TextAlign.center,
                          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: Dimens.spacing),
        Container(
          padding: const EdgeInsets.all(Dimens.spacing),
          decoration: BoxDecoration(color: tone.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(Dimens.radiusMd)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DeclarationStatusChip(status: d.status),
                  if (!d.hasProof) ...[
                    const SizedBox(width: Dimens.spacingSm),
                    Text(l10n.myHomeNoProof, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                  ],
                ],
              ),
              const SizedBox(height: Dimens.spacingSm),
              Text(statusText, style: context.mboaText.body.copyWith(color: colors.ink)),
              if (d.contestReason case final reason?) ...[
                const SizedBox(height: Dimens.spacingSm),
                Text(l10n.declarationContestReason, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                Text('« $reason »', style: context.mboaText.body.copyWith(color: colors.ink)),
              ],
            ],
          ),
        ),
        if (d.receiptId != null) ...[
          const SizedBox(height: Dimens.spacing),
          _ReceiptCard(state: state),
        ],
        const SizedBox(height: Dimens.spacing),
        Container(
          padding: const EdgeInsets.all(Dimens.spacing),
          decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusMd)),
          child: Column(
            children: [
              if (d.paidOn case final paidOn?) field(l10n.declarePaidOn, date(paidOn)),
              field(l10n.declareMethod, methodLabel(l10n, d.method)),
              if (d.reference case final reference?) field(l10n.declarationReference, reference),
              if (d.annonceTitle case final title?) field(l10n.declarationProperty, title),
              if (d.declaredAt case final at?) field(l10n.declarationDeclaredAt, date(at)),
              if (d.note case final note?) ...[
                Divider(height: Dimens.spacingLg, color: colors.border),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(l10n.declarationTenantNote, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('« $note »', style: context.mboaText.body.copyWith(color: colors.ink)),
                ),
              ],
            ],
          ),
        ),
        if (state.proofUrls.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacing),
          Text(l10n.declarationProofs, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
          const SizedBox(height: Dimens.spacingSm),
          Wrap(
            spacing: Dimens.spacingSm,
            runSpacing: Dimens.spacingSm,
            children: [
              for (final url in state.proofUrls)
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.radius),
                  child: SizedBox.square(dimension: 96, child: MboaNetworkImage(url: url)),
                ),
            ],
          ),
        ],
      ],
    );
  }

  static String _initials(String name) =>
      name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).take(2).map((w) => w[0].toUpperCase()).join();
}

/// The receipt a confirmation produced (slice D): ready, being made, or late
/// in coming. Its PDF says what Mboa did — and did not: no money held.
class _ReceiptCard extends StatelessWidget {
  const _ReceiptCard({required this.state});

  final DeclarationReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusMd)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: colors.primaryPale, shape: BoxShape.circle),
            child: state.receiptPending && !state.receiptWaitOver
                ? Padding(
                    padding: const EdgeInsets.all(Dimens.spacingMd),
                    child: CircularProgressIndicator(strokeWidth: 2, color: colors.primary),
                  )
                : Icon(LucideIcons.fileCheck2, color: colors.primary, size: Dimens.icon),
          ),
          const SizedBox(width: Dimens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.receiptTitle, style: context.mboaText.label.copyWith(color: colors.ink)),
                const SizedBox(height: 2),
                Text(
                  switch (state) {
                    DeclarationReady(receiptWaitOver: true) => l10n.receiptLate,
                    DeclarationReady(receiptPending: true) => l10n.receiptPreparing,
                    _ => l10n.receiptBody,
                  },
                  style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                ),
                if (state.receiptWaitOver)
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 36)),
                    onPressed: () =>
                        context.read<DeclarationBloc>().add(const DeclarationReceiptRefreshed(byHand: true)),
                    child: Text(l10n.commonRetry),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Once confirmed: the receipt, the one main action for either party.
class _ReceiptBar extends StatelessWidget {
  const _ReceiptBar({required this.state});

  final DeclarationReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final d = state.declaration;
    final locale = Localizations.localeOf(context).toLanguageTag();
    // The file name the user sees: what, where, when — never an id.
    final name = [
      l10n.receiptTitle,
      ?d.annonceTitle,
      if (d.paidOn case final paidOn?) DateFormat.yMMMd(locale).format(paidOn),
    ].join(' — ');

    return Container(
      decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
      child: SafeArea(
        minimum: const EdgeInsets.all(Dimens.spacing),
        child: Button.primary(
          title: l10n.receiptDownload,
          isLoading: state.receiptBusy,
          onPressed: () => context.read<DeclarationBloc>().add(DeclarationReceiptRequested(name: name)),
        ),
      ),
    );
  }
}

/// The landlord's answer: confirm as the one main action, contest behind
/// "⋯" — only where the server allows it.
class _AnswerBar extends StatelessWidget {
  const _AnswerBar({required this.state});

  final DeclarationReady state;

  Future<void> _confirm(BuildContext context) async {
    final l10n = I18n.of(context);
    final bloc = context.read<DeclarationBloc>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.declarationConfirmTitle),
        content: Text(l10n.declarationConfirmBody(fcfaOf(context, state.declaration.amount))),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: Text(l10n.commonCancel)),
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: Text(l10n.declarationConfirm)),
        ],
      ),
    );
    if (ok ?? false) bloc.add(const DeclarationConfirmed());
  }

  Future<void> _contest(BuildContext context) async {
    final bloc = context.read<DeclarationBloc>();
    final reason = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.mboaColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
      ),
      builder: (_) => const ContestSheet(),
    );
    if (reason != null && reason.trim().isNotEmpty) bloc.add(DeclarationContested(reason));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final d = state.declaration;
    if (!d.canConfirm && !d.canContest) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
      child: SafeArea(
        minimum: const EdgeInsets.all(Dimens.spacing),
        child: Row(
          children: [
            Expanded(
              child: d.canConfirm
                  ? Button.primary(
                      title: l10n.declarationConfirm,
                      isLoading: state.isBusy,
                      onPressed: () => _confirm(context),
                    )
                  : const SizedBox.shrink(),
            ),
            if (d.canContest) ...[
              const SizedBox(width: Dimens.spacingSm),
              SizedBox.square(
                dimension: Dimens.buttonHeight,
                child: IconButton(
                  tooltip: l10n.listingMoreActions,
                  onPressed: state.isBusy
                      ? null
                      : () async {
                          final choice = await showModalBottomSheet<bool>(
                            context: context,
                            backgroundColor: colors.surface,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
                            ),
                            builder: (sheetContext) => SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
                                child: ListTile(
                                  leading: Icon(LucideIcons.circleX, color: colors.error),
                                  title: Text(l10n.declarationContest, style: context.mboaText.label.copyWith(color: colors.error)),
                                  onTap: () => Navigator.of(sheetContext).pop(true),
                                ),
                              ),
                            ),
                          );
                          if ((choice ?? false) && context.mounted) await _contest(context);
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
}

/// The contest's reason — required, seen by the tenant (RM-M30-07).
class ContestSheet extends StatefulWidget {
  const ContestSheet({super.key});

  @override
  State<ContestSheet> createState() => _ContestSheetState();
}

class _ContestSheetState extends State<ContestSheet> {
  final _reason = TextEditingController();

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.declarationContestReason, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
              const SizedBox(height: Dimens.spacingXs),
              Text(l10n.declarationContestHint, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
              const SizedBox(height: Dimens.spacing),
              TextField(
                controller: _reason,
                minLines: 2,
                maxLines: 4,
                maxLength: 500,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: Dimens.spacing),
              Button.primary(
                title: l10n.declarationContest,
                onPressed: _reason.text.trim().isEmpty ? null : () => Navigator.of(context).pop(_reason.text.trim()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
