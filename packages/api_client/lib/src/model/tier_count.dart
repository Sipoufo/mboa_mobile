//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tier_count.g.dart';

/// TierCount
///
/// Properties:
/// * [tier] 
/// * [active] 
/// * [paid] 
/// * [unpaid] 
@BuiltValue()
abstract class TierCount implements Built<TierCount, TierCountBuilder> {
  @BuiltValueField(wireName: r'tier')
  TierCountTierEnum? get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'active')
  int? get active;

  @BuiltValueField(wireName: r'paid')
  int? get paid;

  @BuiltValueField(wireName: r'unpaid')
  int? get unpaid;

  TierCount._();

  factory TierCount([void updates(TierCountBuilder b)]) = _$TierCount;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TierCountBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TierCount> get serializer => _$TierCountSerializer();
}

class _$TierCountSerializer implements PrimitiveSerializer<TierCount> {
  @override
  final Iterable<Type> types = const [TierCount, _$TierCount];

  @override
  final String wireName = r'TierCount';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TierCount object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.tier != null) {
      yield r'tier';
      yield serializers.serialize(
        object.tier,
        specifiedType: const FullType(TierCountTierEnum),
      );
    }
    if (object.active != null) {
      yield r'active';
      yield serializers.serialize(
        object.active,
        specifiedType: const FullType(int),
      );
    }
    if (object.paid != null) {
      yield r'paid';
      yield serializers.serialize(
        object.paid,
        specifiedType: const FullType(int),
      );
    }
    if (object.unpaid != null) {
      yield r'unpaid';
      yield serializers.serialize(
        object.unpaid,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TierCount object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TierCountBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TierCountTierEnum),
          ) as TierCountTierEnum?;
          if (valueDes == null) continue;
          result.tier = valueDes;
          break;
        case r'active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.active = valueDes;
          break;
        case r'paid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.paid = valueDes;
          break;
        case r'unpaid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.unpaid = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TierCount deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TierCountBuilder();
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

class TierCountTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const TierCountTierEnum FREE = _$tierCountTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const TierCountTierEnum BASIC_PLUS = _$tierCountTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const TierCountTierEnum PRO = _$tierCountTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const TierCountTierEnum PRO_PLUS = _$tierCountTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TierCountTierEnum unknownDefaultOpenApi = _$tierCountTierEnum_unknownDefaultOpenApi;

  static Serializer<TierCountTierEnum> get serializer => _$tierCountTierEnumSerializer;

  const TierCountTierEnum._(String name): super(name);

  static BuiltSet<TierCountTierEnum> get values => _$tierCountTierEnumValues;
  static TierCountTierEnum valueOf(String name) => _$tierCountTierEnumValueOf(name);
}

