// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tier_count.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TierCountTierEnum _$tierCountTierEnum_FREE = const TierCountTierEnum._(
  'FREE',
);
const TierCountTierEnum _$tierCountTierEnum_BASIC_PLUS =
    const TierCountTierEnum._('BASIC_PLUS');
const TierCountTierEnum _$tierCountTierEnum_PRO = const TierCountTierEnum._(
  'PRO',
);
const TierCountTierEnum _$tierCountTierEnum_PRO_PLUS =
    const TierCountTierEnum._('PRO_PLUS');
const TierCountTierEnum _$tierCountTierEnum_unknownDefaultOpenApi =
    const TierCountTierEnum._('unknownDefaultOpenApi');

TierCountTierEnum _$tierCountTierEnumValueOf(String name) {
  switch (name) {
    case 'FREE':
      return _$tierCountTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$tierCountTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$tierCountTierEnum_PRO;
    case 'PRO_PLUS':
      return _$tierCountTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$tierCountTierEnum_unknownDefaultOpenApi;
    default:
      return _$tierCountTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TierCountTierEnum> _$tierCountTierEnumValues =
    BuiltSet<TierCountTierEnum>(const <TierCountTierEnum>[
      _$tierCountTierEnum_FREE,
      _$tierCountTierEnum_BASIC_PLUS,
      _$tierCountTierEnum_PRO,
      _$tierCountTierEnum_PRO_PLUS,
      _$tierCountTierEnum_unknownDefaultOpenApi,
    ]);

Serializer<TierCountTierEnum> _$tierCountTierEnumSerializer =
    _$TierCountTierEnumSerializer();

class _$TierCountTierEnumSerializer
    implements PrimitiveSerializer<TierCountTierEnum> {
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
  final Iterable<Type> types = const <Type>[TierCountTierEnum];
  @override
  final String wireName = 'TierCountTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    TierCountTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TierCountTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TierCountTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TierCount extends TierCount {
  @override
  final TierCountTierEnum? tier;
  @override
  final int? active;
  @override
  final int? paid;
  @override
  final int? unpaid;

  factory _$TierCount([void Function(TierCountBuilder)? updates]) =>
      (TierCountBuilder()..update(updates))._build();

  _$TierCount._({this.tier, this.active, this.paid, this.unpaid}) : super._();
  @override
  TierCount rebuild(void Function(TierCountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TierCountBuilder toBuilder() => TierCountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TierCount &&
        tier == other.tier &&
        active == other.active &&
        paid == other.paid &&
        unpaid == other.unpaid;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, active.hashCode);
    _$hash = $jc(_$hash, paid.hashCode);
    _$hash = $jc(_$hash, unpaid.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TierCount')
          ..add('tier', tier)
          ..add('active', active)
          ..add('paid', paid)
          ..add('unpaid', unpaid))
        .toString();
  }
}

class TierCountBuilder implements Builder<TierCount, TierCountBuilder> {
  _$TierCount? _$v;

  TierCountTierEnum? _tier;
  TierCountTierEnum? get tier => _$this._tier;
  set tier(TierCountTierEnum? tier) => _$this._tier = tier;

  int? _active;
  int? get active => _$this._active;
  set active(int? active) => _$this._active = active;

  int? _paid;
  int? get paid => _$this._paid;
  set paid(int? paid) => _$this._paid = paid;

  int? _unpaid;
  int? get unpaid => _$this._unpaid;
  set unpaid(int? unpaid) => _$this._unpaid = unpaid;

  TierCountBuilder() {
    TierCount._defaults(this);
  }

  TierCountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tier = $v.tier;
      _active = $v.active;
      _paid = $v.paid;
      _unpaid = $v.unpaid;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TierCount other) {
    _$v = other as _$TierCount;
  }

  @override
  void update(void Function(TierCountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TierCount build() => _build();

  _$TierCount _build() {
    final _$result =
        _$v ??
        _$TierCount._(tier: tier, active: active, paid: paid, unpaid: unpaid);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
