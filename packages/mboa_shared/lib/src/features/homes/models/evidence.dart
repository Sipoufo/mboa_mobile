import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

/// Where a photo was taken (CDC M30, RM-M30-11).
enum EvidenceRoom {
  livingRoom,
  bedroom,
  kitchen,
  bathroom,
  toilet,
  outdoor,
  other;

  String get wire => switch (this) {
        EvidenceRoom.livingRoom => 'LIVING_ROOM',
        EvidenceRoom.bedroom => 'BEDROOM',
        EvidenceRoom.kitchen => 'KITCHEN',
        EvidenceRoom.bathroom => 'BATHROOM',
        EvidenceRoom.toilet => 'TOILET',
        EvidenceRoom.outdoor => 'OUTDOOR',
        EvidenceRoom.other => 'OTHER',
      };

  static EvidenceRoom fromWire(String? name) =>
      EvidenceRoom.values.where((r) => r.wire == name).firstOrNull ?? EvidenceRoom.other;
}

/// When in the tenancy — moving in, during it, moving out.
enum EvidencePhase {
  entry,
  stay,
  exit;

  String get wire => switch (this) {
        EvidencePhase.entry => 'ENTRY',
        EvidencePhase.stay => 'STAY',
        EvidencePhase.exit => 'EXIT',
      };

  static EvidencePhase fromWire(String? name) =>
      EvidencePhase.values.where((p) => p.wire == name).firstOrNull ?? EvidencePhase.stay;
}

/// One recorded photo: its room, its phase, Mboa's time and fingerprint —
/// never modified nor deleted (RM-M30-12).
class EvidencePhoto extends Equatable {
  const EvidencePhoto({
    required this.id,
    this.room = EvidenceRoom.other,
    this.roomLabel,
    this.phase = EvidencePhase.stay,
    this.comment,
    this.sha256,
    this.recordedAt,
    this.downloadUrl,
  });

  final String id;
  final EvidenceRoom room;

  /// « Chambre 2 ».
  final String? roomLabel;
  final EvidencePhase phase;
  final String? comment;

  /// Hex, as the server returns it.
  final String? sha256;

  /// The server's time — the one that counts.
  final DateTime? recordedAt;

  /// Short-lived — a batch's detail only.
  final String? downloadUrl;

  static EvidencePhoto fromResponse(EvidencePhotoResponse response) => EvidencePhoto(
        id: response.id ?? '',
        room: EvidenceRoom.fromWire(response.room?.name),
        roomLabel: _blank(response.roomLabel),
        phase: EvidencePhase.fromWire(response.phase?.name),
        comment: _blank(response.comment),
        sha256: response.sha256,
        recordedAt: response.recordedAt?.toLocal(),
        downloadUrl: response.downloadUrl,
      );

  @override
  List<Object?> get props => [id, room, roomLabel, phase, comment, sha256, recordedAt, downloadUrl];
}

/// One sending of photos, as Mboa recorded it — and the landlord's
/// acknowledgement, once (he can neither contest nor delete).
class EvidenceBatch extends Equatable {
  const EvidenceBatch({
    required this.id,
    this.contractId,
    this.recordedAt,
    this.photos = const [],
    this.acknowledgedAt,
    this.ownerComment,
    this.canAcknowledge = false,
  });

  final String id;
  final String? contractId;
  final DateTime? recordedAt;
  final List<EvidencePhoto> photos;
  final DateTime? acknowledgedAt;
  final String? ownerComment;
  final bool canAcknowledge;

  bool get isAcknowledged => acknowledgedAt != null;

  /// The phases it covers — usually one.
  Set<EvidencePhase> get phases => {for (final p in photos) p.phase};

  static EvidenceBatch fromResponse(EvidenceBatchResponse response) => EvidenceBatch(
        id: response.id ?? '',
        contractId: response.contractId,
        recordedAt: response.recordedAt?.toLocal(),
        photos: [for (final p in response.photos?.toList() ?? const <EvidencePhotoResponse>[]) EvidencePhoto.fromResponse(p)],
        acknowledgedAt: response.acknowledgedAt?.toLocal(),
        ownerComment: _blank(response.ownerComment),
        canAcknowledge: response.canAcknowledge ?? false,
      );

