// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignable_unit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AssignableUnitPropertyTypeEnum
_$assignableUnitPropertyTypeEnum_APARTMENT =
    const AssignableUnitPropertyTypeEnum._('APARTMENT');
const AssignableUnitPropertyTypeEnum _$assignableUnitPropertyTypeEnum_STUDIO =
    const AssignableUnitPropertyTypeEnum._('STUDIO');
const AssignableUnitPropertyTypeEnum _$assignableUnitPropertyTypeEnum_VILLA =
    const AssignableUnitPropertyTypeEnum._('VILLA');
const AssignableUnitPropertyTypeEnum _$assignableUnitPropertyTypeEnum_ROOM =
    const AssignableUnitPropertyTypeEnum._('ROOM');
const AssignableUnitPropertyTypeEnum _$assignableUnitPropertyTypeEnum_OFFICE =
    const AssignableUnitPropertyTypeEnum._('OFFICE');
const AssignableUnitPropertyTypeEnum
_$assignableUnitPropertyTypeEnum_COMMERCIAL_SPACE =
    const AssignableUnitPropertyTypeEnum._('COMMERCIAL_SPACE');
const AssignableUnitPropertyTypeEnum
_$assignableUnitPropertyTypeEnum_unknownDefaultOpenApi =
    const AssignableUnitPropertyTypeEnum._('unknownDefaultOpenApi');

AssignableUnitPropertyTypeEnum _$assignableUnitPropertyTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'APARTMENT':
      return _$assignableUnitPropertyTypeEnum_APARTMENT;
    case 'STUDIO':
      return _$assignableUnitPropertyTypeEnum_STUDIO;
    case 'VILLA':
      return _$assignableUnitPropertyTypeEnum_VILLA;
    case 'ROOM':
      return _$assignableUnitPropertyTypeEnum_ROOM;
    case 'OFFICE':
      return _$assignableUnitPropertyTypeEnum_OFFICE;
    case 'COMMERCIAL_SPACE':
      return _$assignableUnitPropertyTypeEnum_COMMERCIAL_SPACE;
    case 'unknownDefaultOpenApi':
      return _$assignableUnitPropertyTypeEnum_unknownDefaultOpenApi;
    default:
      return _$assignableUnitPropertyTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AssignableUnitPropertyTypeEnum>
_$assignableUnitPropertyTypeEnumValues =
    BuiltSet<AssignableUnitPropertyTypeEnum>(
      const <AssignableUnitPropertyTypeEnum>[
        _$assignableUnitPropertyTypeEnum_APARTMENT,
        _$assignableUnitPropertyTypeEnum_STUDIO,
        _$assignableUnitPropertyTypeEnum_VILLA,
        _$assignableUnitPropertyTypeEnum_ROOM,
        _$assignableUnitPropertyTypeEnum_OFFICE,
        _$assignableUnitPropertyTypeEnum_COMMERCIAL_SPACE,
        _$assignableUnitPropertyTypeEnum_unknownDefaultOpenApi,
      ],
    );

const AssignableUnitRentalPeriodEnum _$assignableUnitRentalPeriodEnum_DAY =
    const AssignableUnitRentalPeriodEnum._('DAY');
const AssignableUnitRentalPeriodEnum _$assignableUnitRentalPeriodEnum_WEEK =
    const AssignableUnitRentalPeriodEnum._('WEEK');
const AssignableUnitRentalPeriodEnum _$assignableUnitRentalPeriodEnum_MONTH =
    const AssignableUnitRentalPeriodEnum._('MONTH');
const AssignableUnitRentalPeriodEnum _$assignableUnitRentalPeriodEnum_QUARTER =
    const AssignableUnitRentalPeriodEnum._('QUARTER');
const AssignableUnitRentalPeriodEnum _$assignableUnitRentalPeriodEnum_YEAR =
    const AssignableUnitRentalPeriodEnum._('YEAR');
const AssignableUnitRentalPeriodEnum
_$assignableUnitRentalPeriodEnum_unknownDefaultOpenApi =
    const AssignableUnitRentalPeriodEnum._('unknownDefaultOpenApi');

