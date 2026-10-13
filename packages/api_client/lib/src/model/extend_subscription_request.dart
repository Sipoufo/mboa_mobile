//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'extend_subscription_request.g.dart';

/// ExtendSubscriptionRequest
///
/// Properties:
/// * [days] 
/// * [reason] 
@BuiltValue()
abstract class ExtendSubscriptionRequest implements Built<ExtendSubscriptionRequest, ExtendSubscriptionRequestBuilder> {
  @BuiltValueField(wireName: r'days')
  int get days;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  ExtendSubscriptionRequest._();

  factory ExtendSubscriptionRequest([void updates(ExtendSubscriptionRequestBuilder b)]) = _$ExtendSubscriptionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExtendSubscriptionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExtendSubscriptionRequest> get serializer => _$ExtendSubscriptionRequestSerializer();
}

class _$ExtendSubscriptionRequestSerializer implements PrimitiveSerializer<ExtendSubscriptionRequest> {
  @override
  final Iterable<Type> types = const [ExtendSubscriptionRequest, _$ExtendSubscriptionRequest];

  @override
  final String wireName = r'ExtendSubscriptionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExtendSubscriptionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'days';
    yield serializers.serialize(
      object.days,
      specifiedType: const FullType(int),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExtendSubscriptionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExtendSubscriptionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.days = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExtendSubscriptionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExtendSubscriptionRequestBuilder();
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

