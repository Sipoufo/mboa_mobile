//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'assignable_unit.g.dart';

/// AssignableUnit
///
/// Properties:
/// * [annonceId] 
/// * [title] 
/// * [propertyType] 
/// * [price] 
/// * [rentalPeriod] 
@BuiltValue()
abstract class AssignableUnit implements Built<AssignableUnit, AssignableUnitBuilder> {
  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'propertyType')
  AssignableUnitPropertyTypeEnum? get propertyType;
  // enum propertyTypeEnum {  APARTMENT,  STUDIO,  VILLA,  ROOM,  OFFICE,  COMMERCIAL_SPACE,  };

  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  AssignableUnitRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  AssignableUnit._();

  factory AssignableUnit([void updates(AssignableUnitBuilder b)]) = _$AssignableUnit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AssignableUnitBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AssignableUnit> get serializer => _$AssignableUnitSerializer();
}

class _$AssignableUnitSerializer implements PrimitiveSerializer<AssignableUnit> {
  @override
  final Iterable<Type> types = const [AssignableUnit, _$AssignableUnit];

  @override
  final String wireName = r'AssignableUnit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AssignableUnit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.annonceId != null) {
      yield r'annonceId';
      yield serializers.serialize(
        object.annonceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.propertyType != null) {
      yield r'propertyType';
      yield serializers.serialize(
        object.propertyType,
        specifiedType: const FullType(AssignableUnitPropertyTypeEnum),
      );
    }
    if (object.price != null) {
      yield r'price';
      yield serializers.serialize(
        object.price,
        specifiedType: const FullType(int),
      );
    }
    if (object.rentalPeriod != null) {
      yield r'rentalPeriod';
      yield serializers.serialize(
        object.rentalPeriod,
        specifiedType: const FullType(AssignableUnitRentalPeriodEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AssignableUnit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AssignableUnitBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'propertyType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AssignableUnitPropertyTypeEnum),
          ) as AssignableUnitPropertyTypeEnum?;
          if (valueDes == null) continue;
          result.propertyType = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.price = valueDes;
          break;
        case r'rentalPeriod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AssignableUnitRentalPeriodEnum),
          ) as AssignableUnitRentalPeriodEnum?;
          if (valueDes == null) continue;
          result.rentalPeriod = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AssignableUnit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AssignableUnitBuilder();
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

class AssignableUnitPropertyTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APARTMENT')
  static const AssignableUnitPropertyTypeEnum APARTMENT = _$assignableUnitPropertyTypeEnum_APARTMENT;
  @BuiltValueEnumConst(wireName: r'STUDIO')
  static const AssignableUnitPropertyTypeEnum STUDIO = _$assignableUnitPropertyTypeEnum_STUDIO;
  @BuiltValueEnumConst(wireName: r'VILLA')
  static const AssignableUnitPropertyTypeEnum VILLA = _$assignableUnitPropertyTypeEnum_VILLA;
  @BuiltValueEnumConst(wireName: r'ROOM')
  static const AssignableUnitPropertyTypeEnum ROOM = _$assignableUnitPropertyTypeEnum_ROOM;
  @BuiltValueEnumConst(wireName: r'OFFICE')
  static const AssignableUnitPropertyTypeEnum OFFICE = _$assignableUnitPropertyTypeEnum_OFFICE;
  @BuiltValueEnumConst(wireName: r'COMMERCIAL_SPACE')
  static const AssignableUnitPropertyTypeEnum COMMERCIAL_SPACE = _$assignableUnitPropertyTypeEnum_COMMERCIAL_SPACE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AssignableUnitPropertyTypeEnum unknownDefaultOpenApi = _$assignableUnitPropertyTypeEnum_unknownDefaultOpenApi;

  static Serializer<AssignableUnitPropertyTypeEnum> get serializer => _$assignableUnitPropertyTypeEnumSerializer;

  const AssignableUnitPropertyTypeEnum._(String name): super(name);

  static BuiltSet<AssignableUnitPropertyTypeEnum> get values => _$assignableUnitPropertyTypeEnumValues;
  static AssignableUnitPropertyTypeEnum valueOf(String name) => _$assignableUnitPropertyTypeEnumValueOf(name);
}

class AssignableUnitRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const AssignableUnitRentalPeriodEnum DAY = _$assignableUnitRentalPeriodEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const AssignableUnitRentalPeriodEnum WEEK = _$assignableUnitRentalPeriodEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const AssignableUnitRentalPeriodEnum MONTH = _$assignableUnitRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const AssignableUnitRentalPeriodEnum QUARTER = _$assignableUnitRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const AssignableUnitRentalPeriodEnum YEAR = _$assignableUnitRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AssignableUnitRentalPeriodEnum unknownDefaultOpenApi = _$assignableUnitRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<AssignableUnitRentalPeriodEnum> get serializer => _$assignableUnitRentalPeriodEnumSerializer;

  const AssignableUnitRentalPeriodEnum._(String name): super(name);

  static BuiltSet<AssignableUnitRentalPeriodEnum> get values => _$assignableUnitRentalPeriodEnumValues;
  static AssignableUnitRentalPeriodEnum valueOf(String name) => _$assignableUnitRentalPeriodEnumValueOf(name);
}

