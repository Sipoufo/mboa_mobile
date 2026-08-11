// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tier_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TierInfoTierEnum _$tierInfoTierEnum_FREE = const TierInfoTierEnum._(
  'FREE',
);
const TierInfoTierEnum _$tierInfoTierEnum_BASIC_PLUS = const TierInfoTierEnum._(
  'BASIC_PLUS',
);
const TierInfoTierEnum _$tierInfoTierEnum_PRO = const TierInfoTierEnum._('PRO');
const TierInfoTierEnum _$tierInfoTierEnum_PRO_PLUS = const TierInfoTierEnum._(
  'PRO_PLUS',
);
const TierInfoTierEnum _$tierInfoTierEnum_unknownDefaultOpenApi =
    const TierInfoTierEnum._('unknownDefaultOpenApi');

TierInfoTierEnum _$tierInfoTierEnumValueOf(String name) {
  switch (name) {
    case 'FREE':
      return _$tierInfoTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$tierInfoTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$tierInfoTierEnum_PRO;
    case 'PRO_PLUS':
      return _$tierInfoTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$tierInfoTierEnum_unknownDefaultOpenApi;
    default:
      return _$tierInfoTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TierInfoTierEnum> _$tierInfoTierEnumValues =
    BuiltSet<TierInfoTierEnum>(const <TierInfoTierEnum>[
      _$tierInfoTierEnum_FREE,
      _$tierInfoTierEnum_BASIC_PLUS,
      _$tierInfoTierEnum_PRO,
      _$tierInfoTierEnum_PRO_PLUS,
      _$tierInfoTierEnum_unknownDefaultOpenApi,
    ]);

Serializer<TierInfoTierEnum> _$tierInfoTierEnumSerializer =
    _$TierInfoTierEnumSerializer();

class _$TierInfoTierEnumSerializer
    implements PrimitiveSerializer<TierInfoTierEnum> {
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
  final Iterable<Type> types = const <Type>[TierInfoTierEnum];
  @override
  final String wireName = 'TierInfoTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    TierInfoTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TierInfoTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TierInfoTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TierInfo extends TierInfo {
  @override
  final TierInfoTierEnum? tier;
  @override
  final int? rank;
  @override
  final int? monthlyPrice;
  @override
  final int? activeListingLimit;
  @override
  final int? residenceUnitAllowance;
  @override
  final BuiltMap<String, String>? descriptions;

  factory _$TierInfo([void Function(TierInfoBuilder)? updates]) =>
      (TierInfoBuilder()..update(updates))._build();

  _$TierInfo._({
    this.tier,
    this.rank,
    this.monthlyPrice,
    this.activeListingLimit,
    this.residenceUnitAllowance,
    this.descriptions,
  }) : super._();
  @override
  TierInfo rebuild(void Function(TierInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TierInfoBuilder toBuilder() => TierInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TierInfo &&
        tier == other.tier &&
        rank == other.rank &&
        monthlyPrice == other.monthlyPrice &&
        activeListingLimit == other.activeListingLimit &&
        residenceUnitAllowance == other.residenceUnitAllowance &&
        descriptions == other.descriptions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, rank.hashCode);
    _$hash = $jc(_$hash, monthlyPrice.hashCode);
    _$hash = $jc(_$hash, activeListingLimit.hashCode);
    _$hash = $jc(_$hash, residenceUnitAllowance.hashCode);
    _$hash = $jc(_$hash, descriptions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TierInfo')
          ..add('tier', tier)
          ..add('rank', rank)
          ..add('monthlyPrice', monthlyPrice)
          ..add('activeListingLimit', activeListingLimit)
          ..add('residenceUnitAllowance', residenceUnitAllowance)
          ..add('descriptions', descriptions))
        .toString();
  }
}

class TierInfoBuilder implements Builder<TierInfo, TierInfoBuilder> {
  _$TierInfo? _$v;

  TierInfoTierEnum? _tier;
  TierInfoTierEnum? get tier => _$this._tier;
  set tier(TierInfoTierEnum? tier) => _$this._tier = tier;

  int? _rank;
  int? get rank => _$this._rank;
  set rank(int? rank) => _$this._rank = rank;

  int? _monthlyPrice;
  int? get monthlyPrice => _$this._monthlyPrice;
  set monthlyPrice(int? monthlyPrice) => _$this._monthlyPrice = monthlyPrice;

  int? _activeListingLimit;
  int? get activeListingLimit => _$this._activeListingLimit;
  set activeListingLimit(int? activeListingLimit) =>
      _$this._activeListingLimit = activeListingLimit;

  int? _residenceUnitAllowance;
  int? get residenceUnitAllowance => _$this._residenceUnitAllowance;
  set residenceUnitAllowance(int? residenceUnitAllowance) =>
      _$this._residenceUnitAllowance = residenceUnitAllowance;

  MapBuilder<String, String>? _descriptions;
  MapBuilder<String, String> get descriptions =>
      _$this._descriptions ??= MapBuilder<String, String>();
  set descriptions(MapBuilder<String, String>? descriptions) =>
      _$this._descriptions = descriptions;

  TierInfoBuilder() {
    TierInfo._defaults(this);
  }

  TierInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tier = $v.tier;
      _rank = $v.rank;
      _monthlyPrice = $v.monthlyPrice;
      _activeListingLimit = $v.activeListingLimit;
      _residenceUnitAllowance = $v.residenceUnitAllowance;
      _descriptions = $v.descriptions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TierInfo other) {
    _$v = other as _$TierInfo;
  }

  @override
  void update(void Function(TierInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TierInfo build() => _build();

  _$TierInfo _build() {
    _$TierInfo _$result;
    try {
      _$result =
          _$v ??
          _$TierInfo._(
            tier: tier,
            rank: rank,
            monthlyPrice: monthlyPrice,
            activeListingLimit: activeListingLimit,
            residenceUnitAllowance: residenceUnitAllowance,
            descriptions: _descriptions?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'descriptions';
        _descriptions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TierInfo',
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
