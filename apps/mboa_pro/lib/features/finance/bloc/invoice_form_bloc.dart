import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/owner_invoices_repository.dart';
import '../models/finance_refusal.dart';

/// Billing a tenant (CDC M24), or correcting a bill not paid yet. Only the
/// tenant of a running Mboa contract can be billed (RM-M24-02): the form
/// offers those tenancies and no others.
///
/// Three steps, so a landlord with hundreds of tenants finds his way: the
/// tenant (standalone listings apart from residences, searched by person or
/// property), the charge, then the amount and the date.
class InvoiceFormBloc extends Bloc<InvoiceFormEvent, InvoiceFormState> {
  InvoiceFormBloc({required OwnerInvoicesRepository invoices, required HomesRepository homes})
      : _invoices = invoices,
        _homes = homes,
        super(const InvoiceFormState()) {
    on<InvoiceFormStarted>(_onStarted);
    on<InvoiceFormChanged>((event, emit) {
      if (state.isSubmitting) return;
      emit(state.copyWith(
        kind: event.kind,
        label: event.label,
        amount: event.amount,
        dueDate: event.dueDate,
      ));
    });
    on<InvoiceFormSearchChanged>((event, emit) => emit(state.copyWith(query: event.query)));
    on<InvoiceFormGroupChanged>((event, emit) => emit(state.copyWith(group: event.group)));
    on<InvoiceFormTenantChosen>((event, emit) {
      if (state.isSubmitting || state.isEditing) return;
      emit(state.copyWith(contractId: event.contractId, step: InvoiceFormStep.charge));
    });
    on<InvoiceFormStepRequested>((event, emit) {
      final steps = state.steps;
      final from = steps.indexOf(state.step);
      final to = steps.indexOf(event.step);
      if (state.isSubmitting || to < 0 || to == from) return;
      // Back, always; forward, one step at a time and only past a step done.
      if (to > from && (to != from + 1 || !state.canContinue)) return;
      emit(state.copyWith(step: event.step));
    });
    on<InvoiceFormSubmitted>(_onSubmitted);
  }

  final OwnerInvoicesRepository _invoices;
  final HomesRepository _homes;

