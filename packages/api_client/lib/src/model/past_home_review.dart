//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'past_home_review.g.dart';

/// PastHomeReview
///
/// Properties:
/// * [reviewId] 
/// * [rating] 
/// * [canWrite] 
/// * [canEdit] 
/// * [editableUntil] 
@BuiltValue()
abstract class PastHomeReview implements Built<PastHomeReview, PastHomeReviewBuilder> {
  @BuiltValueField(wireName: r'reviewId')
  String? get reviewId;

  @BuiltValueField(wireName: r'rating')
  int? get rating;

  @BuiltValueField(wireName: r'canWrite')
  bool? get canWrite;

  @BuiltValueField(wireName: r'canEdit')
  bool? get canEdit;

  @BuiltValueField(wireName: r'editableUntil')
  DateTime? get editableUntil;

  PastHomeReview._();

  factory PastHomeReview([void updates(PastHomeReviewBuilder b)]) = _$PastHomeReview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PastHomeReviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PastHomeReview> get serializer => _$PastHomeReviewSerializer();
}

class _$PastHomeReviewSerializer implements PrimitiveSerializer<PastHomeReview> {
  @override
  final Iterable<Type> types = const [PastHomeReview, _$PastHomeReview];

  @override
  final String wireName = r'PastHomeReview';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PastHomeReview object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.reviewId != null) {
      yield r'reviewId';
      yield serializers.serialize(
        object.reviewId,
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
    if (object.canWrite != null) {
      yield r'canWrite';
      yield serializers.serialize(
        object.canWrite,
        specifiedType: const FullType(bool),
      );
    }
    if (object.canEdit != null) {
      yield r'canEdit';
      yield serializers.serialize(
        object.canEdit,
        specifiedType: const FullType(bool),
      );
    }
    if (object.editableUntil != null) {
      yield r'editableUntil';
      yield serializers.serialize(
        object.editableUntil,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PastHomeReview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PastHomeReviewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reviewId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reviewId = valueDes;
          break;
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.rating = valueDes;
          break;
        case r'canWrite':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canWrite = valueDes;
          break;
        case r'canEdit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canEdit = valueDes;
          break;
        case r'editableUntil':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.editableUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PastHomeReview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PastHomeReviewBuilder();
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

