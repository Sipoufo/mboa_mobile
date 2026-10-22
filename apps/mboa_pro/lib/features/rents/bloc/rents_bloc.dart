import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// "Loyers" (CDC M30, the landlord's side): the payments his tenants declared
/// that wait for his answer, and his tenants' spaces — all of them, one
/// listing's ([annonceId]) or one residence's units' ([residenceId]).
///
/// Everywhere, his spaces read residence → unit → space (§32): the whole
/// list groups a residence's units under it; a residence's own list is its
/// units. Offline, the last lists read, marked. No add-on (RM-M30-15).
class RentsBloc extends Bloc<RentsEvent, RentsState> {
  RentsBloc({required HomesRepository repository, this.annonceId, this.residenceId})
      : _repository = repository,
        super(const RentsLoading()) {
    on<RentsRequested>(_onRequested);
  }

  final HomesRepository _repository;

  /// One listing's: the spaces narrowed by the server, the inbox here (it
  /// has no such filter).
  final String? annonceId;

  /// One residence's units: both narrowed by the server (§32).
  final String? residenceId;

  Future<void> _onRequested(RentsRequested event, Emitter<RentsState> emit) async {
    // A refresh keeps the lists on screen rather than blanking them.
    if (state is! RentsReady) emit(const RentsLoading());
    try {
      final (waiting, homes) = await (
        _repository.waitingDeclarations(residenceId: residenceId),
        _repository.tenantHomes(annonceId: annonceId, residenceId: residenceId),
      ).wait;
      emit(
        RentsReady(
          waiting: [
            for (final d in waiting.value)
              if (annonceId == null || d.annonceId == annonceId) d,
          ],
          homes: homes.value,
          isOffline: waiting.fromCache || homes.fromCache,
          // The whole list only: a listing's or a residence's is already one.
          byResidence: annonceId == null && residenceId == null,
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
  const RentsReady({this.waiting = const [], this.homes = const [], this.isOffline = false, this.byResidence = false});

  /// In the server's order (oldest first); the screen groups them by day,
  /// newest day first, as it does the requests.
  final List<Declaration> waiting;
  final List<Home> homes;
  final bool isOffline;

  /// The spaces read residence first (§32): set on the whole list.
  final bool byResidence;

  /// The "Locataires" tab: standalone spaces as they are, a residence's
  /// units under one entry, in the order the server listed them.
  List<TenantsEntry> get tenants {
    if (!byResidence) return [for (final h in homes) SingleHome(h)];
    final entries = <TenantsEntry>[];
    final residences = <String, int>{};
    for (final h in homes) {
      final id = h.residenceId;
      if (id == null) {
        entries.add(SingleHome(h));
      } else if (residences[id] case final at?) {
        final group = entries[at] as ResidenceHomes;
        entries[at] = ResidenceHomes(id, group.name, [...group.homes, h]);
      } else {
        residences[id] = entries.length;
        entries.add(ResidenceHomes(id, h.residenceName, [h]));
      }
    }
    return entries;
  }

  @override
  List<Object?> get props => [waiting, homes, isOffline, byResidence];
}

/// One entry of the "Locataires" tab.
sealed class TenantsEntry extends Equatable {
  const TenantsEntry();
}

final class SingleHome extends TenantsEntry {
  const SingleHome(this.home);

  final Home home;

  @override
  List<Object?> get props => [home];
}

/// A residence and its rented units — opened as its own "Loyers".
final class ResidenceHomes extends TenantsEntry {
  const ResidenceHomes(this.residenceId, this.name, this.homes);

  final String residenceId;
  final String? name;
  final List<Home> homes;

  /// Units whose rent is late — the server's verdict on each.
  int get lateCount => homes.where((h) => h.isOverdue).length;

  @override
  List<Object?> get props => [residenceId, name, homes];
}
