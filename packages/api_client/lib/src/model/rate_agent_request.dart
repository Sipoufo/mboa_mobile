//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'rate_agent_request.g.dart';

/// RateAgentRequest
///
/// Properties:
/// * [rating] 
@BuiltValue()
abstract class RateAgentRequest implements Built<RateAgentRequest, RateAgentRequestBuilder> {
  @BuiltValueField(wireName: r'rating')
  int get rating;

  RateAgentRequest._();

  factory RateAgentRequest([void updates(RateAgentRequestBuilder b)]) = _$RateAgentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RateAgentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RateAgentRequest> get serializer => _$RateAgentRequestSerializer();
}

class _$RateAgentRequestSerializer implements PrimitiveSerializer<RateAgentRequest> {
  @override
  final Iterable<Type> types = const [RateAgentRequest, _$RateAgentRequest];

  @override
  final String wireName = r'RateAgentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RateAgentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rating';
    yield serializers.serialize(
      object.rating,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RateAgentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RateAgentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.rating = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RateAgentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RateAgentRequestBuilder();
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

