//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submit_resident_review_request.g.dart';

/// SubmitResidentReviewRequest
///
/// Properties:
/// * [rating] 
/// * [comment] 
/// * [pros] 
/// * [cons] 
@BuiltValue()
abstract class SubmitResidentReviewRequest implements Built<SubmitResidentReviewRequest, SubmitResidentReviewRequestBuilder> {
  @BuiltValueField(wireName: r'rating')
  int get rating;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'pros')
  BuiltList<String>? get pros;

  @BuiltValueField(wireName: r'cons')
  BuiltList<String>? get cons;

  SubmitResidentReviewRequest._();

  factory SubmitResidentReviewRequest([void updates(SubmitResidentReviewRequestBuilder b)]) = _$SubmitResidentReviewRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmitResidentReviewRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubmitResidentReviewRequest> get serializer => _$SubmitResidentReviewRequestSerializer();
}

class _$SubmitResidentReviewRequestSerializer implements PrimitiveSerializer<SubmitResidentReviewRequest> {
  @override
  final Iterable<Type> types = const [SubmitResidentReviewRequest, _$SubmitResidentReviewRequest];

  @override
  final String wireName = r'SubmitResidentReviewRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubmitResidentReviewRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rating';
    yield serializers.serialize(
      object.rating,
      specifiedType: const FullType(int),
    );
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
  }

  @override
  Object serialize(
    Serializers serializers,
    SubmitResidentReviewRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubmitResidentReviewRequestBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubmitResidentReviewRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmitResidentReviewRequestBuilder();
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

