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

import '../bloc/invoice_form_bloc.dart';
import 'widgets/finance_bits.dart';

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

/// Three steps — the tenant, the charge, the amount and its date — each with
/// its own question on top and one action at the bottom. Back goes to the
/// step before, not out of the form.
class InvoiceFormView extends StatefulWidget {
  const InvoiceFormView({super.key});

  @override
  State<InvoiceFormView> createState() => _InvoiceFormViewState();
}

class _InvoiceFormViewState extends State<InvoiceFormView> {
  late final TextEditingController _search;
  late final TextEditingController _label;
  late final TextEditingController _amount;

  /// Filled from what the form starts with — a correction's own words. In
  /// initState, not lazily: a form never shown (no tenancy) would otherwise
  /// read the bloc from dispose.
  @override
  void initState() {
    super.initState();
    final start = context.read<InvoiceFormBloc>().state;
    _search = TextEditingController(text: start.query);
    _label = TextEditingController(text: start.label);
    _amount = TextEditingController(text: start.amount == null ? '' : '${start.amount}');
  }

  @override
  void dispose() {
    _search.dispose();
    _label.dispose();
    _amount.dispose();
    super.dispose();
  }

  void _add(InvoiceFormEvent event) => context.read<InvoiceFormBloc>().add(event);

  void _goTo(InvoiceFormStep step) {
    FocusManager.instance.primaryFocus?.unfocus();
    _add(InvoiceFormStepRequested(step));
  }

  Future<void> _pickDue(InvoiceFormState state) async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: state.dueDate ?? today.add(const Duration(days: 7)),
      firstDate: DateTime(today.year - 1),
      lastDate: DateTime(today.year + 2),
    );
    if (picked != null) _add(InvoiceFormChanged(dueDate: picked));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<InvoiceFormBloc, InvoiceFormState>(
      listenWhen: (previous, current) =>
          current.saved != null || current.refusal != null || (current.failed && !previous.failed),
      listener: (context, state) {
        if (state.saved case final saved?) {
          MboaToast.success(
            context: context,
            title: state.isEditing ? l10n.ownerInvoiceSaved : l10n.ownerInvoiceCreated,
          );
          // After the rebuild that lets the route go (canPop below).
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.router.maybePop(saved);
          });
        } else if (state.refusal case final refusal?) {
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: financeRefusalText(l10n, refusal),
          );
        } else {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError);
        }
      },
      builder: (context, state) {
        final noTenancy = !state.isEditing && !state.isLoadingTenancies && state.tenancies.isEmpty;
        final ready = !state.isLoadingTenancies && !noTenancy;
        final steps = state.steps;

        return PopScope(
          canPop: !ready || state.isFirstStep || state.saved != null,
          onPopInvokedWithResult: (didPop, _) {
            final previous = state.previousStep;
            if (!didPop && previous != null) _goTo(previous);
          },
          child: Scaffold(
            backgroundColor: colors.background,
            appBar: AppBar(
              leading: ready && !state.isFirstStep
                  ? IconButton(
                      icon: Icon(LucideIcons.arrowLeft, color: colors.ink),
                      onPressed: state.isSubmitting ? null : () => _goTo(state.previousStep!),
                    )
                  : const MboaHeaderBackButton(),
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
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          Dimens.screenMargin,
                          0,
                          Dimens.screenMargin,
                          Dimens.spacing,
                        ),
                        child: MboaStepHeader(
                          current: steps.indexOf(state.step) + 1,
                          total: steps.length,
                          title: switch (state.step) {
                            InvoiceFormStep.tenant => l10n.ownerInvoiceFormTenant,
                            InvoiceFormStep.charge => l10n.ownerInvoiceStepCharge,
                            InvoiceFormStep.amount => l10n.ownerInvoiceStepAmount,
                          },
                          onStepTap: state.isSubmitting ? null : (n) => _goTo(steps[n - 1]),
                        ),
                      ),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: KeyedSubtree(
                            key: ValueKey(state.step),
                            child: switch (state.step) {
                              InvoiceFormStep.tenant => _TenantStep(
                                state: state,
                                search: _search,
                                onSearch: (q) => _add(InvoiceFormSearchChanged(q)),
                                onGroup: (g) => _add(InvoiceFormGroupChanged(g)),
                                onChoose: (id) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _add(InvoiceFormTenantChosen(id));
                                },
                              ),
                              InvoiceFormStep.charge => _ChargeStep(
                                state: state,
                                label: _label,
                                onChange: _add,
                                onChangeTenant: () => _goTo(InvoiceFormStep.tenant),
                              ),
                              InvoiceFormStep.amount => _AmountStep(
                                state: state,
                                amount: _amount,
                                onChange: _add,
                                onPickDue: () => _pickDue(state),
                                onChangeTenant: () => _goTo(InvoiceFormStep.tenant),
                              ),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
            // The tenant step's action is the row itself: no bar.
            bottomNavigationBar: !ready || state.step == InvoiceFormStep.tenant
                ? null
                : FinanceActionBar(
                    main: switch (state.nextStep) {
                      final next? => Button.primary(
                        title: l10n.commonContinue,
                        onPressed: state.canContinue ? () => _goTo(next) : null,
                      ),
                      null => Button.primary(
                        title: state.isEditing ? l10n.ownerInvoiceSave : l10n.ownerInvoiceCreate,
                        isLoading: state.isSubmitting,
                        onPressed: state.canSubmit ? () => _add(const InvoiceFormSubmitted()) : null,
                      ),
                    },
                  ),
          ),
        );
      },
    );
  }
}

