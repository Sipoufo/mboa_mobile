import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../../api/api_error.dart';
import '../models/home_request.dart';
import 'homes_repository.dart';

/// Why the server turned a step down — said in words by the screen.
enum HomeRequestRefusal {
  /// Out of order — someone moved it meanwhile.
  transitionInvalid,

  /// The tenancy ended more than 7 days ago.
  readOnly,
}

class HomeRequestRefused implements Exception {
  const HomeRequestRefused(this.reason);

  final HomeRequestRefusal reason;
}

/// What the tenant sends — the body of `POST /homes/{id}/requests`.
class HomeRequestDraft {
  const HomeRequestDraft({
    required this.type,
    required this.title,
    required this.description,
    this.photoKeys = const [],
  });

  final HomeRequestType type;
  final String title;
  final String description;

  /// Uploaded as `MESSAGE_ATTACHMENT`, five at most.
  final List<String> photoKeys;
}

/// Requests to the landlord (CDC M30 lot 3, RM-M30-09) — the tenant asks,
/// the landlord moves them on; both read them. No add-on (RM-M30-15).
class HomeRequestsRepository {
  HomeRequestsRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  MonLogementApi get _api => _dioClient.api.getMonLogementApi();

  /// The landlord's inbox: what still waits on him.
  static const openStatuses = [HomeRequestStatus.sent, HomeRequestStatus.seen, HomeRequestStatus.inProgress];

  /// A home's requests, newest first, either party. Offline, the last list.
  Future<Cached<List<HomeRequest>>> ofHome(String contractId) => _cachedList(
        'requests:$contractId',
        () async => (await _api.listHomeRequests(contractId: contractId, pageable: Pageable((b) => b..size = 50)))
            .data
            ?.content,
      );

  /// The landlord's requests across his homes — open ones by default (the
  /// inbox). Offline, the last list.
  Future<Cached<List<HomeRequest>>> received({List<HomeRequestStatus> statuses = openStatuses}) => _cachedList(
        'requests:received:${statuses.map((s) => s.name).join(',')}',
        () async => (await _api.listMyReceivedRequests(
          pageable: Pageable((b) => b..size = 50),
          status: BuiltList([for (final s in statuses) s.wire]),
        ))
            .data
            ?.content,
      );

  /// The home's counter — the server's total of what waits on him.
  Future<int> openCount() async {
    final response = await _api.listMyReceivedRequests(
      pageable: Pageable((b) => b..size = 1),
      status: BuiltList([for (final s in openStatuses) s.wire]),
    );
    return response.data?.totalElements ?? 0;
  }

  /// One request with its photos and history — what N-38 opens. The
  /// landlord's first look marks it seen.
  Future<HomeRequest> get(String requestId) async => _read((await _api.getHomeRequest(requestId: requestId)).data);

  Future<HomeRequest> create(String contractId, HomeRequestDraft draft) => _guard(
        () async => _read(
          (await _api.createHomeRequest(
            contractId: contractId,
            createHomeRequest: CreateHomeRequest(
              (b) => b
                ..type = CreateHomeRequestTypeEnum.valueOf(draft.type.wire)
                ..title = draft.title.trim()
                ..description = draft.description.trim()
                ..photoKeys = draft.photoKeys.isEmpty ? null : ListBuilder<String>(draft.photoKeys),
            ),
          ))
              .data,
        ),
      );

  /// The landlord takes it in hand, or resolves it — with a word, if any.
  Future<HomeRequest> move(String requestId, HomeRequestStatus status, {String? note}) => _guard(
        () async => _read(
          (await _api.moveHomeRequest(
            requestId: requestId,
            homeRequestStatusRequest: HomeRequestStatusRequest(
              (b) => b
                ..status = HomeRequestStatusRequestStatusEnum.valueOf(status.wire)
                ..note = _blank(note),
            ),
          ))
              .data,
        ),
      );

  /// The tenant closes it, for good.
  Future<HomeRequest> close(String requestId, {String? note}) => _guard(
        () async => _read(
          (await _api.closeHomeRequest(requestId: requestId, homeRequestNoteRequest: _note(note))).data,
        ),
      );

  /// The tenant reopens a resolved one: the problem is still there.
  Future<HomeRequest> reopen(String requestId, {String? note}) => _guard(
        () async => _read(
          (await _api.reopenHomeRequest(requestId: requestId, homeRequestNoteRequest: _note(note))).data,
        ),
      );

  HomeRequestNoteRequest? _note(String? note) =>
      _blank(note) == null ? null : HomeRequestNoteRequest((b) => b..note = _blank(note));

  Future<Cached<List<HomeRequest>>> _cachedList(
    String key,
    Future<BuiltList<HomeRequestResponse>?> Function() read,
  ) async {
    try {
      final items = (await read())?.map(HomeRequest.fromResponse).toList() ?? const <HomeRequest>[];
      await _cache.put(StorageKeys.homesBox, key, {'items': [for (final r in items) r.toCache()]});
      return Cached(items);
    } catch (error) {
      final raw = _cache.get(StorageKeys.homesBox, key)?['items'];
      if (raw is! List) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached([for (final r in raw) ?HomeRequest.fromCache(r)], fromCache: true);
    }
  }

  Future<HomeRequest> _guard(Future<HomeRequest> Function() call) async {
    try {
      return await call();
    } on DioException catch (error) {
      final api = ApiError.from(error);
      if (api.hasCode('HOME_REQUEST_TRANSITION_INVALID')) {
        throw const HomeRequestRefused(HomeRequestRefusal.transitionInvalid);
      }
      if (api.hasCode('HOME_READ_ONLY')) throw const HomeRequestRefused(HomeRequestRefusal.readOnly);
      rethrow;
    }
  }

  HomeRequest _read(HomeRequestResponse? data) {
    if (data == null) throw StateError('empty home request response');
    return HomeRequest.fromResponse(data);
  }

  static String? _blank(String? value) => (value == null || value.trim().isEmpty) ? null : value.trim();
}
