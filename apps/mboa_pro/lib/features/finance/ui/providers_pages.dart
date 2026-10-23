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
import '../bloc/provider_bloc.dart';
import '../bloc/provider_form_bloc.dart';
import '../bloc/provider_payment_form_bloc.dart';
import '../bloc/providers_bloc.dart';
import '../models/ledger.dart';
import '../models/service_provider.dart';
import 'ledger_pages.dart';
import 'widgets/finance_bits.dart';

/// What an intervenant does, in words — his own for « Autre ».
String providerKindText(I18n l10n, ProviderKind kind, {String? label}) => switch (kind) {
      ProviderKind.cleaning => l10n.providerKindCleaning,
      ProviderKind.plumbing => l10n.providerKindPlumbing,
      ProviderKind.electrical => l10n.providerKindElectrical,
      ProviderKind.other => label ?? l10n.providerKindOther,
    };

IconData _kindIcon(ProviderKind kind) => switch (kind) {
      ProviderKind.cleaning => LucideIcons.sparkles,
      ProviderKind.plumbing => LucideIcons.wrench,
      ProviderKind.electrical => LucideIcons.zap,
      ProviderKind.other => LucideIcons.hardHat,
    };

String _initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
  return parts.take(2).map((p) => p[0].toUpperCase()).join();
}

/// The landlord's intervenants (CDC M26). « Ajouter un intervenant » while
/// the add-on runs ([canWrite]).
@RoutePage()
class ProvidersPage extends StatelessWidget implements AutoRouteWrapper {
  const ProvidersPage({super.key, this.canWrite = true});

  final bool canWrite;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ProvidersBloc>(
        create: (_) => getIt<ProvidersBloc>()..add(const ProvidersRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => ProvidersView(
        onAdd: canWrite
            ? () async {
                final bloc = context.read<ProvidersBloc>();
                final saved = await context.router.push<ServiceProvider>(ProviderFormRoute());
                if (saved != null) bloc.add(const ProvidersRequested());
              }
            : null,
        onOpen: (provider) async {
          final bloc = context.read<ProvidersBloc>();
          await context.router.push(ProviderRoute(providerId: provider.id, canWrite: canWrite));
          bloc.add(const ProvidersRequested());
        },
      );
}

class ProvidersView extends StatelessWidget {
  const ProvidersView({super.key, required this.onOpen, this.onAdd});

  final ValueChanged<ServiceProvider> onOpen;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<ProvidersBloc, ProvidersState>(
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.financeProvidersTitle)),
        body: switch (state) {
          ProvidersLoading() => const Center(child: Loader()),
          ProvidersFailure() => Center(
              child: TextButton(
                onPressed: () => context.read<ProvidersBloc>().add(const ProvidersRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          final ProvidersReady ready => RefreshIndicator(
              onRefresh: () async => context.read<ProvidersBloc>().add(const ProvidersRequested()),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacingSm, Dimens.screenMargin, Dimens.spacingXl),
                children: [
                  if (ready.isOffline) ...[
                    Text(l10n.financeOffline, style: context.mboaText.caption.copyWith(color: colors.warning)),
                    const SizedBox(height: Dimens.spacingSm),
                  ],
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: ready.includeArchived,
                    title: Text(l10n.providersShowArchived, style: context.mboaText.label.copyWith(color: colors.ink)),
                    onChanged: ready.isOffline
                        ? null
                        : (on) => context.read<ProvidersBloc>().add(ProvidersRequested(includeArchived: on)),
                  ),
                  if (ready.items.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
                      child: Text(
                        l10n.providersEmpty,
                        textAlign: TextAlign.center,
                        style: context.mboaText.body.copyWith(color: colors.textSecondary),
                      ),
                    )
                  else
                    for (final provider in ready.items) _ProviderRow(provider: provider, onTap: () => onOpen(provider)),
                ],
              ),
            ),
        },
        bottomNavigationBar: onAdd == null || state is! ProvidersReady || state.isOffline
            ? null
            : FinanceActionBar(
                main: Button.primary(
                  title: l10n.providersAdd,
                  icon: const Icon(LucideIcons.plus, size: Dimens.icon),
                  iconAlignment: IconAlignment.start,
                  onPressed: onAdd,
                ),
              ),
      ),
    );
  }
}