/// Step 1 — whom. One search over everyone; the tabs keep standalone
/// listings apart from residences and count what the search found in each,
/// so a match in the other tab is never hidden.
class _TenantStep extends StatelessWidget {
  const _TenantStep({
    required this.state,
    required this.search,
    required this.onSearch,
    required this.onGroup,
    required this.onChoose,
  });

  final InvoiceFormState state;
  final TextEditingController search;
  final ValueChanged<String> onSearch;
  final ValueChanged<TenancyGroup> onGroup;
  final ValueChanged<String> onChoose;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final singles = state.singles;
    final residences = state.residences;

    final rows = <Widget>[
      if (state.group == TenancyGroup.single)
        for (final home in singles)
          _TenancyRow(
            home: home,
            place: home.annonceTitle,
            selected: home.contractId == state.contractId,
            onTap: () => onChoose(home.contractId),
          )
      else
        for (final residence in residences) ...[
          _ResidenceHeader(name: residence.name, count: residence.homes.length),
          for (final home in residence.homes)
            _TenancyRow(
              home: home,
              place: home.annonceTitle,
              selected: home.contractId == state.contractId,
              onTap: () => onChoose(home.contractId),
            ),
        ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.screenMargin),
          child: Input(
            controller: search,
            hintText: l10n.ownerInvoiceSearchHint,
            autocorrect: false,
            textInputAction: TextInputAction.search,
            prefixIcon: Icon(LucideIcons.search, size: Dimens.icon, color: colors.textTertiary),
            suffixIcon: state.query.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(LucideIcons.x, size: Dimens.iconSm),
                    onPressed: () {
                      search.clear();
                      onSearch('');
                    },
                  ),
            onChanged: onSearch,
          ),
        ),
        const SizedBox(height: Dimens.spacingMd),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.screenMargin),
          child: MboaSegmentedControl<TenancyGroup>(
            value: state.group,
            segments: [
              MboaSegment(value: TenancyGroup.single, label: l10n.ownerInvoiceGroupSingle(singles.length)),
              MboaSegment(value: TenancyGroup.multiple, label: l10n.ownerInvoiceGroupMultiple(state.residencesCount)),
            ],
            onChanged: onGroup,
          ),
        ),
        const SizedBox(height: Dimens.spacingSm),
        Expanded(
          child: rows.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(Dimens.spacingXl),
                  child: Text(
                    state.query.trim().isNotEmpty
                        ? l10n.ownerInvoiceSearchEmpty(state.query.trim())
                        : state.group == TenancyGroup.single
                        ? l10n.ownerInvoiceGroupEmptySingle
                        : l10n.ownerInvoiceGroupEmptyMultiple,
                    textAlign: TextAlign.center,
                    style: context.mboaText.body.copyWith(color: colors.textSecondary),
                  ),
                )
              // Hundreds of tenants: built as they scroll in.
              : ListView.builder(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.only(bottom: Dimens.spacingXl),
                  itemCount: rows.length,
                  itemBuilder: (_, i) => rows[i],
                ),
        ),
      ],
    );
  }
}

