import 'dart:async';

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

import '../bloc/declare_payment_bloc.dart';
import '../models/declaration_form.dart';

/// Declaring a payment made outside Mboa (CDC M30, RM-M30-03), after the
/// founder's "Détails de la transaction" and "Moyen de recharge" sheets —
/// here they say how it **was** paid; nothing is paid from this screen
/// (RM-M30-06, CA-M30-03).
@RoutePage()
class DeclarePaymentPage extends StatelessWidget implements AutoRouteWrapper {
  const DeclarePaymentPage({super.key, required this.contractId, required this.form});

  final String contractId;
  final DeclarationForm form;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<DeclarePaymentBloc>(
        create: (_) => getIt<DeclarePaymentBloc>()..add(DeclarationStarted(contractId: contractId, form: form)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const DeclarePaymentView();
}

/// The form under its bloc — public so it can be pumped with a mock one.
class DeclarePaymentView extends StatefulWidget {
  const DeclarePaymentView({super.key});

  @override
  State<DeclarePaymentView> createState() => _DeclarePaymentViewState();
}

/// Only the text controllers live here; every rule is the form's.
class _DeclarePaymentViewState extends State<DeclarePaymentView> {
  final _amount = TextEditingController();
  final _reference = TextEditingController();
  final _note = TextEditingController();

  /// The mockup's two tabs: mobile money, and the rest.
  bool _mobileTab = true;

  @override
  void initState() {
    super.initState();
    final form = context.read<DeclarePaymentBloc>().state.form;
    if (form?.amount case final amount? when amount > 0) _amount.text = '$amount';
  }

  @override
  void dispose() {
    _amount.dispose();
    _reference.dispose();
    _note.dispose();
    super.dispose();
  }

  void _change(DeclarationForm form) => context.read<DeclarePaymentBloc>().add(DeclarationFormChanged(form));

  /// A new range proposes its own amount; the field follows.
  void _toggle(DeclarationForm form, RentDue due) {
    final next = form.toggle(due);
    _amount.text = next.amount == null || next.amount == 0 ? '' : '${next.amount}';
    _change(next);
  }

  Future<void> _pickDate(DeclarationForm form) async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: form.paidOn ?? today,
      firstDate: DateTime(today.year - 2),
      // DECLARATION_DATE_INVALID — not after today.
      lastDate: today,
    );
    if (picked != null) _change(form.copyWith(paidOn: picked));
  }

  Future<void> _addProof() async {
    final bloc = context.read<DeclarePaymentBloc>();
    final source = await showCaptureSourceSheet(context);
    if (source != null) bloc.add(DeclarationProofAdded(source));
  }

