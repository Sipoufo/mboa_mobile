//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unit_group.g.dart';

/// UnitGroup
///
/// Properties:
/// * [propertyType] 
/// * [count] 
/// * [namePrefix] 
/// * [price] 
/// * [rentalPeriod] 
/// * [monthlyRent] 
/// * [chargesIncluded] 
/// * [chargesAmount] 
/// * [surfaceArea] 
/// * [roomCount] 
/// * [bathroomCount] 
/// * [furnished] 
/// * [description] 
@BuiltValue()
abstract class UnitGroup implements Built<UnitGroup, UnitGroupBuilder> {
  @BuiltValueField(wireName: r'propertyType')
  UnitGroupPropertyTypeEnum get propertyType;
  // enum propertyTypeEnum {  APARTMENT,  STUDIO,  VILLA,  ROOM,  OFFICE,  COMMERCIAL_SPACE,  };

  @BuiltValueField(wireName: r'count')
  int get count;

  @BuiltValueField(wireName: r'namePrefix')
  String get namePrefix;

  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  UnitGroupRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'monthlyRent')
  int? get monthlyRent;

  @BuiltValueField(wireName: r'chargesIncluded')
  bool? get chargesIncluded;

  @BuiltValueField(wireName: r'chargesAmount')
  int? get chargesAmount;

  @BuiltValueField(wireName: r'surfaceArea')
  int? get surfaceArea;

  @BuiltValueField(wireName: r'roomCount')
  int? get roomCount;

  @BuiltValueField(wireName: r'bathroomCount')
  int? get bathroomCount;

  @BuiltValueField(wireName: r'furnished')
  bool? get furnished;

  @BuiltValueField(wireName: r'description')
  String? get description;

  UnitGroup._();

  factory UnitGroup([void updates(UnitGroupBuilder b)]) = _$UnitGroup;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnitGroupBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnitGroup> get serializer => _$UnitGroupSerializer();
}

class _$UnitGroupSerializer implements PrimitiveSerializer<UnitGroup> {
  @override
  final Iterable<Type> types = const [UnitGroup, _$UnitGroup];

  @override
  final String wireName = r'UnitGroup';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnitGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'propertyType';
    yield serializers.serialize(
      object.propertyType,
      specifiedType: const FullType(UnitGroupPropertyTypeEnum),
    );
    yield r'count';
    yield serializers.serialize(
      object.count,
      specifiedType: const FullType(int),
    );
    yield r'namePrefix';
    yield serializers.serialize(
      object.namePrefix,
      specifiedType: const FullType(String),
    );
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
        specifiedType: const FullType(UnitGroupRentalPeriodEnum),
      );
    }
    if (object.monthlyRent != null) {
      yield r'monthlyRent';
      yield serializers.serialize(
        object.monthlyRent,
        specifiedType: const FullType(int),
      );
    }
    if (object.chargesIncluded != null) {
      yield r'chargesIncluded';
      yield serializers.serialize(
        object.chargesIncluded,
        specifiedType: const FullType(bool),
      );
    }
    if (object.chargesAmount != null) {
      yield r'chargesAmount';
      yield serializers.serialize(
        object.chargesAmount,
        specifiedType: const FullType(int),
      );
    }
    if (object.surfaceArea != null) {
      yield r'surfaceArea';
      yield serializers.serialize(
        object.surfaceArea,
        specifiedType: const FullType(int),
      );
    }
    if (object.roomCount != null) {
      yield r'roomCount';
      yield serializers.serialize(
        object.roomCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.bathroomCount != null) {
      yield r'bathroomCount';
      yield serializers.serialize(
        object.bathroomCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.furnished != null) {
      yield r'furnished';
      yield serializers.serialize(
        object.furnished,
        specifiedType: const FullType(bool),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UnitGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnitGroupBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'propertyType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UnitGroupPropertyTypeEnum),
          ) as UnitGroupPropertyTypeEnum;
          result.propertyType = valueDes;
          break;
        case r'count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.count = valueDes;
          break;
        case r'namePrefix':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.namePrefix = valueDes;
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
            specifiedType: const FullType.nullable(UnitGroupRentalPeriodEnum),
          ) as UnitGroupRentalPeriodEnum?;
          if (valueDes == null) continue;
          result.rentalPeriod = valueDes;
          break;
        case r'monthlyRent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.monthlyRent = valueDes;
          break;
        case r'chargesIncluded':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.chargesIncluded = valueDes;
          break;
        case r'chargesAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.chargesAmount = valueDes;
          break;
        case r'surfaceArea':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.surfaceArea = valueDes;
          break;
        case r'roomCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.roomCount = valueDes;
          break;
        case r'bathroomCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.bathroomCount = valueDes;
          break;
        case r'furnished':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.furnished = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UnitGroup deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnitGroupBuilder();
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

class UnitGroupPropertyTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APARTMENT')
  static const UnitGroupPropertyTypeEnum APARTMENT = _$unitGroupPropertyTypeEnum_APARTMENT;
  @BuiltValueEnumConst(wireName: r'STUDIO')
  static const UnitGroupPropertyTypeEnum STUDIO = _$unitGroupPropertyTypeEnum_STUDIO;
  @BuiltValueEnumConst(wireName: r'VILLA')
  static const UnitGroupPropertyTypeEnum VILLA = _$unitGroupPropertyTypeEnum_VILLA;
  @BuiltValueEnumConst(wireName: r'ROOM')
  static const UnitGroupPropertyTypeEnum ROOM = _$unitGroupPropertyTypeEnum_ROOM;
  @BuiltValueEnumConst(wireName: r'OFFICE')
  static const UnitGroupPropertyTypeEnum OFFICE = _$unitGroupPropertyTypeEnum_OFFICE;
  @BuiltValueEnumConst(wireName: r'COMMERCIAL_SPACE')
  static const UnitGroupPropertyTypeEnum COMMERCIAL_SPACE = _$unitGroupPropertyTypeEnum_COMMERCIAL_SPACE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UnitGroupPropertyTypeEnum unknownDefaultOpenApi = _$unitGroupPropertyTypeEnum_unknownDefaultOpenApi;

  static Serializer<UnitGroupPropertyTypeEnum> get serializer => _$unitGroupPropertyTypeEnumSerializer;

  const UnitGroupPropertyTypeEnum._(String name): super(name);

  static BuiltSet<UnitGroupPropertyTypeEnum> get values => _$unitGroupPropertyTypeEnumValues;
  static UnitGroupPropertyTypeEnum valueOf(String name) => _$unitGroupPropertyTypeEnumValueOf(name);
}

class UnitGroupRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MONTH')
  static const UnitGroupRentalPeriodEnum MONTH = _$unitGroupRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const UnitGroupRentalPeriodEnum QUARTER = _$unitGroupRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const UnitGroupRentalPeriodEnum YEAR = _$unitGroupRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UnitGroupRentalPeriodEnum unknownDefaultOpenApi = _$unitGroupRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<UnitGroupRentalPeriodEnum> get serializer => _$unitGroupRentalPeriodEnumSerializer;

  const UnitGroupRentalPeriodEnum._(String name): super(name);

  static BuiltSet<UnitGroupRentalPeriodEnum> get values => _$unitGroupRentalPeriodEnumValues;
  static UnitGroupRentalPeriodEnum valueOf(String name) => _$unitGroupRentalPeriodEnumValueOf(name);
}