/// A residence's name over its tenants, and how many there are.
class _ResidenceHeader extends StatelessWidget {
  const _ResidenceHeader({required this.name, required this.count});

  final String name;
  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXs),
      child: Row(
        children: [
          Icon(LucideIcons.building2, size: Dimens.iconSm, color: colors.primary),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.mboaText.label.copyWith(color: colors.primaryDark, fontWeight: FontWeight.w700),
            ),
          ),
          Text('$count', style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
        ],
      ),
    );
  }
}

/// A tenant and what they rent; the row is the choice.
class _TenancyRow extends StatelessWidget {
  const _TenancyRow({required this.home, required this.place, required this.selected, required this.onTap});

  final Home home;
  final String? place;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final name = home.tenant?.displayName ?? l10n.declarationTenant;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.screenMargin, vertical: Dimens.spacingSm),
        child: Row(
          children: [
            _Initials(name: name),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.label.copyWith(color: colors.ink, fontWeight: FontWeight.w600),
                  ),
                  if (place != null)
                    Text(
                      place!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                    ),
                ],
              ),
            ),
            Icon(
              selected ? LucideIcons.circleCheck : LucideIcons.chevronRight,
              size: selected ? Dimens.icon : Dimens.iconSm,
              color: selected ? colors.primary : colors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}

/// A person's initials on the brand's pale green.
class _Initials extends StatelessWidget {
  const _Initials({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    final initials = switch (parts) {
      [] => '?',
      [final only] => only[0],
      [final first, ..., final last] => '${first[0]}${last[0]}',
    };
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: colors.primaryPale, shape: BoxShape.circle),
      child: Text(
        initials.toUpperCase(),
        style: context.mboaText.label.copyWith(color: colors.primaryDark, fontWeight: FontWeight.w700),
      ),
    );
  }
}

/// Who is billed, on top of the next steps — and, before the amount, for
/// what. « Changer » goes back to the tenant when there was a choice.
class _Recap extends StatelessWidget {
  const _Recap({required this.state, required this.onChangeTenant, this.showCharge = false});

  final InvoiceFormState state;
  final VoidCallback onChangeTenant;
  final bool showCharge;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final tenancy = state.tenancy;
    final name = tenancy?.tenant?.displayName ?? state.editing?.annonceTitle ?? l10n.declarationTenant;
    final place = tenancy?.placeTitle;
    final label = state.label?.trim() ?? '';

