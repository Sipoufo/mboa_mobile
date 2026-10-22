import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Asking the landlord (CDC M30, RM-M30-09): a remark, a repair, a question
/// — a title, what is going on, up to five photos. The photos are
/// compressed and uploaded as they are added (`MESSAGE_ATTACHMENT`), so
/// sending is one request.
class HomeRequestFormBloc extends Bloc<HomeRequestFormEvent, HomeRequestFormState> {
  HomeRequestFormBloc({required HomeRequestsRepository repository, required MediaUploader uploader})
      : _repository = repository,
        _uploader = uploader,
        super(const HomeRequestFormState()) {
    on<HomeRequestFormStarted>((event, emit) => emit(HomeRequestFormState(contractId: event.contractId)));
    on<HomeRequestFormChanged>((event, emit) {
      if (state.isSending) return;
      emit(state.copyWith(type: event.type, title: event.title, description: event.description));
    });
    on<HomeRequestPhotoAdded>(_onPhoto);
    on<HomeRequestPhotoRemoved>(
      (event, emit) => emit(state.copyWith(photoKeys: [...state.photoKeys]..remove(event.key))),
    );
    on<HomeRequestFormSubmitted>(_onSubmitted);
  }

  final HomeRequestsRepository _repository;
  final MediaUploader _uploader;

  Future<void> _onPhoto(HomeRequestPhotoAdded event, Emitter<HomeRequestFormState> emit) async {
    if (!state.hasPhotoRoom || state.isUploading || state.isSending) return;
    emit(state.copyWith(isUploading: true));
    try {
      final key = await _uploader.captureAndUpload(
        source: event.source,
        category: CreateUploadRequestCategoryEnum.MESSAGE_ATTACHMENT,
      );
      emit(state.copyWith(photoKeys: key == null ? null : [...state.photoKeys, key]));
    } catch (_) {
      // CE-M30-01 — said, and the form kept.
      emit(state.copyWith(uploadFailed: true));
    }
  }

  Future<void> _onSubmitted(HomeRequestFormSubmitted event, Emitter<HomeRequestFormState> emit) async {
    final contractId = state.contractId;
    if (contractId == null || !state.isComplete || state.isSending || state.isUploading) return;
    emit(state.copyWith(isSending: true));
    try {
      final sent = await _repository.create(
        contractId,
        HomeRequestDraft(
          type: state.type,
          title: state.title,
          description: state.description,
          photoKeys: state.photoKeys,
        ),
      );
      emit(state.copyWith(sent: sent));
    } on HomeRequestRefused catch (refused) {
      emit(state.copyWith(refusal: refused.reason));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }
}

sealed class HomeRequestFormEvent extends Equatable {
  const HomeRequestFormEvent();

  @override
  List<Object?> get props => [];
}

final class HomeRequestFormStarted extends HomeRequestFormEvent {
  const HomeRequestFormStarted(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

/// What changed — the others stay as they are.
final class HomeRequestFormChanged extends HomeRequestFormEvent {
  const HomeRequestFormChanged({this.type, this.title, this.description});

  final HomeRequestType? type;
  final String? title;
  final String? description;

  @override
  List<Object?> get props => [type, title, description];
}

final class HomeRequestPhotoAdded extends HomeRequestFormEvent {
  const HomeRequestPhotoAdded(this.source);

  final ImageSource source;

  @override
  List<Object?> get props => [source];
}

final class HomeRequestPhotoRemoved extends HomeRequestFormEvent {
  const HomeRequestPhotoRemoved(this.key);

  final String key;

  @override
  List<Object?> get props => [key];
}

final class HomeRequestFormSubmitted extends HomeRequestFormEvent {
  const HomeRequestFormSubmitted();
}

class HomeRequestFormState extends Equatable {
  const HomeRequestFormState({
    this.contractId,
    this.type = HomeRequestType.maintenance,
    this.title = '',
    this.description = '',
    this.photoKeys = const [],
    this.isUploading = false,
    this.isSending = false,
    this.sent,
    this.refusal,
    this.failed = false,
    this.uploadFailed = false,
  });

  /// The server's limits.
  static const int maxTitle = 120;
  static const int maxDescription = 2000;
  static const int maxPhotos = 5;

  final String? contractId;
  final HomeRequestType type;
  final String title;
  final String description;
  final List<String> photoKeys;
  final bool isUploading;
  final bool isSending;

  /// The request as the server holds it — the screen closes on it.
  final HomeRequest? sent;
  final HomeRequestRefusal? refusal;
  final bool failed;
  final bool uploadFailed;

  bool get hasPhotoRoom => photoKeys.length < maxPhotos;

  /// A title and what is going on, within the server's limits.
  bool get isComplete {
    final t = title.trim();
    final d = description.trim();
    return t.isNotEmpty && t.length <= maxTitle && d.isNotEmpty && d.length <= maxDescription;
  }

  /// Outcomes are not carried over.
  HomeRequestFormState copyWith({
    HomeRequestType? type,
    String? title,
    String? description,
    List<String>? photoKeys,
    bool isUploading = false,
    bool isSending = false,
    HomeRequest? sent,
    HomeRequestRefusal? refusal,
    bool failed = false,
    bool uploadFailed = false,
  }) =>
      HomeRequestFormState(
        contractId: contractId,
        type: type ?? this.type,
        title: title ?? this.title,
        description: description ?? this.description,
        photoKeys: photoKeys ?? this.photoKeys,
        isUploading: isUploading,
        isSending: isSending,
        sent: sent,
        refusal: refusal,
        failed: failed,
        uploadFailed: uploadFailed,
      );

  @override
  List<Object?> get props =>
      [contractId, type, title, description, photoKeys, isUploading, isSending, sent, refusal, failed, uploadFailed];
}
