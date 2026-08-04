// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UnitSummaryPropertyTypeEnum _$unitSummaryPropertyTypeEnum_APARTMENT =
    const UnitSummaryPropertyTypeEnum._('APARTMENT');
const UnitSummaryPropertyTypeEnum _$unitSummaryPropertyTypeEnum_STUDIO =
    const UnitSummaryPropertyTypeEnum._('STUDIO');
const UnitSummaryPropertyTypeEnum _$unitSummaryPropertyTypeEnum_VILLA =
    const UnitSummaryPropertyTypeEnum._('VILLA');
const UnitSummaryPropertyTypeEnum _$unitSummaryPropertyTypeEnum_ROOM =
    const UnitSummaryPropertyTypeEnum._('ROOM');
const UnitSummaryPropertyTypeEnum _$unitSummaryPropertyTypeEnum_OFFICE =
    const UnitSummaryPropertyTypeEnum._('OFFICE');
const UnitSummaryPropertyTypeEnum
_$unitSummaryPropertyTypeEnum_COMMERCIAL_SPACE =
    const UnitSummaryPropertyTypeEnum._('COMMERCIAL_SPACE');
const UnitSummaryPropertyTypeEnum
_$unitSummaryPropertyTypeEnum_unknownDefaultOpenApi =
    const UnitSummaryPropertyTypeEnum._('unknownDefaultOpenApi');

