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
import '../bloc/ledger_bloc.dart';
import '../bloc/ledger_entry_form_bloc.dart';
import '../models/ledger.dart';
import 'widgets/finance_bits.dart';

/// How a category reads, and its icon.
({String label, IconData icon}) ledgerCategoryLook(I18n l10n, LedgerCategory category) => switch (category) {
      LedgerCategory.rent => (label: l10n.ledgerCategoryRent, icon: LucideIcons.house),
      LedgerCategory.charges => (label: l10n.ledgerCategoryCharges, icon: LucideIcons.zap),
      LedgerCategory.works => (label: l10n.ledgerCategoryWorks, icon: LucideIcons.hammer),
      LedgerCategory.propertyTax => (label: l10n.ledgerCategoryTax, icon: LucideIcons.landmark),
      LedgerCategory.serviceProviders => (label: l10n.ledgerCategoryProviders, icon: LucideIcons.hardHat),
      LedgerCategory.other => (label: l10n.ledgerCategoryOther, icon: LucideIcons.receiptText),
    };

String _periodLabel(I18n l10n, LedgerPeriod period) => switch (period) {
      LedgerPeriod.thisMonth => l10n.ledgerPeriodThisMonth,
      LedgerPeriod.lastThreeMonths => l10n.ledgerPeriodThreeMonths,
      LedgerPeriod.thisYear => l10n.ledgerPeriodThisYear,
      LedgerPeriod.all => l10n.ledgerPeriodAll,
    };

/// A property as a filter or a form says it.
String ledgerPropertyLabel(I18n l10n, LedgerProperty property) => switch (property) {
      AllProperties() => l10n.ledgerAllProperties,
      ListingProperty(:final label) || ResidenceProperty(:final label) => label,
      UnassignedProperty() => l10n.ledgerUnassigned,
    };

/// « 120 000 FCFA » in, « − 45 000 FCFA » out.
String _signed(BuildContext context, LedgerDirection direction, int amount) =>
    direction == LedgerDirection.income ? '+ ${fcfaOf(context, amount)}' : '− ${fcfaOf(context, amount)}';

/// The landlord's register (CDC M25). While the add-on runs ([canWrite]),
/// « Ajouter un mouvement » is the main action and the export sits behind
/// « ⋯ »; expired, the export is all there is to do.
@RoutePage()
class LedgerPage extends StatelessWidget implements AutoRouteWrapper {
  const LedgerPage({super.key, this.canWrite = true});

