//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'review_signalement_request.g.dart';

/// ReviewSignalementRequest
///
/// Properties:
/// * [note] 
@BuiltValue()
abstract class ReviewSignalementRequest implements Built<ReviewSignalementRequest, ReviewSignalementRequestBuilder> {
  @BuiltValueField(wireName: r'note')
  String? get note;

  ReviewSignalementRequest._();

  factory ReviewSignalementRequest([void updates(ReviewSignalementRequestBuilder b)]) = _$ReviewSignalementRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReviewSignalementRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReviewSignalementRequest> get serializer => _$ReviewSignalementRequestSerializer();
}

class _$ReviewSignalementRequestSerializer implements PrimitiveSerializer<ReviewSignalementRequest> {
  @override
  final Iterable<Type> types = const [ReviewSignalementRequest, _$ReviewSignalementRequest];

  @override
  final String wireName = r'ReviewSignalementRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReviewSignalementRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReviewSignalementRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReviewSignalementRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReviewSignalementRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReviewSignalementRequestBuilder();
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

