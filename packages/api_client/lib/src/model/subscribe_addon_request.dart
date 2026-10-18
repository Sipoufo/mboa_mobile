//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subscribe_addon_request.g.dart';

/// SubscribeAddonRequest
///
/// Properties:
/// * [method] 
@BuiltValue()
abstract class SubscribeAddonRequest implements Built<SubscribeAddonRequest, SubscribeAddonRequestBuilder> {
  @BuiltValueField(wireName: r'method')
  SubscribeAddonRequestMethodEnum get method;
  // enum methodEnum {  MTN_MOMO,  ORANGE_MONEY,  };

  SubscribeAddonRequest._();

  factory SubscribeAddonRequest([void updates(SubscribeAddonRequestBuilder b)]) = _$SubscribeAddonRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubscribeAddonRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubscribeAddonRequest> get serializer => _$SubscribeAddonRequestSerializer();
}

class _$SubscribeAddonRequestSerializer implements PrimitiveSerializer<SubscribeAddonRequest> {
  @override
  final Iterable<Type> types = const [SubscribeAddonRequest, _$SubscribeAddonRequest];

  @override
  final String wireName = r'SubscribeAddonRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubscribeAddonRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(SubscribeAddonRequestMethodEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SubscribeAddonRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubscribeAddonRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SubscribeAddonRequestMethodEnum),
          ) as SubscribeAddonRequestMethodEnum;
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
  SubscribeAddonRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubscribeAddonRequestBuilder();
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

class SubscribeAddonRequestMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MTN_MOMO')
  static const SubscribeAddonRequestMethodEnum MTN_MOMO = _$subscribeAddonRequestMethodEnum_MTN_MOMO;
  @BuiltValueEnumConst(wireName: r'ORANGE_MONEY')
  static const SubscribeAddonRequestMethodEnum ORANGE_MONEY = _$subscribeAddonRequestMethodEnum_ORANGE_MONEY;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SubscribeAddonRequestMethodEnum unknownDefaultOpenApi = _$subscribeAddonRequestMethodEnum_unknownDefaultOpenApi;

  static Serializer<SubscribeAddonRequestMethodEnum> get serializer => _$subscribeAddonRequestMethodEnumSerializer;

  const SubscribeAddonRequestMethodEnum._(String name): super(name);

  static BuiltSet<SubscribeAddonRequestMethodEnum> get values => _$subscribeAddonRequestMethodEnumValues;
  static SubscribeAddonRequestMethodEnum valueOf(String name) => _$subscribeAddonRequestMethodEnumValueOf(name);
}

