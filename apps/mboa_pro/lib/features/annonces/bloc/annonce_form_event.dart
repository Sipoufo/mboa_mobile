part of 'annonce_form_bloc.dart';

sealed class AnnonceFormEvent extends Equatable {
  const AnnonceFormEvent();

  @override
  List<Object?> get props => [];
}

/// Opens the form, either blank for [kind] or seeded with [draft] when editing.
final class AnnonceFormStarted extends AnnonceFormEvent {
  const AnnonceFormStarted({required this.kind, this.draft});

  final AnnonceKind kind;
  final AnnonceDraft? draft;

  @override
  List<Object?> get props => [kind, draft];
}

final class AnnonceFormPhotoAdded extends AnnonceFormEvent {
  const AnnonceFormPhotoAdded(this.source);

  final ImageSource source;

  @override
  List<Object?> get props => [source];
}

final class AnnonceFormPhotoRemoved extends AnnonceFormEvent {
  const AnnonceFormPhotoRemoved(this.key);

  final String key;

  @override
  List<Object?> get props => [key];
}

/// A single field edit, expressed as a transform.
///
/// One event for every field keeps the surface small; the alternative is a
/// dozen near-identical events that all do `copyWith`.
final class AnnonceFormChanged extends AnnonceFormEvent {
  const AnnonceFormChanged(this.apply);

  final AnnonceDraft Function(AnnonceDraft draft) apply;

  @override
  List<Object?> get props => [apply];
}

final class AnnonceFormUnitGroupAdded extends AnnonceFormEvent {
  const AnnonceFormUnitGroupAdded();
}

final class AnnonceFormUnitGroupUpdated extends AnnonceFormEvent {
  const AnnonceFormUnitGroupUpdated(this.index, this.group);

  final int index;
  final UnitGroupDraft group;

  @override
  List<Object?> get props => [index, group];
}

final class AnnonceFormUnitGroupRemoved extends AnnonceFormEvent {
  const AnnonceFormUnitGroupRemoved(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

/// Saves as a draft. Publishing is a separate action on the list/detail.
final class AnnonceFormSubmitted extends AnnonceFormEvent {
  const AnnonceFormSubmitted();
}