class _ProviderRow extends StatelessWidget {
  const _ProviderRow({required this.provider, required this.onTap});

  final ServiceProvider provider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

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
                MboaAvatar(initials: _initials(provider.name), size: 44),
                const SizedBox(width: Dimens.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.mboaText.label.copyWith(
                          color: provider.archived ? colors.textTertiary : colors.ink,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(_kindIcon(provider.kind), size: 14, color: colors.textSecondary),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              providerKindText(l10n, provider.kind, label: provider.kindLabel),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                            ),
                          ),
                          if (provider.isLinked) ...[
                            const SizedBox(width: Dimens.spacingSm),
                            _Badge(text: l10n.providerLinked, tone: colors.primary),
                          ],
                          if (provider.archived) ...[
                            const SizedBox(width: Dimens.spacingSm),
                            _Badge(text: l10n.providerArchivedBadge, tone: colors.textTertiary),
                          ],
                        ],
                      ),
                      Text(
                        l10n.providerTotalPaid(provider.paymentCount, fcfaOf(context, provider.totalPaid)),
                        style: context.mboaText.caption.copyWith(color: colors.ink, fontWeight: FontWeight.w600),
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

class _Badge extends StatelessWidget {
  const _Badge({required this.text, required this.tone});

  final String text;
  final Color tone;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
        decoration: BoxDecoration(color: tone.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(Dimens.radiusFull)),
        child: Text(text, style: context.mboaText.micro.copyWith(color: tone, fontWeight: FontWeight.w700)),
      );
}

/// One intervenant (CDC M26): « Déclarer un paiement » the main action; the
/// rest behind « ⋯ ». Archived, « Restaurer » is.
@RoutePage()
class ProviderPage extends StatelessWidget implements AutoRouteWrapper {
  const ProviderPage({super.key, @PathParam('providerId') required this.providerId, this.canWrite = true});

