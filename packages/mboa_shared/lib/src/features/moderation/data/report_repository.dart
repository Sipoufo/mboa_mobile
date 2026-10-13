import 'package:mboa_core/mboa_core.dart';

import '../models/report_target.dart';

/// Reporting a listing, a message or a review to moderation (CDC M23).
///
/// Shared: the same door from either app, and RM-M27-06 made reviews
/// reportable by any signed-in user.
///
/// There is nothing to read back. RM-M23-05 is explicit that the reporter is
/// told their report was received and never the outcome — so this repository
/// writes and returns nothing, and no screen can accidentally promise more.
class ReportRepository {
  ReportRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  SignalementsApi get _api => _dioClient.api.getSignalementsApi();

  Future<void> report(
    ReportTarget target, {
    required ReportReason reason,
    String? comment,
  }) async {
    final trimmed = comment?.trim();
    await _api.createSignalement(
      createSignalementRequest: CreateSignalementRequest(
        (b) => b
          ..targetType = target.kind.wire
          ..targetId = target.id
          ..reason = reason.wire
          ..comment = (trimmed?.isEmpty ?? true) ? null : trimmed,
      ),
    );
  }
}
