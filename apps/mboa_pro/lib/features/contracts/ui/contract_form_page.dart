import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../annonces/bloc/annonces_bloc.dart';
import '../bloc/contract_detail_bloc.dart';
import '../bloc/contract_form_bloc.dart';

/// Drawing up a Contrat Mboa, or amending one (CDC M08).
///
/// Seeded from the listing: RM-M08-05 has the contract **copy** the property,
/// so the rent and its period start from what the listing says and the
/// prestataire adjusts rather than retypes.
@RoutePage()
class ContractFormPage extends StatefulWidget implements AutoRouteWrapper {
  const ContractFormPage({
    super.key,
    required this.annonceId,
    this.contractId,
  });

  final String annonceId;

  /// Set when amending an existing contract (RM-M08-08).
  final String? contractId;

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<ContractFormBloc>(create: (_) => getIt<ContractFormBloc>()),
          if (contractId != null)
            BlocProvider<ContractDetailBloc>(
              create: (_) => getIt<ContractDetailBloc>()
                ..add(ContractRequested(contractId!)),
            ),
        ],
        child: this,
      );

  @override
  State<ContractFormPage> createState() => _ContractFormPageState();
}

class _ContractFormPageState extends State<ContractFormPage> {
  final _price = TextEditingController();
  final _deposit = TextEditingController();
  final _duration = TextEditingController();
  final _phone = TextEditingController();

  bool _seeded = false;

  @override
  void initState() {
    super.initState();
    if (widget.contractId == null) _seedFromListing();
  }

  /// The listing's rent and period are the contract's opening position.
  void _seedFromListing() {
    final state = context.read<AnnoncesBloc>().state;
    final annonce = state is AnnoncesReady
        ? state.items.where((a) => a.id == widget.annonceId).firstOrNull
        : null;

    final terms = ContractTerms(
      annonceId: widget.annonceId,
      price: annonce?.displayPrice,
      rentalPeriod: annonce?.rentalPeriod ?? RentalPeriod.month,
    );
    _price.text = terms.price?.toString() ?? '';
    context.read<ContractFormBloc>().add(ContractFormStarted(terms));
    _seeded = true;
  }

  void _seedFromContract(Contract contract) {
    if (_seeded) return;
    final terms = ContractTerms.of(contract);
    _price.text = terms.price?.toString() ?? '';
    _deposit.text = terms.depositAmount?.toString() ?? '';
    _duration.text = terms.durationUnits?.toString() ?? '';
    context
        .read<ContractFormBloc>()
        .add(ContractFormStarted(terms, amendingId: contract.id));
    _seeded = true;
  }

