//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'review_comment_request.g.dart';

/// ReviewCommentRequest
///
/// Properties:
/// * [body] 
@BuiltValue()
abstract class ReviewCommentRequest implements Built<ReviewCommentRequest, ReviewCommentRequestBuilder> {
  @BuiltValueField(wireName: r'body')
  String get body;

  ReviewCommentRequest._();

  factory ReviewCommentRequest([void updates(ReviewCommentRequestBuilder b)]) = _$ReviewCommentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReviewCommentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReviewCommentRequest> get serializer => _$ReviewCommentRequestSerializer();
}

class _$ReviewCommentRequestSerializer implements PrimitiveSerializer<ReviewCommentRequest> {
  @override
  final Iterable<Type> types = const [ReviewCommentRequest, _$ReviewCommentRequest];

  @override
  final String wireName = r'ReviewCommentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReviewCommentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReviewCommentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReviewCommentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.body = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReviewCommentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReviewCommentRequestBuilder();
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