UnitSummaryPropertyTypeEnum _$unitSummaryPropertyTypeEnumValueOf(String name) {
  switch (name) {
    case 'APARTMENT':
      return _$unitSummaryPropertyTypeEnum_APARTMENT;
    case 'STUDIO':
      return _$unitSummaryPropertyTypeEnum_STUDIO;
    case 'VILLA':
      return _$unitSummaryPropertyTypeEnum_VILLA;
    case 'ROOM':
      return _$unitSummaryPropertyTypeEnum_ROOM;
    case 'OFFICE':
      return _$unitSummaryPropertyTypeEnum_OFFICE;
    case 'COMMERCIAL_SPACE':
      return _$unitSummaryPropertyTypeEnum_COMMERCIAL_SPACE;
    case 'unknownDefaultOpenApi':
      return _$unitSummaryPropertyTypeEnum_unknownDefaultOpenApi;
    default:
      return _$unitSummaryPropertyTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<UnitSummaryPropertyTypeEnum>
_$unitSummaryPropertyTypeEnumValues =
    BuiltSet<UnitSummaryPropertyTypeEnum>(const <UnitSummaryPropertyTypeEnum>[
      _$unitSummaryPropertyTypeEnum_APARTMENT,
      _$unitSummaryPropertyTypeEnum_STUDIO,
      _$unitSummaryPropertyTypeEnum_VILLA,
      _$unitSummaryPropertyTypeEnum_ROOM,
      _$unitSummaryPropertyTypeEnum_OFFICE,
      _$unitSummaryPropertyTypeEnum_COMMERCIAL_SPACE,
      _$unitSummaryPropertyTypeEnum_unknownDefaultOpenApi,
    ]);

const UnitSummaryStatusEnum _$unitSummaryStatusEnum_DRAFT =
    const UnitSummaryStatusEnum._('DRAFT');
const UnitSummaryStatusEnum _$unitSummaryStatusEnum_PUBLISHED =
    const UnitSummaryStatusEnum._('PUBLISHED');
const UnitSummaryStatusEnum _$unitSummaryStatusEnum_RESERVED =
    const UnitSummaryStatusEnum._('RESERVED');
const UnitSummaryStatusEnum _$unitSummaryStatusEnum_RENTED =
    const UnitSummaryStatusEnum._('RENTED');
const UnitSummaryStatusEnum _$unitSummaryStatusEnum_ARCHIVED =
    const UnitSummaryStatusEnum._('ARCHIVED');
const UnitSummaryStatusEnum _$unitSummaryStatusEnum_unknownDefaultOpenApi =
    const UnitSummaryStatusEnum._('unknownDefaultOpenApi');

UnitSummaryStatusEnum _$unitSummaryStatusEnumValueOf(String name) {
  switch (name) {
    case 'DRAFT':
      return _$unitSummaryStatusEnum_DRAFT;
    case 'PUBLISHED':
      return _$unitSummaryStatusEnum_PUBLISHED;
    case 'RESERVED':
      return _$unitSummaryStatusEnum_RESERVED;
    case 'RENTED':
      return _$unitSummaryStatusEnum_RENTED;
    case 'ARCHIVED':
      return _$unitSummaryStatusEnum_ARCHIVED;
    case 'unknownDefaultOpenApi':
      return _$unitSummaryStatusEnum_unknownDefaultOpenApi;
    default:
      return _$unitSummaryStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<UnitSummaryStatusEnum> _$unitSummaryStatusEnumValues =
    BuiltSet<UnitSummaryStatusEnum>(const <UnitSummaryStatusEnum>[
      _$unitSummaryStatusEnum_DRAFT,
      _$unitSummaryStatusEnum_PUBLISHED,
      _$unitSummaryStatusEnum_RESERVED,
      _$unitSummaryStatusEnum_RENTED,
      _$unitSummaryStatusEnum_ARCHIVED,
      _$unitSummaryStatusEnum_unknownDefaultOpenApi,
    ]);

Serializer<UnitSummaryPropertyTypeEnum>
_$unitSummaryPropertyTypeEnumSerializer =
    _$UnitSummaryPropertyTypeEnumSerializer();
Serializer<UnitSummaryStatusEnum> _$unitSummaryStatusEnumSerializer =
    _$UnitSummaryStatusEnumSerializer();

class _$UnitSummaryPropertyTypeEnumSerializer
    implements PrimitiveSerializer<UnitSummaryPropertyTypeEnum> {
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
  final Iterable<Type> types = const <Type>[UnitSummaryPropertyTypeEnum];
  @override
  final String wireName = 'UnitSummaryPropertyTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    UnitSummaryPropertyTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UnitSummaryPropertyTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UnitSummaryPropertyTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UnitSummaryStatusEnumSerializer
    implements PrimitiveSerializer<UnitSummaryStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DRAFT': 'DRAFT',
    'PUBLISHED': 'PUBLISHED',
    'RESERVED': 'RESERVED',
    'RENTED': 'RENTED',
    'ARCHIVED': 'ARCHIVED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DRAFT': 'DRAFT',
    'PUBLISHED': 'PUBLISHED',
    'RESERVED': 'RESERVED',
    'RENTED': 'RENTED',
    'ARCHIVED': 'ARCHIVED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[UnitSummaryStatusEnum];
  @override
  final String wireName = 'UnitSummaryStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    UnitSummaryStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UnitSummaryStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UnitSummaryStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UnitSummary extends UnitSummary {
  @override
  final String? id;
  @override
  final String? title;
  @override
  final UnitSummaryPropertyTypeEnum? propertyType;
  @override
  final UnitSummaryStatusEnum? status;
  @override
  final int? monthlyRent;

  factory _$UnitSummary([void Function(UnitSummaryBuilder)? updates]) =>
      (UnitSummaryBuilder()..update(updates))._build();

  _$UnitSummary._({
    this.id,
    this.title,
    this.propertyType,
    this.status,
    this.monthlyRent,
  }) : super._();
  @override
  UnitSummary rebuild(void Function(UnitSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnitSummaryBuilder toBuilder() => UnitSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnitSummary &&
        id == other.id &&
        title == other.title &&
        propertyType == other.propertyType &&
        status == other.status &&
        monthlyRent == other.monthlyRent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, propertyType.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, monthlyRent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnitSummary')
          ..add('id', id)
          ..add('title', title)
          ..add('propertyType', propertyType)
          ..add('status', status)
          ..add('monthlyRent', monthlyRent))
        .toString();
  }
}

class UnitSummaryBuilder implements Builder<UnitSummary, UnitSummaryBuilder> {
  _$UnitSummary? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  UnitSummaryPropertyTypeEnum? _propertyType;
  UnitSummaryPropertyTypeEnum? get propertyType => _$this._propertyType;
  set propertyType(UnitSummaryPropertyTypeEnum? propertyType) =>
      _$this._propertyType = propertyType;

  UnitSummaryStatusEnum? _status;
  UnitSummaryStatusEnum? get status => _$this._status;
  set status(UnitSummaryStatusEnum? status) => _$this._status = status;

  int? _monthlyRent;
  int? get monthlyRent => _$this._monthlyRent;
  set monthlyRent(int? monthlyRent) => _$this._monthlyRent = monthlyRent;

  UnitSummaryBuilder() {
    UnitSummary._defaults(this);
  }

  UnitSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _propertyType = $v.propertyType;
      _status = $v.status;
      _monthlyRent = $v.monthlyRent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnitSummary other) {
    _$v = other as _$UnitSummary;
  }

  @override
  void update(void Function(UnitSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnitSummary build() => _build();

  _$UnitSummary _build() {
    final _$result =
        _$v ??
        _$UnitSummary._(
          id: id,
          title: title,
          propertyType: propertyType,
          status: status,
          monthlyRent: monthlyRent,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
