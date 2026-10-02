import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/bookable_visitor.dart';

/// Thrown when the tenant already has a visit running on this property.
///
/// RM-M07-03 allows one at a time, and the server answers 409. It is a
/// different screen from a failure — the visit they already have is the
/// answer — so it is a type rather than a flag on an error.
class VisitAlreadyBooked implements Exception {
  const VisitAlreadyBooked();
}

/// Planning a visit, and the visits already planned (CDC M07).
class VisitsRepository {
  VisitsRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  static const int _pageSize = 50;
  static const String _upcomingKey = 'upcoming';

  VisitesApi get _api => _dioClient.api.getVisitesApi();

  /// Who can show this listing, and when (RM-M07-01).
  ///
  /// Visitors with nothing to offer are kept: their `reason` is what CE-M07-01
  /// asks the screen to say, and dropping them would leave the tenant with the
  /// blank "no slots" screen the reason exists to replace.
  Future<List<BookableVisitor>> visitorsFor(String annonceId) async {
    final response = await _api.listBookableSlots(annonceId: annonceId);
    return (response.data?.toList() ?? const <VisitorSlots>[])
        .map(BookableVisitor.fromResponse)
        .nonNulls
        .toList();
  }

  /// Books [startsAt] with [visitorAccountId] (RM-M07-02 — free in MVP).
  Future<Visit> book({
    required String annonceId,
    required String visitorAccountId,
    required DateTime startsAt,
  }) async {
    try {
      final response = await _api.bookVisite(
        bookVisiteRequest: BookVisiteRequest(
          (b) => b
            ..annonceId = annonceId
            ..visitorAccountId = visitorAccountId
            // The API speaks UTC; the slot was shown in the tenant's own time.
            ..startsAt = startsAt.toUtc(),
        ),
      );
      final visit = response.data;
      if (visit == null) throw Exception('empty booking response');
      await _cache.delete(StorageKeys.visitsBox, _upcomingKey);
      return Visit.fromResponse(visit);
    } on DioException catch (error) {
      if (error.response?.statusCode == 409) throw const VisitAlreadyBooked();
      rethrow;
    }
  }

  /// Every visit of the signed-in tenant, newest slot first.
  Future<List<Visit>> mine() async {
    final response = await _api.listMyVisites(
      pageable: Pageable(
        (b) => b
          ..page = 0
          ..size = _pageSize,
      ),
    );
    final visits = (response.data?.content?.toList() ?? const <VisiteResponse>[])
        .map(Visit.fromResponse)
        .toList()
      ..sort((a, b) => _at(b).compareTo(_at(a)));

    await _cacheUpcoming(visits);
    return visits;
  }

  /// RM-M07-04 — the server has the last word; the screen hides the button
  /// inside four hours so nobody taps into a refusal.
  Future<void> cancel(String visitId) async {
    await _api.cancelMyVisite(id: visitId);
    await _cache.delete(StorageKeys.visitsBox, _upcomingKey);
  }

  /// RM-M07-05 — half of the mutual confirmation. The server decides when both
  /// halves are in; the app only reports that this one is.
  Future<Visit> confirmPresence(String visitId) async {
    final response = await _api.confirmClientPresence(id: visitId);
    final visit = response.data;
    if (visit == null) throw Exception('empty confirmation response');
    await _cache.delete(StorageKeys.visitsBox, _upcomingKey);
    return Visit.fromResponse(visit);
  }

  /// RM-M07-07 — rating the **agent's service**, once, and never the property.
  Future<void> rateVisitor({required String visitId, required int rating}) =>
      _api.rateVisiteAgent(
        id: visitId,
        rateAgentRequest: RateAgentRequest((b) => b..rating = rating),
      );

  /// The upcoming visits of the last successful load.
  ///
  /// Only the upcoming ones: someone opening this screen without a line wants
  /// to know when and where they are expected, not to read their history.
  List<Visit> cachedUpcoming() {
    final raw = _cache.get(
      StorageKeys.visitsBox,
      _upcomingKey,
      ttl: CacheTtl.visits,
    );
    if (raw == null) return const [];

    final items = raw['items'];
    if (items is! List) return const [];
    return items
        .whereType<Map<dynamic, dynamic>>()
        .map((item) => _fromCache(item.cast<String, dynamic>()))
        .nonNulls
        .toList();
  }

  Future<void> _cacheUpcoming(List<Visit> visits) => _cache.put(
        StorageKeys.visitsBox,
        _upcomingKey,
        {
          'items': visits.where((visit) => visit.isUpcoming).map(_toCache).toList(),
        },
      );

  static DateTime _at(Visit visit) =>
      visit.scheduledAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  static Map<String, dynamic> _toCache(Visit visit) => {
        'id': visit.id,
        'status': visit.status.name,
        'annonceId': visit.annonceId,
        'annonceTitle': visit.annonceTitle,
        'scheduledAt': visit.scheduledAt?.toIso8601String(),
        'visitorKind': visit.visitorKind.name,
        'visitorAccountId': visit.visitorAccountId,
        'visitorConfirmedAt': visit.visitorConfirmedAt?.toIso8601String(),
        'clientConfirmedAt': visit.clientConfirmedAt?.toIso8601String(),
      };

  /// Tolerant on purpose: a cache written by an older build degrades field by
  /// field rather than taking the screen down on launch.
  static Visit? _fromCache(Map<String, dynamic> raw) {
    final id = raw['id'];
    if (id is! String || id.isEmpty) return null;

    DateTime? date(Object? value) =>
        value is String ? DateTime.tryParse(value) : null;

    return Visit(
      id: id,
      status: VisitStatus.values.firstWhere(
        (status) => status.name == raw['status'],
        orElse: () => VisitStatus.unknown,
      ),
      annonceId: raw['annonceId'] as String?,
      annonceTitle: raw['annonceTitle'] as String?,
      scheduledAt: date(raw['scheduledAt']),
      visitorAccountId: raw['visitorAccountId'] as String?,
      visitorKind: VisitorKind.values.firstWhere(
        (kind) => kind.name == raw['visitorKind'],
        orElse: () => VisitorKind.unknown,
      ),
      visitorConfirmedAt: date(raw['visitorConfirmedAt']),
      clientConfirmedAt: date(raw['clientConfirmedAt']),
    );
  }
}
