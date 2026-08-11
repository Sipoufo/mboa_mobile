//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'availability_rule_request.g.dart';

/// AvailabilityRuleRequest
///
/// Properties:
/// * [dayOfWeek] 
/// * [startTime] 
/// * [endTime] 
@BuiltValue()
abstract class AvailabilityRuleRequest implements Built<AvailabilityRuleRequest, AvailabilityRuleRequestBuilder> {
  @BuiltValueField(wireName: r'dayOfWeek')
  int get dayOfWeek;

  @BuiltValueField(wireName: r'startTime')
  String get startTime;

  @BuiltValueField(wireName: r'endTime')
  String get endTime;

  AvailabilityRuleRequest._();

  factory AvailabilityRuleRequest([void updates(AvailabilityRuleRequestBuilder b)]) = _$AvailabilityRuleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AvailabilityRuleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AvailabilityRuleRequest> get serializer => _$AvailabilityRuleRequestSerializer();
}

class _$AvailabilityRuleRequestSerializer implements PrimitiveSerializer<AvailabilityRuleRequest> {
  @override
  final Iterable<Type> types = const [AvailabilityRuleRequest, _$AvailabilityRuleRequest];

  @override
  final String wireName = r'AvailabilityRuleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AvailabilityRuleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'dayOfWeek';
    yield serializers.serialize(
      object.dayOfWeek,
      specifiedType: const FullType(int),
    );
    yield r'startTime';
    yield serializers.serialize(
      object.startTime,
      specifiedType: const FullType(String),
    );
    yield r'endTime';
    yield serializers.serialize(
      object.endTime,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AvailabilityRuleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AvailabilityRuleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'dayOfWeek':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.dayOfWeek = valueDes;
          break;
        case r'startTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.startTime = valueDes;
          break;
        case r'endTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.endTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AvailabilityRuleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AvailabilityRuleRequestBuilder();
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