  final bool canWrite;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<LedgerBloc>(
        create: (_) => getIt<LedgerBloc>()..add(const LedgerStarted()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => LedgerView(
        canWrite: canWrite,
        onEdit: (entry) async {
          final bloc = context.read<LedgerBloc>();
          final changed = await context.router.push<bool>(LedgerEntryFormRoute(editing: entry));
          if (changed ?? false) bloc.add(const LedgerRefreshed());
        },
        onAdd: () async {
          final bloc = context.read<LedgerBloc>();
          final changed = await context.router.push<bool>(LedgerEntryFormRoute());
          if (changed ?? false) bloc.add(const LedgerRefreshed());
        },
      );
}

class LedgerView extends StatelessWidget {
  const LedgerView({super.key, required this.canWrite, required this.onAdd, required this.onEdit});

  final bool canWrite;
  final VoidCallback onAdd;
  final ValueChanged<LedgerEntry> onEdit;

  Future<void> _pickProperty(BuildContext context, LedgerReady state) async {
    final l10n = I18n.of(context);
    final bloc = context.read<LedgerBloc>();
    final picked = await showModalBottomSheet<LedgerProperty>(
      context: context,
      backgroundColor: context.mboaColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl))),
      builder: (sheetContext) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
          children: [
            for (final property in [const AllProperties(), ...state.properties, const UnassignedProperty()])
              ListTile(
                title: Text(ledgerPropertyLabel(l10n, property)),
                trailing: property == state.scope.property ? Icon(LucideIcons.check, color: context.mboaColors.primary) : null,
                onTap: () => Navigator.of(sheetContext).pop(property),
              ),
          ],
        ),
      ),
    );
    if (picked != null) bloc.add(LedgerScopeChanged(state.scope.copyWith(property: picked)));
  }

  void _export(BuildContext context) =>
      context.read<LedgerBloc>().add(LedgerExportRequested(name: I18n.of(context).ledgerExportName));

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<LedgerBloc, LedgerState>(
      listenWhen: (_, current) => current is LedgerReady && (current.exportFailed || current.loadFailed),
      listener: (context, state) => MboaToast.error(
        context: context,
        title: l10n.commonErrorTitle,
        description: (state as LedgerReady).exportFailed ? l10n.ledgerExportFailed : l10n.commonError,
      ),
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.financeLedgerTitle)),
        body: switch (state) {
          LedgerLoading() => const Center(child: Loader()),
          LedgerFailure() => Center(
              child: TextButton(
                onPressed: () => context.read<LedgerBloc>().add(const LedgerStarted()),
                child: Text(l10n.commonRetry),
              ),
            ),
          final LedgerReady ready => NotificationListener<ScrollEndNotification>(
              onNotification: (notification) {
                if (notification.metrics.extentAfter < 400) {
                  context.read<LedgerBloc>().add(const LedgerNextPageRequested());
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: () async => context.read<LedgerBloc>().add(const LedgerRefreshed()),
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
                          for (final period in LedgerPeriod.values) ...[
                            ChoiceChip(
                              label: Text(_periodLabel(l10n, period)),
                              selected: ready.scope.period == period,
                              showCheckmark: false,
                              selectedColor: colors.primaryPale,
                              labelStyle: financeChipLabel(context, selected: ready.scope.period == period),
                              side: financeChipSide(context, selected: ready.scope.period == period),
                              onSelected: ready.isOffline
                                  ? null
                                  : (_) => context.read<LedgerBloc>().add(LedgerScopeChanged(ready.scope.copyWith(period: period))),
                            ),
                            const SizedBox(width: Dimens.spacingSm),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimens.spacingSm),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: ActionChip(
                        avatar: Icon(LucideIcons.building2, size: 16, color: colors.primary),
                        label: Text(ledgerPropertyLabel(l10n, ready.scope.property)),
                        onPressed: ready.isOffline ? null : () => _pickProperty(context, ready),
                      ),
                    ),
                    const SizedBox(height: Dimens.spacing),
                    if (ready.isLoading)
                      const Padding(padding: EdgeInsets.all(Dimens.spacingLg), child: Center(child: Loader()))
                    else ...[
                      _SummaryCard(summary: ready.summary),
                      const SizedBox(height: Dimens.spacing),
                      if (ready.entries.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
                          child: Text(
                            l10n.ledgerEmpty,
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
                                for (final entry in ready.entries)
                                  _EntryRow(
                                    entry: entry,
                                    // A kept line is corrected at its source;
                                    // writing needs the add-on running.
                                    onTap: entry.readOnly || !canWrite || ready.isOffline ? null : () => onEdit(entry),
                                  ),
                                if (ready.isLoadingMore)
                                  const Padding(padding: EdgeInsets.all(Dimens.spacing), child: Loader()),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
        },
        bottomNavigationBar: switch (state) {
          LedgerReady(isOffline: false) when canWrite => FinanceActionBar(
              isBusy: state.isExporting,
              main: Button.primary(
                title: l10n.ledgerAdd,
                icon: const Icon(LucideIcons.plus, size: Dimens.icon),
                iconAlignment: IconAlignment.start,
                onPressed: onAdd,
              ),
              onMore: () async {
                final choice = await showFinanceActions<bool>(context, [
                  (icon: LucideIcons.fileSpreadsheet, label: l10n.ledgerExport, value: true, destructive: false),
                ]);
                if ((choice ?? false) && context.mounted) _export(context);
              },
            ),
          // Expired: reading and exporting is what is left (RM-M13-09).
          LedgerReady(isOffline: false) => FinanceActionBar(
              main: Button.primary(
                title: l10n.ledgerExport,
                isLoading: state.isExporting,
                onPressed: () => _export(context),
              ),
            ),
          _ => null,
        },
      ),
    );
  }
}

/// In, out, and the net — the server's sums (RM-M25-03) —, by category
/// beneath.
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summary});

  final LedgerSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    Widget figure(String label, int amount, Color tone) => Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: context.mboaText.caption.copyWith(color: colors.onBrand.withValues(alpha: 0.85))),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(fcfaOf(context, amount), style: context.mboaText.label.copyWith(color: tone, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        );

    return Material(
      color: colors.primary,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(child: MboaBrandPattern(color: colors.onBrand, opacity: 0.08, scale: 0.6)),
          Padding(
            padding: const EdgeInsets.all(Dimens.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.ledgerNet, style: context.mboaText.body.copyWith(color: colors.onBrand.withValues(alpha: 0.85))),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${summary.net < 0 ? '− ' : ''}${fcfaOf(context, summary.net.abs())}',
                    style: context.mboaText.display.copyWith(color: colors.onBrand, fontSize: 36, height: 1.1),
                  ),
                ),
                const SizedBox(height: Dimens.spacing),
                Row(
                  children: [
                    figure(l10n.ledgerIncome, summary.income, colors.onBrand),
                    const SizedBox(width: Dimens.spacing),
                    figure(l10n.ledgerExpense, summary.expense, colors.onBrand),
                  ],
                ),
                if (summary.byCategory.isNotEmpty) ...[
                  Divider(height: Dimens.spacingXl, color: colors.onBrand.withValues(alpha: 0.2)),
                  for (final c in summary.byCategory)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Icon(ledgerCategoryLook(l10n, c.category).icon, size: Dimens.iconSm, color: colors.onBrand),
                          const SizedBox(width: Dimens.spacingSm),
                          Expanded(
                            child: Text(
                              ledgerCategoryLook(l10n, c.category).label,
                              style: context.mboaText.caption.copyWith(color: colors.onBrand),
                            ),
                          ),
                          Text(
                            _signed(context, c.direction, c.total),
                            style: context.mboaText.caption.copyWith(color: colors.onBrand, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryRow extends StatelessWidget {
  const _EntryRow({required this.entry, this.onTap});

  final LedgerEntry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final look = ledgerCategoryLook(l10n, entry.category);
    final income = entry.direction == LedgerDirection.income;
    final line = [
      if (entry.date case final date?) DateFormat.yMMMd(locale).format(date),
      entry.propertyLabel ?? l10n.ledgerUnassigned,
    ].join(' · ');

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: income ? colors.primaryPale : colors.background,
                borderRadius: BorderRadius.circular(Dimens.radius),
              ),
              child: Icon(look.icon, size: Dimens.icon, color: income ? colors.primary : colors.textSecondary),
            ),
            const SizedBox(width: Dimens.spacingMd),
            // The words have the width; the figures go beneath.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          entry.note ?? look.label,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.mboaText.label.copyWith(color: colors.ink),
                        ),
                      ),
                      if (entry.hasAttachment) ...[
                        const SizedBox(width: 4),
                        Icon(LucideIcons.paperclip, size: 14, color: colors.textTertiary),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          line,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                        ),
                      ),
                      const SizedBox(width: Dimens.spacingSm),
                      Text(
                        _signed(context, entry.direction, entry.amount),
                        style: context.mboaText.label.copyWith(
                          color: income ? colors.success : colors.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  if (entry.readOnly) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(LucideIcons.lock, size: 12, color: colors.textTertiary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(l10n.ledgerReadOnly, style: context.mboaText.micro.copyWith(color: colors.textTertiary)),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Writing one line of the register, or correcting it ([editing]).
@RoutePage()
class LedgerEntryFormPage extends StatelessWidget implements AutoRouteWrapper {
  const LedgerEntryFormPage({super.key, this.editing});

  final LedgerEntry? editing;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<LedgerEntryFormBloc>(
        create: (_) => getIt<LedgerEntryFormBloc>()..add(LedgerEntryFormStarted(editing: editing)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const LedgerEntryFormView();
}

class LedgerEntryFormView extends StatefulWidget {
  const LedgerEntryFormView({super.key});

  @override
  State<LedgerEntryFormView> createState() => _LedgerEntryFormViewState();
}

class _LedgerEntryFormViewState extends State<LedgerEntryFormView> {
  late final TextEditingController _amount;
  late final TextEditingController _note;

  @override
  void initState() {
    super.initState();
    final editing = context.read<LedgerEntryFormBloc>().state.editing;
    _amount = TextEditingController(text: editing == null ? '' : '${editing.amount}');
    _note = TextEditingController(text: editing?.note);
  }

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  void _change(LedgerEntryFormChanged event) => context.read<LedgerEntryFormBloc>().add(event);

  Future<void> _pickDate(LedgerEntryFormState state) async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: state.date ?? today,
      firstDate: DateTime(today.year - 5),
      lastDate: DateTime(today.year + 1),
    );
    if (picked != null) _change(LedgerEntryFormChanged(date: picked));
  }

  Future<void> _addPhoto() async {
    final bloc = context.read<LedgerEntryFormBloc>();
    final source = await showCaptureSourceSheet(context);
    if (source != null) bloc.add(LedgerEntryAttachmentAdded(source));
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

    return BlocConsumer<LedgerEntryFormBloc, LedgerEntryFormState>(
      listenWhen: (previous, current) =>
          current.done != null ||
          current.refusal != null ||
          current.viewUrl != null ||
          (current.failed && !previous.failed) ||
          (current.uploadFailed && !previous.uploadFailed),
      listener: (context, state) {
        if (state.done case final done?) {
          MboaToast.success(context: context, title: done == LedgerFormDone.saved ? l10n.ledgerSavedToast : l10n.ledgerDeletedToast);
          context.router.maybePop(true);
        } else if (state.viewUrl case final url?) {
          showDialog<void>(
            context: context,
            builder: (dialogContext) => Dialog.fullscreen(
              backgroundColor: Colors.black,
              child: Stack(
                children: [
                  Center(child: InteractiveViewer(child: MboaNetworkImage(url: url))),
                  Positioned(
                    top: Dimens.spacingLg,
                    right: Dimens.spacing,
                    child: IconButton(
                      tooltip: l10n.commonClose,
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      icon: const Icon(LucideIcons.x, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state.refusal case final refusal?) {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: financeRefusalText(l10n, refusal));
        } else if (state.uploadFailed) {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.ledgerUploadFailed);
        } else {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          leading: const MboaHeaderBackButton(),
          title: Text(state.isEditing ? l10n.ledgerFormTitleEdit : l10n.ledgerFormTitleNew),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
          children: [
            MboaSegmentedControl<LedgerDirection>(
              value: state.direction,
              enabled: !state.isSubmitting,
              onChanged: (direction) => _change(LedgerEntryFormChanged(direction: direction)),
              segments: [
                MboaSegment(value: LedgerDirection.expense, label: l10n.ledgerExpense),
                MboaSegment(value: LedgerDirection.income, label: l10n.ledgerIncome),
              ],
            ),
            label(l10n.ledgerFormCategory),
            Wrap(
              spacing: Dimens.spacingSm,
              runSpacing: Dimens.spacingXs,
              children: [
                for (final category in LedgerEntryFormState.categoriesFor(state.direction))
                  ChoiceChip(
                    avatar: Icon(
                      ledgerCategoryLook(l10n, category).icon,
                      size: 16,
                      color: state.category == category ? colors.primary : colors.textSecondary,
                    ),
                    label: Text(ledgerCategoryLook(l10n, category).label),
                    selected: state.category == category,
                    showCheckmark: false,
                    selectedColor: colors.primaryPale,
                    labelStyle: financeChipLabel(context, selected: state.category == category),
                    side: financeChipSide(context, selected: state.category == category),
                    onSelected: state.isSubmitting ? null : (_) => _change(LedgerEntryFormChanged(category: category)),
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
              onChanged: (value) => _change(LedgerEntryFormChanged(amount: int.tryParse(value) ?? 0)),
            ),
            label(l10n.ledgerFormDate),
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
                      state.date == null ? l10n.reservationPickDate : DateFormat.yMMMMd(locale).format(state.date!),
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
                for (final property in [const UnassignedProperty(), ...state.properties])
                  ChoiceChip(
                    label: Text(ledgerPropertyLabel(l10n, property), overflow: TextOverflow.ellipsis),
                    selected: state.property == property,
                    showCheckmark: false,
                    selectedColor: colors.primaryPale,
                    labelStyle: financeChipLabel(context, selected: state.property == property),
                    side: financeChipSide(context, selected: state.property == property),
                    onSelected: state.isSubmitting ? null : (_) => _change(LedgerEntryFormChanged(property: property)),
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
              onChanged: (value) => _change(LedgerEntryFormChanged(note: value)),
            ),
            label(l10n.ledgerFormAttachment),
            if (state.attachmentKey != null)
              InputChip(
                avatar: Icon(LucideIcons.paperclip, size: 16, color: colors.primary),
                label: Text(l10n.ledgerFormAttachmentAdded),
                onDeleted: state.isBusy ? null : () => context.read<LedgerEntryFormBloc>().add(const LedgerEntryAttachmentRemoved()),
              )
            else
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  onPressed: state.isBusy ? null : _addPhoto,
                  icon: state.isUploading
                      ? const SizedBox.square(dimension: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(LucideIcons.camera, size: Dimens.icon),
                  label: Text(l10n.ledgerFormAttachmentAdd),
                ),
              ),
            if (state.hadAttachment) ...[
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  onPressed: state.isBusy
                      ? null
                      : () => context.read<LedgerEntryFormBloc>().add(const LedgerEntryAttachmentViewed()),
                  icon: const Icon(LucideIcons.image, size: Dimens.icon),
                  label: Text(l10n.ledgerFormAttachmentView),
                ),
              ),
              // §34 — said, rather than lost without a word.
              if (state.dropsAttachment)
                Text(l10n.ledgerFormAttachmentDropped, style: context.mboaText.caption.copyWith(color: colors.warning)),
            ],
          ],
        ),
        bottomNavigationBar: FinanceActionBar(
          isBusy: state.isBusy,
          main: Button.primary(
            title: l10n.ledgerFormSave,
            isLoading: state.isSubmitting,
            onPressed: state.canSubmit ? () => context.read<LedgerEntryFormBloc>().add(const LedgerEntryFormSubmitted()) : null,
          ),
          onMore: state.isEditing
              ? () async {
                  final bloc = context.read<LedgerEntryFormBloc>();
                  final choice = await showFinanceActions<bool>(context, [
                    (icon: LucideIcons.trash2, label: l10n.ledgerFormDelete, value: true, destructive: true),
                  ]);
                  if ((choice ?? false) && context.mounted && await confirmFinance(context, l10n.ledgerFormDeleteConfirm)) {
                    bloc.add(const LedgerEntryDeleted());
                  }
                }
              : null,
        ),
      ),
    );
  }
}