  @override
  void dispose() {
    _price.dispose();
    _deposit.dispose();
    _duration.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _update(ContractTerms terms) =>
      context.read<ContractFormBloc>().add(ContractFormChanged(terms));

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    final body = BlocConsumer<ContractFormBloc, ContractFormState>(
      listenWhen: (prev, curr) => curr.saved != null || curr.failure != null,
      listener: (context, state) {
        if (state.saved != null) {
          MboaToast.success(context: context, title: l10n.contractSaved);
          context.router.maybePop();
          return;
        }
        MboaToast.error(
          context: context,
          title: l10n.commonErrorTitle,
          description: switch (state.failure!) {
            // CE-M08-01 — the invitation went out; the contract is drawn up
            // once the tenant has joined, which is a wait, not a failure.
            ContractFormFailure.tenantHasNoAccount => l10n.contractTenantInvited,
            ContractFormFailure.refused => l10n.contractActionFailed,
          },
        );
      },
      builder: (context, state) => _Form(
        state: state,
        price: _price,
        deposit: _deposit,
        duration: _duration,
        phone: _phone,
        onChanged: _update,
      ),
    );

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(
        title: Text(
          widget.contractId == null
              ? l10n.contractFormTitleNew
              : l10n.contractFormTitleAmend,
        ),
      ),
      body: widget.contractId == null
          ? body
          : BlocConsumer<ContractDetailBloc, ContractDetailState>(
              listenWhen: (prev, curr) => curr is ContractDetailReady,
              listener: (context, state) =>
                  _seedFromContract((state as ContractDetailReady).contract),
              builder: (context, state) =>
                  state is ContractDetailReady ? body : const Center(child: Loader()),
            ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({
    required this.state,
    required this.price,
    required this.deposit,
    required this.duration,
    required this.phone,
    required this.onChanged,
  });

  final ContractFormState state;
  final TextEditingController price;
  final TextEditingController deposit;
  final TextEditingController duration;
  final TextEditingController phone;
  final ValueChanged<ContractTerms> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final terms = state.terms;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(Dimens.spacingLg),
            children: [
              if (!state.isAmending) ...[
                Text(l10n.contractFormTenantTitle, style: context.mboaText.h3),
                const SizedBox(height: Dimens.spacingSm),
                Input(
                  controller: phone,
                  labelText: l10n.contractFormTenantPhone,
                  hintText: '+237690000000',
                  keyboardType: TextInputType.phone,
                  variant: InputVariant.underline,
                  onChanged: (value) =>
                      onChanged(terms.copyWith(tenantPhone: value.trim())),
                ),
                const SizedBox(height: Dimens.spacingXs),
                Text(
                  // CE-M08-01, said before the attempt rather than after it.
                  l10n.contractFormTenantHelp,
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
                const SizedBox(height: Dimens.spacingXl),
              ],
              Text(l10n.contractTermsTitle, style: context.mboaText.h3),
              const SizedBox(height: Dimens.spacingSm),
              Input(
                controller: price,
                labelText: l10n.contractTermPrice,
                keyboardType: TextInputType.number,
                variant: InputVariant.underline,
                onChanged: (value) =>
                    onChanged(terms.copyWith(price: int.tryParse(value.trim()))),
              ),
              const SizedBox(height: Dimens.spacingLg),
              Text(
                l10n.contractTermPeriod,
                style: context.mboaText.label.copyWith(color: colors.primaryDark),
              ),
              const SizedBox(height: Dimens.spacingXs),
              MboaSegmentedControl<RentalPeriod>(
                value: terms.rentalPeriod,
                onChanged: (period) =>
                    onChanged(terms.copyWith(rentalPeriod: period)),
                segments: [
                  for (final period in RentalPeriod.values)
                    MboaSegment(value: period, label: period.label(l10n)),
                ],
              ),
              const SizedBox(height: Dimens.spacingLg),
              Input(
                controller: deposit,
                labelText: l10n.contractTermDeposit,
                keyboardType: TextInputType.number,
                variant: InputVariant.underline,
                onChanged: (value) => onChanged(
                  terms.copyWith(depositAmount: int.tryParse(value.trim())),
                ),
              ),
              const SizedBox(height: Dimens.spacingLg),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: terms.chargesIncluded,
                title: Text(l10n.contractTermCharges),
                onChanged: (value) =>
                    onChanged(terms.copyWith(chargesIncluded: value)),
              ),
              const SizedBox(height: Dimens.spacingSm),
              _DateField(
                label: l10n.contractTermStart,
                value: terms.startDate,
                onChanged: (date) => onChanged(terms.copyWith(startDate: date)),
              ),
              const SizedBox(height: Dimens.spacingLg),
              Input(
                controller: duration,
                labelText: l10n.contractTermDuration,
                // RM-M08-08 — the duration is counted in the contract's own
                // periodicity, so the unit follows the selector above.
                hintText: terms.rentalPeriod.label(l10n),
                keyboardType: TextInputType.number,
                variant: InputVariant.underline,
                onChanged: (value) => onChanged(
                  terms.copyWith(durationUnits: int.tryParse(value.trim())),
                ),
              ),
              const SizedBox(height: Dimens.spacingSm),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: terms.tacitRenewal,
                title: Text(l10n.contractTermTacit),
                onChanged: (value) =>
                    onChanged(terms.copyWith(tacitRenewal: value)),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(top: BorderSide(color: colors.border)),
          ),
          child: SafeArea(
            minimum: const EdgeInsets.all(Dimens.spacing),
            child: Button.primary(
              title: state.isAmending ? l10n.contractAmend : l10n.contractFormSave,
              isLoading: state.isSaving,
              onPressed: state.canSubmit
                  ? () => context
                      .read<ContractFormBloc>()
                      .add(const ContractFormSubmitted())
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return InkWell(
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? now,
          firstDate: now.subtract(const Duration(days: 365)),
          lastDate: now.add(const Duration(days: 365 * 5)),
        );
        if (picked != null) onChanged(picked);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: context.mboaText.body.copyWith(color: colors.textSecondary),
              ),
            ),
            Text(
              value == null ? '—' : DateFormat.yMMMMd().format(value!),
              style: context.mboaText.label.copyWith(color: colors.ink),
            ),
          ],
        ),
      ),
    );
  }
}
