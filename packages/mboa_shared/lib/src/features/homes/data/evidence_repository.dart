import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../../api/api_error.dart';
import '../models/evidence.dart';
import 'homes_repository.dart';

/// Why the server turned a sending down — said in words by the screen.
enum EvidenceRefusal {
  /// More than 20 photos at once.
  tooLarge,

  /// 200 photos on this contract already.
  limitReached,

  /// After the tenancy: only exit photos, for 7 days.
  phaseClosed,

  /// The tenancy ended more than 7 days ago.
  readOnly,

  /// A photo did not arrive whole in storage — nothing was recorded.
  notStored,

  /// That very photo is already recorded.
  alreadyRecorded,
}

class EvidenceRefused implements Exception {
  const EvidenceRefused(this.reason);

  final EvidenceRefusal reason;
}

/// A photo storage would not take, even after the retries (CE-M30-01).
class EvidenceUploadFailed implements Exception {
  const EvidenceUploadFailed();
}

/// Photo proofs of the home's condition (CDC M30 lot 3, RM-M30-11/12):
/// sent by the tenant, recorded with Mboa's time and fingerprint, never
/// modified nor deleted, never public. The landlord acknowledges, once.
class EvidenceRepository {
  EvidenceRepository({required DioClient dioClient, required HiveCache cache, Dio? uploadClient})
      : _dioClient = dioClient,
        _cache = cache,
        _uploadClient = uploadClient ?? Dio();

  final DioClient _dioClient;
  final HiveCache _cache;

  /// The PUTs go to storage — never with the app's token.
  final Dio _uploadClient;

  MonLogementApi get _api => _dioClient.api.getMonLogementApi();

  /// The server's caps: 20 a sending.
  static const int maxPerSending = 20;
  static const int _attempts = 3;
  static const String _contentType = 'image/jpeg';

  /// A home's sendings, newest first, without links. Offline, the last list.
  Future<Cached<List<EvidenceBatch>>> batches(String contractId) async {
    final key = 'evidence:$contractId';
    try {
      final response = await _api.listEvidence(contractId: contractId, pageable: Pageable((b) => b..size = 50));
      final items = response.data?.content?.map(EvidenceBatch.fromResponse).toList() ?? const <EvidenceBatch>[];
      await _cache.put(StorageKeys.homesBox, key, {'items': [for (final b in items) b.toCache()]});
      return Cached(items);
    } catch (error) {
      final raw = _cache.get(StorageKeys.homesBox, key)?['items'];
      if (raw is! List) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached([for (final b in raw) ?EvidenceBatch.fromCache(b)], fromCache: true);
    }
  }

  /// One sending, each photo with a short-lived link.
  Future<EvidenceBatch> batch(String contractId, String batchId) async =>
      _read((await _api.getEvidenceBatch(contractId: contractId, batchId: batchId)).data);

  /// Moving in beside moving out, room by room (CA-M31-04) — each photo with
  /// a short-lived link, so never kept offline. Both sides of the lease may
  /// ask, during the tenancy and after it.
  Future<List<EvidenceRoomPair>> compare(String contractId) async {
    final rooms = (await _api.compareEvidence(contractId: contractId)).data?.toList() ?? const [];
    return [for (final r in rooms) EvidenceRoomPair.fromResponse(r)];
  }

  /// The landlord's, once — with a word the tenant sees.
  Future<EvidenceBatch> acknowledge(String contractId, String batchId, {String? comment}) async => _read(
        (await _api.acknowledgeEvidence(
          contractId: contractId,
          batchId: batchId,
          acknowledgeEvidenceRequest: _blank(comment) == null
              ? null
              : AcknowledgeEvidenceRequest((b) => b..comment = _blank(comment)),
        ))
            .data,
      );

  /// Sends [shots] of one [phase]: asks for the uploads, puts each photo's
  /// exact bytes with the headers storage expects (retried three times),
  /// then records them — the server checks each in storage first, and
  /// records nothing if one is missing. [onUploaded] counts them through.
  Future<EvidenceBatch> send(
    String contractId,
    EvidencePhase phase,
    List<EvidenceShot> shots, {
    void Function(int done, int total)? onUploaded,
  }) =>
      _guard(() async {
        final uploads = (await _api.createEvidenceUploads(
          contractId: contractId,
          evidenceUploadsRequest: EvidenceUploadsRequest(
            (b) => b
              ..files = ListBuilder([
                for (final shot in shots)
                  EvidenceFileRequest((f) => f
                    ..contentType = _contentType
                    ..size = shot.photo.bytes.length
                    ..sha256 = shot.photo.sha256),
              ]),
          ),
        ))
            .data
            ?.toList();
        if (uploads == null || uploads.length != shots.length) throw StateError('uploads do not match the photos');

        for (final (index, upload) in uploads.indexed) {
          await _put(upload, shots[index]);
          onUploaded?.call(index + 1, shots.length);
        }

        return _read(
          (await _api.recordEvidence(
            contractId: contractId,
            recordEvidenceRequest: RecordEvidenceRequest(
              (b) => b
                ..photos = ListBuilder([
                  for (final (index, shot) in shots.indexed)
                    EvidencePhotoRequest((p) => p
                      ..objectKey = uploads[index].objectKey
                      ..sha256 = shot.photo.sha256
                      ..room = EvidencePhotoRequestRoomEnum.valueOf(shot.room.wire)
                      ..roomLabel = _blank(shot.roomLabel)
                      ..phase = EvidencePhotoRequestPhaseEnum.valueOf(phase.wire)
                      ..comment = _blank(shot.comment)),
                ]),
            ),
          ))
              .data,
        );
      });

  /// Exactly the headers given — the checksum is part of the signature.
  Future<void> _put(EvidenceUpload upload, EvidenceShot shot) async {
    final url = upload.uploadUrl;
    if (url == null) throw StateError('upload without a link');
    for (var attempt = 1; ; attempt++) {
      try {
        await _uploadClient.requestUri<void>(
          Uri.parse(url),
          data: Stream<List<int>>.fromIterable([shot.photo.bytes]),
          options: Options(
            method: upload.method ?? 'PUT',
            headers: {
              ...?upload.headers?.toMap(),
              Headers.contentLengthHeader: shot.photo.bytes.length,
            },
          ),
        );
        return;
      } on DioException {
        if (attempt >= _attempts) throw const EvidenceUploadFailed();
      }
    }
  }

  Future<EvidenceBatch> _guard(Future<EvidenceBatch> Function() call) async {
    try {
      return await call();
    } on DioException catch (error) {
      final api = ApiError.from(error);
      for (final (code, reason) in const [
        ('EVIDENCE_SENDING_TOO_LARGE', EvidenceRefusal.tooLarge),
        ('EVIDENCE_LIMIT_REACHED', EvidenceRefusal.limitReached),
        ('EVIDENCE_PHASE_CLOSED', EvidenceRefusal.phaseClosed),
        ('HOME_READ_ONLY', EvidenceRefusal.readOnly),
        ('EVIDENCE_NOT_STORED', EvidenceRefusal.notStored),
        ('EVIDENCE_ALREADY_RECORDED', EvidenceRefusal.alreadyRecorded),
      ]) {
        if (api.hasCode(code)) throw EvidenceRefused(reason);
      }
      rethrow;
    }
  }

  EvidenceBatch _read(EvidenceBatchResponse? data) {
    if (data == null) throw StateError('empty evidence response');
    return EvidenceBatch.fromResponse(data);
  }

  static String? _blank(String? value) => (value == null || value.trim().isEmpty) ? null : value.trim();
}
