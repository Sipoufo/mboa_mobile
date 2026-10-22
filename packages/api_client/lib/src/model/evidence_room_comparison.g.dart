// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evidence_room_comparison.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EvidenceRoomComparisonRoomEnum
_$evidenceRoomComparisonRoomEnum_LIVING_ROOM =
    const EvidenceRoomComparisonRoomEnum._('LIVING_ROOM');
const EvidenceRoomComparisonRoomEnum _$evidenceRoomComparisonRoomEnum_BEDROOM =
    const EvidenceRoomComparisonRoomEnum._('BEDROOM');
const EvidenceRoomComparisonRoomEnum _$evidenceRoomComparisonRoomEnum_KITCHEN =
    const EvidenceRoomComparisonRoomEnum._('KITCHEN');
const EvidenceRoomComparisonRoomEnum _$evidenceRoomComparisonRoomEnum_BATHROOM =
    const EvidenceRoomComparisonRoomEnum._('BATHROOM');
const EvidenceRoomComparisonRoomEnum _$evidenceRoomComparisonRoomEnum_TOILET =
    const EvidenceRoomComparisonRoomEnum._('TOILET');
const EvidenceRoomComparisonRoomEnum _$evidenceRoomComparisonRoomEnum_OUTDOOR =
    const EvidenceRoomComparisonRoomEnum._('OUTDOOR');
const EvidenceRoomComparisonRoomEnum _$evidenceRoomComparisonRoomEnum_OTHER =
    const EvidenceRoomComparisonRoomEnum._('OTHER');
const EvidenceRoomComparisonRoomEnum
_$evidenceRoomComparisonRoomEnum_unknownDefaultOpenApi =
    const EvidenceRoomComparisonRoomEnum._('unknownDefaultOpenApi');