AssignableUnitRentalPeriodEnum _$assignableUnitRentalPeriodEnumValueOf(
  String name,
) {
  switch (name) {
    case 'DAY':
      return _$assignableUnitRentalPeriodEnum_DAY;
    case 'WEEK':
      return _$assignableUnitRentalPeriodEnum_WEEK;
    case 'MONTH':
      return _$assignableUnitRentalPeriodEnum_MONTH;
    case 'QUARTER':
      return _$assignableUnitRentalPeriodEnum_QUARTER;
    case 'YEAR':
      return _$assignableUnitRentalPeriodEnum_YEAR;
    case 'unknownDefaultOpenApi':
      return _$assignableUnitRentalPeriodEnum_unknownDefaultOpenApi;
    default:
      return _$assignableUnitRentalPeriodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AssignableUnitRentalPeriodEnum>
_$assignableUnitRentalPeriodEnumValues =
    BuiltSet<AssignableUnitRentalPeriodEnum>(
      const <AssignableUnitRentalPeriodEnum>[
        _$assignableUnitRentalPeriodEnum_DAY,
        _$assignableUnitRentalPeriodEnum_WEEK,
        _$assignableUnitRentalPeriodEnum_MONTH,
        _$assignableUnitRentalPeriodEnum_QUARTER,
        _$assignableUnitRentalPeriodEnum_YEAR,
        _$assignableUnitRentalPeriodEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<AssignableUnitPropertyTypeEnum>
_$assignableUnitPropertyTypeEnumSerializer =
    _$AssignableUnitPropertyTypeEnumSerializer();
Serializer<AssignableUnitRentalPeriodEnum>
_$assignableUnitRentalPeriodEnumSerializer =
    _$AssignableUnitRentalPeriodEnumSerializer();

class _$AssignableUnitPropertyTypeEnumSerializer
    implements PrimitiveSerializer<AssignableUnitPropertyTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'APARTMENT': 'APARTMENT',
    'STUDIO': 'STUDIO',
    'VILLA': 'VILLA',
    'ROOM': 'ROOM',
    'OFFICE': 'OFFICE',
    'COMMERCIAL_SPACE': 'COMMERCIAL_SPACE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'APARTMENT': 'APARTMENT',
    'STUDIO': 'STUDIO',
    'VILLA': 'VILLA',
    'ROOM': 'ROOM',
    'OFFICE': 'OFFICE',
    'COMMERCIAL_SPACE': 'COMMERCIAL_SPACE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AssignableUnitPropertyTypeEnum];
  @override
  final String wireName = 'AssignableUnitPropertyTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AssignableUnitPropertyTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AssignableUnitPropertyTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AssignableUnitPropertyTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AssignableUnitRentalPeriodEnumSerializer
    implements PrimitiveSerializer<AssignableUnitRentalPeriodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DAY': 'DAY',
    'WEEK': 'WEEK',
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DAY': 'DAY',
    'WEEK': 'WEEK',
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AssignableUnitRentalPeriodEnum];
  @override
  final String wireName = 'AssignableUnitRentalPeriodEnum';

  @override
  Object serialize(
    Serializers serializers,
    AssignableUnitRentalPeriodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AssignableUnitRentalPeriodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AssignableUnitRentalPeriodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AssignableUnit extends AssignableUnit {
  @override
  final String? annonceId;
  @override
  final String? title;
  @override
  final AssignableUnitPropertyTypeEnum? propertyType;
  @override
  final int? price;
  @override
  final AssignableUnitRentalPeriodEnum? rentalPeriod;

  factory _$AssignableUnit([void Function(AssignableUnitBuilder)? updates]) =>
      (AssignableUnitBuilder()..update(updates))._build();

  _$AssignableUnit._({
    this.annonceId,
    this.title,
    this.propertyType,
    this.price,
    this.rentalPeriod,
  }) : super._();
  @override
  AssignableUnit rebuild(void Function(AssignableUnitBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssignableUnitBuilder toBuilder() => AssignableUnitBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssignableUnit &&
        annonceId == other.annonceId &&
        title == other.title &&
        propertyType == other.propertyType &&
        price == other.price &&
        rentalPeriod == other.rentalPeriod;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, propertyType.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, rentalPeriod.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssignableUnit')
          ..add('annonceId', annonceId)
          ..add('title', title)
          ..add('propertyType', propertyType)
          ..add('price', price)
          ..add('rentalPeriod', rentalPeriod))
        .toString();
  }
}

class AssignableUnitBuilder
    implements Builder<AssignableUnit, AssignableUnitBuilder> {
  _$AssignableUnit? _$v;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  AssignableUnitPropertyTypeEnum? _propertyType;
  AssignableUnitPropertyTypeEnum? get propertyType => _$this._propertyType;
  set propertyType(AssignableUnitPropertyTypeEnum? propertyType) =>
      _$this._propertyType = propertyType;

  int? _price;
  int? get price => _$this._price;
  set price(int? price) => _$this._price = price;

  AssignableUnitRentalPeriodEnum? _rentalPeriod;
  AssignableUnitRentalPeriodEnum? get rentalPeriod => _$this._rentalPeriod;
  set rentalPeriod(AssignableUnitRentalPeriodEnum? rentalPeriod) =>
      _$this._rentalPeriod = rentalPeriod;

  AssignableUnitBuilder() {
    AssignableUnit._defaults(this);
  }

  AssignableUnitBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _annonceId = $v.annonceId;
      _title = $v.title;
      _propertyType = $v.propertyType;
      _price = $v.price;
      _rentalPeriod = $v.rentalPeriod;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssignableUnit other) {
    _$v = other as _$AssignableUnit;
  }

  @override
  void update(void Function(AssignableUnitBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssignableUnit build() => _build();

  _$AssignableUnit _build() {
    final _$result =
        _$v ??
        _$AssignableUnit._(
          annonceId: annonceId,
          title: title,
          propertyType: propertyType,
          price: price,
          rentalPeriod: rentalPeriod,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