  Future<void> _submit(DeclarationForm form) async {
    final l10n = I18n.of(context);
    final bloc = context.read<DeclarePaymentBloc>();
    // CE-M30-02 — zero, or more than ten times what is due: asked once more.
    if (form.looksUnusual) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(l10n.declareUnusualTitle),
          content: Text(l10n.declareUnusualBody(fcfaOf(context, form.amount ?? 0), fcfaOf(context, form.due))),
          actions: [
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: Text(l10n.commonCancel)),
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: Text(l10n.declareUnusualConfirm)),
          ],
        ),
      );
      if (!(ok ?? false)) return;
    }
    bloc.add(const DeclarationSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return BlocConsumer<DeclarePaymentBloc, DeclarePaymentState>(
      listenWhen: (previous, current) =>
          current.sent != null || current.refusal != null || current.failed || current.uploadFailed,
      listener: (context, state) {
        if (state.sent != null) {
          MboaToast.success(context: context, title: l10n.declareSentTitle, description: l10n.declareSentBody);
          unawaited(context.router.maybePop(true));
        } else if (state.uploadFailed) {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.declareUploadFailed);
        } else {
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: state.refusal == null ? l10n.declareFailed : declarationRefusalText(l10n, state.refusal!),
          );
        }
      },
      builder: (context, state) {
        final form = state.form;
        if (form == null) return const Scaffold(body: Center(child: Loader()));
        final busy = state.isSending;
        final methods = [
          for (final m in RentPaymentMethod.values)
            if (m.isMobile == _mobileTab) m,
        ];

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppBar(
            leading: const MboaHeaderBackButton(),
            title: Text(form.kind == DeclarationKind.deposit ? l10n.declareDepositTitle : l10n.declareTitle),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
            children: [
              if (form.kind == DeclarationKind.rent) ...[
                _Label(l10n.declareWhich),
                if (form.options.isEmpty)
                  Text(l10n.declareNoOpen, style: context.mboaText.body.copyWith(color: colors.textSecondary))
                else ...[
                  Wrap(
                    spacing: Dimens.spacingSm,
                    runSpacing: Dimens.spacingSm,
                    children: [
                      for (final due in form.options)
                        FilterChip(
                          selected: form.isSelected(due),
                          showCheckmark: false,
                          // Chosen reads as the brand's, never as an error.
                          selectedColor: colors.primaryPale,
                          backgroundColor: colors.surface,
                          side: BorderSide(color: form.isSelected(due) ? colors.primary : colors.border),
                          labelStyle: context.mboaText.label.copyWith(
                            color: form.isSelected(due) ? colors.primary : colors.ink,
                          ),
                          onSelected: busy ? null : (_) => _toggle(form, due),
                          label: Text(
                            due.dueDate == null ? '#${due.index + 1}' : DateFormat.yMMM(locale).format(due.dueDate!),
                          ),
                          avatar: due.late ? Icon(LucideIcons.triangleAlert, size: 14, color: colors.error) : null,
                        ),
                    ],
                  ),
                  const SizedBox(height: Dimens.spacingXs),
                  Text(l10n.declareWhichHint, style: context.mboaText.caption.copyWith(color: colors.textTertiary)),
                ],
                const SizedBox(height: Dimens.spacingLg),
              ],
              _Label(l10n.declareAmount),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amount,
                      enabled: !busy,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: context.mboaText.h2.copyWith(color: colors.ink),
                      onChanged: (value) {
                        final parsed = int.tryParse(value);
                        _change(parsed == null ? form.copyWith(clearAmount: true) : form.copyWith(amount: parsed));
                      },
                    ),
                  ),
                  const SizedBox(width: Dimens.spacingMd),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
                    child: Text(l10n.annonceFormCurrency, style: context.mboaText.h3.copyWith(color: colors.primary)),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.spacingLg),
              _Label(l10n.declarePaidOn),
              InkWell(
                onTap: busy ? null : () => _pickDate(form),
                borderRadius: BorderRadius.circular(Dimens.radius),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
                  child: Row(
                    children: [
                      Icon(LucideIcons.calendar, size: Dimens.icon, color: colors.primary),
                      const SizedBox(width: Dimens.spacingSm),
                      Text(
                        form.paidOn == null ? l10n.reservationPickDate : DateFormat.yMMMMd(locale).format(form.paidOn!),
                        style: context.mboaText.label.copyWith(color: colors.ink),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Dimens.spacingLg),
              _Label(l10n.declareMethod),
              MboaSegmentedControl<bool>(
                value: _mobileTab,
                onChanged: (mobile) => setState(() => _mobileTab = mobile),
                segments: [
                  MboaSegment(value: true, label: l10n.declareTabMobile),
                  MboaSegment(value: false, label: l10n.declareTabOther),
                ],
              ),
              const SizedBox(height: Dimens.spacingSm),
              for (final method in methods)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  enabled: !busy,
                  leading: MethodTile(method: method, size: 40),
                  title: Text(methodLabel(l10n, method), style: context.mboaText.label.copyWith(color: colors.ink)),
                  trailing: Icon(
                    form.method == method ? LucideIcons.circleCheck : LucideIcons.circle,
                    color: form.method == method ? colors.primary : colors.border,
                  ),
                  onTap: () => _change(form.copyWith(method: method)),
                ),
              const SizedBox(height: Dimens.spacing),
              TextField(
                controller: _reference,
                enabled: !busy,
                decoration: InputDecoration(labelText: l10n.declareReference, hintText: l10n.declareReferenceHint),
                onChanged: (value) => _change(form.copyWith(reference: value)),
              ),
              const SizedBox(height: Dimens.spacing),
              TextField(
                controller: _note,
                enabled: !busy,
                minLines: 1,
                maxLines: 3,
                maxLength: 500,
                decoration: InputDecoration(labelText: l10n.declareNote),
                onChanged: (value) => _change(form.copyWith(note: value)),
              ),
              const SizedBox(height: Dimens.spacing),
              _Label(l10n.declareProofs),
              Text(l10n.declareProofsHint, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
              const SizedBox(height: Dimens.spacingSm),
              Wrap(
                spacing: Dimens.spacingSm,
                runSpacing: Dimens.spacingSm,
                children: [
                  for (final (index, key) in form.proofKeys.indexed)
                    InputChip(
                      avatar: Icon(LucideIcons.fileCheck, size: 16, color: colors.primary),
                      label: Text(l10n.declareProofN('${index + 1}')),
                      deleteIcon: const Icon(LucideIcons.x, size: 16),
                      onDeleted: busy
                          ? null
                          : () => _change(form.copyWith(proofKeys: [...form.proofKeys]..remove(key))),
                    ),
                  if (form.hasProofRoom)
                    ActionChip(
                      avatar: state.isUploading
                          ? const Loader(size: Dimens.loaderSizeXs)
                          : Icon(LucideIcons.camera, size: 16, color: colors.primary),
                      label: Text(l10n.declareAddProof),
                      onPressed: busy || state.isUploading ? null : _addProof,
                    ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            minimum: const EdgeInsets.all(Dimens.spacing),
            child: Button.primary(
              title: l10n.declareSend,
              isLoading: busy,
              onPressed: form.isComplete && !busy && !state.isUploading ? () => _submit(form) : null,
            ),
          ),
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
        child: Text(text, style: context.mboaText.label.copyWith(color: context.mboaColors.textSecondary)),
      );
}
