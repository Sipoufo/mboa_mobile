import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Adding or changing a useful contact (CDC M30 lot 3, RM-M30-13): a name,
/// a role, a Cameroonian number, and whether — and where — the tenants
/// see it.
class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  ContactFormBloc({required ContactsRepository repository})
      : _repository = repository,
        super(const ContactFormState()) {
    on<ContactFormStarted>((event, emit) {
      final c = event.contact;
      emit(
        c == null
            ? const ContactFormState()
            : ContactFormState(
                editing: c.id,
                name: c.name,
                role: c.role,
                // The field holds the national digits; the dial code is fixed.
                nationalNumber: c.phone.startsWith(dialCode) ? c.phone.substring(dialCode.length) : c.phone,
                shared: c.shared,
                annonceIds: c.annonceIds,
              ),
      );
    });
    on<ContactFormChanged>((event, emit) {
      if (state.isSaving) return;
      emit(
        state.copyWith(
          name: event.name,
          role: event.role,
          nationalNumber: event.nationalNumber,
          shared: event.shared,
          annonceIds: event.annonceIds,
        ),
      );
    });
    on<ContactFormSaved>(_onSaved);
  }

  final ContactsRepository _repository;

  /// Cameroon — the MVP's only market.
  static const String dialCode = '+237';

  Future<void> _onSaved(ContactFormSaved event, Emitter<ContactFormState> emit) async {
    if (!state.isComplete || state.isSaving) return;
    emit(state.copyWith(isSaving: true));
    final draft = ContactDraft(
      name: state.name,
      role: state.role,
      phone: '$dialCode${state.nationalNumber.replaceAll(' ', '')}',
      shared: state.shared,
      annonceIds: state.annonceIds,
    );
    try {
      final saved = state.editing == null
          ? await _repository.create(draft)
          : await _repository.update(state.editing!, draft);
      emit(state.copyWith(saved: saved));
    } on ContactRefused catch (refused) {
      emit(state.copyWith(refusal: refused.reason));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }
}

sealed class ContactFormEvent extends Equatable {
  const ContactFormEvent();

  @override
  List<Object?> get props => [];
}

/// [contact] to change one; null to add one.
final class ContactFormStarted extends ContactFormEvent {
  const ContactFormStarted([this.contact]);

  final UsefulContact? contact;

  @override
  List<Object?> get props => [contact];
}

/// What changed — the rest stays.
final class ContactFormChanged extends ContactFormEvent {
  const ContactFormChanged({this.name, this.role, this.nationalNumber, this.shared, this.annonceIds});

  final String? name;
  final String? role;
  final String? nationalNumber;
  final bool? shared;
  final Set<String>? annonceIds;

  @override
  List<Object?> get props => [name, role, nationalNumber, shared, annonceIds];
}

final class ContactFormSaved extends ContactFormEvent {
  const ContactFormSaved();
}

class ContactFormState extends Equatable {
  const ContactFormState({
    this.editing,
    this.name = '',
    this.role = '',
    this.nationalNumber = '',
    this.shared = true,
    this.annonceIds = const {},
    this.isSaving = false,
    this.saved,
    this.refusal,
    this.failed = false,
  });

  /// The contact being changed — null when adding.
  final String? editing;
  final String name;
  final String role;

  /// The nine national digits.
  final String nationalNumber;
  final bool shared;

  /// Empty: on all his properties.
  final Set<String> annonceIds;
  final bool isSaving;

  /// The contact as the server holds it — the screen closes on it.
  final UsefulContact? saved;
  final ContactRefusal? refusal;
  final bool failed;

  /// A name, a role (60 at most), and nine digits.
  bool get isComplete =>
      name.trim().isNotEmpty &&
      role.trim().isNotEmpty &&
      role.trim().length <= 60 &&
      RegExp(r'^\d{9}$').hasMatch(nationalNumber.replaceAll(' ', ''));

  /// Outcomes are not carried over.
  ContactFormState copyWith({
    String? name,
    String? role,
    String? nationalNumber,
    bool? shared,
    Set<String>? annonceIds,
    bool isSaving = false,
    UsefulContact? saved,
    ContactRefusal? refusal,
    bool failed = false,
  }) =>
      ContactFormState(
        editing: editing,
        name: name ?? this.name,
        role: role ?? this.role,
        nationalNumber: nationalNumber ?? this.nationalNumber,
        shared: shared ?? this.shared,
        annonceIds: annonceIds ?? this.annonceIds,
        isSaving: isSaving,
        saved: saved,
        refusal: refusal,
        failed: failed,
      );

  @override
  List<Object?> get props =>
      [editing, name, role, nationalNumber, shared, annonceIds, isSaving, saved, refusal, failed];
}
