//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'agent_opportunity.g.dart';

/// AgentOpportunity
///
/// Properties:
/// * [annonceId] 
/// * [title] 
/// * [primaryPhotoKey] 
/// * [price] 
/// * [rentalPeriod] 
/// * [monthlyRent] 
/// * [city] 
/// * [district] 
@BuiltValue()
abstract class AgentOpportunity implements Built<AgentOpportunity, AgentOpportunityBuilder> {
  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'primaryPhotoKey')
  String? get primaryPhotoKey;

  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  AgentOpportunityRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'monthlyRent')
  int? get monthlyRent;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'district')
  String? get district;

  AgentOpportunity._();

  factory AgentOpportunity([void updates(AgentOpportunityBuilder b)]) = _$AgentOpportunity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AgentOpportunityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AgentOpportunity> get serializer => _$AgentOpportunitySerializer();
}

class _$AgentOpportunitySerializer implements PrimitiveSerializer<AgentOpportunity> {
  @override
  final Iterable<Type> types = const [AgentOpportunity, _$AgentOpportunity];

  @override
  final String wireName = r'AgentOpportunity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AgentOpportunity object, {
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
    if (object.primaryPhotoKey != null) {
      yield r'primaryPhotoKey';
      yield serializers.serialize(
        object.primaryPhotoKey,
        specifiedType: const FullType(String),
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
        specifiedType: const FullType(AgentOpportunityRentalPeriodEnum),
      );
    }
    if (object.monthlyRent != null) {
      yield r'monthlyRent';
      yield serializers.serialize(
        object.monthlyRent,
        specifiedType: const FullType(int),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    AgentOpportunity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AgentOpportunityBuilder result,
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
        case r'primaryPhotoKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.primaryPhotoKey = valueDes;
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
            specifiedType: const FullType.nullable(AgentOpportunityRentalPeriodEnum),
          ) as AgentOpportunityRentalPeriodEnum?;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AgentOpportunity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AgentOpportunityBuilder();
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

class AgentOpportunityRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MONTH')
  static const AgentOpportunityRentalPeriodEnum MONTH = _$agentOpportunityRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const AgentOpportunityRentalPeriodEnum QUARTER = _$agentOpportunityRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const AgentOpportunityRentalPeriodEnum YEAR = _$agentOpportunityRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AgentOpportunityRentalPeriodEnum unknownDefaultOpenApi = _$agentOpportunityRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<AgentOpportunityRentalPeriodEnum> get serializer => _$agentOpportunityRentalPeriodEnumSerializer;

  const AgentOpportunityRentalPeriodEnum._(String name): super(name);

  static BuiltSet<AgentOpportunityRentalPeriodEnum> get values => _$agentOpportunityRentalPeriodEnumValues;
  static AgentOpportunityRentalPeriodEnum valueOf(String name) => _$agentOpportunityRentalPeriodEnumValueOf(name);
}

