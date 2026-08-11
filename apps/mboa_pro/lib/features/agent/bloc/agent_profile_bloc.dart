import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/agent_repository.dart';
import '../models/agent_profile.dart';

part 'agent_profile_event.dart';
part 'agent_profile_state.dart';

/// The agent's own profile, zones and availability toggle (CDC M15).
///
/// Session-scoped, like `ProProfileBloc`: the agent shell header, the profile
/// screen and the zones screen all read it, and a bloc provided by one route is
/// invisible to its siblings.
class AgentProfileBloc extends Bloc<AgentProfileEvent, AgentProfileState> {
  AgentProfileBloc({
    required AgentRepository repository,
    required MediaUploader uploader,
  })  : _repository = repository,
        _uploader = uploader,
        super(const AgentProfileInitial()) {
    on<AgentProfileLoadRequested>(_onLoad);
    on<AgentProfileSaved>(_onSave);
    on<AgentAcceptingAssignmentsToggled>(_onToggle);
    on<AgentZonesSaved>(_onZonesSaved);
    on<AgentPhotoChangeRequested>(_onPhoto);
  }

  final AgentRepository _repository;
  final MediaUploader _uploader;

  Future<void> _onLoad(
    AgentProfileLoadRequested event,
    Emitter<AgentProfileState> emit,
  ) async {
    emit(const AgentProfileLoadInProgress());
    try {
      emit(AgentProfileReady(await _repository.load()));
    } catch (_) {
      emit(const AgentProfileFailure());
    }
  }

  Future<void> _onSave(
    AgentProfileSaved event,
    Emitter<AgentProfileState> emit,
  ) async {
    final current = state;
    if (current is! AgentProfileReady) return;

    emit(current.copyWith(isSaving: true));
    try {
      final updated = await _repository.save(
        firstName: event.firstName,
        lastName: event.lastName,
      );
      emit(AgentProfileReady(updated, justSaved: true));
    } catch (_) {
      emit(current.copyWith(isSaving: false, lastActionFailed: true));
    }
  }

  /// RM-M15-05 — the switch is optimistic: it flips immediately and reverts if
  /// the call fails, because a toggle that lags a round trip reads as broken.
  Future<void> _onToggle(
    AgentAcceptingAssignmentsToggled event,
    Emitter<AgentProfileState> emit,
  ) async {
    final current = state;
    if (current is! AgentProfileReady) return;

    emit(
      AgentProfileReady(
        current.profile.copyWith(acceptingAssignments: event.accepting),
      ),
    );
    try {
      final updated =
          await _repository.save(acceptingAssignments: event.accepting);
      emit(AgentProfileReady(updated));
    } catch (_) {
      emit(current.copyWith(lastActionFailed: true));
    }
  }

  Future<void> _onZonesSaved(
    AgentZonesSaved event,
    Emitter<AgentProfileState> emit,
  ) async {
    final current = state;
    if (current is! AgentProfileReady) return;

    emit(current.copyWith(isSaving: true));
    try {
      final updated = await _repository.saveZones(
        cityIds: event.cityIds,
        districtIds: event.districtIds,
      );
      emit(AgentProfileReady(updated, justSaved: true));
    } catch (_) {
      emit(current.copyWith(isSaving: false, lastActionFailed: true));
    }
  }

  /// The key goes to `/agents/me`, never `/users/me`: `profileComplete` and the
  /// prestataire's candidate card read the agent record's photo, so writing the
  /// base profile would leave the agent looking complete and unassignable.
  Future<void> _onPhoto(
    AgentPhotoChangeRequested event,
    Emitter<AgentProfileState> emit,
  ) async {
    final current = state;
    if (current is! AgentProfileReady) return;

    emit(current.copyWith(isUploadingPhoto: true));
    try {
      final key = await _uploader.captureAndUpload(
        source: event.source,
        category: CreateUploadRequestCategoryEnum.PROFILE_PHOTO,
      );
      if (key == null) {
        // Picker dismissed — not a failure, just nothing to do.
        emit(current.copyWith(isUploadingPhoto: false));
        return;
      }
      emit(AgentProfileReady(await _repository.save(photoObjectKey: key)));
    } catch (_) {
      emit(current.copyWith(isUploadingPhoto: false, lastActionFailed: true));
    }
  }
}
