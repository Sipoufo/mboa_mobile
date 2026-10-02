//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'badge_decision_request.g.dart';

/// BadgeDecisionRequest
///
/// Properties:
/// * [reason] 
@BuiltValue()
abstract class BadgeDecisionRequest implements Built<BadgeDecisionRequest, BadgeDecisionRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  String get reason;

  BadgeDecisionRequest._();

  factory BadgeDecisionRequest([void updates(BadgeDecisionRequestBuilder b)]) = _$BadgeDecisionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BadgeDecisionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BadgeDecisionRequest> get serializer => _$BadgeDecisionRequestSerializer();
}

class _$BadgeDecisionRequestSerializer implements PrimitiveSerializer<BadgeDecisionRequest> {
  @override
  final Iterable<Type> types = const [BadgeDecisionRequest, _$BadgeDecisionRequest];

  @override
  final String wireName = r'BadgeDecisionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BadgeDecisionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BadgeDecisionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BadgeDecisionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  BadgeDecisionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BadgeDecisionRequestBuilder();
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