  final String providerId;
  final bool canWrite;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ProviderBloc>(
        create: (_) => getIt<ProviderBloc>()..add(ProviderOpened(providerId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    Future<void> openForm(PageRouteInfo<dynamic> route) async {
      final bloc = context.read<ProviderBloc>();
      final changed = await context.router.push<Object?>(route);
      if (changed != null) bloc.add(ProviderOpened(providerId));
    }

    return ProviderView(
      canWrite: canWrite,
      onPay: () => openForm(ProviderPaymentFormRoute(providerId: providerId)),
      onEditPayment: (payment) => openForm(ProviderPaymentFormRoute(providerId: providerId, editing: payment)),
      onEdit: (provider) => openForm(ProviderFormRoute(editing: provider)),
    );
  }
}

class ProviderView extends StatelessWidget {
  const ProviderView({
    super.key,
    required this.canWrite,
    required this.onPay,
    required this.onEditPayment,
    required this.onEdit,
  });

  final bool canWrite;
  final VoidCallback onPay;
  final ValueChanged<ProviderPayment> onEditPayment;
  final ValueChanged<ServiceProvider> onEdit;

  Future<void> _more(BuildContext context, ProviderReady state) async {
    final l10n = I18n.of(context);
    final bloc = context.read<ProviderBloc>();
    final provider = state.provider;
    final choice = await showFinanceActions<_More>(context, [
      (icon: LucideIcons.pencil, label: l10n.providerEdit, value: _More.edit, destructive: false),
      if (!provider.archived) (icon: LucideIcons.archive, label: l10n.providerArchive, value: _More.archive, destructive: true),
      if (provider.canDelete) (icon: LucideIcons.trash2, label: l10n.providerDelete, value: _More.delete, destructive: true),
    ]);
    if (choice == null || !context.mounted) return;
    switch (choice) {
      case _More.edit:
        onEdit(provider);
      case _More.archive:
        if (await confirmFinance(context, l10n.providerArchiveConfirm)) bloc.add(const ProviderArchived());
      case _More.delete:
        if (await confirmFinance(context, l10n.providerDeleteConfirm)) bloc.add(const ProviderDeleted());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return BlocConsumer<ProviderBloc, ProviderState>(
      listenWhen: (_, current) =>
          current is ProviderReady && (current.done != null || current.refusal != null || current.failed),
      listener: (context, state) {
        final ready = state as ProviderReady;
        switch (ready) {
          case ProviderReady(:final done?):
            MboaToast.success(
              context: context,
              title: switch (done) {
                ProviderDone.archived => l10n.providerArchivedToast,
                ProviderDone.restored => l10n.providerRestoredToast,
                ProviderDone.deleted => l10n.providerDeletedToast,
              },
            );
            if (done == ProviderDone.deleted) context.router.maybePop();
          case ProviderReady(:final refusal?):
            MboaToast.error(context: context, title: l10n.commonErrorTitle, description: financeRefusalText(l10n, refusal));
          default:
            MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          leading: const MboaHeaderBackButton(),
          title: Text(state is ProviderReady ? state.provider.name : l10n.financeProvidersTitle),
        ),
        body: switch (state) {
          ProviderLoading() => const Center(child: Loader()),
          ProviderFailure(:final id) => Center(
              child: TextButton(
                onPressed: () => context.read<ProviderBloc>().add(ProviderOpened(id)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final ProviderReady ready => ListView(
              padding: const EdgeInsets.all(Dimens.screenMargin),
              children: [
                if (ready.isOffline) ...[
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
                      MboaAvatar(initials: _initials(ready.provider.name), size: 64),
                      const SizedBox(height: Dimens.spacingSm),
                      Text(ready.provider.name, style: context.mboaText.h3.copyWith(color: colors.ink)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_kindIcon(ready.provider.kind), size: 14, color: colors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            providerKindText(l10n, ready.provider.kind, label: ready.provider.kindLabel),
                            style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                          ),
                          if (ready.provider.isLinked) ...[
                            const SizedBox(width: Dimens.spacingSm),
                            _Badge(text: l10n.providerLinked, tone: colors.primary),
                          ],
                          if (ready.provider.archived) ...[
                            const SizedBox(width: Dimens.spacingSm),
                            _Badge(text: l10n.providerArchivedBadge, tone: colors.textTertiary),
                          ],
                        ],
                      ),
                      if (ready.provider.note case final note?) ...[
                        const SizedBox(height: Dimens.spacingSm),
                        Text(
                          note,
                          textAlign: TextAlign.center,
                          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                        ),
                      ],
                      const SizedBox(height: Dimens.spacing),
                      Text(l10n.providerPaidTotalTitle, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          fcfaOf(context, ready.provider.totalPaid),
                          style: context.mboaText.h1.copyWith(color: colors.primaryDark),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.spacing),
                Text(l10n.providerPaymentsTitle, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
                const SizedBox(height: Dimens.spacingSm),
                if (ready.payments.isEmpty)
                  Text(l10n.providerNoPayment, style: context.mboaText.body.copyWith(color: colors.textSecondary))
                else
                  DecoratedBox(
                    decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusLg)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing, vertical: Dimens.spacingSm),
                      child: Column(
                        children: [
                          for (final payment in ready.payments)
                            InkWell(
                              onTap: canWrite && !ready.isOffline ? () => onEditPayment(payment) : null,
                              borderRadius: BorderRadius.circular(Dimens.radius),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            payment.note ?? ledgerPropertyLabel(l10n, payment.property),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: context.mboaText.label.copyWith(color: colors.ink),
                                          ),
                                          Text(
                                            [
                                              if (payment.paidOn case final day?) DateFormat.yMMMd(locale).format(day),
                                              if (payment.note != null) ledgerPropertyLabel(l10n, payment.property),
                                            ].join(' · '),
                                            style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      fcfaOf(context, payment.amount),
                                      style: context.mboaText.label.copyWith(color: colors.ink, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
        },
        bottomNavigationBar: switch (state) {
          final ProviderReady ready when canWrite && !ready.isOffline => FinanceActionBar(
              isBusy: ready.isBusy,
              main: ready.provider.archived
                  ? Button.primary(
                      title: l10n.providerRestore,
                      isLoading: ready.isBusy,
                      onPressed: () => context.read<ProviderBloc>().add(const ProviderRestored()),
                    )
                  : Button.primary(
                      // Declared, never paid through Mboa (RM-M26-02).
                      title: l10n.providerPay,
                      icon: const Icon(LucideIcons.plus, size: Dimens.icon),
                      iconAlignment: IconAlignment.start,
                      onPressed: onPay,
                    ),
              onMore: () => _more(context, ready),
            ),
          _ => null,
        },
      ),
    );
  }
}

enum _More { edit, archive, delete }

/// Adding an intervenant, or correcting one ([editing]).
@RoutePage()
class ProviderFormPage extends StatelessWidget implements AutoRouteWrapper {
  const ProviderFormPage({super.key, this.editing});

  final ServiceProvider? editing;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ProviderFormBloc>(
        create: (_) => getIt<ProviderFormBloc>()..add(ProviderFormStarted(editing: editing)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const ProviderFormView();
}

class ProviderFormView extends StatefulWidget {
  const ProviderFormView({super.key});

  @override
  State<ProviderFormView> createState() => _ProviderFormViewState();
}

class _ProviderFormViewState extends State<ProviderFormView> {
  late final TextEditingController _name;
  late final TextEditingController _kindLabel;
  late final TextEditingController _note;

  @override
  void initState() {
    super.initState();
    final editing = context.read<ProviderFormBloc>().state.editing;
    _name = TextEditingController(text: editing?.name);
    _kindLabel = TextEditingController(text: editing?.kindLabel);
    _note = TextEditingController(text: editing?.note);
  }

  @override
  void dispose() {
    _name.dispose();
    _kindLabel.dispose();
    _note.dispose();
    super.dispose();
  }

  void _change(ProviderFormChanged event) => context.read<ProviderFormBloc>().add(event);

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    Widget label(String text) => Padding(
          padding: const EdgeInsets.only(top: Dimens.spacing, bottom: Dimens.spacingSm),
          child: Text(text, style: context.mboaText.label.copyWith(color: colors.ink)),
        );

    return BlocConsumer<ProviderFormBloc, ProviderFormState>(
      listenWhen: (previous, current) =>
          current.saved != null || current.refusal != null || (current.failed && !previous.failed),
      listener: (context, state) {
        if (state.saved case final saved?) {
          MboaToast.success(context: context, title: l10n.providerSavedToast);
          context.router.maybePop(saved);
        } else if (state.refusal case final refusal?) {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: financeRefusalText(l10n, refusal));
        } else {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          leading: const MboaHeaderBackButton(),
          title: Text(state.isEditing ? l10n.providerFormTitleEdit : l10n.providerFormTitleNew),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, 0, Dimens.screenMargin, Dimens.spacingXl),
          children: [
            // A link is chosen once, when he is added.
            if (!state.isEditing && state.contacts.isNotEmpty) ...[
              label(l10n.providerFormFromContacts),
              Wrap(
                spacing: Dimens.spacingSm,
                runSpacing: Dimens.spacingXs,
                children: [
                  for (final contact in state.contacts)
                    ChoiceChip(
                      avatar: Icon(
                        LucideIcons.userRound,
                        size: 16,
                        color: state.contact == contact ? colors.primary : colors.textSecondary,
                      ),
                      label: Text(contact.name),
                      selected: state.contact == contact,
                      showCheckmark: false,
                      selectedColor: colors.primaryPale,
                      labelStyle: financeChipLabel(context, selected: state.contact == contact),
                      side: financeChipSide(context, selected: state.contact == contact),
                      onSelected: state.isSubmitting ? null : (_) => _change(ProviderFormChanged(contact: contact)),
                    ),
                  ChoiceChip(
                    avatar: Icon(
                      LucideIcons.pencilLine,
                      size: 16,
                      color: state.contact == null ? colors.primary : colors.textSecondary,
                    ),
                    label: Text(l10n.providerFormTyped),
                    selected: state.contact == null,
                    showCheckmark: false,
                    selectedColor: colors.primaryPale,
                    labelStyle: financeChipLabel(context, selected: state.contact == null),
                    side: financeChipSide(context, selected: state.contact == null),
                    onSelected: state.isSubmitting ? null : (_) => _change(const ProviderFormChanged(clearContact: true)),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.spacingXs),
              Text(l10n.providerFormContactsHint, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
            ],
            // Linked, the name is his account's.
            if (!state.isLinked) ...[
              label(l10n.providerFormName),
              TextField(
                controller: _name,
                enabled: !state.isSubmitting,
                maxLength: 120,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) => _change(ProviderFormChanged(name: value)),
              ),
            ],
            label(l10n.providerFormKind),
            Wrap(
              spacing: Dimens.spacingSm,
              runSpacing: Dimens.spacingXs,
              children: [
                for (final kind in ProviderKind.values)
                  ChoiceChip(
                    avatar: Icon(_kindIcon(kind), size: 16, color: state.kind == kind ? colors.primary : colors.textSecondary),
                    label: Text(providerKindText(l10n, kind)),
                    selected: state.kind == kind,
                    showCheckmark: false,
                    selectedColor: colors.primaryPale,
                    labelStyle: financeChipLabel(context, selected: state.kind == kind),
                    side: financeChipSide(context, selected: state.kind == kind),
                    onSelected: state.isSubmitting ? null : (_) => _change(ProviderFormChanged(kind: kind)),
                  ),
              ],
            ),
            if (state.kind == ProviderKind.other) ...[
              label(l10n.providerFormKindLabel),
              TextField(
                controller: _kindLabel,
                enabled: !state.isSubmitting,
                maxLength: 60,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: l10n.providerFormKindLabelHint),
                onChanged: (value) => _change(ProviderFormChanged(kindLabel: value)),
              ),
            ],
            label(l10n.providerFormNote),
            TextField(
              controller: _note,
              enabled: !state.isSubmitting,
              maxLength: 500,
              minLines: 1,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) => _change(ProviderFormChanged(note: value)),
            ),
          ],
        ),
        bottomNavigationBar: FinanceActionBar(
          main: Button.primary(
            title: l10n.providerFormSave,
            isLoading: state.isSubmitting,
            onPressed: state.canSubmit ? () => context.read<ProviderFormBloc>().add(const ProviderFormSubmitted()) : null,
          ),
        ),
      ),
    );
  }
}

/// A payment declared to an intervenant, or corrected ([editing]).
@RoutePage()
class ProviderPaymentFormPage extends StatelessWidget implements AutoRouteWrapper {
  const ProviderPaymentFormPage({super.key, @PathParam('providerId') required this.providerId, this.editing});

  final String providerId;
  final ProviderPayment? editing;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ProviderPaymentFormBloc>(
        create: (_) => getIt<ProviderPaymentFormBloc>()
          ..add(ProviderPaymentFormStarted(providerId: providerId, editing: editing, today: DateTime.now())),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const ProviderPaymentFormView();
}

class ProviderPaymentFormView extends StatefulWidget {
  const ProviderPaymentFormView({super.key});

  @override
  State<ProviderPaymentFormView> createState() => _ProviderPaymentFormViewState();
}

class _ProviderPaymentFormViewState extends State<ProviderPaymentFormView> {
  late final TextEditingController _amount;
  late final TextEditingController _note;

  @override
  void initState() {
    super.initState();
    final editing = context.read<ProviderPaymentFormBloc>().state.editing;
    _amount = TextEditingController(text: editing == null ? '' : '${editing.amount}');
    _note = TextEditingController(text: editing?.note);
  }

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  void _change(ProviderPaymentFormChanged event) => context.read<ProviderPaymentFormBloc>().add(event);

  Future<void> _pickDate(ProviderPaymentFormState state) async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: state.paidOn ?? today,
      firstDate: DateTime(today.year - 5),
      lastDate: today,
    );
    if (picked != null) _change(ProviderPaymentFormChanged(paidOn: picked));
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

    return BlocConsumer<ProviderPaymentFormBloc, ProviderPaymentFormState>(
      listenWhen: (previous, current) =>
          current.done != null || current.refusal != null || (current.failed && !previous.failed),
      listener: (context, state) {
        if (state.done case final done?) {
          MboaToast.success(
            context: context,
            title: done == ProviderPaymentDone.saved ? l10n.providerPaymentSavedToast : l10n.providerPaymentDeletedToast,
          );
          context.router.maybePop(true);
        } else if (state.refusal case final refusal?) {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: financeRefusalText(l10n, refusal));
        } else {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          leading: const MboaHeaderBackButton(),
          title: Text(state.isEditing ? l10n.providerPaymentTitleEdit : l10n.providerPaymentTitleNew),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(LucideIcons.shieldCheck, size: Dimens.iconSm, color: colors.primary),
                const SizedBox(width: Dimens.spacingSm),
                Expanded(
                  child: Text(l10n.providerPaymentHint, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                ),
              ],
            ),
            label(l10n.ledgerFormAmount),
            TextField(
              controller: _amount,
              enabled: !state.isSubmitting,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: context.mboaText.h2.copyWith(color: colors.ink),
              onChanged: (value) => _change(ProviderPaymentFormChanged(amount: int.tryParse(value) ?? 0)),
            ),
            label(l10n.providerPaymentDate),
            InkWell(
              onTap: state.isSubmitting ? null : () => _pickDate(state),
              borderRadius: BorderRadius.circular(Dimens.radius),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
                child: Row(
                  children: [
                    Icon(LucideIcons.calendar, size: Dimens.icon, color: colors.primary),
                    const SizedBox(width: Dimens.spacingSm),
                    Text(
                      state.paidOn == null ? l10n.reservationPickDate : DateFormat.yMMMMd(locale).format(state.paidOn!),
                      style: context.mboaText.label.copyWith(color: colors.ink),
                    ),
                  ],
                ),
              ),
            ),
            label(l10n.ledgerFormProperty),
            Wrap(
              spacing: Dimens.spacingSm,
              runSpacing: Dimens.spacingXs,
              children: [
                // « Non affecté », the properties, and the one it is on even if
                // it is no longer listed.
                for (final property in {const UnassignedProperty(), ...state.properties, state.property})
                  ChoiceChip(
                    label: Text(ledgerPropertyLabel(l10n, property), overflow: TextOverflow.ellipsis),
                    selected: state.property == property,
                    showCheckmark: false,
                    selectedColor: colors.primaryPale,
                    labelStyle: financeChipLabel(context, selected: state.property == property),
                    side: financeChipSide(context, selected: state.property == property),
                    onSelected: state.isSubmitting ? null : (_) => _change(ProviderPaymentFormChanged(property: property)),
                  ),
              ],
            ),
            label(l10n.ledgerFormNote),
            TextField(
              controller: _note,
              enabled: !state.isSubmitting,
              maxLength: 500,
              minLines: 1,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) => _change(ProviderPaymentFormChanged(note: value)),
            ),
          ],
        ),
        bottomNavigationBar: FinanceActionBar(
          isBusy: state.isSubmitting,
          main: Button.primary(
            title: l10n.providerFormSave,
            isLoading: state.isSubmitting,
            onPressed: state.canSubmit
                ? () => context.read<ProviderPaymentFormBloc>().add(const ProviderPaymentFormSubmitted())
                : null,
          ),
          onMore: state.isEditing
              ? () async {
                  final bloc = context.read<ProviderPaymentFormBloc>();
                  final choice = await showFinanceActions<bool>(context, [
                    (icon: LucideIcons.trash2, label: l10n.providerPaymentDelete, value: true, destructive: true),
                  ]);
                  if ((choice ?? false) && context.mounted && await confirmFinance(context, l10n.providerPaymentDeleteConfirm)) {
                    bloc.add(const ProviderPaymentDeleted());
                  }
                }
              : null,
        ),
      ),
    );
  }
}
