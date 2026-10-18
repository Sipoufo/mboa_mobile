// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_total.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CategoryTotalDirectionEnum _$categoryTotalDirectionEnum_INCOME =
    const CategoryTotalDirectionEnum._('INCOME');
const CategoryTotalDirectionEnum _$categoryTotalDirectionEnum_EXPENSE =
    const CategoryTotalDirectionEnum._('EXPENSE');
const CategoryTotalDirectionEnum
_$categoryTotalDirectionEnum_unknownDefaultOpenApi =
    const CategoryTotalDirectionEnum._('unknownDefaultOpenApi');

CategoryTotalDirectionEnum _$categoryTotalDirectionEnumValueOf(String name) {
  switch (name) {
    case 'INCOME':
      return _$categoryTotalDirectionEnum_INCOME;
    case 'EXPENSE':
      return _$categoryTotalDirectionEnum_EXPENSE;
    case 'unknownDefaultOpenApi':
      return _$categoryTotalDirectionEnum_unknownDefaultOpenApi;
    default:
      return _$categoryTotalDirectionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CategoryTotalDirectionEnum> _$categoryTotalDirectionEnumValues =
    BuiltSet<CategoryTotalDirectionEnum>(const <CategoryTotalDirectionEnum>[
      _$categoryTotalDirectionEnum_INCOME,
      _$categoryTotalDirectionEnum_EXPENSE,
      _$categoryTotalDirectionEnum_unknownDefaultOpenApi,
    ]);

const CategoryTotalCategoryEnum _$categoryTotalCategoryEnum_RENT =
    const CategoryTotalCategoryEnum._('RENT');
const CategoryTotalCategoryEnum _$categoryTotalCategoryEnum_CHARGES =
    const CategoryTotalCategoryEnum._('CHARGES');
const CategoryTotalCategoryEnum _$categoryTotalCategoryEnum_WORKS =
    const CategoryTotalCategoryEnum._('WORKS');
const CategoryTotalCategoryEnum _$categoryTotalCategoryEnum_PROPERTY_TAX =
    const CategoryTotalCategoryEnum._('PROPERTY_TAX');
const CategoryTotalCategoryEnum _$categoryTotalCategoryEnum_SERVICE_PROVIDERS =
    const CategoryTotalCategoryEnum._('SERVICE_PROVIDERS');
const CategoryTotalCategoryEnum _$categoryTotalCategoryEnum_OTHER =
    const CategoryTotalCategoryEnum._('OTHER');
const CategoryTotalCategoryEnum
_$categoryTotalCategoryEnum_unknownDefaultOpenApi =
    const CategoryTotalCategoryEnum._('unknownDefaultOpenApi');

CategoryTotalCategoryEnum _$categoryTotalCategoryEnumValueOf(String name) {
  switch (name) {
    case 'RENT':
      return _$categoryTotalCategoryEnum_RENT;
    case 'CHARGES':
      return _$categoryTotalCategoryEnum_CHARGES;
    case 'WORKS':
      return _$categoryTotalCategoryEnum_WORKS;
    case 'PROPERTY_TAX':
      return _$categoryTotalCategoryEnum_PROPERTY_TAX;
    case 'SERVICE_PROVIDERS':
      return _$categoryTotalCategoryEnum_SERVICE_PROVIDERS;
    case 'OTHER':
      return _$categoryTotalCategoryEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$categoryTotalCategoryEnum_unknownDefaultOpenApi;
    default:
      return _$categoryTotalCategoryEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CategoryTotalCategoryEnum> _$categoryTotalCategoryEnumValues =
    BuiltSet<CategoryTotalCategoryEnum>(const <CategoryTotalCategoryEnum>[
      _$categoryTotalCategoryEnum_RENT,
      _$categoryTotalCategoryEnum_CHARGES,
      _$categoryTotalCategoryEnum_WORKS,
      _$categoryTotalCategoryEnum_PROPERTY_TAX,
      _$categoryTotalCategoryEnum_SERVICE_PROVIDERS,
      _$categoryTotalCategoryEnum_OTHER,
      _$categoryTotalCategoryEnum_unknownDefaultOpenApi,
    ]);

Serializer<CategoryTotalDirectionEnum> _$categoryTotalDirectionEnumSerializer =
    _$CategoryTotalDirectionEnumSerializer();
Serializer<CategoryTotalCategoryEnum> _$categoryTotalCategoryEnumSerializer =
    _$CategoryTotalCategoryEnumSerializer();

class _$CategoryTotalDirectionEnumSerializer
    implements PrimitiveSerializer<CategoryTotalDirectionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'INCOME': 'INCOME',
    'EXPENSE': 'EXPENSE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'INCOME': 'INCOME',
    'EXPENSE': 'EXPENSE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[CategoryTotalDirectionEnum];
  @override
  final String wireName = 'CategoryTotalDirectionEnum';

  @override
  Object serialize(
    Serializers serializers,
    CategoryTotalDirectionEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CategoryTotalDirectionEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CategoryTotalDirectionEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CategoryTotalCategoryEnumSerializer
    implements PrimitiveSerializer<CategoryTotalCategoryEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'RENT': 'RENT',
    'CHARGES': 'CHARGES',
    'WORKS': 'WORKS',
    'PROPERTY_TAX': 'PROPERTY_TAX',
    'SERVICE_PROVIDERS': 'SERVICE_PROVIDERS',
    'OTHER': 'OTHER',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'RENT': 'RENT',
    'CHARGES': 'CHARGES',
    'WORKS': 'WORKS',
    'PROPERTY_TAX': 'PROPERTY_TAX',
    'SERVICE_PROVIDERS': 'SERVICE_PROVIDERS',
    'OTHER': 'OTHER',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[CategoryTotalCategoryEnum];
  @override
  final String wireName = 'CategoryTotalCategoryEnum';

  @override
  Object serialize(
    Serializers serializers,
    CategoryTotalCategoryEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CategoryTotalCategoryEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CategoryTotalCategoryEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CategoryTotal extends CategoryTotal {
  @override
  final CategoryTotalDirectionEnum? direction;
  @override
  final CategoryTotalCategoryEnum? category;
  @override
  final int? total;
  @override
  final int? count;

  factory _$CategoryTotal([void Function(CategoryTotalBuilder)? updates]) =>
      (CategoryTotalBuilder()..update(updates))._build();

  _$CategoryTotal._({this.direction, this.category, this.total, this.count})
    : super._();
  @override
  CategoryTotal rebuild(void Function(CategoryTotalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CategoryTotalBuilder toBuilder() => CategoryTotalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CategoryTotal &&
        direction == other.direction &&
        category == other.category &&
        total == other.total &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, direction.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CategoryTotal')
          ..add('direction', direction)
          ..add('category', category)
          ..add('total', total)
          ..add('count', count))
        .toString();
  }
}

class CategoryTotalBuilder
    implements Builder<CategoryTotal, CategoryTotalBuilder> {
  _$CategoryTotal? _$v;

  CategoryTotalDirectionEnum? _direction;
  CategoryTotalDirectionEnum? get direction => _$this._direction;
  set direction(CategoryTotalDirectionEnum? direction) =>
      _$this._direction = direction;

  CategoryTotalCategoryEnum? _category;
  CategoryTotalCategoryEnum? get category => _$this._category;
  set category(CategoryTotalCategoryEnum? category) =>
      _$this._category = category;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  CategoryTotalBuilder() {
    CategoryTotal._defaults(this);
  }

  CategoryTotalBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _direction = $v.direction;
      _category = $v.category;
      _total = $v.total;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CategoryTotal other) {
    _$v = other as _$CategoryTotal;
  }

  @override
  void update(void Function(CategoryTotalBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CategoryTotal build() => _build();

  _$CategoryTotal _build() {
    final _$result =
        _$v ??
        _$CategoryTotal._(
          direction: direction,
          category: category,
          total: total,
          count: count,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
