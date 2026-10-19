import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Why the server turned an answer down — read once here, told in words by
/// the screen.
enum DecisionRefusal {
  /// No longer waiting: answered, withdrawn, or past its 48 h.
  closed,

  /// The listing left the market meanwhile (CE-M29-04).
  notReservable,

  /// A reservation is extended once only (RM-M29-07).
  alreadyExtended,

  /// Extending or cancelling needs an accepted reservation.
  notAccepted,
}

class ReservationDecisionRefused implements Exception {
  const ReservationDecisionRefused(this.reason);

  final DecisionRefusal reason;
}

/// A page of incoming requests, and where it came from.
class IncomingReservations {
  const IncomingReservations(this.items, {this.fromCache = false});

  final List<Reservation> items;
  final bool fromCache;
}

/// The requests made on the prestataire's listings (CDC M29) —
/// `/prestataires/me/reservations`. Nothing here takes or sends an amount
/// (RM-M29-09).
class IncomingReservationsRepository {
  IncomingReservationsRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  RservationsPrestataireApi get _api => _dioClient.api.getRservationsPrestataireApi();

  /// Newest first — all of them, or one listing's. Offline, the last list
  /// read for the same scope.
  Future<IncomingReservations> list({String? annonceId}) async {
    final key = 'incoming:${annonceId ?? 'all'}';
    try {
      final response = await _api.listIncomingReservations(
        pageable: Pageable((b) => b..size = 100),
        annonceId: annonceId,
      );
      final items = (response.data?.content ?? BuiltList<ReservationResponse>()).map(Reservation.fromResponse).toList();
      await _cache.put(StorageKeys.reservationsBox, key, {'items': items.map((r) => r.toCache()).toList()});
      return IncomingReservations(items);
    } catch (_) {
      final raw = _cache.get(StorageKeys.reservationsBox, key)?['items'];
      if (raw is! List) rethrow;
      return IncomingReservations(
        [
          for (final item in raw.whereType<Map<dynamic, dynamic>>())
            ?Reservation.fromCache(Map<String, dynamic>.from(item)),
        ],
        fromCache: true,
      );
    }
  }

  /// How many wait for an answer — the home's counter, and "Autres demandes
  /// pour ce bien" with [annonceId].
  Future<int> pendingCount({String? annonceId}) async {
    final response = await _api.listIncomingReservations(
      pageable: Pageable((b) => b..size = 1),
      annonceId: annonceId,
      status: BuiltList(['PENDING']),
    );
    return response.data?.totalElements ?? 0;
  }

  Future<Reservation> get(String id) async => _read(await _api.getIncomingReservation(id: id));

  /// The listing is reserved for this client, and every other waiting
  /// request on it is not retained (RM-M29-04).
  Future<Reservation> accept(String id) => _decide(() => _api.acceptReservation(id: id));

  /// RM-M29-06 — a reason from the list, and a word more if wanted.
  Future<Reservation> refuse(String id, {required RefusalReason reason, String? note}) =>
      _decide(() => _api.refuseReservation(id: id, ownerDecisionRequest: _decision(reason, note)));

  /// Once, by the configured length (RM-M29-07).
  Future<Reservation> extend(String id) => _decide(() => _api.extendReservation(id: id));

  /// An accepted reservation, called off with a reason — counted for the
  /// admin (RM-M29-08).
  Future<Reservation> cancel(String id, {required RefusalReason reason, String? note}) =>
      _decide(() => _api.cancelIncomingReservation(id: id, ownerDecisionRequest: _decision(reason, note)));

  OwnerDecisionRequest _decision(RefusalReason reason, String? note) => OwnerDecisionRequest(
        (b) => b
          ..reason = OwnerDecisionRequestReasonEnum.valueOf(reason.wire)
          ..note = (note == null || note.trim().isEmpty) ? null : note.trim(),
      );

  Future<Reservation> _decide(Future<Response<ReservationResponse>> Function() call) async {
    try {
      return _read(await call());
    } catch (error) {
      final api = ApiError.from(error);
      for (final (code, reason) in const [
        ('RESERVATION_CLOSED', DecisionRefusal.closed),
        ('LISTING_NOT_RESERVABLE', DecisionRefusal.notReservable),
        ('RESERVATION_ALREADY_EXTENDED', DecisionRefusal.alreadyExtended),
        ('RESERVATION_NOT_ACCEPTED', DecisionRefusal.notAccepted),
      ]) {
        if (api.hasCode(code)) throw ReservationDecisionRefused(reason);
      }
      rethrow;
    }
  }

  Reservation _read(Response<ReservationResponse> response) {
    final data = response.data;
    if (data == null) throw Exception('empty reservation response');
    return Reservation.fromResponse(data);
  }
}
