//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/comment.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'review_response.g.dart';

/// ReviewResponse
///
/// Properties:
/// * [id] 
/// * [annonceId] 
/// * [authorName] 
/// * [rating] 
/// * [perceivedCondition] 
/// * [comment] 
/// * [pros] 
/// * [cons] 
/// * [photoKeys] 
/// * [publishedAt] 
/// * [comments] 
@BuiltValue()
abstract class ReviewResponse implements Built<ReviewResponse, ReviewResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'authorName')
  String? get authorName;

  @BuiltValueField(wireName: r'rating')
  int? get rating;

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

  @BuiltValueField(wireName: r'publishedAt')
  DateTime? get publishedAt;

  @BuiltValueField(wireName: r'comments')
  BuiltList<Comment>? get comments;

  ReviewResponse._();

  factory ReviewResponse([void updates(ReviewResponseBuilder b)]) = _$ReviewResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReviewResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReviewResponse> get serializer => _$ReviewResponseSerializer();
}

class _$ReviewResponseSerializer implements PrimitiveSerializer<ReviewResponse> {
  @override
  final Iterable<Type> types = const [ReviewResponse, _$ReviewResponse];

  @override
  final String wireName = r'ReviewResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReviewResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.annonceId != null) {
      yield r'annonceId';
      yield serializers.serialize(
        object.annonceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.authorName != null) {
      yield r'authorName';
      yield serializers.serialize(
        object.authorName,
        specifiedType: const FullType(String),
      );
    }
    if (object.rating != null) {
      yield r'rating';
      yield serializers.serialize(
        object.rating,
        specifiedType: const FullType(int),
      );
    }
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
    if (object.publishedAt != null) {
      yield r'publishedAt';
      yield serializers.serialize(
        object.publishedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.comments != null) {
      yield r'comments';
      yield serializers.serialize(
        object.comments,
        specifiedType: const FullType(BuiltList, [FullType(Comment)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReviewResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReviewResponseBuilder result,
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
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceId = valueDes;
          break;
        case r'authorName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.authorName = valueDes;
          break;
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
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
        case r'publishedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.publishedAt = valueDes;
          break;
        case r'comments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(Comment)]),
          ) as BuiltList<Comment>?;
          if (valueDes == null) continue;
          result.comments.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReviewResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReviewResponseBuilder();
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

