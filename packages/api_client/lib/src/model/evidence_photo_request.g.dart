// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evidence_photo_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EvidencePhotoRequestRoomEnum _$evidencePhotoRequestRoomEnum_LIVING_ROOM =
    const EvidencePhotoRequestRoomEnum._('LIVING_ROOM');
const EvidencePhotoRequestRoomEnum _$evidencePhotoRequestRoomEnum_BEDROOM =
    const EvidencePhotoRequestRoomEnum._('BEDROOM');
const EvidencePhotoRequestRoomEnum _$evidencePhotoRequestRoomEnum_KITCHEN =
    const EvidencePhotoRequestRoomEnum._('KITCHEN');
const EvidencePhotoRequestRoomEnum _$evidencePhotoRequestRoomEnum_BATHROOM =
    const EvidencePhotoRequestRoomEnum._('BATHROOM');
const EvidencePhotoRequestRoomEnum _$evidencePhotoRequestRoomEnum_TOILET =
    const EvidencePhotoRequestRoomEnum._('TOILET');
const EvidencePhotoRequestRoomEnum _$evidencePhotoRequestRoomEnum_OUTDOOR =
    const EvidencePhotoRequestRoomEnum._('OUTDOOR');
const EvidencePhotoRequestRoomEnum _$evidencePhotoRequestRoomEnum_OTHER =
    const EvidencePhotoRequestRoomEnum._('OTHER');
const EvidencePhotoRequestRoomEnum
_$evidencePhotoRequestRoomEnum_unknownDefaultOpenApi =
    const EvidencePhotoRequestRoomEnum._('unknownDefaultOpenApi');

