import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/finance_properties.dart';
import '../data/providers_repository.dart';
import '../models/finance_refusal.dart';
import '../models/ledger.dart';
import '../models/service_provider.dart';

enum ProviderPaymentDone { saved, deleted }

/// A payment the landlord made to an intervenant, declared (RM-M26-02) —
/// never made through Mboa — on a property or none; it writes its line in
/// the register (RM-M26-04). Corrected or removed with it.
class ProviderPaymentFormBloc extends Bloc<ProviderPaymentFormEvent, ProviderPaymentFormState> {
  ProviderPaymentFormBloc({required ProvidersRepository repository, required FinanceProperties properties})
      : _repository = repository,
        _properties = properties,
        super(const ProviderPaymentFormState(providerId: '')) {
    on<ProviderPaymentFormStarted>(_onStarted);
    on<ProviderPaymentFormChanged>((event, emit) {
      if (state.isSubmitting) return;
      emit(state.copyWith(amount: event.amount, paidOn: event.paidOn, note: event.note, property: event.property));
    });
    on<ProviderPaymentFormSubmitted>(_onSubmitted);
    on<ProviderPaymentDeleted>(_onDeleted);
  }

  final ProvidersRepository _repository;
  final FinanceProperties _properties;

  Future<void> _onStarted(ProviderPaymentFormStarted event, Emitter<ProviderPaymentFormState> emit) async {
    final editing = event.editing;
    emit(ProviderPaymentFormState(
      providerId: event.providerId,
      editing: editing,
      amount: editing?.amount,
      paidOn: editing?.paidOn ?? event.today,
      note: editing?.note,
      property: editing?.property ?? const UnassignedProperty(),
    ));
    final choices = await _properties.choices();
    emit(state.copyWith(properties: choices));
  }

  Future<void> _onSubmitted(ProviderPaymentFormSubmitted event, Emitter<ProviderPaymentFormState> emit) async {
    if (!state.canSubmit) return;
    emit(state.copyWith(isSubmitting: true));
    final draft = ProviderPaymentDraft(amount: state.amount!, paidOn: state.paidOn!, note: state.note, property: state.property);
    try {
      final editing = state.editing;
      if (editing == null) {
        await _repository.addPayment(state.providerId, draft);
      } else {
        await _repository.updatePayment(state.providerId, editing.id, draft);
      }
      emit(state.copyWith(done: ProviderPaymentDone.saved));
    } on FinanceRefused catch (refused) {
      emit(state.copyWith(refusal: refused.reason));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }

  Future<void> _onDeleted(ProviderPaymentDeleted event, Emitter<ProviderPaymentFormState> emit) async {
    final editing = state.editing;
    if (editing == null || state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true));
    try {
      await _repository.deletePayment(state.providerId, editing.id);
      emit(state.copyWith(done: ProviderPaymentDone.deleted));
    } on FinanceRefused catch (refused) {
      emit(state.copyWith(refusal: refused.reason));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }
}

sealed class ProviderPaymentFormEvent extends Equatable {
  const ProviderPaymentFormEvent();

  @override
  List<Object?> get props => [];
}

final class ProviderPaymentFormStarted extends ProviderPaymentFormEvent {
  const ProviderPaymentFormStarted({required this.providerId, this.editing, this.today});

  final String providerId;
  final ProviderPayment? editing;

  /// The day proposed for a new one.
  final DateTime? today;

  @override
  List<Object?> get props => [providerId, editing, today];
}

final class ProviderPaymentFormChanged extends ProviderPaymentFormEvent {
  const ProviderPaymentFormChanged({this.amount, this.paidOn, this.note, this.property});

  final int? amount;
  final DateTime? paidOn;
  final String? note;
  final LedgerProperty? property;

  @override
  List<Object?> get props => [amount, paidOn, note, property];
}

final class ProviderPaymentFormSubmitted extends ProviderPaymentFormEvent {
  const ProviderPaymentFormSubmitted();
}

final class ProviderPaymentDeleted extends ProviderPaymentFormEvent {
  const ProviderPaymentDeleted();
}

class ProviderPaymentFormState extends Equatable {
  const ProviderPaymentFormState({
    required this.providerId,
    this.editing,
    this.amount,
    this.paidOn,
    this.note,
    this.property = const UnassignedProperty(),
    this.properties = const [],
    this.isSubmitting = false,
    this.done,
    this.refusal,
    this.failed = false,
  });

  final String providerId;
  final ProviderPayment? editing;
  final int? amount;
  final DateTime? paidOn;
  final String? note;
  final LedgerProperty property;
  final List<LedgerProperty> properties;
  final bool isSubmitting;
  final ProviderPaymentDone? done;
  final FinanceRefusal? refusal;
  final bool failed;

  bool get isEditing => editing != null;
  bool get canSubmit => (amount ?? 0) > 0 && paidOn != null && !isSubmitting;

  /// Outcomes are not carried over.
  ProviderPaymentFormState copyWith({
    int? amount,
    DateTime? paidOn,
    String? note,
    LedgerProperty? property,
    List<LedgerProperty>? properties,
    bool isSubmitting = false,
    ProviderPaymentDone? done,
    FinanceRefusal? refusal,
    bool failed = false,
  }) =>
      ProviderPaymentFormState(
        providerId: providerId,
        editing: editing,
        amount: amount ?? this.amount,
        paidOn: paidOn ?? this.paidOn,
        note: note ?? this.note,
        property: property ?? this.property,
        properties: properties ?? this.properties,
        isSubmitting: isSubmitting,
        done: done,
        refusal: refusal,
        failed: failed,
      );

  @override
  List<Object?> get props =>
      [providerId, editing, amount, paidOn, note, property, properties, isSubmitting, done, refusal, failed];
}
