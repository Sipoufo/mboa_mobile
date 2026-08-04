// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_group.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UnitGroupPropertyTypeEnum _$unitGroupPropertyTypeEnum_APARTMENT =
    const UnitGroupPropertyTypeEnum._('APARTMENT');
const UnitGroupPropertyTypeEnum _$unitGroupPropertyTypeEnum_STUDIO =
    const UnitGroupPropertyTypeEnum._('STUDIO');
const UnitGroupPropertyTypeEnum _$unitGroupPropertyTypeEnum_VILLA =
    const UnitGroupPropertyTypeEnum._('VILLA');
const UnitGroupPropertyTypeEnum _$unitGroupPropertyTypeEnum_ROOM =
    const UnitGroupPropertyTypeEnum._('ROOM');
const UnitGroupPropertyTypeEnum _$unitGroupPropertyTypeEnum_OFFICE =
    const UnitGroupPropertyTypeEnum._('OFFICE');
const UnitGroupPropertyTypeEnum _$unitGroupPropertyTypeEnum_COMMERCIAL_SPACE =
    const UnitGroupPropertyTypeEnum._('COMMERCIAL_SPACE');
const UnitGroupPropertyTypeEnum
_$unitGroupPropertyTypeEnum_unknownDefaultOpenApi =
    const UnitGroupPropertyTypeEnum._('unknownDefaultOpenApi');