EvidenceRoomComparisonRoomEnum _$evidenceRoomComparisonRoomEnumValueOf(
  String name,
) {
  switch (name) {
    case 'LIVING_ROOM':
      return _$evidenceRoomComparisonRoomEnum_LIVING_ROOM;
    case 'BEDROOM':
      return _$evidenceRoomComparisonRoomEnum_BEDROOM;
    case 'KITCHEN':
      return _$evidenceRoomComparisonRoomEnum_KITCHEN;
    case 'BATHROOM':
      return _$evidenceRoomComparisonRoomEnum_BATHROOM;
    case 'TOILET':
      return _$evidenceRoomComparisonRoomEnum_TOILET;
    case 'OUTDOOR':
      return _$evidenceRoomComparisonRoomEnum_OUTDOOR;
    case 'OTHER':
      return _$evidenceRoomComparisonRoomEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$evidenceRoomComparisonRoomEnum_unknownDefaultOpenApi;
    default:
      return _$evidenceRoomComparisonRoomEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<EvidenceRoomComparisonRoomEnum>
_$evidenceRoomComparisonRoomEnumValues =
    BuiltSet<EvidenceRoomComparisonRoomEnum>(
      const <EvidenceRoomComparisonRoomEnum>[
        _$evidenceRoomComparisonRoomEnum_LIVING_ROOM,
        _$evidenceRoomComparisonRoomEnum_BEDROOM,
        _$evidenceRoomComparisonRoomEnum_KITCHEN,
        _$evidenceRoomComparisonRoomEnum_BATHROOM,
        _$evidenceRoomComparisonRoomEnum_TOILET,
        _$evidenceRoomComparisonRoomEnum_OUTDOOR,
        _$evidenceRoomComparisonRoomEnum_OTHER,
        _$evidenceRoomComparisonRoomEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<EvidenceRoomComparisonRoomEnum>
_$evidenceRoomComparisonRoomEnumSerializer =
    _$EvidenceRoomComparisonRoomEnumSerializer();

class _$EvidenceRoomComparisonRoomEnumSerializer
    implements PrimitiveSerializer<EvidenceRoomComparisonRoomEnum> {
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
  final Iterable<Type> types = const <Type>[EvidenceRoomComparisonRoomEnum];
  @override
  final String wireName = 'EvidenceRoomComparisonRoomEnum';

  @override
  Object serialize(
    Serializers serializers,
    EvidenceRoomComparisonRoomEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  EvidenceRoomComparisonRoomEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => EvidenceRoomComparisonRoomEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$EvidenceRoomComparison extends EvidenceRoomComparison {
  @override
  final EvidenceRoomComparisonRoomEnum? room;
  @override
  final String? roomLabel;
  @override
  final BuiltList<EvidencePhotoResponse>? entry;
  @override
  final BuiltList<EvidencePhotoResponse>? exit;

  factory _$EvidenceRoomComparison([
    void Function(EvidenceRoomComparisonBuilder)? updates,
  ]) => (EvidenceRoomComparisonBuilder()..update(updates))._build();

  _$EvidenceRoomComparison._({this.room, this.roomLabel, this.entry, this.exit})
    : super._();
  @override
  EvidenceRoomComparison rebuild(
    void Function(EvidenceRoomComparisonBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EvidenceRoomComparisonBuilder toBuilder() =>
      EvidenceRoomComparisonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EvidenceRoomComparison &&
        room == other.room &&
        roomLabel == other.roomLabel &&
        entry == other.entry &&
        exit == other.exit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, room.hashCode);
    _$hash = $jc(_$hash, roomLabel.hashCode);
    _$hash = $jc(_$hash, entry.hashCode);
    _$hash = $jc(_$hash, exit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EvidenceRoomComparison')
          ..add('room', room)
          ..add('roomLabel', roomLabel)
          ..add('entry', entry)
          ..add('exit', exit))
        .toString();
  }
}

class EvidenceRoomComparisonBuilder
    implements Builder<EvidenceRoomComparison, EvidenceRoomComparisonBuilder> {
  _$EvidenceRoomComparison? _$v;

  EvidenceRoomComparisonRoomEnum? _room;
  EvidenceRoomComparisonRoomEnum? get room => _$this._room;
  set room(EvidenceRoomComparisonRoomEnum? room) => _$this._room = room;

  String? _roomLabel;
  String? get roomLabel => _$this._roomLabel;
  set roomLabel(String? roomLabel) => _$this._roomLabel = roomLabel;

  ListBuilder<EvidencePhotoResponse>? _entry;
  ListBuilder<EvidencePhotoResponse> get entry =>
      _$this._entry ??= ListBuilder<EvidencePhotoResponse>();
  set entry(ListBuilder<EvidencePhotoResponse>? entry) => _$this._entry = entry;

  ListBuilder<EvidencePhotoResponse>? _exit;
  ListBuilder<EvidencePhotoResponse> get exit =>
      _$this._exit ??= ListBuilder<EvidencePhotoResponse>();
  set exit(ListBuilder<EvidencePhotoResponse>? exit) => _$this._exit = exit;

  EvidenceRoomComparisonBuilder() {
    EvidenceRoomComparison._defaults(this);
  }

  EvidenceRoomComparisonBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _room = $v.room;
      _roomLabel = $v.roomLabel;
      _entry = $v.entry?.toBuilder();
      _exit = $v.exit?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EvidenceRoomComparison other) {
    _$v = other as _$EvidenceRoomComparison;
  }

  @override
  void update(void Function(EvidenceRoomComparisonBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EvidenceRoomComparison build() => _build();

  _$EvidenceRoomComparison _build() {
    _$EvidenceRoomComparison _$result;
    try {
      _$result =
          _$v ??
          _$EvidenceRoomComparison._(
            room: room,
            roomLabel: roomLabel,
            entry: _entry?.build(),
            exit: _exit?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'entry';
        _entry?.build();
        _$failedField = 'exit';
        _exit?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EvidenceRoomComparison',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
