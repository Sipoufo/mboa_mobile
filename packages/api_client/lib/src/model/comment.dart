//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'comment.g.dart';

/// Comment
///
/// Properties:
/// * [authorName] 
/// * [body] 
/// * [createdAt] 
@BuiltValue()
abstract class Comment implements Built<Comment, CommentBuilder> {
  @BuiltValueField(wireName: r'authorName')
  String? get authorName;

  @BuiltValueField(wireName: r'body')
  String? get body;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  Comment._();

  factory Comment([void updates(CommentBuilder b)]) = _$Comment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CommentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Comment> get serializer => _$CommentSerializer();
}

class _$CommentSerializer implements PrimitiveSerializer<Comment> {
  @override
  final Iterable<Type> types = const [Comment, _$Comment];

  @override
  final String wireName = r'Comment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Comment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.authorName != null) {
      yield r'authorName';
      yield serializers.serialize(
        object.authorName,
        specifiedType: const FullType(String),
      );
    }
    if (object.body != null) {
      yield r'body';
      yield serializers.serialize(
        object.body,
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
    Comment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CommentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'authorName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.authorName = valueDes;
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.body = valueDes;
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
  Comment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CommentBuilder();
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

