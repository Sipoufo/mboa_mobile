//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submit_review_request.g.dart';

/// SubmitReviewRequest
///
/// Properties:
/// * [rating] 
/// * [perceivedCondition] 
/// * [comment] 
/// * [pros] 
/// * [cons] 
/// * [photoKeys] 
/// * [agentRating] 
@BuiltValue()
abstract class SubmitReviewRequest implements Built<SubmitReviewRequest, SubmitReviewRequestBuilder> {
  @BuiltValueField(wireName: r'rating')
  int get rating;

  @BuiltValueField(wireName: r'perceivedCondition')
  int? get perceivedCondition;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'pros')
  BuiltList<String>? get pros;

  @BuiltValueField(wireName: r'cons')
  BuiltList<String>? get cons;

  @BuiltValueField(wireName: r'photoKeys')
  BuiltList<String>? get photoKeys;

  @BuiltValueField(wireName: r'agentRating')
  int? get agentRating;

  SubmitReviewRequest._();

  factory SubmitReviewRequest([void updates(SubmitReviewRequestBuilder b)]) = _$SubmitReviewRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmitReviewRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubmitReviewRequest> get serializer => _$SubmitReviewRequestSerializer();
}

class _$SubmitReviewRequestSerializer implements PrimitiveSerializer<SubmitReviewRequest> {
  @override
  final Iterable<Type> types = const [SubmitReviewRequest, _$SubmitReviewRequest];

  @override
  final String wireName = r'SubmitReviewRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubmitReviewRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rating';
    yield serializers.serialize(
      object.rating,
      specifiedType: const FullType(int),
    );
    if (object.perceivedCondition != null) {
      yield r'perceivedCondition';
      yield serializers.serialize(
        object.perceivedCondition,
        specifiedType: const FullType(int),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
    if (object.pros != null) {
      yield r'pros';
      yield serializers.serialize(
        object.pros,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.cons != null) {
      yield r'cons';
      yield serializers.serialize(
        object.cons,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.photoKeys != null) {
      yield r'photoKeys';
      yield serializers.serialize(
        object.photoKeys,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.agentRating != null) {
      yield r'agentRating';
      yield serializers.serialize(
        object.agentRating,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SubmitReviewRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubmitReviewRequestBuilder result,
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
        case r'perceivedCondition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.perceivedCondition = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        case r'pros':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.pros.replace(valueDes);
          break;
        case r'cons':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.cons.replace(valueDes);
          break;
        case r'photoKeys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.photoKeys.replace(valueDes);
          break;
        case r'agentRating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.agentRating = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubmitReviewRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmitReviewRequestBuilder();
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