EvidencePhotoRequestRoomEnum _$evidencePhotoRequestRoomEnumValueOf(
  String name,
) {
  switch (name) {
    case 'LIVING_ROOM':
      return _$evidencePhotoRequestRoomEnum_LIVING_ROOM;
    case 'BEDROOM':
      return _$evidencePhotoRequestRoomEnum_BEDROOM;
    case 'KITCHEN':
      return _$evidencePhotoRequestRoomEnum_KITCHEN;
    case 'BATHROOM':
      return _$evidencePhotoRequestRoomEnum_BATHROOM;
    case 'TOILET':
      return _$evidencePhotoRequestRoomEnum_TOILET;
    case 'OUTDOOR':
      return _$evidencePhotoRequestRoomEnum_OUTDOOR;
    case 'OTHER':
      return _$evidencePhotoRequestRoomEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$evidencePhotoRequestRoomEnum_unknownDefaultOpenApi;
    default:
      return _$evidencePhotoRequestRoomEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<EvidencePhotoRequestRoomEnum>
_$evidencePhotoRequestRoomEnumValues =
    BuiltSet<EvidencePhotoRequestRoomEnum>(const <EvidencePhotoRequestRoomEnum>[
      _$evidencePhotoRequestRoomEnum_LIVING_ROOM,
      _$evidencePhotoRequestRoomEnum_BEDROOM,
      _$evidencePhotoRequestRoomEnum_KITCHEN,
      _$evidencePhotoRequestRoomEnum_BATHROOM,
      _$evidencePhotoRequestRoomEnum_TOILET,
      _$evidencePhotoRequestRoomEnum_OUTDOOR,
      _$evidencePhotoRequestRoomEnum_OTHER,
      _$evidencePhotoRequestRoomEnum_unknownDefaultOpenApi,
    ]);

const EvidencePhotoRequestPhaseEnum _$evidencePhotoRequestPhaseEnum_ENTRY =
    const EvidencePhotoRequestPhaseEnum._('ENTRY');
const EvidencePhotoRequestPhaseEnum _$evidencePhotoRequestPhaseEnum_STAY =
    const EvidencePhotoRequestPhaseEnum._('STAY');
const EvidencePhotoRequestPhaseEnum _$evidencePhotoRequestPhaseEnum_EXIT =
    const EvidencePhotoRequestPhaseEnum._('EXIT');
const EvidencePhotoRequestPhaseEnum
_$evidencePhotoRequestPhaseEnum_unknownDefaultOpenApi =
    const EvidencePhotoRequestPhaseEnum._('unknownDefaultOpenApi');

EvidencePhotoRequestPhaseEnum _$evidencePhotoRequestPhaseEnumValueOf(
  String name,
) {
  switch (name) {
    case 'ENTRY':
      return _$evidencePhotoRequestPhaseEnum_ENTRY;
    case 'STAY':
      return _$evidencePhotoRequestPhaseEnum_STAY;
    case 'EXIT':
      return _$evidencePhotoRequestPhaseEnum_EXIT;
    case 'unknownDefaultOpenApi':
      return _$evidencePhotoRequestPhaseEnum_unknownDefaultOpenApi;
    default:
      return _$evidencePhotoRequestPhaseEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<EvidencePhotoRequestPhaseEnum>
_$evidencePhotoRequestPhaseEnumValues = BuiltSet<EvidencePhotoRequestPhaseEnum>(
  const <EvidencePhotoRequestPhaseEnum>[
    _$evidencePhotoRequestPhaseEnum_ENTRY,
    _$evidencePhotoRequestPhaseEnum_STAY,
    _$evidencePhotoRequestPhaseEnum_EXIT,
    _$evidencePhotoRequestPhaseEnum_unknownDefaultOpenApi,
  ],
);

Serializer<EvidencePhotoRequestRoomEnum>
_$evidencePhotoRequestRoomEnumSerializer =
    _$EvidencePhotoRequestRoomEnumSerializer();
Serializer<EvidencePhotoRequestPhaseEnum>
_$evidencePhotoRequestPhaseEnumSerializer =
    _$EvidencePhotoRequestPhaseEnumSerializer();

class _$EvidencePhotoRequestRoomEnumSerializer
    implements PrimitiveSerializer<EvidencePhotoRequestRoomEnum> {
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
  final Iterable<Type> types = const <Type>[EvidencePhotoRequestRoomEnum];
  @override
  final String wireName = 'EvidencePhotoRequestRoomEnum';

  @override
  Object serialize(
    Serializers serializers,
    EvidencePhotoRequestRoomEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  EvidencePhotoRequestRoomEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => EvidencePhotoRequestRoomEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$EvidencePhotoRequestPhaseEnumSerializer
    implements PrimitiveSerializer<EvidencePhotoRequestPhaseEnum> {
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
  final Iterable<Type> types = const <Type>[EvidencePhotoRequestPhaseEnum];
  @override
  final String wireName = 'EvidencePhotoRequestPhaseEnum';

  @override
  Object serialize(
    Serializers serializers,
    EvidencePhotoRequestPhaseEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  EvidencePhotoRequestPhaseEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => EvidencePhotoRequestPhaseEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$EvidencePhotoRequest extends EvidencePhotoRequest {
  @override
  final String objectKey;
  @override
  final String sha256;
  @override
  final EvidencePhotoRequestRoomEnum room;
  @override
  final String? roomLabel;
  @override
  final EvidencePhotoRequestPhaseEnum phase;
  @override
  final String? comment;

  factory _$EvidencePhotoRequest([
    void Function(EvidencePhotoRequestBuilder)? updates,
  ]) => (EvidencePhotoRequestBuilder()..update(updates))._build();

  _$EvidencePhotoRequest._({
    required this.objectKey,
    required this.sha256,
    required this.room,
    this.roomLabel,
    required this.phase,
    this.comment,
  }) : super._();
  @override
  EvidencePhotoRequest rebuild(
    void Function(EvidencePhotoRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EvidencePhotoRequestBuilder toBuilder() =>
      EvidencePhotoRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EvidencePhotoRequest &&
        objectKey == other.objectKey &&
        sha256 == other.sha256 &&
        room == other.room &&
        roomLabel == other.roomLabel &&
        phase == other.phase &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, objectKey.hashCode);
    _$hash = $jc(_$hash, sha256.hashCode);
    _$hash = $jc(_$hash, room.hashCode);
    _$hash = $jc(_$hash, roomLabel.hashCode);
    _$hash = $jc(_$hash, phase.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EvidencePhotoRequest')
          ..add('objectKey', objectKey)
          ..add('sha256', sha256)
          ..add('room', room)
          ..add('roomLabel', roomLabel)
          ..add('phase', phase)
          ..add('comment', comment))
        .toString();
  }
}

class EvidencePhotoRequestBuilder
    implements Builder<EvidencePhotoRequest, EvidencePhotoRequestBuilder> {
  _$EvidencePhotoRequest? _$v;

  String? _objectKey;
  String? get objectKey => _$this._objectKey;
  set objectKey(String? objectKey) => _$this._objectKey = objectKey;

  String? _sha256;
  String? get sha256 => _$this._sha256;
  set sha256(String? sha256) => _$this._sha256 = sha256;

  EvidencePhotoRequestRoomEnum? _room;
  EvidencePhotoRequestRoomEnum? get room => _$this._room;
  set room(EvidencePhotoRequestRoomEnum? room) => _$this._room = room;

  String? _roomLabel;
  String? get roomLabel => _$this._roomLabel;
  set roomLabel(String? roomLabel) => _$this._roomLabel = roomLabel;

  EvidencePhotoRequestPhaseEnum? _phase;
  EvidencePhotoRequestPhaseEnum? get phase => _$this._phase;
  set phase(EvidencePhotoRequestPhaseEnum? phase) => _$this._phase = phase;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  EvidencePhotoRequestBuilder() {
    EvidencePhotoRequest._defaults(this);
  }

  EvidencePhotoRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _objectKey = $v.objectKey;
      _sha256 = $v.sha256;
      _room = $v.room;
      _roomLabel = $v.roomLabel;
      _phase = $v.phase;
      _comment = $v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EvidencePhotoRequest other) {
    _$v = other as _$EvidencePhotoRequest;
  }

  @override
  void update(void Function(EvidencePhotoRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EvidencePhotoRequest build() => _build();

  _$EvidencePhotoRequest _build() {
    final _$result =
        _$v ??
        _$EvidencePhotoRequest._(
          objectKey: BuiltValueNullFieldError.checkNotNull(
            objectKey,
            r'EvidencePhotoRequest',
            'objectKey',
          ),
          sha256: BuiltValueNullFieldError.checkNotNull(
            sha256,
            r'EvidencePhotoRequest',
            'sha256',
          ),
          room: BuiltValueNullFieldError.checkNotNull(
            room,
            r'EvidencePhotoRequest',
            'room',
          ),
          roomLabel: roomLabel,
          phase: BuiltValueNullFieldError.checkNotNull(
            phase,
            r'EvidencePhotoRequest',
            'phase',
          ),
          comment: comment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
