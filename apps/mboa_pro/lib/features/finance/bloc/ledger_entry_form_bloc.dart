import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/finance_properties.dart';
import '../data/ledger_repository.dart';
import '../models/finance_refusal.dart';
import '../models/ledger.dart';

enum LedgerFormDone { saved, deleted }

/// One line of the register, written by the landlord (RM-M25-01): in or
/// out, what for, how much, when, on which property — or none —, a word, a
/// photo of the receipt (compressed before it travels). Corrected or removed
/// later; never a line kept from a confirmed payment.
class LedgerEntryFormBloc extends Bloc<LedgerEntryFormEvent, LedgerEntryFormState> {
  LedgerEntryFormBloc({
    required LedgerRepository repository,
    required FinanceProperties properties,
    required MediaUploader uploader,
  })  : _repository = repository,
        _properties = properties,
        _uploader = uploader,
        super(LedgerEntryFormState(date: DateTime.now())) {
    on<LedgerEntryFormStarted>(_onStarted);
    on<LedgerEntryFormChanged>((event, emit) {
      // A photo on its way does not stop the typing; saving does.
      if (state.isSubmitting) return;
      final direction = event.direction ?? state.direction;
      emit(state.copyWith(
        isUploading: state.isUploading,
        direction: direction,
        // A category of the other side does not follow.
        category: event.category ??
            (LedgerEntryFormState.categoriesFor(direction).contains(state.category)
                ? state.category
                : LedgerEntryFormState.categoriesFor(direction).first),
        amount: event.amount,
        date: event.date,
        property: event.property,
        note: event.note,
      ));
    });
    on<LedgerEntryAttachmentAdded>(_onAttachment);
    on<LedgerEntryAttachmentRemoved>((event, emit) {
      if (!state.isBusy) emit(state.copyWith(clearAttachment: true));
    });
    on<LedgerEntryAttachmentViewed>(_onViewed);
    on<LedgerEntryFormSubmitted>(_onSubmitted);
    on<LedgerEntryDeleted>(_onDeleted);
  }

  final LedgerRepository _repository;
  final FinanceProperties _properties;
  final MediaUploader _uploader;

  Future<void> _onStarted(LedgerEntryFormStarted event, Emitter<LedgerEntryFormState> emit) async {
    final editing = event.editing;
    if (editing != null) {
      emit(LedgerEntryFormState(
        editing: editing,
        direction: editing.direction,
        category: editing.category,
        amount: editing.amount,
        date: editing.date,
        property: editing.property,
        note: editing.note,
        hadAttachment: editing.hasAttachment,
      ));
    }
    final choices = await _properties.choices();
    emit(state.copyWith(properties: choices));
  }

  Future<void> _onAttachment(LedgerEntryAttachmentAdded event, Emitter<LedgerEntryFormState> emit) async {
    if (state.isBusy) return;
    emit(state.copyWith(isUploading: true));
    try {
      final key = await _uploader.captureAndUpload(
        source: event.source,
        category: CreateUploadRequestCategoryEnum.FINANCE_ATTACHMENT,
      );
      emit(key == null ? state.copyWith() : state.copyWith(attachmentKey: key));
    } catch (_) {
      emit(state.copyWith(uploadFailed: true));
    }
  }

