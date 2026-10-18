import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/agent_visit.dart';
import 'visit_detail_source.dart';

/// The visits a prestataire carries out himself (RM-M11-10 / RM-M15-06).
///
/// He has no weekly availability like an agent: a client's request arrives as
/// `REQUESTED` and he confirms or turns down the proposed time by hand. Once
/// confirmed it behaves like any other visit — including the mutual presence
/// confirmation, which goes through the same endpoint the agent uses, because
/// on that day he *is* the visitor.
class PrestataireVisitRepository implements VisitsSource, VisitDetailSource, VisitRequestResponder {
  PrestataireVisitRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  static const int _pageSize = 100;

  PrestataireVisitesApi get _api => _dioClient.api.getPrestataireVisitesApi();

  VisitesPrsenceApi get _presenceApi => _dioClient.api.getVisitesPrsenceApi();

  @override
  Future<List<Visit>> range({
    required DateTime from,
    required DateTime to,
  }) async {
    final response = await _api.listMyOwnerVisites(
      // **UTC or nothing**: built_value's DateTime serializer throws
      // "Must be in utc for serialization" on a local one, and the agenda's
      // week boundaries are local days. The throw happened inside the
      // generated client, so it surfaced as a failed load — an empty calendar
      // with a Réessayer button that could never succeed.
      from: from.toUtc(),
      to: to.toUtc(),
      pageable: Pageable(
        (b) => b
          ..page = 0
          ..size = _pageSize,
      ),
    );
    return (response.data?.content ?? const <VisiteResponse>[]).map(Visit.fromResponse).toList();
  }

  /// RM-M15-06 — the proposed time suits him; the visit becomes scheduled.
  @override
  Future<void> confirm(String id) => _api.confirmVisiteRequest(id: id);

  /// Turns the time down. The client may propose another, so this ends the
  /// request and not the client's interest in the property.
  @override
  Future<void> decline(String id) => _api.declineVisiteRequest(id: id);

  /// §14 — the same sheet the agent gets: the client's name and phone, the
  /// exact address, `canConfirm`. Its `prestataire*` fields are his own.
  @override
  Future<AgentVisitDetail> detail(String id) async {
    final response = await _api.getMyOwnerVisite(id: id);
    final data = response.data;
    if (data == null) throw StateError('Visit $id not found');
    return AgentVisitDetail.fromResponse(data);
  }

  /// RM-M07-05 — he is at his own property, and says so.
  ///
  /// From the agenda there is no geofence prompt: the list carries no
  /// coordinates. From the sheet there is, and [overrideReason] is the
  /// justification beyond 500 m. The fix goes to the server either way.
  @override
  Future<void> confirmPresence(
    String id, {
    required double latitude,
    required double longitude,
    String? overrideReason,
  }) => _presenceApi.confirmVisitorPresence(
    id: id,
    startVisiteRequest: StartVisiteRequest(
      (b) => b
        ..latitude = latitude
        ..longitude = longitude
        ..overrideReason = overrideReason,
    ),
  );

  /// §14 — he can call off a confirmed visit, up to one hour before it (the
  /// agent's rule, RM-M16-04). The server owns the cutoff; the client is told
  /// (N-05).
  @override
  Future<void> cancel(String id) => _api.cancelMyOwnerVisite(id: id);
}
