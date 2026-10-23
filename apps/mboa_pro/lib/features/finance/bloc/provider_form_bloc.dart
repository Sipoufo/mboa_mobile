import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/providers_repository.dart';
import '../models/finance_refusal.dart';
import '../models/service_provider.dart';

/// Adding an intervenant, or correcting one (CDC M26): a contact from the
/// threads — name kept up to date, phone never shown —, or a name typed;
/// what he does; a word. A link is chosen once, at creation.
class ProviderFormBloc extends Bloc<ProviderFormEvent, ProviderFormState> {
  ProviderFormBloc({required ProvidersRepository repository})
      : _repository = repository,
        super(const ProviderFormState()) {
    on<ProviderFormStarted>(_onStarted);
    on<ProviderFormChanged>((event, emit) {
      if (state.isSubmitting) return;
      emit(state.copyWith(
        name: event.name,
        kind: event.kind,
        kindLabel: event.kindLabel,
        note: event.note,
        contact: event.contact,
        clearContact: event.clearContact,
      ));
    });
    on<ProviderFormSubmitted>(_onSubmitted);
  }

  final ProvidersRepository _repository;

  Future<void> _onStarted(ProviderFormStarted event, Emitter<ProviderFormState> emit) async {
    final editing = event.editing;
    if (editing != null) {
      emit(ProviderFormState(
        editing: editing,
        name: editing.name,
        kind: editing.kind,
        kindLabel: editing.kindLabel,
        note: editing.note,
      ));
      return;
    }
    try {
      emit(state.copyWith(contacts: await _repository.contacts()));
    } catch (_) {
      // No threads to read: a typed name still works.
    }
  }

  Future<void> _onSubmitted(ProviderFormSubmitted event, Emitter<ProviderFormState> emit) async {
    if (!state.canSubmit) return;
    emit(state.copyWith(isSubmitting: true));
    final draft = ProviderDraft(
      kind: state.kind,
      name: state.name,
      kindLabel: state.kindLabel,
      note: state.note,
      linkedAccountId: state.contact?.accountId,
    );
    try {
      final editing = state.editing;
      final saved = editing == null ? await _repository.create(draft) : await _repository.update(editing.id, draft);
      emit(state.copyWith(saved: saved));
    } on FinanceRefused catch (refused) {
      emit(state.copyWith(refusal: refused.reason));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }
}

sealed class ProviderFormEvent extends Equatable {
  const ProviderFormEvent();

  @override
  List<Object?> get props => [];
}

final class ProviderFormStarted extends ProviderFormEvent {
  const ProviderFormStarted({this.editing});

  final ServiceProvider? editing;

  @override
  List<Object?> get props => [editing];
}

final class ProviderFormChanged extends ProviderFormEvent {
  const ProviderFormChanged({this.name, this.kind, this.kindLabel, this.note, this.contact, this.clearContact = false});

  final String? name;
  final ProviderKind? kind;
  final String? kindLabel;
  final String? note;
  final ProviderContact? contact;

  /// Back to a typed name.
  final bool clearContact;

  @override
  List<Object?> get props => [name, kind, kindLabel, note, contact, clearContact];
}

final class ProviderFormSubmitted extends ProviderFormEvent {
  const ProviderFormSubmitted();
}

class ProviderFormState extends Equatable {
  const ProviderFormState({
    this.editing,
    this.contacts = const [],
    this.contact,
    this.name,
    this.kind = ProviderKind.plumbing,
    this.kindLabel,
    this.note,
    this.isSubmitting = false,
    this.saved,
    this.refusal,
    this.failed = false,
  });

  final ServiceProvider? editing;

  /// The people he has a thread with.
  final List<ProviderContact> contacts;

  /// The contact chosen, when linked.
  final ProviderContact? contact;
  final String? name;
  final ProviderKind kind;
  final String? kindLabel;
  final String? note;
  final bool isSubmitting;
  final ServiceProvider? saved;
  final FinanceRefusal? refusal;
  final bool failed;

  bool get isEditing => editing != null;

  /// A linked one is named by his account; the others by the landlord.
  bool get isLinked => contact != null || (editing?.isLinked ?? false);

  bool get canSubmit =>
      (isLinked || (name?.trim().isNotEmpty ?? false)) &&
      (kind != ProviderKind.other || (kindLabel?.trim().isNotEmpty ?? false)) &&
      !isSubmitting;

  /// Outcomes are not carried over.
  ProviderFormState copyWith({
    List<ProviderContact>? contacts,
    ProviderContact? contact,
    bool clearContact = false,
    String? name,
    ProviderKind? kind,
    String? kindLabel,
    String? note,
    bool isSubmitting = false,
    ServiceProvider? saved,
    FinanceRefusal? refusal,
    bool failed = false,
  }) =>
      ProviderFormState(
        editing: editing,
        contacts: contacts ?? this.contacts,
        contact: clearContact ? null : contact ?? this.contact,
        name: name ?? this.name,
        kind: kind ?? this.kind,
        kindLabel: kindLabel ?? this.kindLabel,
        note: note ?? this.note,
        isSubmitting: isSubmitting,
        saved: saved,
        refusal: refusal,
        failed: failed,
      );

  @override
  List<Object?> get props =>
      [editing, contacts, contact, name, kind, kindLabel, note, isSubmitting, saved, refusal, failed];
}