    return Container(
      padding: const EdgeInsets.all(Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _Initials(name: name),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: context.mboaText.label.copyWith(color: colors.ink, fontWeight: FontWeight.w600),
                    ),
                    if (place != null)
                      Text(place, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                  ],
                ),
              ),
              if (state.steps.contains(InvoiceFormStep.tenant))
                TextButton(
                  onPressed: state.isSubmitting ? null : onChangeTenant,
                  child: Text(l10n.ownerInvoiceChangeTenant),
                ),
            ],
          ),
          if (showCharge) ...[
            Divider(color: colors.border, height: Dimens.spacingLg),
            Row(
              children: [
                InvoiceKindTile(kind: state.kind, size: 32),
                const SizedBox(width: Dimens.spacingMd),
                Expanded(
                  child: Text(
                    label.isEmpty ? invoiceKindLook(l10n, state.kind).label : label,
                    style: context.mboaText.label.copyWith(color: colors.ink),
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

Widget _fieldLabel(BuildContext context, String text) => Padding(
  padding: const EdgeInsets.only(top: Dimens.spacingLg, bottom: Dimens.spacingSm),
  child: Text(text, style: context.mboaText.label.copyWith(color: context.mboaColors.ink)),
);

/// Step 2 — what: the kind as three cards (fixed when correcting), and the
/// words the tenant will read.
class _ChargeStep extends StatelessWidget {
  const _ChargeStep({required this.state, required this.label, required this.onChange, required this.onChangeTenant});

  final InvoiceFormState state;
  final TextEditingController label;
  final ValueChanged<InvoiceFormEvent> onChange;
  final VoidCallback onChangeTenant;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return ListView(
      padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, 0, Dimens.screenMargin, Dimens.spacingXl),
      children: [
        _Recap(state: state, onChangeTenant: onChangeTenant),
        // The step's own question names it: no label over the cards.
        const SizedBox(height: Dimens.spacingLg),
        Row(
          children: [
            for (final kind in InvoiceKind.values) ...[
              if (kind != InvoiceKind.values.first) const SizedBox(width: Dimens.spacingSm),
              Expanded(
                child: _KindCard(
                  kind: kind,
                  selected: state.kind == kind,
                  onTap: state.isEditing || state.isSubmitting ? null : () => onChange(InvoiceFormChanged(kind: kind)),
                ),
              ),
            ],
          ],
        ),
        _fieldLabel(context, l10n.ownerInvoiceFormLabel),
        Input(
          controller: label,
          enabled: !state.isSubmitting,
          maxLength: 120,
          hintText: l10n.ownerInvoiceFormLabelHint,
          onChanged: (value) => onChange(InvoiceFormChanged(label: value)),
        ),
        if (state.kind == InvoiceKind.other)
          Text(
            l10n.ownerInvoiceFormLabelRequired,
            style: context.mboaText.caption.copyWith(color: state.needsLabel ? colors.error : colors.textSecondary),
          ),
      ],
    );
  }
}

/// One kind of charge, as a card; the chosen one in the brand's green.
class _KindCard extends StatelessWidget {
  const _KindCard({required this.kind, required this.selected, required this.onTap});

  final InvoiceKind kind;
  final bool selected;

  /// Null when the kind is fixed (a correction): the others fade.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final look = invoiceKindLook(I18n.of(context), kind);

    return Opacity(
      opacity: onTap == null && !selected ? 0.4 : 1,
      child: Material(
        color: selected ? colors.primaryPale : colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.radiusMd),
          side: BorderSide(color: selected ? colors.primary : colors.border, width: selected ? 1.5 : 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.spacing, horizontal: Dimens.spacingSm),
            child: Column(
              children: [
                Icon(look.icon, size: 28, color: selected ? colors.primary : colors.textSecondary),
                const SizedBox(height: Dimens.spacingSm),
                Text(
                  look.label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: financeChipLabel(context, selected: selected),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Step 3 — how much and by when, under a recap of whom and what.
class _AmountStep extends StatelessWidget {
  const _AmountStep({
    required this.state,
    required this.amount,
    required this.onChange,
    required this.onPickDue,
    required this.onChangeTenant,
  });

  final InvoiceFormState state;
  final TextEditingController amount;
  final ValueChanged<InvoiceFormEvent> onChange;
  final VoidCallback onPickDue;
  final VoidCallback onChangeTenant;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final due = state.dueDate;

    return ListView(
      padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, 0, Dimens.screenMargin, Dimens.spacingXl),
      children: [
        _Recap(state: state, onChangeTenant: onChangeTenant, showCharge: true),
        _fieldLabel(context, l10n.ownerInvoiceFormAmount),
        Input(
          controller: amount,
          enabled: !state.isSubmitting,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          hintText: '0',
          style: context.mboaText.h2.copyWith(color: colors.ink),
          onChanged: (value) => onChange(InvoiceFormChanged(amount: int.tryParse(value) ?? 0)),
        ),
        _fieldLabel(context, l10n.ownerInvoiceFormDue),
        Material(
          color: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.radius),
            side: BorderSide(color: colors.primaryDark),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: state.isSubmitting ? null : onPickDue,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing, vertical: 18),
              child: Row(
                children: [
                  Icon(LucideIcons.calendar, size: Dimens.icon, color: colors.primary),
                  const SizedBox(width: Dimens.spacingSm),
                  Text(
                    due == null ? l10n.reservationPickDate : DateFormat.yMMMMd(locale).format(due),
                    style: context.mboaText.label.copyWith(
                      color: due == null ? colors.textTertiary : colors.ink,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
