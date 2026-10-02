//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'score_adjustment_request.g.dart';

/// ScoreAdjustmentRequest
///
/// Properties:
/// * [delta] 
/// * [reason] 
@BuiltValue()
abstract class ScoreAdjustmentRequest implements Built<ScoreAdjustmentRequest, ScoreAdjustmentRequestBuilder> {
  @BuiltValueField(wireName: r'delta')
  int get delta;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  ScoreAdjustmentRequest._();

  factory ScoreAdjustmentRequest([void updates(ScoreAdjustmentRequestBuilder b)]) = _$ScoreAdjustmentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScoreAdjustmentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScoreAdjustmentRequest> get serializer => _$ScoreAdjustmentRequestSerializer();
}

class _$ScoreAdjustmentRequestSerializer implements PrimitiveSerializer<ScoreAdjustmentRequest> {
  @override
  final Iterable<Type> types = const [ScoreAdjustmentRequest, _$ScoreAdjustmentRequest];

  @override
  final String wireName = r'ScoreAdjustmentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScoreAdjustmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'delta';
    yield serializers.serialize(
      object.delta,
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
    ScoreAdjustmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScoreAdjustmentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'delta':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.delta = valueDes;
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
  ScoreAdjustmentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScoreAdjustmentRequestBuilder();
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