  Future<void> _onStarted(InvoiceFormStarted event, Emitter<InvoiceFormState> emit) async {
    final editing = event.editing;
    if (editing != null) {
      // The tenancy and the kind stay what they were: only the words, the
      // amount and the date are corrected.
      emit(InvoiceFormState(
        editing: editing,
        step: InvoiceFormStep.charge,
        contractId: editing.contractId,
        kind: editing.kind,
        label: editing.label,
        amount: editing.amount,
        dueDate: editing.dueDate,
      ));
      return;
    }
    emit(const InvoiceFormState(isLoadingTenancies: true));
    try {
      final read = await _homes.activeTenantHomes();
      final running = [for (final home in read.value) if (home.state == HomeStage.active) home];
      final one = running.length == 1;
      emit(state.copyWith(
        tenancies: running,
        // One tenancy: nothing to choose.
        contractId: one ? running.single.contractId : null,
        step: one ? InvoiceFormStep.charge : InvoiceFormStep.tenant,
        // Open on the tab that has someone in it.
        group: running.any((h) => h.residenceId == null) ? TenancyGroup.single : TenancyGroup.multiple,
      ));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }

  Future<void> _onSubmitted(InvoiceFormSubmitted event, Emitter<InvoiceFormState> emit) async {
    if (!state.canSubmit) return;
    emit(state.copyWith(isSubmitting: true));
    try {
      final editing = state.editing;
      final saved = editing == null
          ? await _invoices.create(InvoiceDraft(
              contractId: state.contractId!,
              kind: state.kind,
              label: state.label,
              amount: state.amount!,
              dueDate: state.dueDate!,
            ))
          : await _invoices.update(editing.id, label: state.label, amount: state.amount, dueDate: state.dueDate);
      emit(state.copyWith(saved: saved));
    } on FinanceRefused catch (refused) {
      emit(state.copyWith(refusal: refused.reason));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }
}

/// The form's steps, in order.
enum InvoiceFormStep { tenant, charge, amount }

/// The tenant step's two tabs: standalone listings, and residences' units.
enum TenancyGroup { single, multiple }

/// A residence's tenancies, under its name.
typedef ResidenceTenancies = ({String id, String name, List<Home> homes});

sealed class InvoiceFormEvent extends Equatable {
  const InvoiceFormEvent();

  @override
  List<Object?> get props => [];
}

/// [editing]: correcting that invoice; null, a new one.
final class InvoiceFormStarted extends InvoiceFormEvent {
  const InvoiceFormStarted({this.editing});

  final HomeInvoice? editing;

  @override
  List<Object?> get props => [editing];
}

/// What changed — the rest stays.
final class InvoiceFormChanged extends InvoiceFormEvent {
  const InvoiceFormChanged({this.kind, this.label, this.amount, this.dueDate});

  final InvoiceKind? kind;
  final String? label;
  final int? amount;
  final DateTime? dueDate;

  @override
  List<Object?> get props => [kind, label, amount, dueDate];
}

/// The tenant step's search: a person, a unit or a residence.
final class InvoiceFormSearchChanged extends InvoiceFormEvent {
  const InvoiceFormSearchChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class InvoiceFormGroupChanged extends InvoiceFormEvent {
  const InvoiceFormGroupChanged(this.group);

  final TenancyGroup group;

  @override
  List<Object?> get props => [group];
}

/// A tenancy picked — on to the charge.
final class InvoiceFormTenantChosen extends InvoiceFormEvent {
  const InvoiceFormTenantChosen(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

/// Back to a step, or on to the next once this one is done.
final class InvoiceFormStepRequested extends InvoiceFormEvent {
  const InvoiceFormStepRequested(this.step);

  final InvoiceFormStep step;

  @override
  List<Object?> get props => [step];
}

final class InvoiceFormSubmitted extends InvoiceFormEvent {
  const InvoiceFormSubmitted();
}

class InvoiceFormState extends Equatable {
  const InvoiceFormState({
    this.editing,
    this.tenancies = const [],
    this.isLoadingTenancies = false,
    this.step = InvoiceFormStep.tenant,
    this.query = '',
    this.group = TenancyGroup.single,
    this.contractId,
    this.kind = InvoiceKind.water,
    this.label,
    this.amount,
    this.dueDate,
    this.isSubmitting = false,
    this.saved,
    this.refusal,
    this.failed = false,
  });

  final HomeInvoice? editing;

  /// The running tenancies — the only ones that can be billed.
  final List<Home> tenancies;
  final bool isLoadingTenancies;
  final InvoiceFormStep step;
  final String query;
  final TenancyGroup group;
  final String? contractId;
  final InvoiceKind kind;
  final String? label;
  final int? amount;
  final DateTime? dueDate;
  final bool isSubmitting;

  /// Once: the invoice as the server recorded it — the screen closes on it.
  final HomeInvoice? saved;
  final FinanceRefusal? refusal;
  final bool failed;

  bool get isEditing => editing != null;

  /// The steps this form walks: no tenant to pick when correcting, or when
  /// there is only one.
  List<InvoiceFormStep> get steps => isEditing || tenancies.length == 1
      ? const [InvoiceFormStep.charge, InvoiceFormStep.amount]
      : InvoiceFormStep.values;

  bool get isFirstStep => steps.first == step;

  /// The step before this one; null on the first.
  InvoiceFormStep? get previousStep => isFirstStep ? null : steps[steps.indexOf(step) - 1];

  /// The step after this one; null on the last.
  InvoiceFormStep? get nextStep => steps.last == step ? null : steps[steps.indexOf(step) + 1];

  /// This step is done.
  bool get canContinue => switch (step) {
        InvoiceFormStep.tenant => contractId != null,
        InvoiceFormStep.charge => !needsLabel,
        InvoiceFormStep.amount => canSubmit,
      };

  /// The tenancy being billed.
  Home? get tenancy => [for (final h in tenancies) if (h.contractId == contractId) h].firstOrNull;

  /// The standalone listings' tenancies that match the search, by name.
  List<Home> get singles => _byName([for (final h in tenancies) if (h.residenceId == null && _matches(h)) h]);

  /// The residences' tenancies that match the search, residence by residence.
  List<ResidenceTenancies> get residences {
    final byResidence = <String, List<Home>>{};
    for (final h in tenancies) {
      if (h.residenceId case final id? when _matches(h)) (byResidence[id] ??= []).add(h);
    }
    final groups = [
      for (final MapEntry(key: id, value: homes) in byResidence.entries)
        (id: id, name: homes.first.residenceName ?? '', homes: _byName(homes)),
    ]..sort((a, b) => _fold(a.name).compareTo(_fold(b.name)));
    return groups;
  }

  int get residencesCount => residences.fold(0, (sum, r) => sum + r.homes.length);

  /// Every word of the search is somewhere in the tenant's name, the unit's
  /// or the residence's — « awa deido » finds Awa in Résidence Deido.
  bool _matches(Home home) {
    final words = _fold(query).split(' ').where((w) => w.isNotEmpty);
    if (words.isEmpty) return true;
    final haystack = _fold('${home.tenant?.displayName ?? ''} ${home.annonceTitle ?? ''} ${home.residenceName ?? ''}');
    return words.every(haystack.contains);
  }

  static List<Home> _byName(List<Home> homes) =>
      homes..sort((a, b) => _fold(a.tenant?.displayName ?? '').compareTo(_fold(b.tenant?.displayName ?? '')));

  /// Lower case, without accents: « Étoga » is found by « etoga ».
  static String _fold(String value) {
    const accents = 'àâäáãåçèéêëìíîïñòóôöõùúûüýÿœ';
    const plain = 'aaaaaaceeeeiiiinooooouuuuyyo';
    final buffer = StringBuffer();
    for (final char in value.toLowerCase().trim().split('')) {
      final index = accents.indexOf(char);
      buffer.write(index >= 0 ? plain[index] : char);
    }
    return buffer.toString();
  }

  /// An « Autre » charge says what it is.
  bool get needsLabel => kind == InvoiceKind.other && (label?.trim().isEmpty ?? true);

  bool get canSubmit =>
      contractId != null && (amount ?? 0) > 0 && dueDate != null && !needsLabel && !isSubmitting;

  /// Outcomes are not carried over.
  InvoiceFormState copyWith({
    List<Home>? tenancies,
    InvoiceFormStep? step,
    String? query,
    TenancyGroup? group,
    String? contractId,
    InvoiceKind? kind,
    String? label,
    int? amount,
    DateTime? dueDate,
    bool isSubmitting = false,
    HomeInvoice? saved,
    FinanceRefusal? refusal,
    bool failed = false,
  }) =>
      InvoiceFormState(
        editing: editing,
        tenancies: tenancies ?? this.tenancies,
        step: step ?? this.step,
        query: query ?? this.query,
        group: group ?? this.group,
        contractId: contractId ?? this.contractId,
        kind: kind ?? this.kind,
        label: label ?? this.label,
        amount: amount ?? this.amount,
        dueDate: dueDate ?? this.dueDate,
        isSubmitting: isSubmitting,
        saved: saved,
        refusal: refusal,
        failed: failed,
      );

  @override
  List<Object?> get props => [
        editing,
        tenancies,
        isLoadingTenancies,
        step,
        query,
        group,
        contractId,
        kind,
        label,
        amount,
        dueDate,
        isSubmitting,
        saved,
        refusal,
        failed,
      ];
}