  /// What a list row draws, for the offline copy — no links, they expire.
  Map<String, dynamic> toCache() => {
        'id': id,
        'contractId': contractId,
        'recordedAt': recordedAt?.toIso8601String(),
        'acknowledgedAt': acknowledgedAt?.toIso8601String(),
        'ownerComment': ownerComment,
        'photos': [
          for (final p in photos) {'id': p.id, 'room': p.room.name, 'phase': p.phase.name},
        ],
      };

  static EvidenceBatch? fromCache(Object? raw) {
    if (raw is! Map) return null;
    final json = Map<String, dynamic>.from(raw);
    final id = json['id'];
    if (id is! String) return null;
    DateTime? date(Object? value) => value is String ? DateTime.tryParse(value) : null;
    return EvidenceBatch(
      id: id,
      contractId: json['contractId'] as String?,
      recordedAt: date(json['recordedAt']),
      acknowledgedAt: date(json['acknowledgedAt']),
      ownerComment: json['ownerComment'] as String?,
      photos: [
        for (final p in (json['photos'] as List? ?? const []))
          if (p is Map && p['id'] is String)
            EvidencePhoto(
              id: p['id'] as String,
              room: EvidenceRoom.values.where((r) => r.name == p['room']).firstOrNull ?? EvidenceRoom.other,
              phase: EvidencePhase.values.where((f) => f.name == p['phase']).firstOrNull ?? EvidencePhase.stay,
            ),
      ],
    );
  }

  @override
  List<Object?> get props => [id, contractId, recordedAt, photos, acknowledgedAt, ownerComment, canAcknowledge];
}

/// One room, moving in beside moving out (CA-M31-04): each photo with its
/// time. A room photographed only once is still listed — the empty side says
/// so.
class EvidenceRoomPair extends Equatable {
  const EvidenceRoomPair({required this.room, this.roomLabel, this.entry = const [], this.exit = const []});

  final EvidenceRoom room;

  /// The tenant's word for an [EvidenceRoom.other] room.
  final String? roomLabel;
  final List<EvidencePhoto> entry;
  final List<EvidencePhoto> exit;

  /// Both sides exist — a comparison, not a gallery.
  bool get isPaired => entry.isNotEmpty && exit.isNotEmpty;

  static EvidenceRoomPair fromResponse(EvidenceRoomComparison response) => EvidenceRoomPair(
        room: EvidenceRoom.fromWire(response.room?.name),
        roomLabel: response.roomLabel,
        entry: [
          for (final p in response.entry?.toList() ?? const <EvidencePhotoResponse>[]) EvidencePhoto.fromResponse(p),
        ],
        exit: [
          for (final p in response.exit?.toList() ?? const <EvidencePhotoResponse>[]) EvidencePhoto.fromResponse(p),
        ],
      );

  @override
  List<Object?> get props => [room, roomLabel, entry, exit];
}

/// A photo ready to send: compressed, its EXIF gone, and fingerprinted on
/// the very bytes that will travel (base64 SHA-256, §27.6).
class PreparedPhoto extends Equatable {
  const PreparedPhoto({required this.bytes, required this.sha256});

  final Uint8List bytes;
  final String sha256;

  @override
  List<Object?> get props => [sha256];
}

/// One photo of a sending being made: the prepared bytes, and what the
/// tenant says of it.
class EvidenceShot extends Equatable {
  const EvidenceShot({required this.photo, this.room = EvidenceRoom.livingRoom, this.roomLabel, this.comment});

  final PreparedPhoto photo;
  final EvidenceRoom room;
  final String? roomLabel;
  final String? comment;

  EvidenceShot copyWith({EvidenceRoom? room, String? roomLabel, String? comment}) => EvidenceShot(
        photo: photo,
        room: room ?? this.room,
        roomLabel: roomLabel ?? this.roomLabel,
        comment: comment ?? this.comment,
      );

  @override
  List<Object?> get props => [photo, room, roomLabel, comment];
}

String? _blank(String? value) => (value == null || value.trim().isEmpty) ? null : value.trim();
