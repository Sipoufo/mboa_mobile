// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evidence_photo_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EvidencePhotoResponseRoomEnum
_$evidencePhotoResponseRoomEnum_LIVING_ROOM =
    const EvidencePhotoResponseRoomEnum._('LIVING_ROOM');
const EvidencePhotoResponseRoomEnum _$evidencePhotoResponseRoomEnum_BEDROOM =
    const EvidencePhotoResponseRoomEnum._('BEDROOM');
const EvidencePhotoResponseRoomEnum _$evidencePhotoResponseRoomEnum_KITCHEN =
    const EvidencePhotoResponseRoomEnum._('KITCHEN');
const EvidencePhotoResponseRoomEnum _$evidencePhotoResponseRoomEnum_BATHROOM =
    const EvidencePhotoResponseRoomEnum._('BATHROOM');
const EvidencePhotoResponseRoomEnum _$evidencePhotoResponseRoomEnum_TOILET =
    const EvidencePhotoResponseRoomEnum._('TOILET');
const EvidencePhotoResponseRoomEnum _$evidencePhotoResponseRoomEnum_OUTDOOR =
    const EvidencePhotoResponseRoomEnum._('OUTDOOR');
const EvidencePhotoResponseRoomEnum _$evidencePhotoResponseRoomEnum_OTHER =
    const EvidencePhotoResponseRoomEnum._('OTHER');
const EvidencePhotoResponseRoomEnum
_$evidencePhotoResponseRoomEnum_unknownDefaultOpenApi =
    const EvidencePhotoResponseRoomEnum._('unknownDefaultOpenApi');

