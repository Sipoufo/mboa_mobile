// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_opportunity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AgentOpportunityRentalPeriodEnum
_$agentOpportunityRentalPeriodEnum_MONTH =
    const AgentOpportunityRentalPeriodEnum._('MONTH');
const AgentOpportunityRentalPeriodEnum
_$agentOpportunityRentalPeriodEnum_QUARTER =
    const AgentOpportunityRentalPeriodEnum._('QUARTER');
const AgentOpportunityRentalPeriodEnum _$agentOpportunityRentalPeriodEnum_YEAR =
    const AgentOpportunityRentalPeriodEnum._('YEAR');
const AgentOpportunityRentalPeriodEnum
_$agentOpportunityRentalPeriodEnum_unknownDefaultOpenApi =
    const AgentOpportunityRentalPeriodEnum._('unknownDefaultOpenApi');

AgentOpportunityRentalPeriodEnum _$agentOpportunityRentalPeriodEnumValueOf(
  String name,
) {
  switch (name) {
    case 'MONTH':
      return _$agentOpportunityRentalPeriodEnum_MONTH;
    case 'QUARTER':
      return _$agentOpportunityRentalPeriodEnum_QUARTER;
    case 'YEAR':
      return _$agentOpportunityRentalPeriodEnum_YEAR;
    case 'unknownDefaultOpenApi':
      return _$agentOpportunityRentalPeriodEnum_unknownDefaultOpenApi;
    default:
      return _$agentOpportunityRentalPeriodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AgentOpportunityRentalPeriodEnum>
_$agentOpportunityRentalPeriodEnumValues =
    BuiltSet<AgentOpportunityRentalPeriodEnum>(
      const <AgentOpportunityRentalPeriodEnum>[
        _$agentOpportunityRentalPeriodEnum_MONTH,
        _$agentOpportunityRentalPeriodEnum_QUARTER,
        _$agentOpportunityRentalPeriodEnum_YEAR,
        _$agentOpportunityRentalPeriodEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<AgentOpportunityRentalPeriodEnum>
_$agentOpportunityRentalPeriodEnumSerializer =
    _$AgentOpportunityRentalPeriodEnumSerializer();

class _$AgentOpportunityRentalPeriodEnumSerializer
    implements PrimitiveSerializer<AgentOpportunityRentalPeriodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AgentOpportunityRentalPeriodEnum];
  @override
  final String wireName = 'AgentOpportunityRentalPeriodEnum';

  @override
  Object serialize(
    Serializers serializers,
    AgentOpportunityRentalPeriodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AgentOpportunityRentalPeriodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AgentOpportunityRentalPeriodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AgentOpportunity extends AgentOpportunity {
  @override
  final String? annonceId;
  @override
  final String? title;
  @override
  final String? primaryPhotoKey;
  @override
  final int? price;
  @override
  final AgentOpportunityRentalPeriodEnum? rentalPeriod;
  @override
  final int? monthlyRent;
  @override
  final String? city;
  @override
  final String? district;

  factory _$AgentOpportunity([
    void Function(AgentOpportunityBuilder)? updates,
  ]) => (AgentOpportunityBuilder()..update(updates))._build();

  _$AgentOpportunity._({
    this.annonceId,
    this.title,
    this.primaryPhotoKey,
    this.price,
    this.rentalPeriod,
    this.monthlyRent,
    this.city,
    this.district,
  }) : super._();
  @override
  AgentOpportunity rebuild(void Function(AgentOpportunityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AgentOpportunityBuilder toBuilder() =>
      AgentOpportunityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AgentOpportunity &&
        annonceId == other.annonceId &&
        title == other.title &&
        primaryPhotoKey == other.primaryPhotoKey &&
        price == other.price &&
        rentalPeriod == other.rentalPeriod &&
        monthlyRent == other.monthlyRent &&
        city == other.city &&
        district == other.district;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, primaryPhotoKey.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, rentalPeriod.hashCode);
    _$hash = $jc(_$hash, monthlyRent.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AgentOpportunity')
          ..add('annonceId', annonceId)
          ..add('title', title)
          ..add('primaryPhotoKey', primaryPhotoKey)
          ..add('price', price)
          ..add('rentalPeriod', rentalPeriod)
          ..add('monthlyRent', monthlyRent)
          ..add('city', city)
          ..add('district', district))
        .toString();
  }
}

class AgentOpportunityBuilder
    implements Builder<AgentOpportunity, AgentOpportunityBuilder> {
  _$AgentOpportunity? _$v;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _primaryPhotoKey;
  String? get primaryPhotoKey => _$this._primaryPhotoKey;
  set primaryPhotoKey(String? primaryPhotoKey) =>
      _$this._primaryPhotoKey = primaryPhotoKey;

  int? _price;
  int? get price => _$this._price;
  set price(int? price) => _$this._price = price;

  AgentOpportunityRentalPeriodEnum? _rentalPeriod;
  AgentOpportunityRentalPeriodEnum? get rentalPeriod => _$this._rentalPeriod;
  set rentalPeriod(AgentOpportunityRentalPeriodEnum? rentalPeriod) =>
      _$this._rentalPeriod = rentalPeriod;

  int? _monthlyRent;
  int? get monthlyRent => _$this._monthlyRent;
  set monthlyRent(int? monthlyRent) => _$this._monthlyRent = monthlyRent;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _district;
  String? get district => _$this._district;
  set district(String? district) => _$this._district = district;

  AgentOpportunityBuilder() {
    AgentOpportunity._defaults(this);
  }

  AgentOpportunityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _annonceId = $v.annonceId;
      _title = $v.title;
      _primaryPhotoKey = $v.primaryPhotoKey;
      _price = $v.price;
      _rentalPeriod = $v.rentalPeriod;
      _monthlyRent = $v.monthlyRent;
      _city = $v.city;
      _district = $v.district;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AgentOpportunity other) {
    _$v = other as _$AgentOpportunity;
  }

  @override
  void update(void Function(AgentOpportunityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AgentOpportunity build() => _build();

  _$AgentOpportunity _build() {
    final _$result =
        _$v ??
        _$AgentOpportunity._(
          annonceId: annonceId,
          title: title,
          primaryPhotoKey: primaryPhotoKey,
          price: price,
          rentalPeriod: rentalPeriod,
          monthlyRent: monthlyRent,
          city: city,
          district: district,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
