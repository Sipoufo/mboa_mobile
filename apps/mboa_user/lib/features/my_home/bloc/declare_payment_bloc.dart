import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/declaration_form.dart';

/// Declaring a payment made outside Mboa (CDC M30, RM-M30-03): what for, how
/// much, when, how, a reference and up to three proofs — **no money moves**
/// (RM-M30-06).
///
/// The proofs are compressed and uploaded as they are added (the shared
/// uploader, `FINANCE_ATTACHMENT`), so sending is one request.
class DeclarePaymentBloc extends Bloc<DeclarePaymentEvent, DeclarePaymentState> {
  DeclarePaymentBloc({required HomesRepository repository, required MediaUploader uploader})
      : _repository = repository,
        _uploader = uploader,
        super(const DeclarePaymentState()) {
    on<DeclarationStarted>((event, emit) => emit(DeclarePaymentState(contractId: event.contractId, form: event.form)));
    on<DeclarationFormChanged>((event, emit) {
      if (state.isSending) return;
      emit(state.copyWith(form: event.form));
    });
    on<DeclarationProofAdded>(_onProof);
    on<DeclarationSubmitted>(_onSubmitted);
  }

  final HomesRepository _repository;
  final MediaUploader _uploader;

  Future<void> _onProof(DeclarationProofAdded event, Emitter<DeclarePaymentState> emit) async {
    final form = state.form;
    if (form == null || !form.hasProofRoom || state.isUploading) return;
    emit(state.copyWith(isUploading: true));
    try {
      final key = await _uploader.captureAndUpload(
        source: event.source,
        category: CreateUploadRequestCategoryEnum.FINANCE_ATTACHMENT,
      );
      final current = state.form ?? form;
      emit(
        state.copyWith(
          form: key == null ? current : current.copyWith(proofKeys: [...current.proofKeys, key]),
        ),
      );
    } catch (_) {
      // CE-M30-01 — said, and the form kept.
      emit(state.copyWith(uploadFailed: true));
    }
  }

  Future<void> _onSubmitted(DeclarationSubmitted event, Emitter<DeclarePaymentState> emit) async {
    final form = state.form;
    final contractId = state.contractId;
    if (form == null || contractId == null || !form.isComplete || state.isSending || state.isUploading) return;
    emit(state.copyWith(isSending: true));
    try {
      // An invoice is declared on the invoice, never on the home's route.
      final declaration = switch (form.invoiceId) {
        final invoiceId? when form.kind == DeclarationKind.invoice =>
          await _repository.declareInvoice(invoiceId, form.toDraft()),
        _ => await _repository.declare(contractId, form.toDraft()),
      };
      emit(state.copyWith(sent: declaration));
    } on DeclarationRefused catch (refused) {
      emit(state.copyWith(refusal: refused.reason));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }
}

sealed class DeclarePaymentEvent extends Equatable {
  const DeclarePaymentEvent();

  @override
  List<Object?> get props => [];
}

final class DeclarationStarted extends DeclarePaymentEvent {
  const DeclarationStarted({required this.contractId, required this.form});

  final String contractId;
  final DeclarationForm form;

  @override
  List<Object?> get props => [contractId, form];
}

/// The form as the tenant has it now — its rules are the form's own.
final class DeclarationFormChanged extends DeclarePaymentEvent {
  const DeclarationFormChanged(this.form);

  final DeclarationForm form;

  @override
  List<Object?> get props => [form];
}

final class DeclarationProofAdded extends DeclarePaymentEvent {
  const DeclarationProofAdded(this.source);

  final ImageSource source;

  @override
  List<Object?> get props => [source];
}

final class DeclarationSubmitted extends DeclarePaymentEvent {
  const DeclarationSubmitted();
}

class DeclarePaymentState extends Equatable {
  const DeclarePaymentState({
    this.contractId,
    this.form,
    this.isUploading = false,
    this.isSending = false,
    this.sent,
    this.refusal,
    this.failed = false,
    this.uploadFailed = false,
  });

  final String? contractId;
  final DeclarationForm? form;
  final bool isUploading;
  final bool isSending;

  /// The declaration as the server holds it — the screen closes on it.
  final Declaration? sent;

  /// Why the server turned it down — said once.
  final DeclarationRefusal? refusal;
  final bool failed;
  final bool uploadFailed;

  /// Outcomes are not carried over.
  DeclarePaymentState copyWith({
    DeclarationForm? form,
    bool isUploading = false,
    bool isSending = false,
    Declaration? sent,
    DeclarationRefusal? refusal,
    bool failed = false,
    bool uploadFailed = false,
  }) =>
      DeclarePaymentState(
        contractId: contractId,
        form: form ?? this.form,
        isUploading: isUploading,
        isSending: isSending,
        sent: sent,
        refusal: refusal,
        failed: failed,
        uploadFailed: uploadFailed,
      );

  @override
  List<Object?> get props => [contractId, form, isUploading, isSending, sent, refusal, failed, uploadFailed];
}
