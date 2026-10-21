// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_request_event_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HomeRequestEventResponseStatusEnum
_$homeRequestEventResponseStatusEnum_SENT =
    const HomeRequestEventResponseStatusEnum._('SENT');
const HomeRequestEventResponseStatusEnum
_$homeRequestEventResponseStatusEnum_SEEN =
    const HomeRequestEventResponseStatusEnum._('SEEN');
const HomeRequestEventResponseStatusEnum
_$homeRequestEventResponseStatusEnum_IN_PROGRESS =
    const HomeRequestEventResponseStatusEnum._('IN_PROGRESS');
const HomeRequestEventResponseStatusEnum
_$homeRequestEventResponseStatusEnum_RESOLVED =
    const HomeRequestEventResponseStatusEnum._('RESOLVED');
const HomeRequestEventResponseStatusEnum
_$homeRequestEventResponseStatusEnum_CLOSED =
    const HomeRequestEventResponseStatusEnum._('CLOSED');
const HomeRequestEventResponseStatusEnum
_$homeRequestEventResponseStatusEnum_unknownDefaultOpenApi =
    const HomeRequestEventResponseStatusEnum._('unknownDefaultOpenApi');

HomeRequestEventResponseStatusEnum _$homeRequestEventResponseStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'SENT':
      return _$homeRequestEventResponseStatusEnum_SENT;
    case 'SEEN':
      return _$homeRequestEventResponseStatusEnum_SEEN;
    case 'IN_PROGRESS':
      return _$homeRequestEventResponseStatusEnum_IN_PROGRESS;
    case 'RESOLVED':
      return _$homeRequestEventResponseStatusEnum_RESOLVED;
    case 'CLOSED':
      return _$homeRequestEventResponseStatusEnum_CLOSED;
    case 'unknownDefaultOpenApi':
      return _$homeRequestEventResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$homeRequestEventResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<HomeRequestEventResponseStatusEnum>
_$homeRequestEventResponseStatusEnumValues =
    BuiltSet<HomeRequestEventResponseStatusEnum>(
      const <HomeRequestEventResponseStatusEnum>[
        _$homeRequestEventResponseStatusEnum_SENT,
        _$homeRequestEventResponseStatusEnum_SEEN,
        _$homeRequestEventResponseStatusEnum_IN_PROGRESS,
        _$homeRequestEventResponseStatusEnum_RESOLVED,
        _$homeRequestEventResponseStatusEnum_CLOSED,
        _$homeRequestEventResponseStatusEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<HomeRequestEventResponseStatusEnum>
_$homeRequestEventResponseStatusEnumSerializer =
    _$HomeRequestEventResponseStatusEnumSerializer();

class _$HomeRequestEventResponseStatusEnumSerializer
    implements PrimitiveSerializer<HomeRequestEventResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SENT': 'SENT',
    'SEEN': 'SEEN',
    'IN_PROGRESS': 'IN_PROGRESS',
    'RESOLVED': 'RESOLVED',
    'CLOSED': 'CLOSED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SENT': 'SENT',
    'SEEN': 'SEEN',
    'IN_PROGRESS': 'IN_PROGRESS',
    'RESOLVED': 'RESOLVED',
    'CLOSED': 'CLOSED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[HomeRequestEventResponseStatusEnum];
  @override
  final String wireName = 'HomeRequestEventResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HomeRequestEventResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HomeRequestEventResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HomeRequestEventResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HomeRequestEventResponse extends HomeRequestEventResponse {
  @override
  final HomeRequestEventResponseStatusEnum? status;
  @override
  final bool? byLandlord;
  @override
  final String? note;
  @override
  final DateTime? at;

  factory _$HomeRequestEventResponse([
    void Function(HomeRequestEventResponseBuilder)? updates,
  ]) => (HomeRequestEventResponseBuilder()..update(updates))._build();

  _$HomeRequestEventResponse._({
    this.status,
    this.byLandlord,
    this.note,
    this.at,
  }) : super._();
  @override
  HomeRequestEventResponse rebuild(
    void Function(HomeRequestEventResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HomeRequestEventResponseBuilder toBuilder() =>
      HomeRequestEventResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeRequestEventResponse &&
        status == other.status &&
        byLandlord == other.byLandlord &&
        note == other.note &&
        at == other.at;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, byLandlord.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, at.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeRequestEventResponse')
          ..add('status', status)
          ..add('byLandlord', byLandlord)
          ..add('note', note)
          ..add('at', at))
        .toString();
  }
}

class HomeRequestEventResponseBuilder
    implements
        Builder<HomeRequestEventResponse, HomeRequestEventResponseBuilder> {
  _$HomeRequestEventResponse? _$v;

  HomeRequestEventResponseStatusEnum? _status;
  HomeRequestEventResponseStatusEnum? get status => _$this._status;
  set status(HomeRequestEventResponseStatusEnum? status) =>
      _$this._status = status;

  bool? _byLandlord;
  bool? get byLandlord => _$this._byLandlord;
  set byLandlord(bool? byLandlord) => _$this._byLandlord = byLandlord;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  DateTime? _at;
  DateTime? get at => _$this._at;
  set at(DateTime? at) => _$this._at = at;

  HomeRequestEventResponseBuilder() {
    HomeRequestEventResponse._defaults(this);
  }

  HomeRequestEventResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _byLandlord = $v.byLandlord;
      _note = $v.note;
      _at = $v.at;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeRequestEventResponse other) {
    _$v = other as _$HomeRequestEventResponse;
  }

  @override
  void update(void Function(HomeRequestEventResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeRequestEventResponse build() => _build();

  _$HomeRequestEventResponse _build() {
    final _$result =
        _$v ??
        _$HomeRequestEventResponse._(
          status: status,
          byLandlord: byLandlord,
          note: note,
          at: at,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
