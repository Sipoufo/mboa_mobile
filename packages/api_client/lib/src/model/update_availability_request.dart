//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/availability_rule_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_availability_request.g.dart';

/// UpdateAvailabilityRequest
///
/// Properties:
/// * [rules] 
/// * [visitDurationMinutes] 
@BuiltValue()
abstract class UpdateAvailabilityRequest implements Built<UpdateAvailabilityRequest, UpdateAvailabilityRequestBuilder> {
  @BuiltValueField(wireName: r'rules')
  BuiltList<AvailabilityRuleRequest> get rules;

  @BuiltValueField(wireName: r'visitDurationMinutes')
  int? get visitDurationMinutes;

  UpdateAvailabilityRequest._();

  factory UpdateAvailabilityRequest([void updates(UpdateAvailabilityRequestBuilder b)]) = _$UpdateAvailabilityRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateAvailabilityRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateAvailabilityRequest> get serializer => _$UpdateAvailabilityRequestSerializer();
}

class _$UpdateAvailabilityRequestSerializer implements PrimitiveSerializer<UpdateAvailabilityRequest> {
  @override
  final Iterable<Type> types = const [UpdateAvailabilityRequest, _$UpdateAvailabilityRequest];

  @override
  final String wireName = r'UpdateAvailabilityRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateAvailabilityRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rules';
    yield serializers.serialize(
      object.rules,
      specifiedType: const FullType(BuiltList, [FullType(AvailabilityRuleRequest)]),
    );
    if (object.visitDurationMinutes != null) {
      yield r'visitDurationMinutes';
      yield serializers.serialize(
        object.visitDurationMinutes,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateAvailabilityRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateAvailabilityRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rules':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AvailabilityRuleRequest)]),
          ) as BuiltList<AvailabilityRuleRequest>;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateAvailabilityRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateAvailabilityRequestBuilder();
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

