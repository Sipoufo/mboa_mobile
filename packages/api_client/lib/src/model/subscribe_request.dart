//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subscribe_request.g.dart';

/// SubscribeRequest
///
/// Properties:
/// * [tier] 
/// * [method] 
@BuiltValue()
abstract class SubscribeRequest implements Built<SubscribeRequest, SubscribeRequestBuilder> {
  @BuiltValueField(wireName: r'tier')
  SubscribeRequestTierEnum get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'method')
  SubscribeRequestMethodEnum get method;
  // enum methodEnum {  MTN_MOMO,  ORANGE_MONEY,  };

  SubscribeRequest._();

  factory SubscribeRequest([void updates(SubscribeRequestBuilder b)]) = _$SubscribeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubscribeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubscribeRequest> get serializer => _$SubscribeRequestSerializer();
}

class _$SubscribeRequestSerializer implements PrimitiveSerializer<SubscribeRequest> {
  @override
  final Iterable<Type> types = const [SubscribeRequest, _$SubscribeRequest];

  @override
  final String wireName = r'SubscribeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubscribeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'tier';
    yield serializers.serialize(
      object.tier,
      specifiedType: const FullType(SubscribeRequestTierEnum),
    );
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(SubscribeRequestMethodEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SubscribeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubscribeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SubscribeRequestTierEnum),
          ) as SubscribeRequestTierEnum;
          result.tier = valueDes;
          break;
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SubscribeRequestMethodEnum),
          ) as SubscribeRequestMethodEnum;
          result.method = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubscribeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubscribeRequestBuilder();
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

class SubscribeRequestTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const SubscribeRequestTierEnum FREE = _$subscribeRequestTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const SubscribeRequestTierEnum BASIC_PLUS = _$subscribeRequestTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const SubscribeRequestTierEnum PRO = _$subscribeRequestTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const SubscribeRequestTierEnum PRO_PLUS = _$subscribeRequestTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SubscribeRequestTierEnum unknownDefaultOpenApi = _$subscribeRequestTierEnum_unknownDefaultOpenApi;

  static Serializer<SubscribeRequestTierEnum> get serializer => _$subscribeRequestTierEnumSerializer;

  const SubscribeRequestTierEnum._(String name): super(name);

  static BuiltSet<SubscribeRequestTierEnum> get values => _$subscribeRequestTierEnumValues;
  static SubscribeRequestTierEnum valueOf(String name) => _$subscribeRequestTierEnumValueOf(name);
}

class SubscribeRequestMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MTN_MOMO')
  static const SubscribeRequestMethodEnum MTN_MOMO = _$subscribeRequestMethodEnum_MTN_MOMO;
  @BuiltValueEnumConst(wireName: r'ORANGE_MONEY')
  static const SubscribeRequestMethodEnum ORANGE_MONEY = _$subscribeRequestMethodEnum_ORANGE_MONEY;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SubscribeRequestMethodEnum unknownDefaultOpenApi = _$subscribeRequestMethodEnum_unknownDefaultOpenApi;

  static Serializer<SubscribeRequestMethodEnum> get serializer => _$subscribeRequestMethodEnumSerializer;

  const SubscribeRequestMethodEnum._(String name): super(name);

  static BuiltSet<SubscribeRequestMethodEnum> get values => _$subscribeRequestMethodEnumValues;
  static SubscribeRequestMethodEnum valueOf(String name) => _$subscribeRequestMethodEnumValueOf(name);
}