UnitGroupPropertyTypeEnum _$unitGroupPropertyTypeEnumValueOf(String name) {
  switch (name) {
    case 'APARTMENT':
      return _$unitGroupPropertyTypeEnum_APARTMENT;
    case 'STUDIO':
      return _$unitGroupPropertyTypeEnum_STUDIO;
    case 'VILLA':
      return _$unitGroupPropertyTypeEnum_VILLA;
    case 'ROOM':
      return _$unitGroupPropertyTypeEnum_ROOM;
    case 'OFFICE':
      return _$unitGroupPropertyTypeEnum_OFFICE;
    case 'COMMERCIAL_SPACE':
      return _$unitGroupPropertyTypeEnum_COMMERCIAL_SPACE;
    case 'unknownDefaultOpenApi':
      return _$unitGroupPropertyTypeEnum_unknownDefaultOpenApi;
    default:
      return _$unitGroupPropertyTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<UnitGroupPropertyTypeEnum> _$unitGroupPropertyTypeEnumValues =
    BuiltSet<UnitGroupPropertyTypeEnum>(const <UnitGroupPropertyTypeEnum>[
      _$unitGroupPropertyTypeEnum_APARTMENT,
      _$unitGroupPropertyTypeEnum_STUDIO,
      _$unitGroupPropertyTypeEnum_VILLA,
      _$unitGroupPropertyTypeEnum_ROOM,
      _$unitGroupPropertyTypeEnum_OFFICE,
      _$unitGroupPropertyTypeEnum_COMMERCIAL_SPACE,
      _$unitGroupPropertyTypeEnum_unknownDefaultOpenApi,
    ]);

Serializer<UnitGroupPropertyTypeEnum> _$unitGroupPropertyTypeEnumSerializer =
    _$UnitGroupPropertyTypeEnumSerializer();

class _$UnitGroupPropertyTypeEnumSerializer
    implements PrimitiveSerializer<UnitGroupPropertyTypeEnum> {
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
  final Iterable<Type> types = const <Type>[UnitGroupPropertyTypeEnum];
  @override
  final String wireName = 'UnitGroupPropertyTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    UnitGroupPropertyTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UnitGroupPropertyTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UnitGroupPropertyTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UnitGroup extends UnitGroup {
  @override
  final UnitGroupPropertyTypeEnum propertyType;
  @override
  final int count;
  @override
  final String namePrefix;
  @override
  final int monthlyRent;
  @override
  final bool? chargesIncluded;
  @override
  final int? chargesAmount;
  @override
  final int? surfaceArea;
  @override
  final int? roomCount;
  @override
  final int? bathroomCount;
  @override
  final bool? furnished;
  @override
  final String? description;

  factory _$UnitGroup([void Function(UnitGroupBuilder)? updates]) =>
      (UnitGroupBuilder()..update(updates))._build();

  _$UnitGroup._({
    required this.propertyType,
    required this.count,
    required this.namePrefix,
    required this.monthlyRent,
    this.chargesIncluded,
    this.chargesAmount,
    this.surfaceArea,
    this.roomCount,
    this.bathroomCount,
    this.furnished,
    this.description,
  }) : super._();
  @override
  UnitGroup rebuild(void Function(UnitGroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnitGroupBuilder toBuilder() => UnitGroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnitGroup &&
        propertyType == other.propertyType &&
        count == other.count &&
        namePrefix == other.namePrefix &&
        monthlyRent == other.monthlyRent &&
        chargesIncluded == other.chargesIncluded &&
        chargesAmount == other.chargesAmount &&
        surfaceArea == other.surfaceArea &&
        roomCount == other.roomCount &&
        bathroomCount == other.bathroomCount &&
        furnished == other.furnished &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, propertyType.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, namePrefix.hashCode);
    _$hash = $jc(_$hash, monthlyRent.hashCode);
    _$hash = $jc(_$hash, chargesIncluded.hashCode);
    _$hash = $jc(_$hash, chargesAmount.hashCode);
    _$hash = $jc(_$hash, surfaceArea.hashCode);
    _$hash = $jc(_$hash, roomCount.hashCode);
    _$hash = $jc(_$hash, bathroomCount.hashCode);
    _$hash = $jc(_$hash, furnished.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnitGroup')
          ..add('propertyType', propertyType)
          ..add('count', count)
          ..add('namePrefix', namePrefix)
          ..add('monthlyRent', monthlyRent)
          ..add('chargesIncluded', chargesIncluded)
          ..add('chargesAmount', chargesAmount)
          ..add('surfaceArea', surfaceArea)
          ..add('roomCount', roomCount)
          ..add('bathroomCount', bathroomCount)
          ..add('furnished', furnished)
          ..add('description', description))
        .toString();
  }
}

class UnitGroupBuilder implements Builder<UnitGroup, UnitGroupBuilder> {
  _$UnitGroup? _$v;

  UnitGroupPropertyTypeEnum? _propertyType;
  UnitGroupPropertyTypeEnum? get propertyType => _$this._propertyType;
  set propertyType(UnitGroupPropertyTypeEnum? propertyType) =>
      _$this._propertyType = propertyType;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  String? _namePrefix;
  String? get namePrefix => _$this._namePrefix;
  set namePrefix(String? namePrefix) => _$this._namePrefix = namePrefix;

  int? _monthlyRent;
  int? get monthlyRent => _$this._monthlyRent;
  set monthlyRent(int? monthlyRent) => _$this._monthlyRent = monthlyRent;

  bool? _chargesIncluded;
  bool? get chargesIncluded => _$this._chargesIncluded;
  set chargesIncluded(bool? chargesIncluded) =>
      _$this._chargesIncluded = chargesIncluded;

  int? _chargesAmount;
  int? get chargesAmount => _$this._chargesAmount;
  set chargesAmount(int? chargesAmount) =>
      _$this._chargesAmount = chargesAmount;

  int? _surfaceArea;
  int? get surfaceArea => _$this._surfaceArea;
  set surfaceArea(int? surfaceArea) => _$this._surfaceArea = surfaceArea;

  int? _roomCount;
  int? get roomCount => _$this._roomCount;
  set roomCount(int? roomCount) => _$this._roomCount = roomCount;

  int? _bathroomCount;
  int? get bathroomCount => _$this._bathroomCount;
  set bathroomCount(int? bathroomCount) =>
      _$this._bathroomCount = bathroomCount;

  bool? _furnished;
  bool? get furnished => _$this._furnished;
  set furnished(bool? furnished) => _$this._furnished = furnished;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  UnitGroupBuilder() {
    UnitGroup._defaults(this);
  }

  UnitGroupBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _propertyType = $v.propertyType;
      _count = $v.count;
      _namePrefix = $v.namePrefix;
      _monthlyRent = $v.monthlyRent;
      _chargesIncluded = $v.chargesIncluded;
      _chargesAmount = $v.chargesAmount;
      _surfaceArea = $v.surfaceArea;
      _roomCount = $v.roomCount;
      _bathroomCount = $v.bathroomCount;
      _furnished = $v.furnished;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnitGroup other) {
    _$v = other as _$UnitGroup;
  }

  @override
  void update(void Function(UnitGroupBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnitGroup build() => _build();

  _$UnitGroup _build() {
    final _$result =
        _$v ??
        _$UnitGroup._(
          propertyType: BuiltValueNullFieldError.checkNotNull(
            propertyType,
            r'UnitGroup',
            'propertyType',
          ),
          count: BuiltValueNullFieldError.checkNotNull(
            count,
            r'UnitGroup',
            'count',
          ),
          namePrefix: BuiltValueNullFieldError.checkNotNull(
            namePrefix,
            r'UnitGroup',
            'namePrefix',
          ),
          monthlyRent: BuiltValueNullFieldError.checkNotNull(
            monthlyRent,
            r'UnitGroup',
            'monthlyRent',
          ),
          chargesIncluded: chargesIncluded,
          chargesAmount: chargesAmount,
          surfaceArea: surfaceArea,
          roomCount: roomCount,
          bathroomCount: bathroomCount,
          furnished: furnished,
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
