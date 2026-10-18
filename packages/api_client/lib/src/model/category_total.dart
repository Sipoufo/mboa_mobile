//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'category_total.g.dart';

/// CategoryTotal
///
/// Properties:
/// * [direction] 
/// * [category] 
/// * [total] 
/// * [count] 
@BuiltValue()
abstract class CategoryTotal implements Built<CategoryTotal, CategoryTotalBuilder> {
  @BuiltValueField(wireName: r'direction')
  CategoryTotalDirectionEnum? get direction;
  // enum directionEnum {  INCOME,  EXPENSE,  };

  @BuiltValueField(wireName: r'category')
  CategoryTotalCategoryEnum? get category;
  // enum categoryEnum {  RENT,  CHARGES,  WORKS,  PROPERTY_TAX,  SERVICE_PROVIDERS,  OTHER,  };

  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'count')
  int? get count;

  CategoryTotal._();

  factory CategoryTotal([void updates(CategoryTotalBuilder b)]) = _$CategoryTotal;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CategoryTotalBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CategoryTotal> get serializer => _$CategoryTotalSerializer();
}

class _$CategoryTotalSerializer implements PrimitiveSerializer<CategoryTotal> {
  @override
  final Iterable<Type> types = const [CategoryTotal, _$CategoryTotal];

  @override
  final String wireName = r'CategoryTotal';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CategoryTotal object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.direction != null) {
      yield r'direction';
      yield serializers.serialize(
        object.direction,
        specifiedType: const FullType(CategoryTotalDirectionEnum),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(CategoryTotalCategoryEnum),
      );
    }
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(int),
      );
    }
    if (object.count != null) {
      yield r'count';
      yield serializers.serialize(
        object.count,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CategoryTotal object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CategoryTotalBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'direction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(CategoryTotalDirectionEnum),
          ) as CategoryTotalDirectionEnum?;
          if (valueDes == null) continue;
          result.direction = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(CategoryTotalCategoryEnum),
          ) as CategoryTotalCategoryEnum?;
          if (valueDes == null) continue;
          result.category = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.total = valueDes;
          break;
        case r'count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.count = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CategoryTotal deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CategoryTotalBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class CategoryTotalDirectionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'INCOME')
  static const CategoryTotalDirectionEnum INCOME = _$categoryTotalDirectionEnum_INCOME;
  @BuiltValueEnumConst(wireName: r'EXPENSE')
  static const CategoryTotalDirectionEnum EXPENSE = _$categoryTotalDirectionEnum_EXPENSE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CategoryTotalDirectionEnum unknownDefaultOpenApi = _$categoryTotalDirectionEnum_unknownDefaultOpenApi;

  static Serializer<CategoryTotalDirectionEnum> get serializer => _$categoryTotalDirectionEnumSerializer;

  const CategoryTotalDirectionEnum._(String name): super(name);

  static BuiltSet<CategoryTotalDirectionEnum> get values => _$categoryTotalDirectionEnumValues;
  static CategoryTotalDirectionEnum valueOf(String name) => _$categoryTotalDirectionEnumValueOf(name);
}

class CategoryTotalCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RENT')
  static const CategoryTotalCategoryEnum RENT = _$categoryTotalCategoryEnum_RENT;
  @BuiltValueEnumConst(wireName: r'CHARGES')
  static const CategoryTotalCategoryEnum CHARGES = _$categoryTotalCategoryEnum_CHARGES;
  @BuiltValueEnumConst(wireName: r'WORKS')
  static const CategoryTotalCategoryEnum WORKS = _$categoryTotalCategoryEnum_WORKS;
  @BuiltValueEnumConst(wireName: r'PROPERTY_TAX')
  static const CategoryTotalCategoryEnum PROPERTY_TAX = _$categoryTotalCategoryEnum_PROPERTY_TAX;
  @BuiltValueEnumConst(wireName: r'SERVICE_PROVIDERS')
  static const CategoryTotalCategoryEnum SERVICE_PROVIDERS = _$categoryTotalCategoryEnum_SERVICE_PROVIDERS;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const CategoryTotalCategoryEnum OTHER = _$categoryTotalCategoryEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CategoryTotalCategoryEnum unknownDefaultOpenApi = _$categoryTotalCategoryEnum_unknownDefaultOpenApi;

  static Serializer<CategoryTotalCategoryEnum> get serializer => _$categoryTotalCategoryEnumSerializer;

  const CategoryTotalCategoryEnum._(String name): super(name);

  static BuiltSet<CategoryTotalCategoryEnum> get values => _$categoryTotalCategoryEnumValues;
  static CategoryTotalCategoryEnum valueOf(String name) => _$categoryTotalCategoryEnumValueOf(name);
}

