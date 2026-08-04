import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../media/media_uploader.dart';
import '../data/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

/// The shared Settings/profile bloc, generic over the profile type [D] and the
/// edit type [E]. Each app registers it with its own [ProfileRepository] — a
/// save is immediately reflected wherever the (singleton) bloc is read.
///
/// Pass a [MediaUploader] to enable profile-photo capture/upload; without one,
/// [ProfilePhotoChangeRequested] is a no-op.
class ProfileBloc<D, E> extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileRepository<D, E> repository, MediaUploader? uploader})
      : _repository = repository,
        _uploader = uploader,
        super(const ProfileInitial()) {
    on<ProfileLoadRequested>(_onLoadRequested);
    on<ProfileSaveRequested<E>>(_onSaveRequested);
    on<ProfilePhotoChangeRequested>(_onPhotoChangeRequested);
  }

  final ProfileRepository<D, E> _repository;
  final MediaUploader? _uploader;

  Future<void> _onLoadRequested(ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    if (state is! ProfileReady<D>) emit(const ProfileLoadInProgress());
    try {
      emit(ProfileReady<D>(await _repository.load()));
    } catch (_) {
      if (state is! ProfileReady<D>) emit(const ProfileLoadFailure());
    }
  }

  Future<void> _onSaveRequested(ProfileSaveRequested<E> event, Emitter<ProfileState> emit) async {
    final current = state;
    final data = current is ProfileReady<D> ? current.data : null;
    if (data != null) emit(ProfileReady<D>(data, saving: true));
    try {
      final updated = await _repository.save(event.edit);
      emit(ProfileReady<D>(updated, justSaved: true));
    } catch (_) {
      if (data != null) emit(ProfileReady<D>(data, saveFailed: true));
    }
  }

  Future<void> _onPhotoChangeRequested(
    ProfilePhotoChangeRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final uploader = _uploader;
    final current = state;
    if (uploader == null || current is! ProfileReady<D>) return;

    emit(ProfileReady<D>(current.data, saving: true));
    try {
      final key = await uploader.captureAndUpload(
        source: event.source,
        category: CreateUploadRequestCategoryEnum.PROFILE_PHOTO,
      );
      if (key == null) {
        emit(ProfileReady<D>(current.data)); // user cancelled
        return;
      }
      emit(ProfileReady<D>(await _repository.updatePhoto(key), photoJustUpdated: true));
    } catch (_) {
      emit(ProfileReady<D>(current.data, photoFailed: true));
    }
  }
}
