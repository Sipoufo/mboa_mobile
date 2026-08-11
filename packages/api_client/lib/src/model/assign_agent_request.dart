//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'assign_agent_request.g.dart';

/// AssignAgentRequest
///
/// Properties:
/// * [agentAccountId] 
@BuiltValue()
abstract class AssignAgentRequest implements Built<AssignAgentRequest, AssignAgentRequestBuilder> {
  @BuiltValueField(wireName: r'agentAccountId')
  String get agentAccountId;

  AssignAgentRequest._();

  factory AssignAgentRequest([void updates(AssignAgentRequestBuilder b)]) = _$AssignAgentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AssignAgentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AssignAgentRequest> get serializer => _$AssignAgentRequestSerializer();
}

class _$AssignAgentRequestSerializer implements PrimitiveSerializer<AssignAgentRequest> {
  @override
  final Iterable<Type> types = const [AssignAgentRequest, _$AssignAgentRequest];

  @override
  final String wireName = r'AssignAgentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AssignAgentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'agentAccountId';
    yield serializers.serialize(
      object.agentAccountId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AssignAgentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AssignAgentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'agentAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.agentAccountId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AssignAgentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AssignAgentRequestBuilder();
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