  /// The current attachment, through a short-lived link.
  Future<void> _onViewed(LedgerEntryAttachmentViewed event, Emitter<LedgerEntryFormState> emit) async {
    final editing = state.editing;
    if (editing == null || !state.hadAttachment || state.isBusy) return;
    try {
      emit(state.copyWith(viewUrl: await _repository.attachmentUrl(editing.id)));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }

  Future<void> _onSubmitted(LedgerEntryFormSubmitted event, Emitter<LedgerEntryFormState> emit) async {
    if (!state.canSubmit) return;
    emit(state.copyWith(isSubmitting: true));
    final draft = LedgerDraft(
      direction: state.direction,
      category: state.category,
      amount: state.amount!,
      date: state.date!,
      property: state.property,
      note: state.note,
      attachmentKey: state.attachmentKey,
    );
    try {
      final editing = state.editing;
      if (editing == null) {
        await _repository.create(draft);
      } else {
        await _repository.update(editing.id, draft);
      }
      emit(state.copyWith(done: LedgerFormDone.saved));
    } on FinanceRefused catch (refused) {
      emit(state.copyWith(refusal: refused.reason));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }

  Future<void> _onDeleted(LedgerEntryDeleted event, Emitter<LedgerEntryFormState> emit) async {
    final editing = state.editing;
    if (editing == null || state.isBusy) return;
    emit(state.copyWith(isSubmitting: true));
    try {
      await _repository.delete(editing.id);
      emit(state.copyWith(done: LedgerFormDone.deleted));
    } on FinanceRefused catch (refused) {
      emit(state.copyWith(refusal: refused.reason));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }
}

sealed class LedgerEntryFormEvent extends Equatable {
  const LedgerEntryFormEvent();

  @override
  List<Object?> get props => [];
}

/// [editing]: correcting that line; null, a new one.
final class LedgerEntryFormStarted extends LedgerEntryFormEvent {
  const LedgerEntryFormStarted({this.editing});

  final LedgerEntry? editing;

  @override
  List<Object?> get props => [editing];
}

/// What changed — the rest stays.
final class LedgerEntryFormChanged extends LedgerEntryFormEvent {
  const LedgerEntryFormChanged({this.direction, this.category, this.amount, this.date, this.property, this.note});

  final LedgerDirection? direction;
  final LedgerCategory? category;
  final int? amount;
  final DateTime? date;
  final LedgerProperty? property;
  final String? note;

  @override
  List<Object?> get props => [direction, category, amount, date, property, note];
}

final class LedgerEntryAttachmentAdded extends LedgerEntryFormEvent {
  const LedgerEntryAttachmentAdded(this.source);

  final ImageSource source;

  @override
  List<Object?> get props => [source];
}

final class LedgerEntryAttachmentRemoved extends LedgerEntryFormEvent {
  const LedgerEntryAttachmentRemoved();
}

final class LedgerEntryAttachmentViewed extends LedgerEntryFormEvent {
  const LedgerEntryAttachmentViewed();
}

final class LedgerEntryFormSubmitted extends LedgerEntryFormEvent {
  const LedgerEntryFormSubmitted();
}

final class LedgerEntryDeleted extends LedgerEntryFormEvent {
  const LedgerEntryDeleted();
}

class LedgerEntryFormState extends Equatable {
  const LedgerEntryFormState({
    this.editing,
    this.direction = LedgerDirection.expense,
    this.category = LedgerCategory.works,
    this.amount,
    this.date,
    this.property = const UnassignedProperty(),
    this.note,
    this.attachmentKey,
    this.hadAttachment = false,
    this.properties = const [],
    this.isUploading = false,
    this.isSubmitting = false,
    this.done,
    this.refusal,
    this.failed = false,
    this.uploadFailed = false,
    this.viewUrl,
  });

  final LedgerEntry? editing;
  final LedgerDirection direction;
  final LedgerCategory category;
  final int? amount;
  final DateTime? date;
  final LedgerProperty property;
  final String? note;

  /// A new photo, uploaded.
  final String? attachmentKey;

  /// Correcting a line that had one. It cannot be kept: the server replaces
  /// the attachment with what the correction carries, and never gives its
  /// key back (§34) — the form says so.
  final bool hadAttachment;
  final List<LedgerProperty> properties;
  final bool isUploading;
  final bool isSubmitting;
  final LedgerFormDone? done;
  final FinanceRefusal? refusal;
  final bool failed;
  final bool uploadFailed;

  /// Once: the current attachment's link, to look at.
  final String? viewUrl;

  bool get isEditing => editing != null;
  bool get isBusy => isUploading || isSubmitting;

  /// Saving this correction would drop the attachment the line had.
  bool get dropsAttachment => hadAttachment && attachmentKey == null;

  /// The categories of a side: a rent comes in, works go out.
  static List<LedgerCategory> categoriesFor(LedgerDirection direction) => switch (direction) {
        LedgerDirection.income => const [LedgerCategory.rent, LedgerCategory.charges, LedgerCategory.other],
        LedgerDirection.expense => const [
            LedgerCategory.works,
            LedgerCategory.charges,
            LedgerCategory.propertyTax,
            LedgerCategory.serviceProviders,
            LedgerCategory.other,
          ],
      };

  bool get canSubmit => (amount ?? 0) > 0 && date != null && !isBusy;

  /// Outcomes are not carried over.
  LedgerEntryFormState copyWith({
    LedgerDirection? direction,
    LedgerCategory? category,
    int? amount,
    DateTime? date,
    LedgerProperty? property,
    String? note,
    String? attachmentKey,
    bool clearAttachment = false,
    List<LedgerProperty>? properties,
    bool isUploading = false,
    bool isSubmitting = false,
    LedgerFormDone? done,
    FinanceRefusal? refusal,
    bool failed = false,
    bool uploadFailed = false,
    String? viewUrl,
  }) =>
      LedgerEntryFormState(
        editing: editing,
        direction: direction ?? this.direction,
        category: category ?? this.category,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        property: property ?? this.property,
        note: note ?? this.note,
        attachmentKey: clearAttachment ? null : attachmentKey ?? this.attachmentKey,
        hadAttachment: hadAttachment,
        properties: properties ?? this.properties,
        isUploading: isUploading,
        isSubmitting: isSubmitting,
        done: done,
        refusal: refusal,
        failed: failed,
        uploadFailed: uploadFailed,
        viewUrl: viewUrl,
      );

  @override
  List<Object?> get props => [
        editing,
        direction,
        category,
        amount,
        date,
        property,
        note,
        attachmentKey,
        hadAttachment,
        properties,
        isUploading,
        isSubmitting,
        done,
        refusal,
        failed,
        uploadFailed,
        viewUrl,
      ];
}
