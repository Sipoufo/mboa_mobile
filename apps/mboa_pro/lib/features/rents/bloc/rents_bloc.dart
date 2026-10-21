import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// "Loyers" (CDC M30, the landlord's side): the payments his tenants declared
/// that wait for his answer, and his tenants' spaces — all of them, or one
/// listing's (or a residence's units') when built with [annonceIds].
///
/// Offline, the last lists read, marked. No add-on needed (RM-M30-15).
class RentsBloc extends Bloc<RentsEvent, RentsState> {
  RentsBloc({required HomesRepository repository, this.annonceIds})
      : _repository = repository,
        super(const RentsLoading()) {
    on<RentsRequested>(_onRequested);
  }

  final HomesRepository _repository;

  /// Set when the screen is one listing's, or a residence's units'. The
  /// API narrows the spaces by one listing only, and the inbox not at all,
  /// so the rest is narrowed here.
  final Set<String>? annonceIds;

  Future<void> _onRequested(RentsRequested event, Emitter<RentsState> emit) async {
    // A refresh keeps the lists on screen rather than blanking them.
    if (state is! RentsReady) emit(const RentsLoading());
    final ids = annonceIds;
    try {
      final (waiting, homes) = await (
        _repository.waitingDeclarations(),
        _repository.tenantHomes(annonceId: ids?.length == 1 ? ids!.single : null),
      ).wait;
      bool kept(String? annonceId) => ids == null || ids.contains(annonceId);
      emit(
        RentsReady(
          waiting: [for (final d in waiting.value) if (kept(d.annonceId)) d],
          homes: [for (final h in homes.value) if (kept(h.annonceId)) h],
          isOffline: waiting.fromCache || homes.fromCache,
        ),
      );
    } catch (_) {
      if (state is! RentsReady) emit(const RentsFailure());
    }
  }
}

sealed class RentsEvent extends Equatable {
  const RentsEvent();

  @override
  List<Object?> get props => [];
}

final class RentsRequested extends RentsEvent {
  const RentsRequested();
}

sealed class RentsState extends Equatable {
  const RentsState();

  @override
  List<Object?> get props => [];
}

final class RentsLoading extends RentsState {
  const RentsLoading();
}

final class RentsFailure extends RentsState {
  const RentsFailure();
}

final class RentsReady extends RentsState {
  const RentsReady({this.waiting = const [], this.homes = const [], this.isOffline = false});

  /// In the server's order (oldest first); the screen groups them by day,
  /// newest day first, as it does the requests.
  final List<Declaration> waiting;
  final List<Home> homes;
  final bool isOffline;

  @override
  List<Object?> get props => [waiting, homes, isOffline];
}
