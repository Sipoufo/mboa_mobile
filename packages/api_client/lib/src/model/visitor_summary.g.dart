// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const VisitorSummaryKindEnum _$visitorSummaryKindEnum_AGENT =
    const VisitorSummaryKindEnum._('AGENT');
const VisitorSummaryKindEnum _$visitorSummaryKindEnum_OWNER =
    const VisitorSummaryKindEnum._('OWNER');
const VisitorSummaryKindEnum _$visitorSummaryKindEnum_unknownDefaultOpenApi =
    const VisitorSummaryKindEnum._('unknownDefaultOpenApi');

VisitorSummaryKindEnum _$visitorSummaryKindEnumValueOf(String name) {
  switch (name) {
    case 'AGENT':
      return _$visitorSummaryKindEnum_AGENT;
    case 'OWNER':
      return _$visitorSummaryKindEnum_OWNER;
    case 'unknownDefaultOpenApi':
      return _$visitorSummaryKindEnum_unknownDefaultOpenApi;
    default:
      return _$visitorSummaryKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<VisitorSummaryKindEnum> _$visitorSummaryKindEnumValues =
    BuiltSet<VisitorSummaryKindEnum>(const <VisitorSummaryKindEnum>[
      _$visitorSummaryKindEnum_AGENT,
      _$visitorSummaryKindEnum_OWNER,
      _$visitorSummaryKindEnum_unknownDefaultOpenApi,
    ]);

Serializer<VisitorSummaryKindEnum> _$visitorSummaryKindEnumSerializer =
    _$VisitorSummaryKindEnumSerializer();

class _$VisitorSummaryKindEnumSerializer
    implements PrimitiveSerializer<VisitorSummaryKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'AGENT': 'AGENT',
    'OWNER': 'OWNER',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'AGENT': 'AGENT',
    'OWNER': 'OWNER',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[VisitorSummaryKindEnum];
  @override
  final String wireName = 'VisitorSummaryKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    VisitorSummaryKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  VisitorSummaryKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => VisitorSummaryKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$VisitorSummary extends VisitorSummary {
  @override
  final VisitorSummaryKindEnum? kind;
  @override
  final String? agentId;
  @override
  final String? displayName;
  @override
  final String? photoKey;

  factory _$VisitorSummary([void Function(VisitorSummaryBuilder)? updates]) =>
      (VisitorSummaryBuilder()..update(updates))._build();

  _$VisitorSummary._({this.kind, this.agentId, this.displayName, this.photoKey})
    : super._();
  @override
  VisitorSummary rebuild(void Function(VisitorSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VisitorSummaryBuilder toBuilder() => VisitorSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VisitorSummary &&
        kind == other.kind &&
        agentId == other.agentId &&
        displayName == other.displayName &&
        photoKey == other.photoKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, agentId.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, photoKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VisitorSummary')
          ..add('kind', kind)
          ..add('agentId', agentId)
          ..add('displayName', displayName)
          ..add('photoKey', photoKey))
        .toString();
  }
}

class VisitorSummaryBuilder
    implements Builder<VisitorSummary, VisitorSummaryBuilder> {
  _$VisitorSummary? _$v;

  VisitorSummaryKindEnum? _kind;
  VisitorSummaryKindEnum? get kind => _$this._kind;
  set kind(VisitorSummaryKindEnum? kind) => _$this._kind = kind;

  String? _agentId;
  String? get agentId => _$this._agentId;
  set agentId(String? agentId) => _$this._agentId = agentId;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _photoKey;
  String? get photoKey => _$this._photoKey;
  set photoKey(String? photoKey) => _$this._photoKey = photoKey;

  VisitorSummaryBuilder() {
    VisitorSummary._defaults(this);
  }

  VisitorSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _kind = $v.kind;
      _agentId = $v.agentId;
      _displayName = $v.displayName;
      _photoKey = $v.photoKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VisitorSummary other) {
    _$v = other as _$VisitorSummary;
  }

  @override
  void update(void Function(VisitorSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VisitorSummary build() => _build();

  _$VisitorSummary _build() {
    final _$result =
        _$v ??
        _$VisitorSummary._(
          kind: kind,
          agentId: agentId,
          displayName: displayName,
          photoKey: photoKey,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
