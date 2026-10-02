//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'score_adjustment_response.g.dart';

/// ScoreAdjustmentResponse
///
/// Properties:
/// * [id] 
/// * [delta] 
/// * [reason] 
/// * [adminAccountId] 
/// * [createdAt] 
@BuiltValue()
abstract class ScoreAdjustmentResponse implements Built<ScoreAdjustmentResponse, ScoreAdjustmentResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'delta')
  int? get delta;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  @BuiltValueField(wireName: r'adminAccountId')
  String? get adminAccountId;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  ScoreAdjustmentResponse._();

  factory ScoreAdjustmentResponse([void updates(ScoreAdjustmentResponseBuilder b)]) = _$ScoreAdjustmentResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScoreAdjustmentResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScoreAdjustmentResponse> get serializer => _$ScoreAdjustmentResponseSerializer();
}

class _$ScoreAdjustmentResponseSerializer implements PrimitiveSerializer<ScoreAdjustmentResponse> {
  @override
  final Iterable<Type> types = const [ScoreAdjustmentResponse, _$ScoreAdjustmentResponse];

  @override
  final String wireName = r'ScoreAdjustmentResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScoreAdjustmentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.delta != null) {
      yield r'delta';
      yield serializers.serialize(
        object.delta,
        specifiedType: const FullType(int),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
    if (object.adminAccountId != null) {
      yield r'adminAccountId';
      yield serializers.serialize(
        object.adminAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ScoreAdjustmentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScoreAdjustmentResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'delta':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.delta = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'adminAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.adminAccountId = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScoreAdjustmentResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScoreAdjustmentResponseBuilder();
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

