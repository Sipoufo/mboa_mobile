//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/availability_rule_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'availability_response.g.dart';

/// AvailabilityResponse
///
/// Properties:
/// * [rules] 
/// * [visitDurationMinutes] 
/// * [daysOff] 
@BuiltValue()
abstract class AvailabilityResponse implements Built<AvailabilityResponse, AvailabilityResponseBuilder> {
  @BuiltValueField(wireName: r'rules')
  BuiltList<AvailabilityRuleRequest>? get rules;

  @BuiltValueField(wireName: r'visitDurationMinutes')
  int? get visitDurationMinutes;

  @BuiltValueField(wireName: r'daysOff')
  BuiltList<Date>? get daysOff;

  AvailabilityResponse._();

  factory AvailabilityResponse([void updates(AvailabilityResponseBuilder b)]) = _$AvailabilityResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AvailabilityResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AvailabilityResponse> get serializer => _$AvailabilityResponseSerializer();
}

class _$AvailabilityResponseSerializer implements PrimitiveSerializer<AvailabilityResponse> {
  @override
  final Iterable<Type> types = const [AvailabilityResponse, _$AvailabilityResponse];

  @override
  final String wireName = r'AvailabilityResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AvailabilityResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.rules != null) {
      yield r'rules';
      yield serializers.serialize(
        object.rules,
        specifiedType: const FullType(BuiltList, [FullType(AvailabilityRuleRequest)]),
      );
    }
    if (object.visitDurationMinutes != null) {
      yield r'visitDurationMinutes';
      yield serializers.serialize(
        object.visitDurationMinutes,
        specifiedType: const FullType(int),
      );
    }
    if (object.daysOff != null) {
      yield r'daysOff';
      yield serializers.serialize(
        object.daysOff,
        specifiedType: const FullType(BuiltList, [FullType(Date)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AvailabilityResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AvailabilityResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rules':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(AvailabilityRuleRequest)]),
          ) as BuiltList<AvailabilityRuleRequest>?;
          if (valueDes == null) continue;
          result.rules.replace(valueDes);
          break;
        case r'visitDurationMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.visitDurationMinutes = valueDes;
          break;
        case r'daysOff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(Date)]),
          ) as BuiltList<Date>?;
          if (valueDes == null) continue;
          result.daysOff.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AvailabilityResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AvailabilityResponseBuilder();
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

