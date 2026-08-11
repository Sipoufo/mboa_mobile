//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unit_summary.g.dart';

/// UnitSummary
///
/// Properties:
/// * [id] 
/// * [title] 
/// * [propertyType] 
/// * [status] 
/// * [price] 
/// * [rentalPeriod] 
/// * [monthlyRent] 
@BuiltValue()
abstract class UnitSummary implements Built<UnitSummary, UnitSummaryBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'propertyType')
  UnitSummaryPropertyTypeEnum? get propertyType;
  // enum propertyTypeEnum {  APARTMENT,  STUDIO,  VILLA,  ROOM,  OFFICE,  COMMERCIAL_SPACE,  };

  @BuiltValueField(wireName: r'status')
  UnitSummaryStatusEnum? get status;
  // enum statusEnum {  DRAFT,  PUBLISHED,  RESERVED,  RENTED,  ARCHIVED,  SUSPENDED,  };

  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  UnitSummaryRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'monthlyRent')
  int? get monthlyRent;

  UnitSummary._();

  factory UnitSummary([void updates(UnitSummaryBuilder b)]) = _$UnitSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnitSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnitSummary> get serializer => _$UnitSummarySerializer();
}

class _$UnitSummarySerializer implements PrimitiveSerializer<UnitSummary> {
  @override
  final Iterable<Type> types = const [UnitSummary, _$UnitSummary];

  @override
  final String wireName = r'UnitSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnitSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
        specifiedType: const FullType(UnitSummaryPropertyTypeEnum),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(UnitSummaryStatusEnum),
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
        specifiedType: const FullType(UnitSummaryRentalPeriodEnum),
      );
    }
    if (object.monthlyRent != null) {
      yield r'monthlyRent';
      yield serializers.serialize(
        object.monthlyRent,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UnitSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnitSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
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
            specifiedType: const FullType.nullable(UnitSummaryPropertyTypeEnum),
          ) as UnitSummaryPropertyTypeEnum?;
          if (valueDes == null) continue;
          result.propertyType = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UnitSummaryStatusEnum),
          ) as UnitSummaryStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
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
            specifiedType: const FullType.nullable(UnitSummaryRentalPeriodEnum),
          ) as UnitSummaryRentalPeriodEnum?;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UnitSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnitSummaryBuilder();
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

class UnitSummaryPropertyTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APARTMENT')
  static const UnitSummaryPropertyTypeEnum APARTMENT = _$unitSummaryPropertyTypeEnum_APARTMENT;
  @BuiltValueEnumConst(wireName: r'STUDIO')
  static const UnitSummaryPropertyTypeEnum STUDIO = _$unitSummaryPropertyTypeEnum_STUDIO;
  @BuiltValueEnumConst(wireName: r'VILLA')
  static const UnitSummaryPropertyTypeEnum VILLA = _$unitSummaryPropertyTypeEnum_VILLA;
  @BuiltValueEnumConst(wireName: r'ROOM')
  static const UnitSummaryPropertyTypeEnum ROOM = _$unitSummaryPropertyTypeEnum_ROOM;
  @BuiltValueEnumConst(wireName: r'OFFICE')
  static const UnitSummaryPropertyTypeEnum OFFICE = _$unitSummaryPropertyTypeEnum_OFFICE;
  @BuiltValueEnumConst(wireName: r'COMMERCIAL_SPACE')
  static const UnitSummaryPropertyTypeEnum COMMERCIAL_SPACE = _$unitSummaryPropertyTypeEnum_COMMERCIAL_SPACE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UnitSummaryPropertyTypeEnum unknownDefaultOpenApi = _$unitSummaryPropertyTypeEnum_unknownDefaultOpenApi;

  static Serializer<UnitSummaryPropertyTypeEnum> get serializer => _$unitSummaryPropertyTypeEnumSerializer;

  const UnitSummaryPropertyTypeEnum._(String name): super(name);

  static BuiltSet<UnitSummaryPropertyTypeEnum> get values => _$unitSummaryPropertyTypeEnumValues;
  static UnitSummaryPropertyTypeEnum valueOf(String name) => _$unitSummaryPropertyTypeEnumValueOf(name);
}

class UnitSummaryStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DRAFT')
  static const UnitSummaryStatusEnum DRAFT = _$unitSummaryStatusEnum_DRAFT;
  @BuiltValueEnumConst(wireName: r'PUBLISHED')
  static const UnitSummaryStatusEnum PUBLISHED = _$unitSummaryStatusEnum_PUBLISHED;
  @BuiltValueEnumConst(wireName: r'RESERVED')
  static const UnitSummaryStatusEnum RESERVED = _$unitSummaryStatusEnum_RESERVED;
  @BuiltValueEnumConst(wireName: r'RENTED')
  static const UnitSummaryStatusEnum RENTED = _$unitSummaryStatusEnum_RENTED;
  @BuiltValueEnumConst(wireName: r'ARCHIVED')
  static const UnitSummaryStatusEnum ARCHIVED = _$unitSummaryStatusEnum_ARCHIVED;
  @BuiltValueEnumConst(wireName: r'SUSPENDED')
  static const UnitSummaryStatusEnum SUSPENDED = _$unitSummaryStatusEnum_SUSPENDED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UnitSummaryStatusEnum unknownDefaultOpenApi = _$unitSummaryStatusEnum_unknownDefaultOpenApi;

  static Serializer<UnitSummaryStatusEnum> get serializer => _$unitSummaryStatusEnumSerializer;

  const UnitSummaryStatusEnum._(String name): super(name);

  static BuiltSet<UnitSummaryStatusEnum> get values => _$unitSummaryStatusEnumValues;
  static UnitSummaryStatusEnum valueOf(String name) => _$unitSummaryStatusEnumValueOf(name);
}

class UnitSummaryRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const UnitSummaryRentalPeriodEnum DAY = _$unitSummaryRentalPeriodEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const UnitSummaryRentalPeriodEnum WEEK = _$unitSummaryRentalPeriodEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const UnitSummaryRentalPeriodEnum MONTH = _$unitSummaryRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const UnitSummaryRentalPeriodEnum QUARTER = _$unitSummaryRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const UnitSummaryRentalPeriodEnum YEAR = _$unitSummaryRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UnitSummaryRentalPeriodEnum unknownDefaultOpenApi = _$unitSummaryRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<UnitSummaryRentalPeriodEnum> get serializer => _$unitSummaryRentalPeriodEnumSerializer;

  const UnitSummaryRentalPeriodEnum._(String name): super(name);

  static BuiltSet<UnitSummaryRentalPeriodEnum> get values => _$unitSummaryRentalPeriodEnumValues;
  static UnitSummaryRentalPeriodEnum valueOf(String name) => _$unitSummaryRentalPeriodEnumValueOf(name);
}

