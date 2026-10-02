//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/score_signal.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mboa_score_response.g.dart';

/// MboaScoreResponse
///
/// Properties:
/// * [score] 
/// * [maxScore] 
/// * [signals] 
@BuiltValue()
abstract class MboaScoreResponse implements Built<MboaScoreResponse, MboaScoreResponseBuilder> {
  @BuiltValueField(wireName: r'score')
  int? get score;

  @BuiltValueField(wireName: r'maxScore')
  int? get maxScore;

  @BuiltValueField(wireName: r'signals')
  BuiltList<ScoreSignal>? get signals;

  MboaScoreResponse._();

  factory MboaScoreResponse([void updates(MboaScoreResponseBuilder b)]) = _$MboaScoreResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MboaScoreResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MboaScoreResponse> get serializer => _$MboaScoreResponseSerializer();
}

class _$MboaScoreResponseSerializer implements PrimitiveSerializer<MboaScoreResponse> {
  @override
  final Iterable<Type> types = const [MboaScoreResponse, _$MboaScoreResponse];

  @override
  final String wireName = r'MboaScoreResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MboaScoreResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.score != null) {
      yield r'score';
      yield serializers.serialize(
        object.score,
        specifiedType: const FullType(int),
      );
    }
    if (object.maxScore != null) {
      yield r'maxScore';
      yield serializers.serialize(
        object.maxScore,
        specifiedType: const FullType(int),
      );
    }
    if (object.signals != null) {
      yield r'signals';
      yield serializers.serialize(
        object.signals,
        specifiedType: const FullType(BuiltList, [FullType(ScoreSignal)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MboaScoreResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MboaScoreResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.score = valueDes;
          break;
        case r'maxScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.maxScore = valueDes;
          break;
        case r'signals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(ScoreSignal)]),
          ) as BuiltList<ScoreSignal>?;
          if (valueDes == null) continue;
          result.signals.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MboaScoreResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MboaScoreResponseBuilder();
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

