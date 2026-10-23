import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/invoice_form_bloc.dart';
import '../bloc/owner_invoice_bloc.dart';
import '../bloc/owner_invoices_bloc.dart';
import 'widgets/finance_bits.dart';

/// The landlord's invoices (CDC M24), by where they stand. « Nouvelle
/// facture » is the one action — while the add-on runs ([canWrite]).
@RoutePage()
class OwnerInvoicesPage extends StatelessWidget implements AutoRouteWrapper {
  const OwnerInvoicesPage({super.key, this.canWrite = true});

  final bool canWrite;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<OwnerInvoicesBloc>(
        create: (_) => getIt<OwnerInvoicesBloc>()..add(const OwnerInvoicesRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => OwnerInvoicesView(
        onNew: canWrite
            ? () async {
                final bloc = context.read<OwnerInvoicesBloc>();
                final created = await context.router.push<HomeInvoice>(InvoiceFormRoute());
                if (created != null) bloc.add(const OwnerInvoicesRequested());
              }
            : null,
        onOpen: (invoice) async {
          final bloc = context.read<OwnerInvoicesBloc>();
          await context.router.push(OwnerInvoiceRoute(invoiceId: invoice.id));
          // Paid, cancelled or corrected there: read again on the way back.
          bloc.add(const OwnerInvoicesRequested());
        },
      );
}

class OwnerInvoicesView extends StatelessWidget {
  const OwnerInvoicesView({super.key, required this.onOpen, this.onNew});

  final ValueChanged<HomeInvoice> onOpen;
  final VoidCallback? onNew;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    String filterLabel(InvoiceStatus status) => switch (status) {
          InvoiceStatus.toPay => l10n.invoiceStatusToPay,
          InvoiceStatus.overdue => l10n.invoiceStatusOverdue,
          InvoiceStatus.paid => l10n.invoiceStatusPaid,
          _ => l10n.invoiceStatusCancelled,
        };

    return BlocBuilder<OwnerInvoicesBloc, OwnerInvoicesState>(
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.invoicesTitle)),
        body: switch (state) {
          OwnerInvoicesLoading() => const Center(child: Loader()),
          OwnerInvoicesFailure() => Center(
              child: TextButton(
                onPressed: () => context.read<OwnerInvoicesBloc>().add(const OwnerInvoicesRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          final OwnerInvoicesReady ready => RefreshIndicator(
              onRefresh: () async => context.read<OwnerInvoicesBloc>().add(const OwnerInvoicesRequested()),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacingSm, Dimens.screenMargin, Dimens.spacingXl),
                children: [
                  if (ready.isOffline) ...[
                    Text(l10n.financeOffline, style: context.mboaText.caption.copyWith(color: colors.warning)),
                    const SizedBox(height: Dimens.spacingSm),
                  ],
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final filter in OwnerInvoicesReady.filters) ...[
                          ChoiceChip(
                            label: Text(
                              ready.count(filter) == 0 ? filterLabel(filter) : '${filterLabel(filter)} (${ready.count(filter)})',
                            ),
                            selected: ready.filter == filter,
                            showCheckmark: false,
                            selectedColor: filter == InvoiceStatus.overdue ? colors.error.withValues(alpha: 0.12) : colors.primaryPale,
                            labelStyle: financeChipLabel(context, selected: ready.filter == filter),
                            side: financeChipSide(context, selected: ready.filter == filter),
                            onSelected: (_) => context.read<OwnerInvoicesBloc>().add(OwnerInvoicesFilterChanged(filter)),
                          ),
                          const SizedBox(width: Dimens.spacingSm),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimens.spacingSm),
                  if (ready.shown.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
                      child: Text(
                        l10n.ownerInvoicesEmpty,
                        textAlign: TextAlign.center,
                        style: context.mboaText.body.copyWith(color: colors.textSecondary),
                      ),
                    )
                  else
                    DecoratedBox(
                      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusLg)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing, vertical: Dimens.spacingSm),
                        child: Column(
                          children: [
                            for (final invoice in ready.shown)
                              InvoiceRow(invoice: invoice, showPlace: true, onTap: () => onOpen(invoice)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
        },
        bottomNavigationBar: onNew == null || state is! OwnerInvoicesReady || state.isOffline
            ? null
            : FinanceActionBar(
                main: Button.primary(
                  title: l10n.ownerInvoiceNew,
                  icon: const Icon(LucideIcons.plus, size: Dimens.icon),
                  iconAlignment: IconAlignment.start,
                  onPressed: onNew,
                ),
              ),
      ),
    );
  }
}

/// One invoice: marked paid as the main action while it is open — corrected
/// or cancelled behind « ⋯ » —, its payment withdrawn when declared by
/// mistake, nothing to do once settled otherwise.
@RoutePage()
class OwnerInvoicePage extends StatelessWidget implements AutoRouteWrapper {
  const OwnerInvoicePage({super.key, @PathParam('invoiceId') required this.invoiceId});

  final String invoiceId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<OwnerInvoiceBloc>(
        create: (_) => getIt<OwnerInvoiceBloc>()..add(OwnerInvoiceOpened(invoiceId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => OwnerInvoiceView(
        onEdit: (invoice) async {
          final bloc = context.read<OwnerInvoiceBloc>();
          final saved = await context.router.push<HomeInvoice>(InvoiceFormRoute(editing: invoice));
          if (saved != null) bloc.add(OwnerInvoiceOpened(invoiceId));
        },
      );
}

class OwnerInvoiceView extends StatelessWidget {
  const OwnerInvoiceView({super.key, required this.onEdit});

  final ValueChanged<HomeInvoice> onEdit;

  Future<void> _markPaid(BuildContext context) async {
    final l10n = I18n.of(context);
    final bloc = context.read<OwnerInvoiceBloc>();
    final today = DateTime.now();
    final paidOn = await showDatePicker(
      context: context,
      helpText: l10n.ownerInvoicePaidOnTitle,
      initialDate: today,
      firstDate: DateTime(today.year - 2),
      lastDate: today,
    );
    if (paidOn != null) bloc.add(OwnerInvoiceMarkedPaid(paidOn));
  }

  Future<void> _more(BuildContext context, OwnerInvoiceReady state) async {
    final l10n = I18n.of(context);
    final bloc = context.read<OwnerInvoiceBloc>();
    final choice = await showFinanceActions<_More>(context, [
      if (state.isOpen) (icon: LucideIcons.pencil, label: l10n.ownerInvoiceEdit, value: _More.edit, destructive: false),
      if (state.isOpen) (icon: LucideIcons.circleX, label: l10n.ownerInvoiceCancel, value: _More.cancel, destructive: true),
      if (state.canReopen)
        (icon: LucideIcons.undo2, label: l10n.ownerInvoiceReopen, value: _More.reopen, destructive: true),
    ]);
    if (choice == null || !context.mounted) return;
    switch (choice) {
      case _More.edit:
        onEdit(state.invoice);
      case _More.cancel:
        if (await confirmFinance(context, l10n.ownerInvoiceCancelConfirm)) bloc.add(const OwnerInvoiceCancelled());
      case _More.reopen:
        if (await confirmFinance(context, l10n.ownerInvoiceReopenConfirm)) bloc.add(const OwnerInvoiceReopened());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<OwnerInvoiceBloc, OwnerInvoiceState>(
      listenWhen: (_, current) =>
          current is OwnerInvoiceReady && (current.done != null || current.refusal != null || current.failed),
      listener: (context, state) {
        final ready = state as OwnerInvoiceReady;
        switch (ready) {
          case OwnerInvoiceReady(:final done?):
            MboaToast.success(
              context: context,
              title: switch (done) {
                OwnerInvoiceDone.paid => l10n.ownerInvoicePaidToast,
                OwnerInvoiceDone.cancelled => l10n.ownerInvoiceCancelledToast,
                OwnerInvoiceDone.reopened => l10n.ownerInvoiceReopenedToast,
              },
            );
          case OwnerInvoiceReady(:final refusal?):
            MboaToast.error(context: context, title: l10n.commonErrorTitle, description: financeRefusalText(l10n, refusal));
          default:
            MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          leading: const MboaHeaderBackButton(),
          title: Text(l10n.invoiceTitle),
          actions: [
            // Paid by hand: nothing expected, the withdrawal is rare — behind
            // « ⋯ » up here rather than a bar of its own.
            if (state case final OwnerInvoiceReady ready when ready.canReopen)
              IconButton(
                tooltip: l10n.listingMoreActions,
                icon: Icon(LucideIcons.ellipsis, color: colors.primary),
                onPressed: () => _more(context, ready),
              ),
          ],
        ),
        body: switch (state) {
          OwnerInvoiceLoading() => const Center(child: Loader()),
          OwnerInvoiceFailure(:final id) => Center(
              child: TextButton(
                onPressed: () => context.read<OwnerInvoiceBloc>().add(OwnerInvoiceOpened(id)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final OwnerInvoiceReady ready => _InvoiceBody(state: ready),
        },
        bottomNavigationBar: switch (state) {
          final OwnerInvoiceReady ready when ready.isOpen => FinanceActionBar(
              isBusy: ready.isBusy,
              main: Button.primary(
                title: l10n.ownerInvoiceMarkPaid,
                isLoading: ready.isBusy,
                onPressed: () => _markPaid(context),
              ),
              onMore: () => _more(context, ready),
            ),
          _ => null,
        },
      ),
    );
  }
}

enum _More { edit, cancel, reopen }

class _InvoiceBody extends StatelessWidget {
  const _InvoiceBody({required this.state});

  final OwnerInvoiceReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    String day(DateTime d) => DateFormat.yMMMMd(locale).format(d);
    final invoice = state.invoice;
    final kind = invoiceKindLook(l10n, invoice.kind);
    final partly = invoice.status.isOpen && invoice.confirmedTotal > 0;

    return ListView(
      padding: const EdgeInsets.all(Dimens.screenMargin),
      children: [
        if (state.isOffline) ...[
          Text(l10n.financeOffline, style: context.mboaText.caption.copyWith(color: colors.warning)),
          const SizedBox(height: Dimens.spacingSm),
        ],
        Container(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(Dimens.radiusLg),
            boxShadow: MboaShadows.card,
          ),
          child: Column(
            children: [
              InvoiceKindTile(kind: invoice.kind, size: 56),
              const SizedBox(height: Dimens.spacingSm),
              Text(
                invoice.label ?? kind.label,
                textAlign: TextAlign.center,
                style: context.mboaText.body.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: Dimens.spacingXs),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(fcfaOf(context, invoice.amount), style: context.mboaText.h1.copyWith(color: colors.ink)),
              ),
              const SizedBox(height: Dimens.spacingSm),
              InvoiceStatusChip(status: invoice.status, pastDue: invoice.pastDue),
              if (partly) ...[
                const SizedBox(height: Dimens.spacingSm),
                Text(
                  l10n.invoiceConfirmedSoFar(fcfaOf(context, invoice.confirmedTotal), fcfaOf(context, invoice.remaining)),
                  textAlign: TextAlign.center,
                  style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: Dimens.spacing),
        DecoratedBox(
          decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusMd)),
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacing),
            child: Column(
              children: [
                _Field(label: l10n.ownerInvoiceFormKind, value: kind.label),
                if (invoice.annonceTitle case final place?) _Field(label: l10n.declarationProperty, value: place),
                if (invoice.dueDate case final due?) _Field(label: l10n.ownerInvoiceFormDue, value: day(due)),
                if ((invoice.status, invoice.paidAt) case (InvoiceStatus.paid, final paidAt?))
                  _Field(label: l10n.ownerInvoicePaidOnTitle, value: day(paidAt)),
              ],
            ),
          ),
        ),
        if (invoice.status == InvoiceStatus.paid) ...[
          const SizedBox(height: Dimens.spacing),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(LucideIcons.info, size: Dimens.iconSm, color: colors.textSecondary),
              const SizedBox(width: Dimens.spacingSm),
              Expanded(
                child: Text(
                  invoice.paidViaDeclaration ? l10n.ownerInvoiceByDeclaration : l10n.ownerInvoiceByHand,
                  style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Padding(
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
  }
}

/// Billing a tenant, or correcting a bill not paid yet ([editing]).
@RoutePage()
class InvoiceFormPage extends StatelessWidget implements AutoRouteWrapper {
  const InvoiceFormPage({super.key, this.editing});

  final HomeInvoice? editing;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<InvoiceFormBloc>(
        create: (_) => getIt<InvoiceFormBloc>()..add(InvoiceFormStarted(editing: editing)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const InvoiceFormView();
}

class InvoiceFormView extends StatefulWidget {
  const InvoiceFormView({super.key});

  @override
  State<InvoiceFormView> createState() => _InvoiceFormViewState();
}

class _InvoiceFormViewState extends State<InvoiceFormView> {
  late final TextEditingController _label;
  late final TextEditingController _amount;

  /// Filled from what the form starts with — a correction's own words. In
  /// initState, not lazily: a form never shown (no tenancy) would otherwise
  /// read the bloc from dispose.
  @override
  void initState() {
    super.initState();
    final start = context.read<InvoiceFormBloc>().state;
    _label = TextEditingController(text: start.label);
    _amount = TextEditingController(text: start.amount == null ? '' : '${start.amount}');
  }

  @override
  void dispose() {
    _label.dispose();
    _amount.dispose();
    super.dispose();
  }

  void _change(InvoiceFormChanged event) => context.read<InvoiceFormBloc>().add(event);

  Future<void> _pickDue(InvoiceFormState state) async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: state.dueDate ?? today.add(const Duration(days: 7)),
      firstDate: DateTime(today.year - 1),
      lastDate: DateTime(today.year + 2),
    );
    if (picked != null) _change(InvoiceFormChanged(dueDate: picked));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    Widget label(String text) => Padding(
          padding: const EdgeInsets.only(top: Dimens.spacing, bottom: Dimens.spacingSm),
          child: Text(text, style: context.mboaText.label.copyWith(color: colors.ink)),
        );

    return BlocConsumer<InvoiceFormBloc, InvoiceFormState>(
      listenWhen: (previous, current) =>
          current.saved != null || current.refusal != null || (current.failed && !previous.failed),
      listener: (context, state) {
        if (state.saved case final saved?) {
          MboaToast.success(context: context, title: state.isEditing ? l10n.ownerInvoiceSaved : l10n.ownerInvoiceCreated);
          context.router.maybePop(saved);
        } else if (state.refusal case final refusal?) {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: financeRefusalText(l10n, refusal));
        } else {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError);
        }
      },
      builder: (context, state) {
        final noTenancy = !state.isEditing && !state.isLoadingTenancies && state.tenancies.isEmpty;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppBar(
            leading: const MboaHeaderBackButton(),
            title: Text(state.isEditing ? l10n.ownerInvoiceEdit : l10n.ownerInvoiceNew),
          ),
          body: state.isLoadingTenancies
              ? const Center(child: Loader())
              : noTenancy
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(Dimens.spacingXl),
                        child: Text(
                          l10n.ownerInvoiceFormNoTenant,
                          textAlign: TextAlign.center,
                          style: context.mboaText.body.copyWith(color: colors.textSecondary),
                        ),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, 0, Dimens.screenMargin, Dimens.spacingXl),
                      children: [
                        if (!state.isEditing) ...[
                          label(l10n.ownerInvoiceFormTenant),
                          // RM-M24-02 — the running tenancies, and no others.
                          RadioGroup<String>(
                            groupValue: state.contractId,
                            onChanged: (id) {
                              if (!state.isSubmitting && id != null) _change(InvoiceFormChanged(contractId: id));
                            },
                            child: Column(
                              children: [
                                for (final home in state.tenancies)
                                  RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    value: home.contractId,
                                    title: Text(
                                      home.tenant?.displayName ?? l10n.declarationTenant,
                                      style: context.mboaText.label.copyWith(color: colors.ink),
                                    ),
                                    subtitle: Text(
                                      home.placeTitle ?? '',
                                      style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          label(l10n.ownerInvoiceFormKind),
                          Wrap(
                            spacing: Dimens.spacingSm,
                            children: [
                              for (final kind in InvoiceKind.values)
                                ChoiceChip(
                                  avatar: Icon(invoiceKindLook(l10n, kind).icon, size: 16),
                                  label: Text(invoiceKindLook(l10n, kind).label),
                                  selected: state.kind == kind,
                                  showCheckmark: false,
                                  selectedColor: colors.primaryPale,
                                  labelStyle: financeChipLabel(context, selected: state.kind == kind),
                                  side: financeChipSide(context, selected: state.kind == kind),
                                  onSelected: state.isSubmitting ? null : (_) => _change(InvoiceFormChanged(kind: kind)),
                                ),
                            ],
                          ),
                        ],
                        label(l10n.ownerInvoiceFormLabel),
                        TextField(
                          controller: _label,
                          enabled: !state.isSubmitting,
                          maxLength: 120,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: l10n.ownerInvoiceFormLabelHint,
                            helperText: state.kind == InvoiceKind.other ? l10n.ownerInvoiceFormLabelRequired : null,
                          ),
                          onChanged: (value) => _change(InvoiceFormChanged(label: value)),
                        ),
                        label(l10n.ownerInvoiceFormAmount),
                        TextField(
                          controller: _amount,
                          enabled: !state.isSubmitting,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          style: context.mboaText.h2.copyWith(color: colors.ink),
                          onChanged: (value) => _change(InvoiceFormChanged(amount: int.tryParse(value) ?? 0)),
                        ),
                        label(l10n.ownerInvoiceFormDue),
                        InkWell(
                          onTap: state.isSubmitting ? null : () => _pickDue(state),
                          borderRadius: BorderRadius.circular(Dimens.radius),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
                            child: Row(
                              children: [
                                Icon(LucideIcons.calendar, size: Dimens.icon, color: colors.primary),
                                const SizedBox(width: Dimens.spacingSm),
                                Text(
                                  state.dueDate == null
                                      ? l10n.reservationPickDate
                                      : DateFormat.yMMMMd(locale).format(state.dueDate!),
                                  style: context.mboaText.label.copyWith(color: colors.ink),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
          bottomNavigationBar: noTenancy || state.isLoadingTenancies
              ? null
              : FinanceActionBar(
                  main: Button.primary(
                    title: state.isEditing ? l10n.ownerInvoiceSave : l10n.ownerInvoiceCreate,
                    isLoading: state.isSubmitting,
                    onPressed: state.canSubmit ? () => context.read<InvoiceFormBloc>().add(const InvoiceFormSubmitted()) : null,
                  ),
                ),
        );
      },
    );
  }
}
