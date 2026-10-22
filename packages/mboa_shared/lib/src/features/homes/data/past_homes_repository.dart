import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

import '../models/home.dart';
import '../models/past_home.dart';
import 'homes_repository.dart';

/// « Mes anciens logements » (CDC M31): the tenant's ended tenancies, kept
/// for him. Read-only — what was signed, paid and said stays as it was. The
/// landlord has no such page (RM-M31-09): the server answers him 403.
class PastHomesRepository {
  PastHomesRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  MesAnciensLogementsApi get _api => _dioClient.api.getMesAnciensLogementsApi();

  static const String _listKey = 'past-homes';
  static String _key(String contractId) => 'past-home:$contractId';

  /// The ended tenancies, newest end first. Offline, the last list.
  Future<Cached<List<Home>>> list() async {
    try {
      final response = await _api.listMyPastHomes(pageable: Pageable((b) => b..size = 50));
      final homes = response.data?.content?.map(Home.fromResponse).toList() ?? const <Home>[];
      await _cache.put(StorageKeys.homesBox, _listKey, {'items': [for (final h in homes) h.toCache()]});
      return Cached(homes);
    } catch (error) {
      final raw = _cache.get(StorageKeys.homesBox, _listKey)?['items'];
      if (raw is! List) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached([for (final h in raw) ?Home.fromCache(h)], fromCache: true);
    }
  }

  /// One ended tenancy, everything the sheet shows. Offline, the last copy —
  /// without what must be asked again (a receipt's link, the review's rights).
  Future<Cached<PastHome>> get(String contractId) async {
    try {
      final data = (await _api.getMyPastHome(contractId: contractId)).data;
      if (data == null) throw StateError('empty past home $contractId');
      final home = PastHome.fromResponse(data);
      await _cache.put(StorageKeys.homesBox, _key(contractId), home.toCache());
      return Cached(home);
    } catch (error) {
      final cached = PastHome.fromCache(_cache.get(StorageKeys.homesBox, _key(contractId)));
      if (cached == null) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached(cached, fromCache: true);
    }
  }

  /// The expenses statement (RM-M31-03), made by the server from confirmed
  /// payments only. Read as bytes: the generated call would decode a PDF as
  /// text.
  Future<Uint8List> expensesPdf(String contractId) async {
    final response = await _dioClient.dio.get<List<int>>(
      '/api/v1/past-homes/$contractId/expenses.pdf',
      options: Options(responseType: ResponseType.bytes),
    );
    final bytes = response.data;
    if (bytes == null || bytes.isEmpty) throw StateError('empty expenses PDF for $contractId');
    return Uint8List.fromList(bytes);
  }
}