EvidencePhotoResponseRoomEnum _$evidencePhotoResponseRoomEnumValueOf(
  String name,
) {
  switch (name) {
    case 'LIVING_ROOM':
      return _$evidencePhotoResponseRoomEnum_LIVING_ROOM;
    case 'BEDROOM':
      return _$evidencePhotoResponseRoomEnum_BEDROOM;
    case 'KITCHEN':
      return _$evidencePhotoResponseRoomEnum_KITCHEN;
    case 'BATHROOM':
      return _$evidencePhotoResponseRoomEnum_BATHROOM;
    case 'TOILET':
      return _$evidencePhotoResponseRoomEnum_TOILET;
    case 'OUTDOOR':
      return _$evidencePhotoResponseRoomEnum_OUTDOOR;
    case 'OTHER':
      return _$evidencePhotoResponseRoomEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$evidencePhotoResponseRoomEnum_unknownDefaultOpenApi;
    default:
      return _$evidencePhotoResponseRoomEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<EvidencePhotoResponseRoomEnum>
_$evidencePhotoResponseRoomEnumValues = BuiltSet<EvidencePhotoResponseRoomEnum>(
  const <EvidencePhotoResponseRoomEnum>[
    _$evidencePhotoResponseRoomEnum_LIVING_ROOM,
    _$evidencePhotoResponseRoomEnum_BEDROOM,
    _$evidencePhotoResponseRoomEnum_KITCHEN,
    _$evidencePhotoResponseRoomEnum_BATHROOM,
    _$evidencePhotoResponseRoomEnum_TOILET,
    _$evidencePhotoResponseRoomEnum_OUTDOOR,
    _$evidencePhotoResponseRoomEnum_OTHER,
    _$evidencePhotoResponseRoomEnum_unknownDefaultOpenApi,
  ],
);

const EvidencePhotoResponsePhaseEnum _$evidencePhotoResponsePhaseEnum_ENTRY =
    const EvidencePhotoResponsePhaseEnum._('ENTRY');
const EvidencePhotoResponsePhaseEnum _$evidencePhotoResponsePhaseEnum_STAY =
    const EvidencePhotoResponsePhaseEnum._('STAY');
const EvidencePhotoResponsePhaseEnum _$evidencePhotoResponsePhaseEnum_EXIT =
    const EvidencePhotoResponsePhaseEnum._('EXIT');
const EvidencePhotoResponsePhaseEnum
_$evidencePhotoResponsePhaseEnum_unknownDefaultOpenApi =
    const EvidencePhotoResponsePhaseEnum._('unknownDefaultOpenApi');

EvidencePhotoResponsePhaseEnum _$evidencePhotoResponsePhaseEnumValueOf(
  String name,
) {
  switch (name) {
    case 'ENTRY':
      return _$evidencePhotoResponsePhaseEnum_ENTRY;
    case 'STAY':
      return _$evidencePhotoResponsePhaseEnum_STAY;
    case 'EXIT':
      return _$evidencePhotoResponsePhaseEnum_EXIT;
    case 'unknownDefaultOpenApi':
      return _$evidencePhotoResponsePhaseEnum_unknownDefaultOpenApi;
    default:
      return _$evidencePhotoResponsePhaseEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<EvidencePhotoResponsePhaseEnum>
_$evidencePhotoResponsePhaseEnumValues =
    BuiltSet<EvidencePhotoResponsePhaseEnum>(
      const <EvidencePhotoResponsePhaseEnum>[
        _$evidencePhotoResponsePhaseEnum_ENTRY,
        _$evidencePhotoResponsePhaseEnum_STAY,
        _$evidencePhotoResponsePhaseEnum_EXIT,
        _$evidencePhotoResponsePhaseEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<EvidencePhotoResponseRoomEnum>
_$evidencePhotoResponseRoomEnumSerializer =
    _$EvidencePhotoResponseRoomEnumSerializer();
Serializer<EvidencePhotoResponsePhaseEnum>
_$evidencePhotoResponsePhaseEnumSerializer =
    _$EvidencePhotoResponsePhaseEnumSerializer();

class _$EvidencePhotoResponseRoomEnumSerializer
    implements PrimitiveSerializer<EvidencePhotoResponseRoomEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'LIVING_ROOM': 'LIVING_ROOM',
    'BEDROOM': 'BEDROOM',
    'KITCHEN': 'KITCHEN',
    'BATHROOM': 'BATHROOM',
    'TOILET': 'TOILET',
    'OUTDOOR': 'OUTDOOR',
    'OTHER': 'OTHER',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'LIVING_ROOM': 'LIVING_ROOM',
    'BEDROOM': 'BEDROOM',
    'KITCHEN': 'KITCHEN',
    'BATHROOM': 'BATHROOM',
    'TOILET': 'TOILET',
    'OUTDOOR': 'OUTDOOR',
    'OTHER': 'OTHER',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[EvidencePhotoResponseRoomEnum];
  @override
  final String wireName = 'EvidencePhotoResponseRoomEnum';

  @override
  Object serialize(
    Serializers serializers,
    EvidencePhotoResponseRoomEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  EvidencePhotoResponseRoomEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => EvidencePhotoResponseRoomEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$EvidencePhotoResponsePhaseEnumSerializer
    implements PrimitiveSerializer<EvidencePhotoResponsePhaseEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ENTRY': 'ENTRY',
    'STAY': 'STAY',
    'EXIT': 'EXIT',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ENTRY': 'ENTRY',
    'STAY': 'STAY',
    'EXIT': 'EXIT',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[EvidencePhotoResponsePhaseEnum];
  @override
  final String wireName = 'EvidencePhotoResponsePhaseEnum';

  @override
  Object serialize(
    Serializers serializers,
    EvidencePhotoResponsePhaseEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  EvidencePhotoResponsePhaseEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => EvidencePhotoResponsePhaseEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$EvidencePhotoResponse extends EvidencePhotoResponse {
  @override
  final String? id;
  @override
  final EvidencePhotoResponseRoomEnum? room;
  @override
  final String? roomLabel;
  @override
  final EvidencePhotoResponsePhaseEnum? phase;
  @override
  final String? comment;
  @override
  final String? sha256;
  @override
  final int? sizeBytes;
  @override
  final DateTime? recordedAt;
  @override
  final String? downloadUrl;

  factory _$EvidencePhotoResponse([
    void Function(EvidencePhotoResponseBuilder)? updates,
  ]) => (EvidencePhotoResponseBuilder()..update(updates))._build();

  _$EvidencePhotoResponse._({
    this.id,
    this.room,
    this.roomLabel,
    this.phase,
    this.comment,
    this.sha256,
    this.sizeBytes,
    this.recordedAt,
    this.downloadUrl,
  }) : super._();
  @override
  EvidencePhotoResponse rebuild(
    void Function(EvidencePhotoResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EvidencePhotoResponseBuilder toBuilder() =>
      EvidencePhotoResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EvidencePhotoResponse &&
        id == other.id &&
        room == other.room &&
        roomLabel == other.roomLabel &&
        phase == other.phase &&
        comment == other.comment &&
        sha256 == other.sha256 &&
        sizeBytes == other.sizeBytes &&
        recordedAt == other.recordedAt &&
        downloadUrl == other.downloadUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, room.hashCode);
    _$hash = $jc(_$hash, roomLabel.hashCode);
    _$hash = $jc(_$hash, phase.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, sha256.hashCode);
    _$hash = $jc(_$hash, sizeBytes.hashCode);
    _$hash = $jc(_$hash, recordedAt.hashCode);
    _$hash = $jc(_$hash, downloadUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EvidencePhotoResponse')
          ..add('id', id)
          ..add('room', room)
          ..add('roomLabel', roomLabel)
          ..add('phase', phase)
          ..add('comment', comment)
          ..add('sha256', sha256)
          ..add('sizeBytes', sizeBytes)
          ..add('recordedAt', recordedAt)
          ..add('downloadUrl', downloadUrl))
        .toString();
  }
}

class EvidencePhotoResponseBuilder
    implements Builder<EvidencePhotoResponse, EvidencePhotoResponseBuilder> {
  _$EvidencePhotoResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  EvidencePhotoResponseRoomEnum? _room;
  EvidencePhotoResponseRoomEnum? get room => _$this._room;
  set room(EvidencePhotoResponseRoomEnum? room) => _$this._room = room;

  String? _roomLabel;
  String? get roomLabel => _$this._roomLabel;
  set roomLabel(String? roomLabel) => _$this._roomLabel = roomLabel;

  EvidencePhotoResponsePhaseEnum? _phase;
  EvidencePhotoResponsePhaseEnum? get phase => _$this._phase;
  set phase(EvidencePhotoResponsePhaseEnum? phase) => _$this._phase = phase;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  String? _sha256;
  String? get sha256 => _$this._sha256;
  set sha256(String? sha256) => _$this._sha256 = sha256;

  int? _sizeBytes;
  int? get sizeBytes => _$this._sizeBytes;
  set sizeBytes(int? sizeBytes) => _$this._sizeBytes = sizeBytes;

  DateTime? _recordedAt;
  DateTime? get recordedAt => _$this._recordedAt;
  set recordedAt(DateTime? recordedAt) => _$this._recordedAt = recordedAt;

  String? _downloadUrl;
  String? get downloadUrl => _$this._downloadUrl;
  set downloadUrl(String? downloadUrl) => _$this._downloadUrl = downloadUrl;

  EvidencePhotoResponseBuilder() {
    EvidencePhotoResponse._defaults(this);
  }

  EvidencePhotoResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _room = $v.room;
      _roomLabel = $v.roomLabel;
      _phase = $v.phase;
      _comment = $v.comment;
      _sha256 = $v.sha256;
      _sizeBytes = $v.sizeBytes;
      _recordedAt = $v.recordedAt;
      _downloadUrl = $v.downloadUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EvidencePhotoResponse other) {
    _$v = other as _$EvidencePhotoResponse;
  }

  @override
  void update(void Function(EvidencePhotoResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EvidencePhotoResponse build() => _build();

  _$EvidencePhotoResponse _build() {
    final _$result =
        _$v ??
        _$EvidencePhotoResponse._(
          id: id,
          room: room,
          roomLabel: roomLabel,
          phase: phase,
          comment: comment,
          sha256: sha256,
          sizeBytes: sizeBytes,
          recordedAt: recordedAt,
          downloadUrl: downloadUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
