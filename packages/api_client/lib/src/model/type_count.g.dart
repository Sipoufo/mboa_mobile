// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_count.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TypeCountPropertyTypeEnum _$typeCountPropertyTypeEnum_APARTMENT =
    const TypeCountPropertyTypeEnum._('APARTMENT');
const TypeCountPropertyTypeEnum _$typeCountPropertyTypeEnum_STUDIO =
    const TypeCountPropertyTypeEnum._('STUDIO');
const TypeCountPropertyTypeEnum _$typeCountPropertyTypeEnum_VILLA =
    const TypeCountPropertyTypeEnum._('VILLA');
const TypeCountPropertyTypeEnum _$typeCountPropertyTypeEnum_ROOM =
    const TypeCountPropertyTypeEnum._('ROOM');
const TypeCountPropertyTypeEnum _$typeCountPropertyTypeEnum_OFFICE =
    const TypeCountPropertyTypeEnum._('OFFICE');
const TypeCountPropertyTypeEnum _$typeCountPropertyTypeEnum_COMMERCIAL_SPACE =
    const TypeCountPropertyTypeEnum._('COMMERCIAL_SPACE');
const TypeCountPropertyTypeEnum
_$typeCountPropertyTypeEnum_unknownDefaultOpenApi =
    const TypeCountPropertyTypeEnum._('unknownDefaultOpenApi');

TypeCountPropertyTypeEnum _$typeCountPropertyTypeEnumValueOf(String name) {
  switch (name) {
    case 'APARTMENT':
      return _$typeCountPropertyTypeEnum_APARTMENT;
    case 'STUDIO':
      return _$typeCountPropertyTypeEnum_STUDIO;
    case 'VILLA':
      return _$typeCountPropertyTypeEnum_VILLA;
    case 'ROOM':
      return _$typeCountPropertyTypeEnum_ROOM;
    case 'OFFICE':
      return _$typeCountPropertyTypeEnum_OFFICE;
    case 'COMMERCIAL_SPACE':
      return _$typeCountPropertyTypeEnum_COMMERCIAL_SPACE;
    case 'unknownDefaultOpenApi':
      return _$typeCountPropertyTypeEnum_unknownDefaultOpenApi;
    default:
      return _$typeCountPropertyTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TypeCountPropertyTypeEnum> _$typeCountPropertyTypeEnumValues =
    BuiltSet<TypeCountPropertyTypeEnum>(const <TypeCountPropertyTypeEnum>[
      _$typeCountPropertyTypeEnum_APARTMENT,
      _$typeCountPropertyTypeEnum_STUDIO,
      _$typeCountPropertyTypeEnum_VILLA,
      _$typeCountPropertyTypeEnum_ROOM,
      _$typeCountPropertyTypeEnum_OFFICE,
      _$typeCountPropertyTypeEnum_COMMERCIAL_SPACE,
      _$typeCountPropertyTypeEnum_unknownDefaultOpenApi,
    ]);

Serializer<TypeCountPropertyTypeEnum> _$typeCountPropertyTypeEnumSerializer =
    _$TypeCountPropertyTypeEnumSerializer();

class _$TypeCountPropertyTypeEnumSerializer
    implements PrimitiveSerializer<TypeCountPropertyTypeEnum> {
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
  final Iterable<Type> types = const <Type>[TypeCountPropertyTypeEnum];
  @override
  final String wireName = 'TypeCountPropertyTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TypeCountPropertyTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TypeCountPropertyTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TypeCountPropertyTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TypeCount extends TypeCount {
  @override
  final TypeCountPropertyTypeEnum? propertyType;
  @override
  final int? count;

  factory _$TypeCount([void Function(TypeCountBuilder)? updates]) =>
      (TypeCountBuilder()..update(updates))._build();

  _$TypeCount._({this.propertyType, this.count}) : super._();
  @override
  TypeCount rebuild(void Function(TypeCountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TypeCountBuilder toBuilder() => TypeCountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TypeCount &&
        propertyType == other.propertyType &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, propertyType.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TypeCount')
          ..add('propertyType', propertyType)
          ..add('count', count))
        .toString();
  }
}

class TypeCountBuilder implements Builder<TypeCount, TypeCountBuilder> {
  _$TypeCount? _$v;

  TypeCountPropertyTypeEnum? _propertyType;
  TypeCountPropertyTypeEnum? get propertyType => _$this._propertyType;
  set propertyType(TypeCountPropertyTypeEnum? propertyType) =>
      _$this._propertyType = propertyType;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  TypeCountBuilder() {
    TypeCount._defaults(this);
  }

  TypeCountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _propertyType = $v.propertyType;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TypeCount other) {
    _$v = other as _$TypeCount;
  }

  @override
  void update(void Function(TypeCountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TypeCount build() => _build();

  _$TypeCount _build() {
    final _$result =
        _$v ?? _$TypeCount._(propertyType: propertyType, count: count);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
