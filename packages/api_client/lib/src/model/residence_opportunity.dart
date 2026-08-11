//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/type_count.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'residence_opportunity.g.dart';

/// ResidenceOpportunity
///
/// Properties:
/// * [residenceId] 
/// * [residenceName] 
/// * [primaryPhotoKey] 
/// * [city] 
/// * [district] 
/// * [unitCount] 
/// * [breakdown] 
/// * [fromPrice] 
/// * [fromRentalPeriod] 
/// * [fromMonthlyRent] 
@BuiltValue()
abstract class ResidenceOpportunity implements Built<ResidenceOpportunity, ResidenceOpportunityBuilder> {
  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'residenceName')
  String? get residenceName;

  @BuiltValueField(wireName: r'primaryPhotoKey')
  String? get primaryPhotoKey;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'district')
  String? get district;

  @BuiltValueField(wireName: r'unitCount')
  int? get unitCount;

  @BuiltValueField(wireName: r'breakdown')
  BuiltList<TypeCount>? get breakdown;

  @BuiltValueField(wireName: r'fromPrice')
  int? get fromPrice;

  @BuiltValueField(wireName: r'fromRentalPeriod')
  ResidenceOpportunityFromRentalPeriodEnum? get fromRentalPeriod;
  // enum fromRentalPeriodEnum {  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'fromMonthlyRent')
  int? get fromMonthlyRent;

  ResidenceOpportunity._();

  factory ResidenceOpportunity([void updates(ResidenceOpportunityBuilder b)]) = _$ResidenceOpportunity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResidenceOpportunityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResidenceOpportunity> get serializer => _$ResidenceOpportunitySerializer();
}

class _$ResidenceOpportunitySerializer implements PrimitiveSerializer<ResidenceOpportunity> {
  @override
  final Iterable<Type> types = const [ResidenceOpportunity, _$ResidenceOpportunity];

  @override
  final String wireName = r'ResidenceOpportunity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResidenceOpportunity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.residenceId != null) {
      yield r'residenceId';
      yield serializers.serialize(
        object.residenceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.residenceName != null) {
      yield r'residenceName';
      yield serializers.serialize(
        object.residenceName,
        specifiedType: const FullType(String),
      );
    }
    if (object.primaryPhotoKey != null) {
      yield r'primaryPhotoKey';
      yield serializers.serialize(
        object.primaryPhotoKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType(String),
      );
    }
    if (object.district != null) {
      yield r'district';
      yield serializers.serialize(
        object.district,
        specifiedType: const FullType(String),
      );
    }
    if (object.unitCount != null) {
      yield r'unitCount';
      yield serializers.serialize(
        object.unitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.breakdown != null) {
      yield r'breakdown';
      yield serializers.serialize(
        object.breakdown,
        specifiedType: const FullType(BuiltList, [FullType(TypeCount)]),
      );
    }
    if (object.fromPrice != null) {
      yield r'fromPrice';
      yield serializers.serialize(
        object.fromPrice,
        specifiedType: const FullType(int),
      );
    }
    if (object.fromRentalPeriod != null) {
      yield r'fromRentalPeriod';
      yield serializers.serialize(
        object.fromRentalPeriod,
        specifiedType: const FullType(ResidenceOpportunityFromRentalPeriodEnum),
      );
    }
    if (object.fromMonthlyRent != null) {
      yield r'fromMonthlyRent';
      yield serializers.serialize(
        object.fromMonthlyRent,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ResidenceOpportunity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResidenceOpportunityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'residenceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceId = valueDes;
          break;
        case r'residenceName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceName = valueDes;
          break;
        case r'primaryPhotoKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.primaryPhotoKey = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'district':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.district = valueDes;
          break;
        case r'unitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.unitCount = valueDes;
          break;
        case r'breakdown':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(TypeCount)]),
          ) as BuiltList<TypeCount>?;
          if (valueDes == null) continue;
          result.breakdown.replace(valueDes);
          break;
        case r'fromPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.fromPrice = valueDes;
          break;
        case r'fromRentalPeriod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ResidenceOpportunityFromRentalPeriodEnum),
          ) as ResidenceOpportunityFromRentalPeriodEnum?;
          if (valueDes == null) continue;
          result.fromRentalPeriod = valueDes;
          break;
        case r'fromMonthlyRent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.fromMonthlyRent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResidenceOpportunity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResidenceOpportunityBuilder();
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

class ResidenceOpportunityFromRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MONTH')
  static const ResidenceOpportunityFromRentalPeriodEnum MONTH = _$residenceOpportunityFromRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const ResidenceOpportunityFromRentalPeriodEnum QUARTER = _$residenceOpportunityFromRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const ResidenceOpportunityFromRentalPeriodEnum YEAR = _$residenceOpportunityFromRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ResidenceOpportunityFromRentalPeriodEnum unknownDefaultOpenApi = _$residenceOpportunityFromRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<ResidenceOpportunityFromRentalPeriodEnum> get serializer => _$residenceOpportunityFromRentalPeriodEnumSerializer;

  const ResidenceOpportunityFromRentalPeriodEnum._(String name): super(name);

  static BuiltSet<ResidenceOpportunityFromRentalPeriodEnum> get values => _$residenceOpportunityFromRentalPeriodEnumValues;
  static ResidenceOpportunityFromRentalPeriodEnum valueOf(String name) => _$residenceOpportunityFromRentalPeriodEnumValueOf(name);
}

