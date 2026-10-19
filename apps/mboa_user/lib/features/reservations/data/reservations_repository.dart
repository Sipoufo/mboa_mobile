import 'package:built_collection/built_collection.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Why a request was turned down before it was even made — the server's
/// codes, read once here (CE-M29-01 to 03).
enum RequestRefusal {
  /// The listing is no longer published (reserved, let, archived…).
  notReservable,

  /// First name, last name and search city are needed first (CE-M29-02).
  profileIncomplete,

  /// One active request per listing.
  alreadyActive,

  /// Three waiting requests in all.
  limitReached,
  startPast,
  startTooFar,
}

class ReservationRequestRefused implements Exception {
  const ReservationRequestRefused(this.reason);

  final RequestRefusal reason;
}

/// The list, and where it came from.
class MyReservationsPage {
  const MyReservationsPage(this.items, {this.fromCache = false});

  final List<Reservation> items;
  final bool fromCache;
}

/// The tenant's reservation requests (CDC M29) — `/reservations`.
///
/// **No money anywhere** (RM-M29-09): nothing here takes or sends an amount.
class ReservationsRepository {
  ReservationsRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  static const String _listKey = 'mine';

  RservationsApi get _api => _dioClient.api.getRservationsApi();

  /// Asks to reserve [annonceId] from [start] for [units] periods of the
  /// listing's own periodicity.
  ///
  /// Throws [ReservationRequestRefused] for the refusals the screen explains.
  Future<Reservation> request({
    required String annonceId,
    required DateTime start,
    required int units,
    String? message,
  }) async {
    try {
      final response = await _api.requestReservation(
        createReservationRequest: CreateReservationRequest(
          (b) => b
            ..annonceId = annonceId
            ..desiredStartDate = Date(start.year, start.month, start.day)
            ..durationUnits = units
            ..message = (message == null || message.trim().isEmpty) ? null : message.trim(),
        ),
      );
      final data = response.data;
      if (data == null) throw Exception('empty reservation response');
      return Reservation.fromResponse(data);
    } catch (error) {
      final api = ApiError.from(error);
      for (final (code, reason) in const [
        ('LISTING_NOT_RESERVABLE', RequestRefusal.notReservable),
        ('PROFILE_INCOMPLETE', RequestRefusal.profileIncomplete),
        ('RESERVATION_ALREADY_ACTIVE', RequestRefusal.alreadyActive),
        ('RESERVATION_LIMIT_REACHED', RequestRefusal.limitReached),
        ('RESERVATION_START_PAST', RequestRefusal.startPast),
        ('RESERVATION_START_TOO_FAR', RequestRefusal.startTooFar),
      ]) {
        if (api.hasCode(code)) throw ReservationRequestRefused(reason);
      }
      rethrow;
    }
  }

  /// The tenant's requests, newest first. Offline, the last list read —
  /// read-only — or the failure when there is none.
  Future<MyReservationsPage> mine() async {
    try {
      final response = await _api.listMyReservations(pageable: Pageable((b) => b..size = 50));
      final items = (response.data?.content ?? BuiltList<ReservationResponse>()).map(Reservation.fromResponse).toList();
      await _cache.put(StorageKeys.reservationsBox, _listKey, {
        'items': items.map((r) => r.toCache()).toList(),
      });
      return MyReservationsPage(items);
    } catch (_) {
      final raw = _cache.get(StorageKeys.reservationsBox, _listKey)?['items'];
      if (raw is! List) rethrow;
      return MyReservationsPage(
        [
          for (final item in raw.whereType<Map<dynamic, dynamic>>())
            ?Reservation.fromCache(Map<String, dynamic>.from(item)),
        ],
        fromCache: true,
      );
    }
  }

  Future<Reservation> get(String id) async {
    final data = (await _api.getMyReservation(id: id)).data;
    if (data == null) throw Exception('reservation $id not found');
    return Reservation.fromResponse(data);
  }

  /// Withdraws a waiting request, or cancels an accepted reservation — free
  /// before signature (RM-M29-08).
  Future<Reservation> cancel(String id) async {
    final data = (await _api.cancelMyReservation(id: id)).data;
    if (data == null) throw Exception('empty cancellation response');
    return Reservation.fromResponse(data);
  }
}
