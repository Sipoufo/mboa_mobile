// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adjustment_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdjustmentResponseKindEnum _$adjustmentResponseKindEnum_GRANT =
    const AdjustmentResponseKindEnum._('GRANT');
const AdjustmentResponseKindEnum _$adjustmentResponseKindEnum_EXTEND =
    const AdjustmentResponseKindEnum._('EXTEND');
const AdjustmentResponseKindEnum
_$adjustmentResponseKindEnum_unknownDefaultOpenApi =
    const AdjustmentResponseKindEnum._('unknownDefaultOpenApi');

AdjustmentResponseKindEnum _$adjustmentResponseKindEnumValueOf(String name) {
  switch (name) {
    case 'GRANT':
      return _$adjustmentResponseKindEnum_GRANT;
    case 'EXTEND':
      return _$adjustmentResponseKindEnum_EXTEND;
    case 'unknownDefaultOpenApi':
      return _$adjustmentResponseKindEnum_unknownDefaultOpenApi;
    default:
      return _$adjustmentResponseKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdjustmentResponseKindEnum> _$adjustmentResponseKindEnumValues =
    BuiltSet<AdjustmentResponseKindEnum>(const <AdjustmentResponseKindEnum>[
      _$adjustmentResponseKindEnum_GRANT,
      _$adjustmentResponseKindEnum_EXTEND,
      _$adjustmentResponseKindEnum_unknownDefaultOpenApi,
    ]);

const AdjustmentResponseTierEnum _$adjustmentResponseTierEnum_FREE =
    const AdjustmentResponseTierEnum._('FREE');
const AdjustmentResponseTierEnum _$adjustmentResponseTierEnum_BASIC_PLUS =
    const AdjustmentResponseTierEnum._('BASIC_PLUS');
const AdjustmentResponseTierEnum _$adjustmentResponseTierEnum_PRO =
    const AdjustmentResponseTierEnum._('PRO');
const AdjustmentResponseTierEnum _$adjustmentResponseTierEnum_PRO_PLUS =
    const AdjustmentResponseTierEnum._('PRO_PLUS');
const AdjustmentResponseTierEnum
_$adjustmentResponseTierEnum_unknownDefaultOpenApi =
    const AdjustmentResponseTierEnum._('unknownDefaultOpenApi');

AdjustmentResponseTierEnum _$adjustmentResponseTierEnumValueOf(String name) {
  switch (name) {
    case 'FREE':
      return _$adjustmentResponseTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$adjustmentResponseTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$adjustmentResponseTierEnum_PRO;
    case 'PRO_PLUS':
      return _$adjustmentResponseTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$adjustmentResponseTierEnum_unknownDefaultOpenApi;
    default:
      return _$adjustmentResponseTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdjustmentResponseTierEnum> _$adjustmentResponseTierEnumValues =
    BuiltSet<AdjustmentResponseTierEnum>(const <AdjustmentResponseTierEnum>[
      _$adjustmentResponseTierEnum_FREE,
      _$adjustmentResponseTierEnum_BASIC_PLUS,
      _$adjustmentResponseTierEnum_PRO,
      _$adjustmentResponseTierEnum_PRO_PLUS,
      _$adjustmentResponseTierEnum_unknownDefaultOpenApi,
    ]);

Serializer<AdjustmentResponseKindEnum> _$adjustmentResponseKindEnumSerializer =
    _$AdjustmentResponseKindEnumSerializer();
Serializer<AdjustmentResponseTierEnum> _$adjustmentResponseTierEnumSerializer =
    _$AdjustmentResponseTierEnumSerializer();

class _$AdjustmentResponseKindEnumSerializer
    implements PrimitiveSerializer<AdjustmentResponseKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'GRANT': 'GRANT',
    'EXTEND': 'EXTEND',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'GRANT': 'GRANT',
    'EXTEND': 'EXTEND',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AdjustmentResponseKindEnum];
  @override
  final String wireName = 'AdjustmentResponseKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdjustmentResponseKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdjustmentResponseKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdjustmentResponseKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdjustmentResponseTierEnumSerializer
    implements PrimitiveSerializer<AdjustmentResponseTierEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'FREE': 'FREE',
    'BASIC_PLUS': 'BASIC_PLUS',
    'PRO': 'PRO',
    'PRO_PLUS': 'PRO_PLUS',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'FREE': 'FREE',
    'BASIC_PLUS': 'BASIC_PLUS',
    'PRO': 'PRO',
    'PRO_PLUS': 'PRO_PLUS',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AdjustmentResponseTierEnum];
  @override
  final String wireName = 'AdjustmentResponseTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdjustmentResponseTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdjustmentResponseTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdjustmentResponseTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdjustmentResponse extends AdjustmentResponse {
  @override
  final String? id;
  @override
  final AdjustmentResponseKindEnum? kind;
  @override
  final AdjustmentResponseTierEnum? tier;
  @override
  final int? days;
  @override
  final String? reason;
  @override
  final String? adminAccountId;
  @override
  final DateTime? periodEndBefore;
  @override
  final DateTime? periodEndAfter;
  @override
  final DateTime? createdAt;

  factory _$AdjustmentResponse([
    void Function(AdjustmentResponseBuilder)? updates,
  ]) => (AdjustmentResponseBuilder()..update(updates))._build();

  _$AdjustmentResponse._({
    this.id,
    this.kind,
    this.tier,
    this.days,
    this.reason,
    this.adminAccountId,
    this.periodEndBefore,
    this.periodEndAfter,
    this.createdAt,
  }) : super._();
  @override
  AdjustmentResponse rebuild(
    void Function(AdjustmentResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdjustmentResponseBuilder toBuilder() =>
      AdjustmentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdjustmentResponse &&
        id == other.id &&
        kind == other.kind &&
        tier == other.tier &&
        days == other.days &&
        reason == other.reason &&
        adminAccountId == other.adminAccountId &&
        periodEndBefore == other.periodEndBefore &&
        periodEndAfter == other.periodEndAfter &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, days.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, adminAccountId.hashCode);
    _$hash = $jc(_$hash, periodEndBefore.hashCode);
    _$hash = $jc(_$hash, periodEndAfter.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdjustmentResponse')
          ..add('id', id)
          ..add('kind', kind)
          ..add('tier', tier)
          ..add('days', days)
          ..add('reason', reason)
          ..add('adminAccountId', adminAccountId)
          ..add('periodEndBefore', periodEndBefore)
          ..add('periodEndAfter', periodEndAfter)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class AdjustmentResponseBuilder
    implements Builder<AdjustmentResponse, AdjustmentResponseBuilder> {
  _$AdjustmentResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  AdjustmentResponseKindEnum? _kind;
  AdjustmentResponseKindEnum? get kind => _$this._kind;
  set kind(AdjustmentResponseKindEnum? kind) => _$this._kind = kind;

  AdjustmentResponseTierEnum? _tier;
  AdjustmentResponseTierEnum? get tier => _$this._tier;
  set tier(AdjustmentResponseTierEnum? tier) => _$this._tier = tier;

  int? _days;
  int? get days => _$this._days;
  set days(int? days) => _$this._days = days;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _adminAccountId;
  String? get adminAccountId => _$this._adminAccountId;
  set adminAccountId(String? adminAccountId) =>
      _$this._adminAccountId = adminAccountId;

  DateTime? _periodEndBefore;
  DateTime? get periodEndBefore => _$this._periodEndBefore;
  set periodEndBefore(DateTime? periodEndBefore) =>
      _$this._periodEndBefore = periodEndBefore;

  DateTime? _periodEndAfter;
  DateTime? get periodEndAfter => _$this._periodEndAfter;
  set periodEndAfter(DateTime? periodEndAfter) =>
      _$this._periodEndAfter = periodEndAfter;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  AdjustmentResponseBuilder() {
    AdjustmentResponse._defaults(this);
  }

  AdjustmentResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _kind = $v.kind;
      _tier = $v.tier;
      _days = $v.days;
      _reason = $v.reason;
      _adminAccountId = $v.adminAccountId;
      _periodEndBefore = $v.periodEndBefore;
      _periodEndAfter = $v.periodEndAfter;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdjustmentResponse other) {
    _$v = other as _$AdjustmentResponse;
  }

  @override
  void update(void Function(AdjustmentResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdjustmentResponse build() => _build();

  _$AdjustmentResponse _build() {
    final _$result =
        _$v ??
        _$AdjustmentResponse._(
          id: id,
          kind: kind,
          tier: tier,
          days: days,
          reason: reason,
          adminAccountId: adminAccountId,
          periodEndBefore: periodEndBefore,
          periodEndAfter: periodEndAfter,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
