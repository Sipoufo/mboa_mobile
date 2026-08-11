//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/residence_opportunity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/agent_opportunity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'opportunity_item.g.dart';

/// OpportunityItem
///
/// Properties:
/// * [type] 
/// * [listing] 
/// * [residence] 
@BuiltValue()
abstract class OpportunityItem implements Built<OpportunityItem, OpportunityItemBuilder> {
  @BuiltValueField(wireName: r'type')
  OpportunityItemTypeEnum? get type;
  // enum typeEnum {  LISTING,  RESIDENCE,  };

  @BuiltValueField(wireName: r'listing')
  AgentOpportunity? get listing;

  @BuiltValueField(wireName: r'residence')
  ResidenceOpportunity? get residence;

  OpportunityItem._();

  factory OpportunityItem([void updates(OpportunityItemBuilder b)]) = _$OpportunityItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OpportunityItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OpportunityItem> get serializer => _$OpportunityItemSerializer();
}

class _$OpportunityItemSerializer implements PrimitiveSerializer<OpportunityItem> {
  @override
  final Iterable<Type> types = const [OpportunityItem, _$OpportunityItem];

  @override
  final String wireName = r'OpportunityItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OpportunityItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(OpportunityItemTypeEnum),
      );
    }
    if (object.listing != null) {
      yield r'listing';
      yield serializers.serialize(
        object.listing,
        specifiedType: const FullType(AgentOpportunity),
      );
    }
    if (object.residence != null) {
      yield r'residence';
      yield serializers.serialize(
        object.residence,
        specifiedType: const FullType(ResidenceOpportunity),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OpportunityItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OpportunityItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OpportunityItemTypeEnum),
          ) as OpportunityItemTypeEnum?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'listing':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AgentOpportunity),
          ) as AgentOpportunity?;
          if (valueDes == null) continue;
          result.listing.replace(valueDes);
          break;
        case r'residence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ResidenceOpportunity),
          ) as ResidenceOpportunity?;
          if (valueDes == null) continue;
          result.residence.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OpportunityItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OpportunityItemBuilder();
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

class OpportunityItemTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LISTING')
  static const OpportunityItemTypeEnum LISTING = _$opportunityItemTypeEnum_LISTING;
  @BuiltValueEnumConst(wireName: r'RESIDENCE')
  static const OpportunityItemTypeEnum RESIDENCE = _$opportunityItemTypeEnum_RESIDENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OpportunityItemTypeEnum unknownDefaultOpenApi = _$opportunityItemTypeEnum_unknownDefaultOpenApi;

  static Serializer<OpportunityItemTypeEnum> get serializer => _$opportunityItemTypeEnumSerializer;

  const OpportunityItemTypeEnum._(String name): super(name);

  static BuiltSet<OpportunityItemTypeEnum> get values => _$opportunityItemTypeEnumValues;
  static OpportunityItemTypeEnum valueOf(String name) => _$opportunityItemTypeEnumValueOf(name);
}

