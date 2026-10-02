//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/mboa_score_response.dart';
import 'package:api_client/src/model/score_adjustment_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_mboa_score_response.g.dart';

/// AdminMboaScoreResponse
///
/// Properties:
/// * [score] 
/// * [adjustments] 
@BuiltValue()
abstract class AdminMboaScoreResponse implements Built<AdminMboaScoreResponse, AdminMboaScoreResponseBuilder> {
  @BuiltValueField(wireName: r'score')
  MboaScoreResponse? get score;

  @BuiltValueField(wireName: r'adjustments')
  BuiltList<ScoreAdjustmentResponse>? get adjustments;

  AdminMboaScoreResponse._();

  factory AdminMboaScoreResponse([void updates(AdminMboaScoreResponseBuilder b)]) = _$AdminMboaScoreResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminMboaScoreResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminMboaScoreResponse> get serializer => _$AdminMboaScoreResponseSerializer();
}

class _$AdminMboaScoreResponseSerializer implements PrimitiveSerializer<AdminMboaScoreResponse> {
  @override
  final Iterable<Type> types = const [AdminMboaScoreResponse, _$AdminMboaScoreResponse];

  @override
  final String wireName = r'AdminMboaScoreResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminMboaScoreResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.score != null) {
      yield r'score';
      yield serializers.serialize(
        object.score,
        specifiedType: const FullType(MboaScoreResponse),
      );
    }
    if (object.adjustments != null) {
      yield r'adjustments';
      yield serializers.serialize(
        object.adjustments,
        specifiedType: const FullType(BuiltList, [FullType(ScoreAdjustmentResponse)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminMboaScoreResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminMboaScoreResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MboaScoreResponse),
          ) as MboaScoreResponse?;
          if (valueDes == null) continue;
          result.score.replace(valueDes);
          break;
        case r'adjustments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(ScoreAdjustmentResponse)]),
          ) as BuiltList<ScoreAdjustmentResponse>?;
          if (valueDes == null) continue;
          result.adjustments.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminMboaScoreResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminMboaScoreResponseBuilder();
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

